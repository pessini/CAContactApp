//
//  Contato.m
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "Contato.h"

@implementation Contato


- (CLLocationCoordinate2D) coordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString * )title
{
    return self.nome;
}

- (NSString *)subtitle
{
    return self.telefone;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <%@>", self.nome, self.email];
}


// encode é colocar os elementos da lista em uma lista de bytes (gravação local em arquivo)
- (void) encodeWithCoder: (NSCoder *) aCoder
{
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefone forKey:@"telefone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.endereco forKey:@"endereco"];
    [aCoder encodeObject:self.site forKey:@"site"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.foto forKey:@"foto"];
}


// ao invés de chamar o init normal, ele já pega o objeto encodado e retorna as informações com decode
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        self.nome = [aDecoder decodeObjectForKey:@"nome"];
        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
        self.site = [aDecoder decodeObjectForKey:@"site"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.foto = [aDecoder decodeObjectForKey:@"foto"];
    }
    
    return self;
}

@end
