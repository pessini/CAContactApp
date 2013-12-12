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

// Depois da  versão 2.0 vamos declarar a interface privada da classe com a variável para usar nos objetos (iVar)

@interface ListaContatosViewController()
{
    Contato *contatoSelecionado;
}
@end

@implementation ListaContatosViewController


// sobrescrever o init do NSObject
- (id)init
{
    self = [super init];
    if (self) {

        UIImage * img = [UIImage imageNamed:@"lista-contatos.png"]; //nome de image lógico que ele busca a imagem de acordo com a tela
        UITabBarItem * tbi = [[UITabBarItem alloc] initWithTitle:@"Contatos" image:img tag:0];
        
        self.tabBarItem = tbi;
        
        // coloca o título na barra de navegação
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem * botaoAvancaCadastro = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        
        self.navigationItem.rightBarButtonItem = botaoAvancaCadastro;
        
        // adicionar botão Edit para editar elementos da TableView
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        self.linhaSelecionada = -1;
        
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
    
    if (self.linhaSelecionada >= 0) {

        NSIndexPath * ip = [NSIndexPath indexPathForRow:self.linhaSelecionada inSection:0];
    
        [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        self.linhaSelecionada = -1;
    }
    
}


// não é colocado no init porque os Outlets ainda não estão prontos
// portanto o Xcode não dará erro porém o gesto não será reconhecido
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIGestureRecognizer * gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:gr];
    
}

- (void) exibeMaisAcoes:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
    // verifica se o besto está no começo (se você deixar para o final, o usuário irá segurar e enquanto não soltar o menu de ações não aparece
        
        // a classe de gestos reconhece apenas o XY
        
        // CGPoint é um structure do C (por isso não tem referência)
        CGPoint ponto = [gesture locationInView:self.tableView];
        
        NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:ponto];
        
        contatoSelecionado = self.contatos[ip.row];
        
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:contatoSelecionado.nome delegate:self cancelButtonTitle:@"Cancela" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar E-mail", @"Visualizar Site", @"Mostrar Mapa", nil];
        
        [as showInView:self.view];
        
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    //NSLog(@"Botão %d", buttonIndex);
    
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        default:
            break;
    }
    
}

- (void)ligar
{
    UIDevice *device = [UIDevice currentDevice];
    
    // iPhone
    // iPad
    // iPod touch
    // iPhone Simulator
    // openURL (biblioteca para comunicar com o iOS) - http://handleopenurl.com/
    if ([device.model isEqualToString:@"iPhone"]) {
        
        NSString *numero = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.telefone];
        
        [self abrirAplicativoComURL: numero];
        
    }else{
        
        [[[UIAlertView alloc] initWithTitle:@"Impossível fazer a ligação" message:@"Seu dispositivo não é um iPhone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
    }
}

- (void)abrirAplicativoComURL: (NSString *)strURL
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL]];
}

- (void)enviarEmail
{

    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        
        mc.mailComposeDelegate = self;
        
        [mc setToRecipients:@[contatoSelecionado.email]];
        
        [mc setSubject:@"Contatos Caelum"];
        
        [self presentViewController:mc animated:YES completion:nil];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Não é possível enviar e-mail" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // retirar a tela quando terminar a ação do e-mail
    
    /*
        Para tratar o resultado tem 4 variáveis
     
        MFMAilComposeResultCancelled
        MFMAilComposeResultSaved
        MFMAilComposeResultSent
        MFMAilComposeResultFailed   

     */
}

- (void)abrirSite
{
    [self abrirAplicativoComURL:contatoSelecionado.site]; // poderia verificar se tem ou não o http://
    // aqui não precisa verificar pois todo o dispositivo tem Safari
}

- (void)mostrarMapa
{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco]
                     stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [self abrirAplicativoComURL:url];

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
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
    
}

- (void)contatoAdicionado:(Contato *)novoContato
{
    [self.contatos addObject:novoContato];
    
    self.linhaSelecionada = [self.contatos indexOfObject:novoContato];
}

- (void)contatoAlterado:(Contato *)contato
{
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
}

@end
