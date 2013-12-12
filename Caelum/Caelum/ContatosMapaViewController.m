//
//  ContatosMapaViewController.m
//  Caelum
//
//  Created by ios3918 on 12/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "ContatosMapaViewController.h"

@interface ContatosMapaViewController ()

@end

@implementation ContatosMapaViewController

// sobrescrever o init do NSObject
- (id)init
{
    self = [super init];
    if (self) {
        
        UIImage * img = [UIImage imageNamed:@"mapa-contatos.png"]; //nome de image lógico que ele busca a imagem de acordo com a tela
        UITabBarItem * tbi = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:img tag:0];
        
        self.tabBarItem = tbi;
        
        // coloca o título na barra de navegação
        self.navigationItem.title = @"Mapa";

        //criando o botão de navegação do mapa
        MKUserTrackingBarButtonItem * btn = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
        
        self.navigationItem.leftBarButtonItem = btn;
        
    }
    return self;
    
}

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

@end
