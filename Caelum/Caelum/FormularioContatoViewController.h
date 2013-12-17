//
//  FormularioContatoViewController.h
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "FormularioContatoViewControllerDelegate.h"

//@interface FormularioContatoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@interface FormularioContatoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;

- (IBAction)proximoCampo:(UITextField *)campoAtual;

// ele não trabalha com a lista, só tem a referência do contato na lista
@property (weak) id<FormularioContatoViewControllerDelegate> delegate;

- (id)initWithContato:(Contato *)contato;
@property (strong) Contato * contato;

- (IBAction)botaoAdicionaImagem:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
- (IBAction)buscarCoordenadas:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (weak) NSManagedObjectContext * context;

@end
