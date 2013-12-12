//
//  ListaContatosViewController.h
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormularioContatoViewControllerDelegate.h"

@interface ListaContatosViewController : UITableViewController <FormularioContatoViewControllerDelegate, UIActionSheetDelegate>

@property (weak) NSMutableArray * contatos; // pode ser weak porque ela é dependente dos contatos

// assign pq é uma propriedade primitiva (porém para o ARC o assign e weak é o mesmo)
@property (assign) NSInteger linhaSelecionada;

- (void) exibeMaisAcoes: (UIGestureRecognizer *) gesture;

@end
