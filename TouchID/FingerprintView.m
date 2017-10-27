//
//  FingerprintView.m
//  zhbg
//
//  Created by liulc on 16/11/23.
//  Copyright © 2016年 王光虎. All rights reserved.
//

#import "FingerprintView.h"

@interface FingerprintView ()
//@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,strong) UIButton *fingerprintButton;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton * accountLoginButton;
@end

#define centerP        [UIApplication sharedApplication].keyWindow.center
#define AppFrameWidth       [UIScreen mainScreen].applicationFrame.size.width//获取屏幕宽度
#define AppFrameHeight      [UIScreen mainScreen].applicationFrame.size.height//获取屏幕高度
#define TitleColor [UIColor blackColor]                   //标题颜色

@implementation FingerprintView

+ (instancetype)viewWithAccount:(NSString *)account fingerprintBlock:(void (^)())fingerprintBlock accountLoginBlock:(void (^)())accountLoginBlock{
    //类方法中无法直接调用实例方法
    FingerprintView *fingerPrintView = [[FingerprintView alloc] initWithAccount:account fingerprintBlock:fingerprintBlock accountLoginBlock:accountLoginBlock];
    return fingerPrintView;

}

- (instancetype)initWithAccount:(NSString *)account fingerprintBlock:(void (^)())fingerprintBlock accountLoginBlock:(void (^)())accountLoginBlock{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.FingerprintBlock = fingerprintBlock;
        self.AccountLoginBlock = accountLoginBlock;
        
        self.backgroundColor = [UIColor whiteColor];
        //布局
        // UIImageView *imageView = [[UIImageView alloc] init];
        // //imageView.image = [UIImage imageNamed:@"logo.png"];
        // self.imageView = imageView;
        // [self addSubview:imageView];
        
        UILabel *accountLabel = [[UILabel alloc] init];
        accountLabel.backgroundColor = [UIColor clearColor];
        accountLabel.textAlignment = NSTextAlignmentCenter;
        accountLabel.textColor = TitleColor;
        accountLabel.text = [NSString stringWithFormat:@"%@用户",account];
        [accountLabel sizeToFit];
        self.accountLabel = accountLabel;
        [self addSubview:accountLabel];
    
        UIButton *fingerprintButton =  [UIButton buttonWithType:UIButtonTypeCustom]; ;
        [fingerprintButton setBackgroundImage:[UIImage imageNamed:@"fingerprint"] forState:UIControlStateNormal];
        [fingerprintButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        self.fingerprintButton = fingerprintButton;
        [self addSubview:fingerprintButton];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.text = @"点击进行指纹登录";
        [detailLabel sizeToFit];
        self.detailLabel = detailLabel;
        [self addSubview:detailLabel];
        
        UIButton *accountLoginButton = [[UIButton alloc] init];
        [accountLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [accountLoginButton setTitle:@"切换其它登录方式" forState:UIControlStateNormal];
        [accountLoginButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        self.accountLoginButton = accountLoginButton;
        [self addSubview:accountLoginButton];
    }
    
    return self;
}

- (void)clickedButton:(UIButton *)button
{
    if (button == self.fingerprintButton) {
        if (self.FingerprintBlock) {
            self.FingerprintBlock();
        }
    }else if (button == self.accountLoginButton){
        if (self.AccountLoginBlock) {
            self.AccountLoginBlock();
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];

    //self.imageView.frame = CGRectMake((AppFrameWidth - 80)/2, 70, 80, 80);
    self.accountLabel.center = CGPointMake(centerP.x, centerP.y+70);
    self.fingerprintButton.frame = CGRectMake(0, 0, 70, 70);
    self.fingerprintButton.center = centerP;
    self.detailLabel.center = CGPointMake(centerP.x, centerP.y+50);
    self.accountLoginButton.frame = CGRectMake(0, AppFrameHeight - 90, AppFrameWidth, 60);;
    
}


@end
