//
//  LRDQSenderMngView.m
//  LRDQSender
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQSenderMngView.h"
#import "UIView+Extension.h"
#define Margin 8.f
@implementation LRDQSenderMngView

+(instancetype)senderMngView{
    LRDQSenderMngView * senderMngView=[[LRDQSenderMngView alloc]init];
    senderMngView.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.7,5*Margin+3*30.f+44.f);
    senderMngView.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5,[UIScreen mainScreen].bounds.size.height/3);
    senderMngView.backgroundColor=[UIColor lightGrayColor];
    return senderMngView;
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        UITextField * desc=[[UITextField alloc]init];
        _desc=desc;
        [self addSubview:desc];
        desc.placeholder=@"请输入快递具体描述";
        desc.backgroundColor=[UIColor whiteColor];
        
        UITextField *tel=[[UITextField alloc]init];
        _tel=tel;
        tel.placeholder=@"请输入电话";
        [self addSubview:tel];
        tel.backgroundColor=[UIColor whiteColor];
        
        UITextField *address=[[UITextField alloc]init];
        _address=address;
        address.placeholder=@"请输入地址";
        [self addSubview:address];
       address.backgroundColor=[UIColor whiteColor];
        
        UIButton * cancel=[[UIButton alloc]init];
        _cancel=cancel;
        [self addSubview:cancel];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * sender=[[UIButton alloc]init];
        _sender=sender;
        [self addSubview:sender];
        [sender setTitle:@"发送" forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(senderButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
   
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _address.frame=CGRectMake(Margin, Margin, self.frame.size.width-2*Margin, 30.f);
    
    _tel.frame=CGRectMake(_address.left, _address.bottom+Margin, _address.width, _address.height);
    
    _desc.frame=CGRectMake(_tel.left, _tel.bottom+Margin, _tel.width, _tel.height);
    
    _cancel.frame=CGRectMake(_desc.left, _desc.bottom+8.f, (_desc.width-Margin)*0.5, 44.f);
    
    _sender.frame=CGRectMake(_cancel.right+Margin, _cancel.top, (_desc.width-Margin)*0.5, 44.f);
    
    
}
-(void)cancelButtonClicked:(UIButton*)sender{
    [self hide];
    
}
-(void)senderButtonClicked:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(senderMngView:senderMngtoHome:::)]) {
        
        if (_address.text.length==0||_tel.text.length==0||_desc.text.length==0) {
            UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没输全信息呢，亲！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
        }else {
        [_delegate senderMngView:self senderMngtoHome:_address.text :_tel.text :_desc.text];
    }
    }
}
-(void)showInView:(UIView *)view{
    UIView * coverBoard=[[UIView alloc]init];
    _coverBoard=coverBoard;
    coverBoard.frame=[UIScreen mainScreen].bounds;
    [view addSubview:coverBoard];
    coverBoard.backgroundColor=[UIColor grayColor];
    coverBoard.alpha=0.3f;
}
-(void)hide{
    [_coverBoard removeFromSuperview];
    [self removeFromSuperview];
}

-(void)setMsgModel:(LRDQHomeMsgModel *)msgModel{//1109没用
    msgModel.isload = NO;
}
@end