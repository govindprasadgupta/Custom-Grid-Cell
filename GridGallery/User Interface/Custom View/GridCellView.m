/**
 *  GridCellView.m
 *  GridGallery
 *
 *  This grid cell view class is derived from base cell view and used to show image info.
 *
 *  Created by Govind Gupta on 17/07/15.
 *  Copyright (c) 2015 Govind Gupta. All rights reserved.
 */

#import "GridCellView.h"

@implementation GridCellView

/**
 * Summary: loadViewFromNib
 * Method is used to crate a custom view.
 *
 * return: Grid cell view object
 */
+ (GridCellView *)loadViewFromNib {
    
    NSString        *nibName        = NSStringFromClass(self);
    NSArray         *nibContents    = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    GridCellView    *customView     = (GridCellView *)[nibContents objectAtIndex:0];
    return customView;
}

@end
