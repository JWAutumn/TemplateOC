//
//  Injection.h
//  ControlPressure
//
//  Created by 帝云科技 on 2020/3/27.
//  Copyright © 2020 帝云科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#if DEBUG

@interface DYViewController (Injection)

@end

@interface DYView (Injection)

@end

@interface DYTableViewCell (Injection)

@end

@interface DYCollectionViewCell (Injection)

@end

#endif
