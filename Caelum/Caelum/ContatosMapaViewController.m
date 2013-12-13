//
//  ContatosMapaViewController.m
//  Caelum
//
//  Created by ios3918 on 12/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "ContatosMapaViewController.h"
#import "Contato.h"

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
    
    //criando o botão de navegação do mapa
    MKUserTrackingBarButtonItem * btn = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    
    self.navigationItem.leftBarButtonItem = btn;
    
    
    // delegar via código (porém fizemos via .xib arrastando até o file's owner e selecionando delegate
   // self.mapa.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.mapa addAnnotations: self.contatos];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapa removeAnnotations:self.contatos];
}

// aqui você customiza o alfinete e o balão do mapa
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString * pool = @"pool";

    MKPinAnnotationView * pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pool];

    if (!pin){
    
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pool];
    }else{
        pin.annotation = annotation;
    }

    pin.pinColor = MKPinAnnotationColorRed;

    pin.canShowCallout = YES;

    Contato * contato = (Contato *)annotation;
    
    if (contato.foto) {
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        
        imagemContato.image = contato.foto;
        pin.leftCalloutAccessoryView = imagemContato;
    }
    
    return pin;

}

@end
