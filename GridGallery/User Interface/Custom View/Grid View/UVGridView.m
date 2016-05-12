/**
 *  UVGridView.m
 *  GridGallery
 *
 *  This class is derived from scroll view and used to create custom grid view.
 *
 *  Created by Govind Gupta on 17/07/15.
 *  Copyright (c) 2015 Govind Gupta. All rights reserved.
 */

#import "UVGridView.h"
#import "UVGridCellView.h"

#define DEFAULT_MARGIN_FOR_GRID_VIEW                                UIEdgeInsetsMake(0, 0, 0, 0)
#define DEFAULT_NUMBER_OF_SECTION                                   1
#define DEFAULT_GRID_CELL_SIZE                                      CGSizeMake(40, 40)
#define DEFAULT_MIN_SPACE_BETWEEN_CELL_IN_ROW                       10
#define DEFAULT_MIN_SPACE_BETWEEN_CELL_IN_COLUMN                    10

@implementation UVGridView {
    
    CGFloat gridViewContentHeight;
    BOOL    isViewLoadedFirstTime;
}

/**
 * Summary: layoutSubviews
 * This method is called on UI update if constraints are used
 *
 * return:
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    if (!isViewLoadedFirstTime) {
        
        //Handling device rotation
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChange:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        
        [self loadGridView];
        isViewLoadedFirstTime = YES;
    }
}

/**
 * Summary: loadGridView
 * This method is load grid view
 *
 * return:
 */
- (void)loadGridView {
    
    gridViewContentHeight = 0;
    NSInteger numberOfSection = [self numberOfSectionsInGridView];
    for (int section = 0; section < numberOfSection; section++) {
        
        [self loadGridCellViewForSection:section];
    }
}

/**
 * Summary: loadGridCellViewForSection:
 * This method is load grid cell for given section
 *
 * @param $section: Grid view section
 *
 * return:
 */
- (void)loadGridCellViewForSection:(NSInteger)section {
    
    [self setTitleForHeaderInSection:section];
    
    NSInteger       numberOfItems           = [self numberOfItemsInSection:section];    //Number of items in given section
    CGSize          gridCellViewSize        = [self sizeForGridCellViewInSection:section];  // Used grid cell view size
    UIEdgeInsets    edgeInset               = [self edgeInsetForGridView];  //Grid view margin from super view
    CGFloat         minSpaceForCellInRow    = [self minimumSpaceBetweenGridCellViewInRow];  //Minimum space between two cell in a row
    CGFloat         minSpaceForCellInColumn = [self minimumSpaceBetweenGridCellViewInColumn];   //Minimum space between two cell in a column
    CGFloat         gridCellViewYMargin     = gridViewContentHeight;    //Grid cell view Y coordinate
    CGFloat         gridViewWidth           = self.frame.size.width - (edgeInset.left + edgeInset.right);   //Grid view width after removing margin
    int             numberOfItemInRow       = (gridViewWidth + minSpaceForCellInRow)/(gridCellViewSize.width + minSpaceForCellInRow);   //Number of item in a row
    int             totalSpaceInRow         = gridViewWidth - (numberOfItemInRow * gridCellViewSize.width); //Total margin between cell
    float           numberOfRow             = ceil((CGFloat)numberOfItems/numberOfItemInRow);   //Number of rows in section
    
    for(int rowCount = 0; rowCount < numberOfRow; rowCount++) {
        
        int gridCellViewXMargin=edgeInset.left;
        for(int itemCountInRow = 0; itemCountInRow < numberOfItemInRow; itemCountInRow++) {
            
            int itemCount = (rowCount *numberOfItemInRow) + itemCountInRow;
            if (itemCount < numberOfItems) {
                
                NSIndexPath *gridCellViewIndexPath = [NSIndexPath indexPathForRow:itemCount inSection:section];
                UVGridCellView *gridCellView = [self cellForItemAtIndexPath:gridCellViewIndexPath];
                gridCellView.frame = CGRectMake(gridCellViewXMargin, gridCellViewYMargin,gridCellViewSize.width, gridCellViewSize.height);
                gridCellViewXMargin = gridCellViewXMargin + (totalSpaceInRow / (numberOfItemInRow - 1)) + gridCellViewSize.width;
                [self addSubview:gridCellView];
            }
        }
        gridCellViewYMargin= gridCellViewYMargin + gridCellViewSize.height + minSpaceForCellInColumn;
    }
    
    gridViewContentHeight = gridCellViewYMargin;
    [self setContentSize:CGSizeMake(self.frame.size.width,gridViewContentHeight)];
}

#pragma mark - Grid cell methods

/**
 * Summary: girdCellSelected:
 * This method is called on selecting grid cell view.
 *
 * @param $tapGesture: tap gesture
 *
 * return:
 */
- (void)girdCellSelected:(UITapGestureRecognizer *)tapGesture {
    
    if (_gridDelegate && [_gridDelegate respondsToSelector:@selector(gridView:didSelectItemAtIndexPath:)]) {
        
        UVGridCellView *gridCellView = (UVGridCellView *)tapGesture.view;
        [_gridDelegate gridView:self didSelectItemAtIndexPath:gridCellView.indexPath];
    }
    
}

