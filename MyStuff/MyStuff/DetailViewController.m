//
//  DetailViewController.m
//  MyStuff
//
//  Created by X on 14/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "DetailViewController.h"
#import "MyWhatsit.h"

#import <MobileCoreServices/UTCoreTypes.h>

@interface DetailViewController ()
{
    UIPopoverController *imagePopoverController;
}

- (void)configureView;
- (void)presentImagePickerUsingCamera:(BOOL)useCamera;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem != nil)
    {
        self.nameField.text     = self.detailItem.name;
        self.locationField.text = self.detailItem.location;
        self.imageView.image    = self.detailItem.viewImage;
    }
}

- (void)presentImagePickerUsingCamera:(BOOL)useCamera
{
    imagePopoverController = nil;
    UIImagePickerController *cameraUI = [UIImagePickerController new];
    cameraUI.sourceType = ( useCamera ? UIImagePickerControllerSourceTypeCamera
                           : UIImagePickerControllerSourceTypePhotoLibrary );
    cameraUI.mediaTypes = @[(NSString*)kUTTypeImage];
    cameraUI.delegate = self;
    if (useCamera || UIDevice.currentDevice.userInterfaceIdiom==UIUserInterfaceIdiomPhone)
    {
        [self presentViewController:cameraUI animated:YES completion:nil];
    } else
    {
        imagePopoverController = [[UIPopoverController alloc] initWithContentViewController:cameraUI];
        [imagePopoverController presentPopoverFromRect:self.imageView.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

- (IBAction)changedDetail:(id)sender
{
    if (sender == self.nameField)
    {
        self.detailItem.name = self.nameField.text;
    }
    else if (sender == self.locationField)
    {
        self.detailItem.location = self.locationField.text;
    }
    [self.detailItem postDidChangeNotification];
}

- (IBAction)choosePicture:(id)sender
{
    if (self.detailItem == nil)
        return;
    BOOL hasPhotoLibrary = [UIImagePickerController
                            isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (!hasPhotoLibrary && !hasCamera)
        return;
    [self dismissKeyboard:self];
    if (hasPhotoLibrary && hasCamera)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Take a Picture",@"Choose a Photo",nil];
        [actionSheet showInView:self.view];
        return;
    }
    [self presentImagePickerUsingCamera:hasCamera];
}

- (void) actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: // camera button
        case 1: // photo button
            [self presentImagePickerUsingCamera:(buttonIndex==0)];
        break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *whatsitImage = info[UIImagePickerControllerEditedImage];
        if (whatsitImage == nil)
            whatsitImage = info[UIImagePickerControllerOriginalImage];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
            UIImageWriteToSavedPhotosAlbum(whatsitImage,nil,nil,nil);
        CGImageRef coreGraphicsImage = whatsitImage.CGImage;
        CGFloat height = CGImageGetHeight(coreGraphicsImage);
        CGFloat width  = CGImageGetWidth(coreGraphicsImage);
        CGRect crop;
        if (height > width)
        {
            crop.size.height = crop.size.width = width;
            crop.origin.x = 0;
            crop.origin.y = floorf((height-width)/2);
        }
        else
        {
            crop.size.height = crop.size.width = height;
            crop.origin.y = 0;
            crop.origin.x = floorf((width-height)/2);
        }
        CGImageRef croppedImage = CGImageCreateWithImageInRect(coreGraphicsImage,crop);
        whatsitImage = [UIImage imageWithCGImage:croppedImage
                                           scale:MAX(crop.size.height/512,1.0)
                                     orientation:whatsitImage.imageOrientation];
        CGImageRelease(croppedImage);

        _detailItem.image    = whatsitImage;
        self.imageView.image = whatsitImage;
        [_detailItem postDidChangeNotification];
    }
    [self dismissImagePicker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissImagePicker];
}

- (void)dismissImagePicker
{
    if (imagePopoverController!=nil)
    {
        [imagePopoverController dismissPopoverAnimated:YES];
        imagePopoverController = nil;
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
