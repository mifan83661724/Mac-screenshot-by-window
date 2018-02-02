//
//  MainTrainning.h
//  SonOfGrab
//
//  Created by liuxiang on 2018/2/2.
//

#import <Foundation/Foundation.h>


@interface RecognizedResult : NSObject

@property (assign) double money;
@property (copy  ) NSString* remark;
@property (assign) int count;

@end

@interface MainTrainning : NSObject

- (int)recognize:(char *)path money:(double *)money remaork:(char **)remark index:(int *)index;
- (RecognizedResult *)recognize:(char *)path;

@end
