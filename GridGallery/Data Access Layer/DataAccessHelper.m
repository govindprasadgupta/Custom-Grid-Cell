/**
 *  DataAccessHelper.m
 *  GridGallery
 *
 *  This classs is used as a helper to access data.
 *
 *  Created by Govind Gupta on 17/07/15.
 *  Copyright (c) 2015 Govind Gupta. All rights reserved.
 */

#import "DataAccessHelper.h"

#define ANIMAL_INFO_MAPPING           @"AnimalIconMapping"
#define MAPPING_FILE_EXTENSION        @"plist"

@implementation DataAccessHelper

/**
 * Summary: numberOfAnimalGroup
 * This method is used to get animal groups.
 *
 * return: Animal groups
 */
+ (NSInteger)numberOfAnimalGroup {
    
    return [[DataAccessHelper getAnimalInformation] count];
}

/**
 * Summary: getAnimalArrayForGroupNumnber:
 * This method is used to get animal list for provided group number
 *
 * @param $groupNumber: group number
 *
 * return: Animal list array
 */
+ (NSArray *)getAnimalArrayForGroupNumnber:(NSInteger)groupNumber {
    
    return [[DataAccessHelper getAnimalInformation] objectAtIndex:groupNumber];
}

/**
 * Summary: getAnimalInformation
 * This method is used to get animal information.
 *
 * return: All animal list
 */
+ (NSArray *)getAnimalInformation {
    
    NSString *animalPlistPath = [[NSBundle mainBundle] pathForResource:ANIMAL_INFO_MAPPING ofType:MAPPING_FILE_EXTENSION];
    NSArray *animalGroups = [NSArray arrayWithContentsOfFile:animalPlistPath];
    return animalGroups;
}

@end
