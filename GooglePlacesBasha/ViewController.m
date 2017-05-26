//
//  ViewController.m
//  GooglePlacesBasha
//
//  Created by Rajashekhar on 24/05/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *PlacesArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationTxtFld.delegate=self;
    _locationTblView.delegate=self;
    _locationTblView.dataSource=self;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_locationTxtFld resignFirstResponder];
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return PlacesArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
        return 30;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
               UILabel *lblname =[[UILabel alloc]initWithFrame:CGRectMake(0,0,300,25)];
            //lblname.backgroundColor=[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0];
            //colorWithRed:124.0/255.0 green:42.0/255.0 blue:46.0/255.0 alpha:1.0];
            lblname.textColor=[UIColor lightGrayColor]; //colorWithRed:136.0/255.0 green:132.0/255.0 blue:130.0/255.0 alpha:1.0];
            [lblname setFont:[UIFont fontWithName:@"SFUIText-Light" size:10]];
            lblname.numberOfLines=2;
            //lblname.text=[arrSearchPKey objectAtIndex:(indexPath.row)];
            
            lblname.text=[PlacesArr objectAtIndex:indexPath.row];
            lblname.textAlignment=NSTextAlignmentLeft;
            UILabel *lblLine =[[UILabel alloc]initWithFrame:CGRectMake(0,20,_locationTblView.frame.size.width,0.5f)];
            lblLine.backgroundColor=[UIColor lightGrayColor];
            [cell addSubview:lblLine];
            [cell addSubview:lblname];
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (PlacesArr.count!=0){
            [_locationTxtFld resignFirstResponder];
            _locationTxtFld.text=[PlacesArr objectAtIndex:indexPath.row];
            _locationTblView.hidden=true;
        }
    }
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [Service getGooglePlaces:_locationTxtFld.text withCompletionBlock:^(NSArray *result, NSError *error) {
        if (!error) {
            //(@"Google places:%@",result);
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSArray *resultArr=[result valueForKey:@"predictions"];
                //(@"predictions:%@",resultArr);
                if (resultArr.count<1) {
                }else{
                    PlacesArr=[resultArr valueForKey:@"description"];
                    //(@"description:%@",PlacesArr);
                    
                }
                
            }
        }
        
    }];
            if (![PlacesArr isKindOfClass:[NSNull class]]) {
            _locationTblView.hidden=false;
            [_locationTblView reloadData];
        }
        if ([_locationTxtFld.text isEqualToString:@""]) {
            _locationTblView.hidden=true;
            
        }
    return YES;
    
}

@end
