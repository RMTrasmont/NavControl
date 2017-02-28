//
//  EditCompanyViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "EditCompanyViewController.h"

@interface EditCompanyViewController ()
@property (nonatomic)float textFieldWidth;
@property (nonatomic)float textFieldHeight;
@property (strong,nonatomic)UITextField *editNameTextField;
@property (strong,nonatomic)UITextField *editLogoURLTextField;
@property (nonatomic) DAO *dataManager;
@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataManager = [DAO sharedManager];
    
    //ADD BACKGROUND COLOR
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //ADD HEADER TITLE
    [self.navigationItem setTitle:@"Edit Company"];
    
    //ADD CANCEL BUTTON TO TOP LEFT BAR
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                              target:self
                                              action:@selector(popToCompanyViewController)]   //<---MAKE & DEFINE METHOD
                                             autorelease];
    
    //ADD SAVE BUTTON TO TOP RIGHT BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                               target:self action:@selector(saveEditedCompany)]  // <--- MAKE & DEFINE METHOD
                                              autorelease];
    
    //SET PROPORTIONAL TEXTFIELD SIZES
    [self proportionalWidth:0.9f];
    [self proportionalHeight:0.075f];
    
    //ADD TEXTFIELD FOR EDITCOMPANY EDIT NAME SCREEN
    self.editNameTextField = [self createTextFieldNamed:@"EDIT COMPANY NAME" withXLocation:20.0f withYLocation:100.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0];   // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD TEXTFIELD FOR EDITCOMPANY EDIT LOGO URL
    self.editLogoURLTextField = [self createTextFieldNamed:@"EDIT COMPANY LOGO URL" withXLocation:20.0F withYLocation:180.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];  // <--- CAN USE ID TAG TO REFER TO THE TEXT FIELD
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//************************************************************************************
//METHOD TO PROPORTIONALLY ADJUST WIDTH & HEIGHT OF TEXTFIELD IN RELATION TO VIEW
-(void)proportionalWidth:(float)percent{
    _textFieldWidth = self.view.frame.size.width * percent;
}

-(void)proportionalHeight:(float)percent{
    _textFieldHeight = self.view.frame.size.height * percent;
}

//************************************************************************************
//METHOD TO CREATE TEXTFIELD
-(UITextField *)createTextFieldNamed:(NSString *)placeHolder withXLocation:(float)x withYLocation:(float)y withWidth:(float)width andHeight:(float)height withIDTag:(int)tag{
    
    CGRect newTextFieldFrame = CGRectMake(x,y,width,height);
    UITextField *newTextField = [[UITextField alloc] initWithFrame:newTextFieldFrame];
    newTextField.placeholder = placeHolder;
    newTextField.backgroundColor = [UIColor whiteColor];
    newTextField.textColor = [UIColor blackColor];
    newTextField.font = [UIFont systemFontOfSize:14.0f];
    newTextField.textAlignment = NSTextAlignmentCenter;
    newTextField.borderStyle = UITextBorderStyleRoundedRect;
    newTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    newTextField.returnKeyType = UIReturnKeyDone;
    newTextField.textAlignment = NSTextAlignmentCenter;
    newTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    newTextField.tag = tag;
    newTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:newTextField];
    return newTextField;
}

//************************************************************************************
//OVERRIDE METHOD TO MAKE KEYBOARD DISAPEAR WHEN BACKGROUND IS TOUCHED
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

//METHOD TO POP OUT OF EDIT SCREEN
-(void)popToCompanyViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

//METHOD TO SAVE INFO IN EDIT COMPANY SCREEN
-(void)saveEditedCompany{
    NSString *editedCompanyName = self.editNameTextField.text;
    NSLog(@"%@",editedCompanyName);
    
    NSURL *editedCompanyLogoURL = [NSURL URLWithString:self.editLogoURLTextField.text];
    NSLog(@"%@",editedCompanyLogoURL);
    
    
    
    NSString *originalName = self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyName;
    NSURL *originalLogoURL = self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyLogoURL;
    
    Company *lastCompanyTouched = self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched];
    
    //SET THE EDITED NEW NAME TO THE COMPANY //IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE THE NAME
    if([self.editNameTextField isEditing]){
        lastCompanyTouched.companyName = editedCompanyName;
    } else {
        lastCompanyTouched.companyName = originalName;
    }

    //SET THE EDITED NEW LOGO URL TO THE COMPANY //IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE THE URL
    if([self.editLogoURLTextField isEditing]){
        lastCompanyTouched.companyLogoURL = editedCompanyLogoURL;
    } else {
        lastCompanyTouched.companyLogoURL = originalLogoURL;
    }
    
    //POP OUT OF THE VIEW
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
