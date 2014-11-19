//
//  StripeTest.m
//  Stripe Test
//
//  Created by Chris Webb on 2014-10-11.
//  Copyright (c) 2014 Chris Webb. All rights reserved.
//

#import "StripeTest.h"

@implementation StripeTest

- (IBAction)processButton:(id)sender {
    _sc = [StripeConnection connectionWithPublishableKey:@"STRIPE KEY GOES HERE"];
    StripeCard *card =  [[StripeCard alloc] init];
    card.number = [_cardNumber stringValue];
    card.name = [_cardholderName stringValue];
    card.securityCode = [_cvv stringValue];
    NSDate *enteredDate = [_expirationDate dateValue];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:enteredDate];
    NSInteger month=[components month];
    NSInteger year = [components year];
    card.expiryMonth =  [NSNumber numberWithInteger:month];
    card.expiryYear =   [NSNumber numberWithInteger:year];
    NSInteger iterations = [_iterations integerValue];
    NSOperationQueue *nsq = [[NSOperationQueue alloc] init];
    nsq.name=@"CC Processing Queue";
    [nsq setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    __block int iter;
    for (int i = 0; i<iterations; i++) {
        [_progressIndicator setMaxValue:iterations];
        [_progressIndicator setDoubleValue:0];
            [nsq addOperationWithBlock:^{
            [_sc performRequestWithCard:card
                                success:^(StripeResponse *token)
             {
                 NSLog(@"Success");
                 iter++;
                 [_progressIndicator setDoubleValue:iter];
             }
                                  error:^(NSError *error)
             {
                 NSLog(@"Failure");
                 NSLog(error);
                 iter++;
                 [_progressIndicator setDoubleValue:iter];
             }];
            wait(1000000);

        }];
        [nsq waitUntilAllOperationsAreFinished];
        }

}
@end
