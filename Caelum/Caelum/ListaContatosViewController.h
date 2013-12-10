//
//  ListaContatosViewController.h
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListaContatosViewController : UITableViewController

@property (weak) NSMutableArray * contatos; // pode ser weak porque ela é dependente dos contatos

@end
