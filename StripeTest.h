//
//  StripeTest.h
//  Stripe Test
//
//  Created by Chris Webb on 2014-10-11.
//  Copyright (c) 2014 Chris Webb. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Stripe.h"
@interface StripeTest : NSWindow
@property (strong) IBOutlet NSTextField *cardNumber;
@property (strong) IBOutlet NSTextField *cardholderName;
@property (strong) IBOutlet NSDatePicker *expirationDate;
@property (strong) IBOutlet NSTextField *cvv;
@property (strong) IBOutlet NSTextField *transactionAmount;
@property (strong) IBOutlet NSTextField *iterations;
@property (strong,nonatomic) StripeConnection *sc;
- (IBAction)processButton:(id)sender;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;

@end
