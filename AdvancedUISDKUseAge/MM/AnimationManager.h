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
    
    typedef int (*fun) (int a);
    typedef int AFun (int b);
    fun funC;
    
    int funB(int b)
    {
        return b;
    }
    void getValue(void)
    {
        funC = funB;
        int c = (*funC)(10);
        std::cout << "c = " << c <<std::endl;
        AFun *funD = funB;
        int d = funD(32);
        std::cout << "d = " << d <<std::endl;
    }
    
    struct job
    {
        char name[40];
        int age;
        double salary;
    };
    template <> void DisplayResult<job>(job& j1, job& j2)
    {
        double temp1;
        int age1;
        age1 = j1.age;
        temp1 = j1.salary;
        j1.age = j2.age;
        j1.salary = j2.salary;
        j2.age = age1;
        j2.salary = temp1;
    }
}
