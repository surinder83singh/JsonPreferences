//
//  JsonPreferences.h
//  JsonPreferences
//
//  Created by Surinder Singh on 21/06/15.
//  Copyright (c) 2015 Surinder Singh. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>

@interface JsonPreferences : NSPreferencePane
    @property NSDictionary *json;
    @property NSMutableArray *tasks;
- (void)mainViewDidLoad;

@end
