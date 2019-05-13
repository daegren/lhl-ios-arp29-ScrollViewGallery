//
//  ViewController.m
//  ScrollView Image Gallery
//
//  Created by David Mills on 2019-05-13.
//  Copyright © 2019 David Mills. All rights reserved.
//

#import "ViewController.h"
#import "ImageDetailViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray<UIImage *> *images;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  UIImageView *prevImageView;

  for (UIImage *image in self.images) {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    // Tap recog
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [imageView addGestureRecognizer:tap];


    [self.scrollView addSubview:imageView];

    // constraints
    // width
    [imageView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = YES;
    // center y
    [imageView.centerYAnchor constraintEqualToAnchor:self.scrollView.centerYAnchor].active = YES;
    // top
    [imageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = YES;
    // bottom
    [imageView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    // no translates auto-resizing mask to constraints
    imageView.translatesAutoresizingMaskIntoConstraints = NO;

    // if this is the last image to display
    if ([self.images indexOfObject:image] == self.images.count - 1) {
      // attach the right anchor, to the right anchor of the scroll view
      // need to do this for it to calculate content size
      [imageView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;
    }
    // If there was a previous imageview
    if (prevImageView) {
      // setup a constraint from our left anchor to its right anchor
      [imageView.leftAnchor constraintEqualToAnchor:prevImageView.rightAnchor].active = YES;
    } else {
      // otherwise, connect the left anchor to the left anchor of the scroll view.
      [imageView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor].active = YES;
    }

    prevImageView = imageView;
  }

}

#pragma mark - Lazy Properties

- (NSArray<UIImage *> *)images {
  if (!_images) {
    _images = @[[UIImage imageNamed:@"Lighthouse-in-Field"],
                [UIImage imageNamed:@"Lighthouse-night"],
                [UIImage imageNamed:@"Lighthouse-zoomed"]
                ];
  }

  return _images;
}

#pragma mark - Actions

- (void)tap:(UITapGestureRecognizer *)sender {
  [self performSegueWithIdentifier:@"showDetail" sender:sender.view];
}

- (IBAction)pageChanged:(id)sender {
  CGFloat pageWidth = self.scrollView.contentSize.width / self.pageControl.numberOfPages;
  [self.scrollView scrollRectToVisible:CGRectMake(pageWidth * self.pageControl.currentPage, 0, pageWidth, 10)
                              animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showDetail"]) {
    ImageDetailViewController *dvc = segue.destinationViewController;
    UIImageView *tappedImageView = sender;
    dvc.image = tappedImageView.image;
  }
}

#pragma mark - UIScrollViewDelegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  NSUInteger pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
  self.pageControl.currentPage = pageIndex;
}


@end
