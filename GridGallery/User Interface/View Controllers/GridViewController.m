/**
 *  GridViewController.m
 *  GridGallery
 *
 *  This controller class is used to show animal information in a grid view.
 *
 *  Created by Govind Gupta on 17/07/15.
 *  Copyright (c) 2015 Govind Gupta. All rights reserved.
 */

#import "GridViewController.h"
#import "UVGridView.h"
#import "UIConstants.h"
#import "UIStringConstants.h"
#import "DataAccessHelper.h"
#import "GridCellView.h"

@interface GridViewController () <UIGridViewDataSource,UIGridViewDelegate>

@property (weak, nonatomic) IBOutlet UVGridView *animalGridView;

@end

@implementation GridViewController

/**
 * Summary: viewDidLoad
 * This method is called at loading time this controller.
 *
 * return:
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = NAV_TITLE_ANIMALS;
    _animalGridView.dataSource = self;
    _animalGridView.gridDelegate = self;
}

#pragma Mark - Grid view datasource protocol methods

/**
 * Summary: numberOfSectionsInGridView:
 * This method is used to get number of section in grid view.
 *
 * @param $gridView: Grid view
 *
 * return: Number of section
 */
- (NSInteger)numberOfSectionsInGridView:(UVGridView *)gridView {
    
    return [DataAccessHelper numberOfAnimalGroup];
}

/**
 * Summary: gridView:numberOfItemsInSection:
 * This method is used to get number of items in given grid section.
 *
 * @param $gridView: Grid view
 * @param $section: Grid view section
 *
 * return: Number of items in given section
 */
- (NSInteger)gridView:(UVGridView *)gridView numberOfItemsInSection:(NSInteger)section {
    
    return [[DataAccessHelper getAnimalArrayForGroupNumnber:section] count];
}

/**
 * Summary: gridView:cellForItemAtIndexPath:
 * This method is used to create a grid view cell object.
 *
 * @param $gridView: Grid view
 * @param $indexPath: Index path for cell
 *
 * return: Grid view cell
 */
- (UVGridCellView *)gridView:(UVGridView *)gridView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray         *animalList         = [DataAccessHelper getAnimalArrayForGroupNumnber:indexPath.section];
    GridCellView    *gridCellView       = (GridCellView *)[GridCellView loadViewFromNib];
    gridCellView.lblTitle.text          = [animalList objectAtIndex:indexPath.row];
    gridCellView.imgViewAnimal.image    = [UIImage imageNamed:[animalList objectAtIndex:indexPath.row]];
    return gridCellView;
}

/**
 * Summary: gridView:titleForHeaderInSection:
 * This method is used to set header title for grid view section.
 *
 * @param $gridView: Grid view
 * @param $section: Grid view section
 *
 * return: Grid view header title
 */
- (NSString *)gridView:(UVGridView *)gridView titleForHeaderInSection:(NSInteger)section {
    
    return [NSString stringWithFormat:GRID_VIEW_SECTION_HEADER_TITLE_ANIMAL,(int)section + 1];
}

#pragma mark -Grid view delegate method

/**
 * Summary: gridView:didSelectItemAtIndexPath:
 * This method is called on selecting grid cell view.
 *
 * @param $gridView: Grid view
 * @param $indexPath: Index path
 *
 * return:
 */
- (void)gridView:(UVGridView *)gridView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *animalList = [DataAccessHelper getAnimalArrayForGroupNumnber:indexPath.section];
    NSString *animalName = [animalList objectAtIndex:indexPath.row];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[NSString stringWithFormat:ALERT_MESSAGE_IMAGE_SELECTED,animalName]
                                                       delegate:nil
                                              cancelButtonTitle:ALERT_BUTTON_OK
                                              otherButtonTitles:nil];
    [alertView show];
}

/**
 * Summary: edgeInsetForGridView
 * This method is used to get grid view edget inset value.
 *
 * return: Grid view edge inset value
 */
- (UIEdgeInsets)edgeInsetForGridView {
    
    return MARGIN_FOR_GRID_VIEW;
}

/**
 * Summary: gridView:sizeForSection:
 * This method is used to get grid cell view size.
 *
 * @param $gridView: Grid view
 * @param $section: Grid view section
 *
 * return: Grid cell view size
 */
- (CGSize)gridView:(UVGridView *)gridView sizeForSection:(NSInteger)section {
    
    return GRID_CELL_SIZE;
}

/**
 * Summary: minimumSpaceBetweenGridCellViewInRow
 * This method is used to get minimum row space between two grid cell.
 *
 * return: Minimum column row between two grid cell
 */
- (NSInteger)minimumSpaceBetweenGridCellViewInRow {
    
    return MIN_SPACE_BETWEEN_CELL_IN_ROW;
}

/**
 * Summary: minimumSpaceBetweenGridCellViewInColumn
 * This method is used to get minimum column space between two grid cell.
 *
 * return: Minimum column space between two grid cell
 */
- (NSInteger)minimumSpaceBetweenGridCellViewInColumn {
    
    return MIN_SPACE_BETWEEN_CELL_IN_COLUMN;
}


@end
