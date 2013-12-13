//
//  AppDelegate.h
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//


/*
 
 
 Cocoacontrols (catálogo de componentes/softwares para usar com cocoapods)
 
 Cocoapods - feito em Ruby
 Ajuda no controle das versões do iOS
 
 $gem install cocoapods
 $pod setup
 
 
 
 Podfile
  TPKeyboardAvoiding
 
 */

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong) NSMutableArray * contatos;

@property (strong) NSString *caminhoArquivo;

@end
