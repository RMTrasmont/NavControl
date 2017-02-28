//
//  NewCompanyViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/16/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "NewCompanyViewController.h"

@interface NewCompanyViewController ()

@property (nonatomic)float textFieldWidth;
@property (nonatomic)float textFieldHeight;

@property (strong,nonatomic)UITextField *theNewCompanyNameTextField;
@property (strong,nonatomic)UITextField *theNewCompanyLogoURLTextField;

@property (nonatomic) DAO *dataManager;

@end



@implementation NewCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataManager = [DAO sharedManager];
    
    //ADD BACKGROUND COLOR
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //ADD HEADER TITLE
    [self.navigationItem setTitle:@"New Company"];
    
    //ADD CANCEL BUTTON TO TOP LEFT BAR
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                               target:self
                                               action:@selector(popToCompanyViewController)]   //<---MAKE & DEFINE METHOD
                                              autorelease];

    //ADD SAVE BUTTON TO TOP RIGHT BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                               target:self action:@selector(saveNewCompany)]  // <--- MAKE & DEFINE METHOD
                                               autorelease];
    
    
    //SET PROPORTIONAL TEXTFIELD SIZES
    [self proportionalWidth:0.9f];
    [self proportionalHeight:0.075f];
    
    //ADD TEXTFIELD FOR NEW COMPANY
    self.theNewCompanyNameTextField = [self createTextFieldNamed:@"ENTER COMPANY NAME" withXLocation:20.0f withYLocation:100.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0];   // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD TEXTFIELD FOR COMPANY LOGO URL
     self.theNewCompanyLogoURLTextField = [self createTextFieldNamed:@"ENTER COMPANY LOGO URL" withXLocation:20.0F withYLocation:180.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];  // <--- CAN USE ID TAG TO REFER TO THE TEXT FIELD
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************************************************************************
//METHOD TO POP BACK TO COMPANY VIEW CONTROLLER / SEGUE WILL ONLY ADD ANOTHER LAYER OF THE SAME VIEW
-(void)popToCompanyViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//************************************************************************************
//METHOD TO ADD COMPANY TO LIST OF COMPANIES & THEN SEGUE BACK TO TO COMPANY LIST VIEW 
-(void)saveNewCompany{
    //GET TEXTFIELD INPUT FOR NEW COMPANY AND COMPANY LOGO URL
    NSString *newCompany = self.theNewCompanyNameTextField.text;
    NSLog(@"%@",newCompany);
    
    NSURL *newCompanyLogoURL = [NSURL URLWithString: self.theNewCompanyLogoURLTextField.text];
    NSLog(@"%@",newCompanyLogoURL);
    
    //SET THE TEXTFIELD INPUT TO LOCAL VARIABLES COMPANY NAME & URL VARIABLE
    self.theNewCompanyName = self.theNewCompanyNameTextField.text;
    self.theNewCompanyURL = [NSURL URLWithString:(self.theNewCompanyLogoURLTextField.text)];
    
    //CREATE A NEW COMPANY USING DAO METHOD AND GIVE IT THE LOCAL NAME & URL
    Company *madeCompany = [self.dataManager makeNewCompanyWithName:self.theNewCompanyName andLogoURL:self.theNewCompanyURL];
    
    //ADD COMPANY DAO ARRAY
    [self.dataManager.companyListDAO addObject:madeCompany];
    
    //POP BACK TO COMPANY VIEW CONTROLLER // PUSHING ONLY ADDS ANOTHER LAYER OF THE SAME VIEW
    [self.navigationController popViewControllerAnimated:YES];
}

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
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



@end
