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
    form.delegate = self;
    
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

// quando o view irá aparecer ele recarrega os dados da tabela
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated]; // manter a herança da classe para não perder algo de importante
    
    NSIndexPath * ip = [NSIndexPath indexPathForRow:self.linhaSelecionada inSection:0];
    
    [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
}

// reescrevendo objeto para pegar a mensagem do botão delete que herdamos da classe e colocando ação de deletar
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // se a mensagem enviada é para deletar
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.contatos removeObjectAtIndex:indexPath.row]; // apaga o contato no file
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // apaga a linha (está no plural pq é um array e por isso que está @[indexPath]
        
    }
}

// pega a ação de tocar na linha da tabela e vamos reescrever o método para dar resposta a essa mensagem
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contato * contato = self.contatos[indexPath.row];
    
//    NSLog(@"%@", contato);
    
    FormularioContatoViewController * form = [[FormularioContatoViewController alloc] initWithContato: contato];
    
    [self.navigationController pushViewController:form animated:YES];
    
}

- (void)contatoAdicionado:(Contato *)novoContato
{
    [self.contatos addObject:novoContato];
    
    self.linhaSelecionada = [self.contatos indexOfObject:novoContato];
}

@end