/**
 * Summary: numberOfSectionsInGridView
 * This method is used to get number of section in grid view.
 *
 * @param $gridView: Grid view
 *
 * return: Number of section
 */
- (NSInteger)numberOfSectionsInGridView {
    
    NSInteger numberOfSection = DEFAULT_NUMBER_OF_SECTION;
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfSectionsInGridView:)]) {
        
        numberOfSection = [_dataSource numberOfSectionsInGridView:self];
    }
    return numberOfSection;
}

/**
 * Summary: numberOfItemsInSection:
 * This method is used to get number of items in given grid section.
 *
 * @param $section: Grid view section
 *
 * return: Number of items in given section
 */
- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    
    return [_dataSource gridView:self numberOfItemsInSection:section];
}

/**
 * Summary: cellForItemAtIndexPath:
 * This method is used to create a grid view cell object.
 *
 * @param $indexPath: Index path for cell
 *
 * return: Grid view cell
 */
- (UVGridCellView *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UVGridCellView *gridCellView = [_dataSource gridView:self cellForItemAtIndexPath:indexPath];
    gridCellView.indexPath = indexPath;
    
    //Add a gesture for cell selection
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(girdCellSelected:)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [gridCellView addGestureRecognizer:tapRecognizer];
    
    return gridCellView;
}

/**
 * Summary: setTitleForHeaderInSection:
 * This method is used to set header title for grid view section.
 *
 * @param $section: Grid view section
 *
 * return: Grid view header title
 */
- (void)setTitleForHeaderInSection:(NSInteger)section{
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(gridView:titleForHeaderInSection:)]) {
        
        NSString *headerTitle = [_dataSource gridView:self titleForHeaderInSection:section];
        UIEdgeInsets    edgeInset               = [self edgeInsetForGridView];
        int headerYCoordinate = gridViewContentHeight + edgeInset.top;
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headerYCoordinate, self.frame.size.width, 23)];
        headerLabel.backgroundColor = [UIColor grayColor];
        headerLabel.text = headerTitle;
        [self addSubview:headerLabel];
        gridViewContentHeight = headerYCoordinate +30;
        
    }
}

#pragma mark - UI layout methods

/**
 * Summary: edgeInsetForGridView
 * This method is used to get grid view edget inset value.
 *
 * return: Grid view edge inset value
 */
- (UIEdgeInsets)edgeInsetForGridView {
    
    UIEdgeInsets edgeInset = DEFAULT_MARGIN_FOR_GRID_VIEW;
    if (_gridDelegate && [_gridDelegate respondsToSelector:@selector(edgeInsetForGridView)]) {
        
        edgeInset = [_gridDelegate edgeInsetForGridView];
    }
    return edgeInset;
}

/**
 * Summary: sizeForGridCellViewInSection:
 * This method is used to get grid cell view size.
 *
 * @param $section: Grid view section
 *
 * return: Grid cell view size
 */
- (CGSize)sizeForGridCellViewInSection:(NSInteger)section{
    
    CGSize gridCellSize = DEFAULT_GRID_CELL_SIZE;
    if (_gridDelegate && [_gridDelegate respondsToSelector:@selector(gridView:sizeForSection:)]) {
        
        gridCellSize = [_gridDelegate gridView:self sizeForSection:section];
    }
    return gridCellSize;
}

/**
 * Summary: minimumSpaceBetweenGridCellViewInRow
 * This method is used to get minimum row space between two grid cell.
 *
 * return: Minimum column row between two grid cell
 */
- (CGFloat)minimumSpaceBetweenGridCellViewInRow {
    
    CGFloat minimumSpaceInRow = DEFAULT_MIN_SPACE_BETWEEN_CELL_IN_ROW;
    if (_gridDelegate && [_gridDelegate respondsToSelector:@selector(minimumSpaceBetweenGridCellViewInRow)]) {
        
        minimumSpaceInRow = [_gridDelegate minimumSpaceBetweenGridCellViewInRow];
    }
    return minimumSpaceInRow;
}

/**
 * Summary: minimumSpaceBetweenGridCellViewInColumn
 * This method is used to get minimum column space between two grid cell.
 *
 * return: Minimum column space between two grid cell
 */
- (CGFloat)minimumSpaceBetweenGridCellViewInColumn {
    
    CGFloat minimumSpaceInColumn = DEFAULT_MIN_SPACE_BETWEEN_CELL_IN_COLUMN;
    if (_gridDelegate && [_gridDelegate respondsToSelector:@selector(minimumSpaceBetweenGridCellViewInColumn)]) {
        
        minimumSpaceInColumn = [_gridDelegate minimumSpaceBetweenGridCellViewInColumn];
    }
    return minimumSpaceInColumn;
}

#pragma mark - Device rotation

/**
 * Summary: deviceOrientationDidChange:
 * This method is called on device rotation
 *
 * @param $notification: rotation notification
 *
 * return: Grid cell view size
 */
- (void)deviceOrientationDidChange:(NSNotification *)notification {
  
    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self loadGridView];
}

@end
