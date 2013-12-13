//
//  ContatosMapaViewController.h
//  Caelum
//
//  Created by ios3918 on 12/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContatosMapaViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (weak) NSMutableArray * contatos; // pode ser weak porque ela é dependente dos contatos

@end
