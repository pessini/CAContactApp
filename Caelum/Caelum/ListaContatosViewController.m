//
//  ListaContatosViewController.m
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController


// sobrescrever o init do NSObject
- (id)init
{
    self = [super init];
    if (self) {
        
        // coloca o título na barra de navegação
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem * botaoAvancaCadastro = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        
        self.navigationItem.rightBarButtonItem = botaoAvancaCadastro;
        
    }
    return self;
}

- (void)exibeForm
{
    FormularioContatoViewController * form = [[FormularioContatoViewController alloc] init];
    
    // dependência contatos do Formulário agora referencia o mesmo objeto da dependência de contatos da Lista
    form.contatos = self.contatos;
    
    // cria uma pilha de navegação na barra de navegação
    [self.navigationController pushViewController:form animated:YES];
}

@end
