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

- (IBAction)pegaDadosFormulario:(id)sender {
    
    Contato * contato = [[Contato alloc] init];
    
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
   // NSDictionary * newContact = [[NSDictionary alloc] init]; nesse caso a classe NSDictionary é imutável
    
    
    /*
    
     NSMutableDictionary * contato = [[NSMutableDictionary alloc] init];
    
    [contato setObject:self.nome.text forKey:@"nome"];
    [contato setObject:self.telefone.text forKey:@"telefone"];
    [contato setObject:self.email.text forKey:@"email"];
    [contato setObject:self.endereco.text forKey:@"endereco"];
    [contato setObject:self.site.text forKey:@"site"];
     
     NSLog(@"Contato %@ adicionado com sucesso", contato[@"nome"]);
     
     */
    
    NSLog(@"Contato %@ adicionado com sucesso", contato);
    
    [self.view endEditing:YES]; // esconder o teclado
    
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
