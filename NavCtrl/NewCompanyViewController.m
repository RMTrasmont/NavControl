//
//  NewCompanyViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/16/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "NewCompanyViewController.h"
#define kOFFSET_FOR_KEYBOARD 80.0
@interface NewCompanyViewController ()

@property (nonatomic)float textFieldWidth;
@property (nonatomic)float textFieldHeight;
@property (strong,nonatomic)UITextField *theNewCompanyNameTextField;
@property (strong,nonatomic)UITextField *theNewCompanyLogoURLTextField;
@property (strong,nonatomic)UILabel *companyNameLabel;
@property (strong,nonatomic)UILabel *companyURLLabel;
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
    self.theNewCompanyNameTextField = [self createTextFieldNamed:@"ENTER COMPANY NAME" withXLocation:20.0f withYLocation:130.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0];   // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD TEXTFIELD FOR COMPANY LOGO URL
     self.theNewCompanyLogoURLTextField = [self createTextFieldNamed:@"ENTER COMPANY LOGO URL" withXLocation:20.0F withYLocation:210.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];  // <--- CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD LABEL FOR COMPANY NAME
    self.companyNameLabel = [self createLabelNamed:@"New Company:" withXLocation:20.0f withYLocation:100.0f withWidth:250.0f andHeight:20.0f];
    [self.companyNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //ADD LABEL FOR URL
    self.companyURLLabel = [self createLabelNamed:@"New Logo URL:" withXLocation:20.0f withYLocation:180.0f withWidth:250.0f andHeight:20.0f];
    [self.companyURLLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    
}

//************************************************************************************

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
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
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

//************************************************************************************
//METHODS TO MOVE OBJECT UP ABOVE KEYBOARD
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.theNewCompanyLogoURLTextField])   // <--- ONLY NEED TO MOVE BOTTOM TEXT FIELD
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
//************************************************************************************

@end
