//
//  RunLoopUseAgeViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/1/11.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "RunLoopUseAgeViewController.h"
#include <mach/mach_time.h>
#import <pthread.h>

typedef struct __CFRuntimeBase {
    uintptr_t _cfisa;
    uint8_t _cfinfo[4];
#if __LP64__
    uint32_t _rc;
#endif
} CFRuntimeBase;

typedef mach_port_t __CFPort;
#define CFPORT_NULL MACH_PORT_NULL
typedef mach_port_t __CFPortSet;

typedef struct _per_run_data {
    uint32_t a;
    uint32_t b;
    uint32_t stopped;
    uint32_t ignoreWakeUps;
} _per_run_data;



struct __CFRunLoopMode {
    CFRuntimeBase _base;
    pthread_mutex_t _lock;    /* must have the run loop locked before locking this */
    CFStringRef _name;
    Boolean _stopped;
    char _padding[3];
    CFMutableSetRef _sources0;
    CFMutableSetRef _sources1;
    CFMutableArrayRef _observers;
    CFMutableArrayRef _timers;
    CFMutableDictionaryRef _portToV1SourceMap;
    __CFPortSet _portSet;
    CFIndex _observerMask;
#if USE_DISPATCH_SOURCE_FOR_TIMERS
    dispatch_source_t _timerSource;
    dispatch_queue_t _queue;
    Boolean _timerFired; // set to true by the source when a timer has fired
    Boolean _dispatchTimerArmed;
#endif
#if USE_MK_TIMER_TOO
    mach_port_t _timerPort;
    Boolean _mkTimerArmed;
#endif
#if DEPLOYMENT_TARGET_WINDOWS
    DWORD _msgQMask;
    void (*_msgPump)(void);
#endif
    uint64_t _timerSoftDeadline; /* TSR */
    uint64_t _timerHardDeadline; /* TSR */
};

typedef struct __CFRunLoopMode *CFRunLoopModeRef;

struct __CFRunLoop {
    CFRuntimeBase _base;
    pthread_mutex_t _lock;  /* locked for accessing mode list */
    __CFPort _wakeUpPort;    // used for CFRunLoopWakeUp 内核向该端口发送消息可以唤醒runloop
    Boolean _unused;
    volatile _per_run_data *_perRunData; // reset for runs of the run loop
    pthread_t _pthread;             //RunLoop对应的线程
    uint32_t _winthread;
    CFMutableSetRef _commonModes;    //存储的是字符串，记录所有标记为common的mode
    CFMutableSetRef _commonModeItems;//存储所有commonMode的item(source、timer、observer)
    CFRunLoopModeRef _currentMode;   //当前运行的mode
    CFMutableSetRef _modes;          //存储的是CFRunLoopModeRef
    struct _block_item *_blocks_head;//doblocks的时候用到
    struct _block_item *_blocks_tail;
    CFTypeRef _counterpart;
};

void foo2(void *arg3)
{
    printf("调用");
}

typedef struct
{
    int a;
    void *(*foo)(void *arg1); //函数指针 返回值 是一个 void *的指针
    void (*foo1)(void *arg2); //指针函数 一个指针 指向一个函数
}CFContext;


@interface RunLoopUseAgeViewController ()

@end

@implementation RunLoopUseAgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)configSetting
{
    CFContext c1;
    int b = 8;
    int *c = &b;
    c1.foo1 = &foo2;
    c1.foo1(c);
    uint64_t timeNow = mach_absolute_time();
//    pthread_mutex_lock()
    
}
- (IBAction)creatRunLoopAction:(UIButton *)sender
{
    
    [self creatARunloop];
}

- (void)creatARunloop
{
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    pthread_t thread1 = pthread_self();
    int result = pthread_equal(thread1, runloop->_pthread);
    NSLog(@"result is %d",result);
    
//    pthread_t thread2 = NULL;
//    pthread_attr_t attr;
//    pthread_attr_init(&attr);
//    pthread_attr_setschedparam(attr, <#const struct sched_param *restrict _Nonnull#>)
//
//    int res = pthread_create(thread2, <#const pthread_attr_t *restrict _Nullable#>, <#void * _Nullable (* _Nonnull)(void * _Nullable)#>, <#void *restrict _Nullable#>)
}

- (void)runThread2:(void *)obj
{
    
}



@end
