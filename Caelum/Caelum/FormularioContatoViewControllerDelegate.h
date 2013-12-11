//
//  FormularioContatoViewControllerDelegate.h
//  Caelum
//
//  Created by ios3918 on 11/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol FormularioContatoViewControllerDelegate <NSObject>

- (void) contatoAdicionado: (Contato *)novoContato;

@end
