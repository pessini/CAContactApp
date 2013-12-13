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

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // design pattern para criar e limitar a janela dependendo do dispositivo
    
    // busca a pasta do usuário Documents/ é um array pois no Mac tem a pasta Global e do usuário porém no iphone sempre é do usuário
    NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = userDirs[0]; // é o [0] pq no iOS só tem a pasta do usuário
    self.caminhoArquivo = [NSString stringWithFormat:@"%@/caminhoArquivo", documentDir];
    
    // faz um decode na lista para transformar o binário da lista em lista novamente
    //self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.caminhoArquivo];
    self.contatos = [self buscarContatos];
    
    if (!self.contatos) { // na primeira vez que a aplicação carregar ele verifica se tem o array, se não ele inicializa o objeto
        self.contatos = [[NSMutableArray alloc] init];
    }
    
    // inicio a view criada para a lista
    ListaContatosViewController * lista = [[ListaContatosViewController alloc] init];
    
    // injetar dependência via setter (agora tem uma referência para o mesmo objeto da lista)
    lista.contatos = self.contatos;
    lista.context = self.managedObjectContext;
    
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
    //[NSKeyedArchiver archiveRootObject:self.contatos toFile:self.caminhoArquivo];
    
    [self saveContext]; // você garante que tudo que está na memória, ele persiste no banco de dados
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


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Modelo_Contatos" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Contatos.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSMutableArray *)buscarContatos
{
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    
    NSSortDescriptor * ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    [fr setSortDescriptors: @[ordenarPorNome]];
    
    NSArray * contatosImutaveis = [self.managedObjectContext executeFetchRequest:fr error:nil];
    
    NSMutableArray * contatos = [contatosImutaveis mutableCopy];
    
    return contatos;
     
}

@end
