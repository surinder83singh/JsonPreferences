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
    /*
    NSLog(@"c %@", self.tasks );
    if ([self.tasks count] == 0){
        
        self.tasks = [[NSMutableArray alloc] initWithCapacity:10];
    }
    */
    
    [self buildUI: @"/Users/surindersingh/Documents/dev/p2.json"];
}

-(IBAction) buttonPressed: (id) btn{
    NSArray *buttons    =  [self.json objectForKey:@"buttons"];
    NSDictionary *config = [buttons objectAtIndex: (NSInteger) [btn tag]];
    NSLog(@"button pressed, tag:%ld, config: %@", (long)[btn tag], config);
    [self runCommand: config btnId: btn];
}

- (void) runCommand:(NSDictionary *) config  btnId: (id) btn{
    
    NSString *action = [config objectForKey:@"action"];
    NSArray  *args   = [config objectForKey:@"args"];
    NSLog(@"action: %@, args: %@", action, args);

    NSPipe *pipe = [NSPipe pipe];
    NSTask *task = [[NSTask alloc] init];

    task.launchPath = action;
    task.arguments = args;
    task.standardOutput = pipe;
    
    [task launch];
    bool isRunning = [task isRunning];
    //[self.tasks insertObject:task atIndex:(NSUInteger)[btn tag] ];
    NSLog(@"cccc %@", self.tasks );

    
    // file handler for pipe
    NSFileHandle *handle = [task.standardOutput fileHandleForReading];
    [handle setReadabilityHandler:^(NSFileHandle *aHandle) {
        NSData *data = [aHandle availableData];
        NSString *log = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Task console output: %@", log);
    }];
    
    [task setTerminationHandler:^(NSTask *aTask) {
        if ([aTask terminationStatus] != 0 ) {
            NSLog(@"[Error] Task error");
        }
    }];
    
    //NSString *grepOutput = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    //NSLog (@"grep returned:\n%@", grepOutput);

    //NSAlert *alert = [NSAlert init];
    //[alert setInformativeText: grepOutput];
    //[alert runModal];
    NSButton *b = (NSButton *)btn;
    if (isRunning) {
        [b setTitle: [NSString stringWithFormat:@"%@ - %@", [b title],  @"Running"]];
    }
    

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
    self.json           = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    NSLog(@"parsedData: %@", self.json);

    if (self.json) {
        NSArray *buttons    =  [self.json objectForKey:@"buttons"];
        NSLog(@" %@ ", self.json);
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
    int x = 20;
    int y;

    int width = 180;
    int height = 22;
    int i = tag;

    i = i - (15 * (tag/15));
    if (i <= 0) {
        i = 1;
    }
    x = x + ((width + 10) * (tag/15));
    y = self.mainView.bounds.size.height - ((height)*i) - 5;

    NSButton *btn = [[NSButton alloc] initWithFrame:NSMakeRect(x, y, width, height)];

    [btn setTitle:[data objectForKey:@"text"]];
    [btn setBezelStyle:NSRoundedBezelStyle];
    [btn setTag:tag-1];
    [btn setTarget:self];
    [btn setAction:@selector(buttonPressed:)];
    [self.mainView addSubview: btn ];}

@end
