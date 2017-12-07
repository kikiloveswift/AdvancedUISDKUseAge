//
//  AnimationManager.h
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/7.
//  Copyright © 2017年 konglee. All rights reserved.
//
//#ifndef __AdvancedUISDKUseAge__AnimationManager__
//#define __AdvancedUISDKUseAge__AnimationManager__
#import <iostream>

namespace AnimationManager
{
    template <typename T>
    T& GetMax(T& a, T& b)
    {
        if (a < b)
        {
            return b;
        }
        return a;
    }
    int abc;
    
    template<typename T>
    void DisplayResult(T& t1, T& t2)
    {
        std::cout<< GetMax(t1, t2)<< std::endl;
    }
}
