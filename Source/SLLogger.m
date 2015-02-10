//
//  SLLogger.m
//  LoggingDemo
//
//  Created by 利辺羅 on 2014/12/09.
//  Copyright (c) 2014年 SLF4C. All rights reserved.
//

#import "SLLogger.h"
#import "SLLibMacros.h"

@implementation SLLog

static Class<SLLogger> _loggerClass;
static NSMutableDictionary * _markers;

+ (Class<SLLogger>)loggerClass
{
//    if (!_loggerClass)
//    {
//        #ifdef DEBUG
//            _loggerClass = [SLNSLogger class];
//        #else
//            _loggerClass = [SLNOPLogger class];
//        #endif
//    }
    return _loggerClass;
}

+ (void)setLoggerClass:(Class<SLLogger>)loggerClass
{
    _loggerClass = loggerClass;
    
    SLInfo(@"Logger set to '%@'.", NSStringFromClass(loggerClass));
    
    Class<SLLogger> _lgr = loggerClass;
    id<SLMarker> _mrk = [self markerWithName:SLMarkerName];
    SLLevel _lvl = SLLevelInfo;
    if ([_lgr isLogWithMarker:_mrk
              enabledForLevel:_lvl])
    {
        [_lgr logWithMarker:_mrk
                      level:_lvl
                       path:__FILE__
                       line:__LINE__
                   function:__PRETTY_FUNCTION__
                     format:@"Set to log with '%@'.", NSStringFromClass(loggerClass)];
    }
}

+ (id<SLMarker>)appMarker
{
    return [self markerWithName:@"App"];
}

+ (NSArray *)allMarkers
{
    NSArray * orderedMarkerNames = [[_markers allKeys]
                                    sortedArrayWithOptions:0
                                    usingComparator:^NSComparisonResult(NSString * name1,
                                                                        NSString * name2)
                                    {
                                        if ([name1 isEqualToString:@"App"])
                                        {
                                            return NSOrderedAscending;
                                        }
                                        if ([name2 isEqualToString:@"App"])
                                        {
                                            return NSOrderedDescending;
                                        }
                                        return [name1 caseInsensitiveCompare:name2];
                                    }];
    NSMutableArray * allMarkers = [NSMutableArray array];
    for (NSString * name in orderedMarkerNames)
    {
        [allMarkers addObject:_markers[name]];
    }
    return [NSArray arrayWithArray:allMarkers];
}

+ (id<SLMarker>)markerWithName:(NSString *)name
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      _markers = [NSMutableDictionary dictionary];
                  });
    
    @synchronized (self)
    {
        id<SLMarker> marker = _markers[name];
        if (marker)
        {
            return marker;
        }
        
        // New marker
        Class aClass = [_loggerClass markerClass];
        marker = [[aClass alloc] init];
        ((id<SLMarker>)marker).name = name;
        _markers[name] = marker;
        
        return marker;
    }
}

@end


@implementation SLSimpleMarker

@end


//@implementation SLNOPLogger
//
//+ (Class<SLMarker>)markerClass
//{
//    return nil;
//}
//
//+ (void)logWithMarker:(id<SLMarker>)marker
//                level:(SLLevel)level
//                 path:(const char *)file
//                 line:(uint32_t)line
//             function:(const char *)function
//               format:(NSString *)format, ...
//{
//    return;
//}
//
//+ (BOOL)isLogWithMarker:(id<SLMarker>)marker
//        enabledForLevel:(SLLevel)level
//{
//    return NO;
//}
//
//@end
//
//
//@implementation SLNSLogger
//
//+ (Class<SLMarker>)markerClass
//{
//    return [SLSimpleMarker class];
//}
//
//+ (void)logWithMarker:(id<SLMarker>)marker
//                level:(SLLevel)level
//                 path:(const char *)file
//                 line:(uint32_t)line
//             function:(const char *)function
//               format:(NSString *)format, ...
//{
//    return;
//}
//
//+ (BOOL)isLogWithMarker:(id<SLMarker>)marker
//        enabledForLevel:(SLLevel)level
//{
//    return NO;
//}
//
//+ (SLLevel)logLevelForMarker:(id<SLMarker>)marker
//{
//    return SLLevelOff;
//}
//
//+ (void)setLogLevel:(SLLevel)level
//          forMarker:(id<SLMarker>)marker
//{
//    return;
//}
//
//@end

