//
//  FormularioContatoViewController.m
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// sobrescrever o init do NSObject
- (id)init
{
    self = [super init];
    if (self) {
        self.contatos = [[NSMutableArray alloc] init];
        
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *botaoAddContato = [[UIBarButtonItem alloc]
                                            initWithTitle:@"Confimar"
                                            style:UIBarButtonItemStylePlain
                                            target:self
                                            action:@selector(criaContato)];
        
        self.navigationItem.rightBarButtonItem = botaoAddContato;
    }
    return self;
}

- (void)criaContato
{
    // cria o objetivo contato
    Contato * contato = [self pegaDadosFormulario];
    
    // (envia uma mensagem) adicionar os contatos na lista criada NSMutableArray * contatos
    [self.contatos addObject:contato];
    
    NSLog(@"Contatos: %@", self.contatos);
    
    // desempilha para voltar a view anterior
    [self.navigationController popViewControllerAnimated:YES];
}

- (Contato *)pegaDadosFormulario {
    
    // cria o objetivo contato
    Contato * contato = [[Contato alloc] init];
    
    // preenche o objeto com os dados preenchidos
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    //[self.view endEditing:YES]; // esconder o teclado
    
    return contato;

}
- (IBAction)proximoCampo:(UITextField *)campoAtual {
    
    UIResponder * proximoCampo = [self.view viewWithTag:(campoAtual.tag+1)];
    
    if (proximoCampo) {
        [proximoCampo becomeFirstResponder];
    } else {
        [campoAtual resignFirstResponder];
    }

}

@end
