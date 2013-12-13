//
//  AppDelegate.m
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "AppDelegate.h"
#import "FormularioContatoViewController.h"
#import "ListaContatosViewController.h"
#import "ContatosMapaViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // design pattern para criar e limitar a janela dependendo do dispositivo
    
    // busca a pasta do usuário Documents/ é um array pois no Mac tem a pasta Global e do usuário porém no iphone sempre é do usuário
    NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = userDirs[0]; // é o [0] pq no iOS só tem a pasta do usuário
    self.caminhoArquivo = [NSString stringWithFormat:@"%@/caminhoArquivo", documentDir];
    
    // faz um decode na lista para transformar o binário da lista em lista novamente
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.caminhoArquivo];
    
    if (!self.contatos) { // na primeira vez que a aplicação carregar ele verifica se tem o array, se não ele inicializa o objeto
        self.contatos = [[NSMutableArray alloc] init];
    }
    
    // inicio a view criada para a lista
    ListaContatosViewController * lista = [[ListaContatosViewController alloc] init];
    
    // injetar dependência via setter (agora tem uma referência para o mesmo objeto da lista)
    lista.contatos = self.contatos;
    
    ContatosMapaViewController * mapa = [[ContatosMapaViewController alloc] init];
    mapa.contatos = self.contatos; // injetou a dependência para o mapa
    
    UITabBarController * tabs = [[UITabBarController alloc] init];
    
    // inicia a barra de navegação e coloca a lista acima
    UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:lista];
    UINavigationController * navigationMapa = [[UINavigationController alloc] initWithRootViewController:mapa];
    
    // criando a view que tem o menu
    tabs.viewControllers = @[navigation, navigationMapa];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabs; // colocando o form como janela principal
    [self.window makeKeyAndVisible]; // com colchetes estou mandando uma mensagem para esse objeto
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application // press Home button
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // grava os contatos da lista no arquivo local do iOS
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.caminhoArquivo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application // return to application after to enter in background
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application // iOS kill your application or you kill by yourself
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
