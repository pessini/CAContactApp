//
//  Contato.m
//  Caelum
//
//  Created by ios3918 on 10/12/13.
//  Copyright (c) 2013 ios3918. All rights reserved.
//

#import "Contato.h"

@implementation Contato

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ <%@>", self.nome, self.email];
}

@end
