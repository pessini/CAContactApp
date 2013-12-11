//
//  ListaContatosViewController.m
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"
#import "Contato.h"

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
        
        // adicionar botão Edit para editar elementos da TableView
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
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

// TableView - Seções? Linhas? O que?

// Seções - agrupamento de linhas (por exemplo nos contatos organiza e agrupa contatos por letra, A / B / C)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Nº de linhas
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contatos count]; // envia mensagem para a lista e confere quantos contatos existe na mesma
}

// o que será exibido na linha

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * pool = @"pool";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:pool];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pool];
    }
    
    //Contato * contato = [self.contatos objectAtIndex:indexPath.row];
    Contato * contato = self.contatos[indexPath.row];
    cell.textLabel.text = contato.nome;

    return cell;
}

// quando o view irá aparecer ele recarrega os dados da tabela
- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}


@end
