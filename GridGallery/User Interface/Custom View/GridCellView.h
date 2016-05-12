/**
 *  GridCellView.h
 *  GridGallery
 *
 *  This grid cell view class is derived from base cell view and used to show image info.
 *
 *  Created by Govind Gupta on 17/07/15.
 *  Copyright (c) 2015 Govind Gupta. All rights reserved.
 */

#import "UVGridCellView.h"

@interface GridCellView : UVGridCellView

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewAnimal;

/**
 * Summary: loadViewFromNib
 * Method is used to crate a custom view.
 *
 * return: Grid cell view object
 */
+ (GridCellView *)loadViewFromNib;

@end
