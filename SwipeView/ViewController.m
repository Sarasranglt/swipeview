//
//  ViewController.m
//  SwipeView
//
//  Created by Libsys on 07/04/15.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{



bool panningLeft;

UIView  *vA;
UIView *vB;
UIView *vC;
int count;


/**
*  Sample data to display inside view you can use images etc. according to your needs
*/
NSArray *dataList;





}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    

    dataList=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"21",@"23",@"24",@"25",@"26",@"27",@"28",@"29"];
    count=2;
    
    vA= _viewA;
    vB=_viewB;
    vC=_viewC;
    
    
}

- (void) configureViewsOnScreen{
    
    UILabel *textA =  ((UILabel*)[[vA subviews] objectAtIndex:0]);
    textA.text=dataList[count-2];
    UILabel *textB =  ((UILabel*)[[vB subviews] objectAtIndex:0]);
    textB.text=dataList[count-1];
    UILabel *textC =  ((UILabel*)[[vC subviews] objectAtIndex:0]);
    textC.text=dataList[dataList.count-1];
    
    
    
    
    UIPanGestureRecognizer *swipeRecognzier=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    
    
    
    
    [_viewA setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    [_viewB setFrame:CGRectMake(self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [_viewC setFrame:CGRectMake(-self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    [((UIView*)[[_viewA subviews] objectAtIndex:0]) setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [((UIView*)[[_viewB subviews] objectAtIndex:0]) setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [((UIView*)[[_viewC subviews] objectAtIndex:0]) setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];

    
    [self.view addGestureRecognizer:swipeRecognzier];
    
    
    
    [_pgNo setFrame:CGRectMake(self.view.frame.size.width/2-_pgNo.frame.size.width/2,self.view.frame.size.height-_pgNo.frame.size.height-10,50,_pgNo.frame.size.height)];
    
    _pgNo.text=[NSString stringWithFormat:@"%d/%d",1,(int)dataList.count];
    
    
    
    
}


-(void)handleBack:(id)sender{
    
    
    vC.hidden=YES;
    vB.hidden=YES;
    vA.hidden=YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLayoutSubviews{
    
    [self configureViewsOnScreen];
    
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    if(panRecognizer.state == UIGestureRecognizerStateEnded )
    {
        if(panningLeft)
        {
            panningLeft=NO;
            [UIView animateWithDuration:0.25 animations:^{
                
                [vA setFrame:CGRectMake(-self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
                [vB setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
                [vC setFrame:CGRectMake(-self.view.frame.size.width-self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
                
                
                
                
                
            } completion:^(BOOL finished){
                
                
                int index = count%dataList.count;
                ((UILabel*)[[vC subviews] objectAtIndex:0]).text=dataList[index];
                
                _pgNo.text=[NSString stringWithFormat:@"%d/%d",index==0?(int)dataList.count:index,(int)dataList.count];
                
                
                count =(count+1)%(dataList.count);
                [vC setFrame:CGRectMake(self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
                
                UIView *tempV=vA;
                vA=vB;
                vB=vC;
                vC=tempV;
                
                
            }];
            
        }
        else{
            
            [UIView animateWithDuration:0.25 animations:^{
                
                [vA setFrame:CGRectMake(self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
                [vC setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
                [vB setFrame:CGRectMake(self.view.frame.size.width+self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
                
            } completion:^(BOOL finished){
                
                
                
                
                int index;
                if(count<=4)
                {
                    index= (int)(dataList.count - abs(count-4)%dataList.count)%dataList.count;
                }
                else{
                    
                    index=(count-4)%dataList.count;
                }
                
                ((UILabel*)[[vB subviews] objectAtIndex:0]).text=dataList[index];
                _pgNo.text=[NSString stringWithFormat:@"%lu/%d",(index+2)%dataList.count==0?(int)dataList.count:(int)(index+2)%dataList.count,(int)dataList.count];
                
                count--;
                if(count==-1)
                    count=(int)dataList.count-1;
                
                
                [vB setFrame:CGRectMake(-self.view.frame.size.width,0, self.view.frame.size.width, self.view.frame.size.height)];
                
                
                UIView *tempV=vB;
                vB=vA;
                vA=vC;
                vC=tempV;
                
                
                
                
            }];
            
            
        }
    }
    else{
        CGPoint translation = [panRecognizer translationInView:self.view];
        
        
        if(translation.x<0)
            panningLeft=YES;
        else
            panningLeft=NO;
        
        
        CGPoint viewPositionA = vA.center;
        CGPoint viewPositionB=vB.center;
        CGPoint viewPositionC=vC.center;
        viewPositionA.x += translation.x;
        viewPositionB.x+= translation.x;
        viewPositionC.x+= translation.x;
        
        
        
        vA.center = viewPositionA;
        vB.center=viewPositionB;
        vC.center=viewPositionC;
        [panRecognizer setTranslation:CGPointZero inView:self.view];
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
