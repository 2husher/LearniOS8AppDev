//
//  BookViewController.m
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "BookViewController.h"
#import "BookDataSource.h"

@interface BookViewController ()
{
    BookDataSource *bookSource;
}
@end


@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = bookSource = [BookDataSource new];
    NSURL *bookURL = [[NSBundle mainBundle] URLForResource:@"Alice"
                                             withExtension:@"txt"];
    NSString *text = [NSString stringWithContentsOfURL:bookURL
                                              encoding:NSUTF8StringEncoding
                                                 error:NULL];
    bookSource.paginator.bookText = text;

    [self setViewControllers:@[[bookSource pageViewController:self loadPage:1]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
