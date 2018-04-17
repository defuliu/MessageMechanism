//
//  Person.m
//  消息机制一
//
//  Created by 刘德福 on 2018/4/17.
//  Copyright © 2018年 Dreams. All rights reserved.
//

#import "Person.h"
#import "Car.h"
#import <objc/message.h>

@implementation Person
/**
 动态方法解析
 @param sel selector
 @return yes or no
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
     // 1.判断没实现方法, 就动态添加方法
//    if (sel == @selector(run)) {
//        // 动态添加方法  IMP(函数指针)
//        class_addMethod(self, sel, (IMP)runValue, "v@:");
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

void runValue(id self , SEL sel)
{
    //id self , SEL sel
}

//二.消息转发重定向
- (id)forwardingTargetForSelector:(SEL)aSelector OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0){
    
    NSLog(@"aSelector ===== :%@",NSStringFromSelector(aSelector));
    
    // return [Car new];
    
    return [super forwardingTargetForSelector:aSelector];
}



//三.生成方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector OBJC_SWIFT_UNAVAILABLE("")
{
    // return [super methodSignatureForSelector:aSelector];
    NSString *selector = NSStringFromSelector(aSelector);
    if ([selector isEqualToString:@"run"]){
        NSLog(@"实现run方法");
    }
    //(const char *)types;
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
 
}

// 四.方法的签名配发
- (void)forwardInvocation:(NSInvocation *)anInvocation OBJC_SWIFT_UNAVAILABLE(""){
    
    NSLog(@"----%@----",anInvocation);
    //1.拿到消息
    SEL selector = [anInvocation selector];
    
    //转发消息
    Car *car = [Car new];
    if ([car respondsToSelector:selector]){
        // 调用这个对象, 去进行转发
        [anInvocation invokeWithTarget:car];
    }
    else {
        /**
         这里抛异常
         */
        [super forwardInvocation:anInvocation];
    }
}

@end
