//
//  SLLogger.h
//  LoggingDemo
//
//  Created by 利辺羅 on 2014/12/09.
//  Copyright (c) 2014年 SLF4C. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLLogger, SLMarker;

typedef NS_ENUM(NSUInteger, SLLevel)
{
    SLLevelOff = 0,
    SLLevelVerbose,
    SLLevelDebug,
    SLLevelInfo,
    SLLevelWarning,
    SLLevelError
};


@interface SLLog : NSObject

+ (Class<SLLogger>)loggerClass;
+ (void)setLoggerClass:(Class<SLLogger>)loggerClass;

+ (id<SLMarker>)appMarker;
+ (NSArray *)allMarkers;
+ (id<SLMarker>)markerWithName:(NSString *)name;

@end


@protocol SLLogger <NSObject>

+ (Class<SLMarker>)markerClass;

+ (void)logWithMarker:(id<SLMarker>)marker
                level:(SLLevel)level
                 path:(const char *)file
                 line:(uint32_t)line
             function:(const char *)function
               format:(NSString *)format, ... NS_FORMAT_FUNCTION(6, 7);

+ (BOOL)isLogWithMarker:(id<SLMarker>)marker
        enabledForLevel:(SLLevel)level;

@end


@protocol SLMarker <NSObject>

@property (nonatomic, strong) NSString * name; // Should be read-only

@end


@interface SLSimpleMarker : NSObject <SLMarker>

@property (nonatomic, strong) NSString * name;

@end


//@interface SLNOPLogger : NSObject <SLLogger>
//
//@end
//
//
//@interface SLNSLogger : NSObject <SLLogger>
//
//@end
//
//
