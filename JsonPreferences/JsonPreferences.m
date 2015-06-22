//
//  JsonPreferences.m
//  JsonPreferences
//
//  Created by Surinder Singh on 21/06/15.
//  Copyright (c) 2015 Surinder Singh. All rights reserved.
//

#import "JsonPreferences.h"

@implementation JsonPreferences

- (void)mainViewDidLoad
{
    
    [self buildUI: @"/Users/surindersingh/Documents/dev/p2.json"];
}

-(IBAction) buttonPressed: (id) btn{
    NSLog(@"button pressed");
}

- (NSString *) readFile: (NSString*) path{
    return [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

- (void) buildUI: (NSString*) path{
    //read file
    NSString *jsonString = [self readFile: path];
    //NSLog(@"jsonString: %@", jsonString);
    NSData *jsonData    = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
    //NSLog(@"jsonData: %@", jsonData);
    NSError *error      = nil;
    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    NSLog(@"parsedData: %@", json);

    if (json) {
        NSArray *buttons    =  [json objectForKey:@"buttons"];
        NSLog(@" %@ ", json);
        int i = 1;
        for (NSDictionary *button in buttons) {
            //NSLog(@"Text: %@ ", [button objectForKey:@"text"]);
            //NSLog(@"Action: %@ ", [button objectForKey:@"action"]);
            [self buildButton:button buttonTag:i];
            i++;
        }
    }else{
        NSLog(@"UNABLE TO PARSE file %@ %@", path, error);
    }
}

- (void) buildButton: (NSDictionary *const) data buttonTag:(int) tag{
    int x = 20; //possition x
    int y; //possition y

    int width = 130;
    int height = 22;
    int i = tag;

    i = i - (15 * (tag/15));
    if (i <= 0) {
        i = 1;
    }
    x = x + ((width + 10) * (tag/15));

    y = self.mainView.bounds.size.height - ((height)*i) - 5;

    

    NSButton *myButton = [[NSButton alloc] initWithFrame:NSMakeRect(x, y, width, height)];
    NSLog(@"ssss tag: %d y: %d, i: %d, t: %d", tag, y, i, tag/15);

    [myButton setTitle:[data objectForKey:@"text"]];
    [myButton setBezelStyle:NSRoundedBezelStyle];
    [myButton setTag:tag];
    [myButton setTarget:self];
    [myButton setAction:@selector(buttonPressed:)];
    [self.mainView addSubview:myButton ];}

@end
