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
        //NSString *buttonId = [NSString stringWithFormat:@"b%i", i];
        for (NSDictionary *button in buttons) {
            NSLog(@"Text: %@ ", [button objectForKey:@"text"]);
            NSLog(@"Action: %@ ", [button objectForKey:@"action"]);
            //NSString *buttonId = [NSString stringWithFormat:@"b%i", i];
            //NSString const *c =buttonId;
            //NSButton *b = [self objc_getAssociatedObject];
            //NSButton *b = [self valueForKey:[NSString stringWithFormat:@"b%i", i]];
            //objc_property_t t = class_getProperty ([self class], c);
            //NSObject *button = class_getProperty ([self class],  buttonId);
            //[self set]
            //[b setTitle:[button objectForKey:@"text"]];
            //[b set];
            //NSLog(@"button %@ name: %@", b, [NSString stringWithFormat:@"b%i", i]);
            [self buildButton:button buttonTag:i];
            i++;
        }
    }else{
        NSLog(@"UNABLE TO PARSE file %@ %@", path, error);
    }
}

- (void) buildButton: (NSDictionary *const) data buttonTag:(int) tag{
    int x = 100; //possition x
    int y = 100; //possition y
    
    int width = 130;
    int height = 40;
    
    y = 200;//(height+5)*tag;
    
    NSLog(@"ssss i: %d y: %d", tag, y);
    
    NSButton *myButton = [[NSButton alloc] initWithFrame: NSMakeRect(x, y, width, height)];
    [self.mainView addSubview:myButton ];//positioned:(NSWindowOrderingMode) relativeTo:<#(NSView *)#>: ];
    [myButton setTitle:[data objectForKey:@"text"]];
    //[myButton setTag:tag];
    [myButton setButtonType:NSMomentaryLightButton]; //Set what type button You want
    [myButton setBezelStyle:NSRoundedBezelStyle]; //Set what style You want
    
    [myButton setTarget:self];
    [myButton setAction:@selector(buttonPressed:)];
}

@end
