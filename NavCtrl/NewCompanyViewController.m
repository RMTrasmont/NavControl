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
@property (strong,nonatomic)UITextField *theNewCompanyStockSymbolTextField;
@property (strong,nonatomic)UILabel *companyNameLabel;
@property (strong,nonatomic)UILabel *companyURLLabel;
@property (strong,nonatomic)UILabel *companyTickerLabel;
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
                                               action:@selector(popToCompanyViewController)]
                                              autorelease];

    //ADD SAVE BUTTON TO TOP RIGHT BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                               target:self action:@selector(saveNewCompany)]
                                               autorelease];
    
    
    //SET PROPORTIONAL TEXTFIELD SIZES
    [self proportionalWidth:0.9f];
    [self proportionalHeight:0.075f];
    
    //ADD TEXTFIELD FOR NEW COMPANY
    self.theNewCompanyNameTextField = [self createTextFieldNamed:@"ENTER COMPANY NAME" withXLocation:20.0f withYLocation:100.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0];   // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD TEXTFIELD FOR COMPANY LOGO URL
     self.theNewCompanyLogoURLTextField = [self createTextFieldNamed:@"ENTER COMPANY LOGO URL" withXLocation:20.0F withYLocation:180.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];  // <--- CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD TEXTFIELD FOR COMPANY STOCK SYMBOL
    self.theNewCompanyStockSymbolTextField = [self createTextFieldNamed:@"ENTER TICKER SYMBOL" withXLocation:20.0f withYLocation:260.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:2];
    
    //ADD LABEL FOR COMPANY NAME
    self.companyNameLabel = [self createLabelNamed:@"New Company:" withXLocation:20.0f withYLocation:70.0f withWidth:250.0f andHeight:20.0f];
    [self.companyNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //ADD LABEL FOR URL
    self.companyURLLabel = [self createLabelNamed:@"New Logo URL:" withXLocation:20.0f withYLocation:150.0f withWidth:250.0f andHeight:20.0f];
    [self.companyURLLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //ADD LABEL FOR STOCK SYMBOL
    self.companyTickerLabel = [self createLabelNamed:@"Stock Ticker:" withXLocation:20.0f withYLocation:230.0f withWidth:250.0f andHeight:20.0f];
    [self.companyTickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
   //SET TEXTFIELD AS DELEGATE FOR MOVING KEYBOARD
    self.theNewCompanyLogoURLTextField.delegate = self;      //<------
    self.theNewCompanyStockSymbolTextField.delegate = self;  //<------
    

    
}

//************************************************************************************

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

//************************************************************************************

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

}

//************************************************************************************

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************************************************************************
//METHOD TO POP BACK TO COMPANY VIEW CONTROLLER / SEGUE WILL ONLY ADD ANOTHER LAYER OF THE SAME VIEW USED IN "CANCEL" BUTTON
-(void)popToCompanyViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

//************************************************************************************
//METHOD TO ADD COMPANY TO LIST OF COMPANIES & THEN SEGUE BACK TO TO COMPANY LIST VIEW 
-(void)saveNewCompany{
    
    //SET THE TEXTFIELD INPUT TO LOCAL VARIABLES COMPANY NAME & URL VARIABLE
    self.theNewCompanyName = self.theNewCompanyNameTextField.text;
    self.theNewCompanyURL = [NSURL URLWithString:(self.theNewCompanyLogoURLTextField.text)];
    self.theNewCompanyStockSymbol = self.theNewCompanyStockSymbolTextField.text;
    
    //CREATE A NEW COMPANY USING DAO METHOD AND GIVE IT THE LOCAL NAME & URL
    Company *madeCompany = [self.dataManager makeNewCompanyWithName:self.theNewCompanyName withLogoURL:self.theNewCompanyURL andStockSymbol:self.theNewCompanyStockSymbol];
    
    //ASSIGN THE NEW COMPANY TO THE NEWCOMPANY PAROPERTY IN DAO
    self.dataManager.theNewCompanyDAO = madeCompany;
    
    //ADD COMPANY DAO ARRAY
    [self.dataManager.companyListDAO addObject:madeCompany];
    
    //SAVE THE NEW COMPANY TO CORE DATA
    [self.dataManager saveNewCompanyToCoreData];
    
    //LET DAO KNOW THE CURRENT COMPANY
    self.dataManager.currentCompanyDAO = madeCompany;
    
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
//METHOD TO CREATE LABEL
-(UILabel *)createLabelNamed:(NSString *)labelName withXLocation:(float)x withYLocation:(float)y withWidth:(float)width andHeight:(float)height{
    CGRect newLabelFrame = CGRectMake(x,y,width,height);
    UILabel *newLabel = [[UILabel alloc]initWithFrame:newLabelFrame];
    newLabel.text = labelName;
    [self.view addSubview:newLabel];
    return newLabel;
}


//*************************KEYBOARD HANDLING **********************************************
//OVERRIDE METHOD TO MAKE KEYBOARD DISAPEAR WHEN CLICKING OUTSIDE OF TEXTFIELD
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

//TEXTFIELD & KEYBOARD METHODS
//METHOD TO MOVE TEXTFIELD UP WHEN CLICKED
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag > 0)   // <--- ONLY AFFECTS THE BOTTOM TWO
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-80.0,
                                     self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}
//METHOD TO MOVE TEXTFIELD BACK DOWN WHEN CLICKED "DONE"
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag > 0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 80.0,
                                     self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    [textField resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField.tag > 0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view .frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+80.0,
                                      self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        

    }
    [textField resignFirstResponder];
    return YES;
}
//************************************************************************************

@end
