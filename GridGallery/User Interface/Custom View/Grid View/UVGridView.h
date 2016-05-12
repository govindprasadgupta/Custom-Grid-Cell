/**
 *  UVGridView.h
 *  GridGallery
 *
 *  This class is derived from scroll view and used to create custom grid view.
 *
 *  Created by Govind Gupta on 17/07/15.
 *  Copyright (c) 2015 Govind Gupta. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "UVGridCellView.h"

@class UVGridView;

@protocol UIGridViewDelegate <NSObject>

@optional

/**
 * Summary: edgeInsetForGridView
 * This method is used to get grid view edget inset value.
 *
 * return: Grid view edge inset value
 */
- (UIEdgeInsets)edgeInsetForGridView;

/**
 * Summary: gridView:sizeForSection:
 * This method is used to get grid cell view size.
 *
 * @param $gridView: Grid view
 * @param $section: Grid view section
 *
 * return: Grid cell view size
 */
- (CGSize)gridView:(UVGridView *)gridView sizeForSection:(NSInteger)section;

/**
 * Summary: minimumSpaceBetweenGridCellViewInRow
 * This method is used to get minimum row space between two grid cell.
 *
 * return: Minimum column row between two grid cell
 */
- (NSInteger)minimumSpaceBetweenGridCellViewInRow;

/**
 * Summary: minimumSpaceBetweenGridCellViewInColumn
 * This method is used to get minimum column space between two grid cell.
 *
 * return: Minimum column space between two grid cell
 */
- (NSInteger)minimumSpaceBetweenGridCellViewInColumn;

/**
 * Summary: gridView:didSelectItemAtIndexPath:
 * This method is called on selecting grid cell view.
 *
 * @param $gridView: Grid view
 * @param $indexPath: Index path
 *
 * return:
 */
- (void)gridView:(UVGridView *)gridView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol UIGridViewDataSource <NSObject>

@required

/**
 * Summary: gridView:numberOfItemsInSection:
 * This method is used to get number of items in given grid section.
 *
 * @param $gridView: Grid view
 * @param $section: Grid view section
 *
 * return: Number of items in given section
 */
- (NSInteger)gridView:(UVGridView *)gridView numberOfItemsInSection:(NSInteger)section;

/**
 * Summary: gridView:cellForItemAtIndexPath:
 * This method is used to create a grid view cell object.
 *
 * @param $gridView: Grid view
 * @param $indexPath: Index path for cell
 *
 * return: Grid view cell
 */
- (UVGridCellView *)gridView:(UVGridView *)gridView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 * Summary: numberOfSectionsInGridView:
 * This method is used to get number of section in grid view.
 *
 * @param $gridView: Grid view
 *
 * return: Number of section
 */
- (NSInteger)numberOfSectionsInGridView:(UVGridView *)gridView;

/**
 * Summary: gridView:titleForHeaderInSection:
 * This method is used to set header title for grid view section.
 *
 * @param $gridView: Grid view
 * @param $section: Grid view section
 *
 * return: Grid view header title
 */
- (NSString *)gridView:(UVGridView *)gridView titleForHeaderInSection:(NSInteger)section;

@end

@interface UVGridView : UIScrollView

@property (nonatomic, assign)   id <UIGridViewDelegate>     gridDelegate;
@property (nonatomic, assign)   id <UIGridViewDataSource>   dataSource;

@end
