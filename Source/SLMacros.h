//
//  SLLibMacros.h
//  LoggingDemo
//
//  Created by 利辺羅 on 2014/12/10.
//  Copyright (c) 2014年 SLF4C. All rights reserved.
//

#import "SLLogger.h"

#define SLMarkerName @"App"

#define LOG_MACRO(_lvl, _frmt, ...) \
        do { Class<SLLogger> _lgr = [SLLog loggerClass]; \
             id<SLMarker> _mrk = [self markerWithName:SLMarkerName]; \
             if([_lgr isLogWithMarker:_mrk enabledForLevel:_lvl]) { \
                 [_lgr logWithMarker:_mrk \
                 level:_lvl \
                 path:__FILE__ \
                 line:__LINE__ \
                 function:__PRETTY_FUNCTION__ \
                 format:_frmt, ##__VA_ARGS__]; }} while(0)

#define SLError(frmt, ...)   LOG_MACRO(SLLevelError,   frmt, ##__VA_ARGS__)
#define SLWarning(frmt, ...) LOG_MACRO(SLLevelWarning, frmt, ##__VA_ARGS__)
#define SLInfo(frmt, ...)    LOG_MACRO(SLLevelInfo,    frmt, ##__VA_ARGS__)
#define SLDebug(frmt, ...)   LOG_MACRO(SLLevelDebug,   frmt, ##__VA_ARGS__)
#define SLVerbose(frmt, ...) LOG_MACRO(SLLevelVerbose, frmt, ##__VA_ARGS__)

