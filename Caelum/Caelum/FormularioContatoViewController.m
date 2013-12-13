//
//  FormularioContatoViewController.m
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"
#import <CoreLocation/CoreLocation.h>

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
    
    // caso eu esteja alterando (pq se eu tiver incluindo ele não terá contato, ou seja, terá nil)
    
    if (self.contato) {
        self.nome.text= self.contato.nome;
        self.telefone.text= self.contato.telefone;
        self.email.text= self.contato.email;
        self.endereco.text= self.contato.endereco;
        self.site.text= self.contato.site;
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];

        if (self.contato.foto) {
            [self.botaoFoto setImage:self.contato.foto forState:UIControlStateNormal];
        }
    }
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
    [self.delegate contatoAdicionado:contato];
    
    // desempilha para voltar a view anterior
    [self.navigationController popViewControllerAnimated:YES];
}


// ********** DICA ****************
//  é possível fazer a lógica com um design pattern chamado Command (derivado do strategy)
// ********************************
- (Contato *)pegaDadosFormulario {
    
    if (!self.contato) { // verifica se não existe (se não, é uma inclusão...se sim, é esse mesmo que quero atualizar)
        // cria o objetivo contato
        self.contato = [[Contato alloc] init];
    }
    // preenche o objeto com os dados preenchidos
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    self.contato.latitude = [NSNumber numberWithFloat:[self.latitude.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue]];
    
    if (self.botaoFoto.imageView.image) {
        self.contato.foto = self.botaoFoto.imageView.image;
    }
    
    //[self.view endEditing:YES]; // esconder o teclado
    
    return self.contato;

}
- (IBAction)proximoCampo:(UITextField *)campoAtual {
    
    UIResponder * proximoCampo = [self.view viewWithTag:(campoAtual.tag+1)];
    
    if (proximoCampo) {
        [proximoCampo becomeFirstResponder];
    } else {
        [campoAtual resignFirstResponder];
    }

}

// sobrescrever o init do Contato (alteração de algum dado)
- (id)initWithContato:(Contato *)contato
{
    self = [super init];
    if (self) {
        self.contato = contato;
        self.navigationItem.title = @"Alteração";
        
        UIBarButtonItem *botaoAlterContato = [[UIBarButtonItem alloc]
                                            initWithTitle:@"Alterar"
                                            style:UIBarButtonItemStylePlain
                                            target:self
                                            action:@selector(alteraContato)];
        
        self.navigationItem.rightBarButtonItem = botaoAlterContato;
        
    }
    return self;
}

- (void)alteraContato
{
    // temos o endereço do contato na memória (re-utiliza o pegaDadosFormulario pois ele já faz a lógica)
    Contato * c = [self pegaDadosFormulario];
    [self.delegate contatoAlterado:c];

    // desempilha (pilha de navegação) para voltar a view anterior
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)botaoAdicionaImagem:(id)sender
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //
    }else{

        UIImagePickerController* picker = [[UIImagePickerController alloc] init];

        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;

        [self presentViewController:picker animated:YES completion:nil];

    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // aqui trata a alteração do botão
    
    UIImage * imagemSelecionada = info[UIImagePickerControllerEditedImage];
    
    [self.botaoFoto setImage:imagemSelecionada forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)buscarCoordenadas:(id)sender
{
    
    [self.loading startAnimating];
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:self.endereco.text completionHandler: ^ (NSArray * resultados, NSError * erro)
     {
         if (erro == nil && [resultados count] > 0) {
             CLPlacemark * resultado = resultados[0];
             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
             self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
             self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
         }
         [self.loading stopAnimating];
     }
    ];
    
}

@end
