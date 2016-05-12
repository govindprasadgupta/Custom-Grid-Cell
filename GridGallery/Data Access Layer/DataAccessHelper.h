/**
 *  DataAccessHelper.h
 *  GridGallery
 *
 *  This classs is used as a helper to access data.
 *
 *  Created by Govind Gupta on 17/07/15.
 *  Copyright (c) 2015 Govind Gupta. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface DataAccessHelper : NSObject

/**
 * Summary: numberOfAnimalGroup
 * This method is used to get animal groups.
 *
 * return: Animal groups
 */
+ (NSInteger)numberOfAnimalGroup;

/**
 * Summary: getAnimalArrayForGroupNumnber:
 * This method is used to get animal list for provided group number
 *
 * @param $groupNumber: group number
 *
 * return: Animal list array
 */
+ (NSArray *)getAnimalArrayForGroupNumnber:(NSInteger)groupNumber;
@end
