
//
//  PGPFoundation.h
//  ObjectivePGP
//
//  Created by Marcin Krzyzanowski on 31/05/2017.
//  Copyright © 2017 Marcin Krzyżanowski. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define PGPCast(obj, c) ((c * _Nullable) _pgp__cast(obj, c.class))

id _Nullable _pgp__cast(id _Nullable obj, Class objClass);

@interface PGPFoundation : NSObject

@end

NS_ASSUME_NONNULL_END
