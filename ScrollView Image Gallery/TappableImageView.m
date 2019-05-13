//
//  TappableImageView.m
//  ScrollView Image Gallery
//
//  Created by David Mills on 2019-05-13.
//  Copyright © 2019 David Mills. All rights reserved.
//

#import "TappableImageView.h"

@interface TappableImageView ()

@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation TappableImageView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:_tapRecognizer];

    [self addSubview:self.imageView];
    [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.imageView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.imageView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [self.imageView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
  }

  return self;
}

- (void)tap:(UITapGestureRecognizer *)sender {
  [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
  }

  return _imageView;
}

- (void)setImage:(UIImage *)image {
  self.imageView.image = image;
}

- (UIImage *)image {
  return self.imageView.image;
}

- (CGSize)intrinsicContentSize {
  return self.imageView.intrinsicContentSize;
}

@end
