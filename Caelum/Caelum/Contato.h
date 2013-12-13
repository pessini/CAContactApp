//
//  Contato.h
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contato : NSObject<NSCoding>

@property (copy) NSString * nome;
@property (copy) NSString * telefone;
@property (copy) NSString * email;
@property (copy) NSString * endereco;
@property (copy) NSString * site;
@property (copy) NSString * latitude;
@property (copy) NSString * longitude;
@property (strong) UIImage * foto;

/*
 
 Gerenciamento de memória
 ARC - weak, copy, strong
 non-ARC - assign, copy, retain
 
DICA: Se for Outlet você usa weak. Se não for Outlet, você usa strong.
 */


@end
