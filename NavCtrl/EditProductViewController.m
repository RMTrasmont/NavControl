//
//  EditProductViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"
@interface EditProductViewController ()
@property (nonatomic)float textFieldWidth;
@property (nonatomic)float textFieldHeight;
@property (strong, nonatomic) UITextField *editNameTextField;
@property (strong,nonatomic) UITextField *editURLTextField;
@property (strong,nonatomic)UILabel *editNameLabel;
@property (strong,nonatomic)UILabel *editURLLabel;
@property (nonatomic)DAO *dataManager;

@end

@implementation EditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataManager = [DAO sharedManager];
    
    //ADD BACKGROUND COLOR
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //ADD HEADER TITLE
    [self.navigationItem setTitle:@"Edit Product"];
    
    //ADD CANCEL BUTTON TO TOP LEFT BAR
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                              target:self
                                              action:@selector(popToProductViewController)]   //<---MAKE & DEFINE METHOD
                                             autorelease];
    
    //ADD SAVE BUTTON TO TOP RIGHT BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                               target:self action:@selector(saveEditedProduct)]  // <--- MAKE & DEFINE METHOD
                                              autorelease];
    
    //SET PROPORTIONAL TEXTFIELD SIZES
    [self proportionalWidth:0.9f];
    [self proportionalHeight:0.075f];
    
    //ADD TEXTFIELD FOR EDITCOMPANY EDIT NAME SCREEN
    self.editNameTextField = [self createTextFieldNamed:@"EDIT PRODUCT NAME" withXLocation:20.0f withYLocation:130.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0];   // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD TEXTFIELD FOR EDITCOMPANY EDIT LOGO URL
    self.editURLTextField = [self createTextFieldNamed:@"EDIT PRODUCT URL" withXLocation:20.0F withYLocation:210.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];  // <--- CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    
    //ADD EDIT PRODUCT NAME LABEL
    self.editNameLabel = [self createLabelNamed:@"Product Name:" withXLocation:20.0 withYLocation:100.0f withWidth:250.0f andHeight:20.0f];
    [self.editNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //ADD EDIT PRODUCT URL LABEL
    self.editURLLabel = [self createLabelNamed:@"Product URL:" withXLocation:20.0f withYLocation:180.0f withWidth:250.0f andHeight:20.0f];
    [self.editURLLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //SET KEYBOARD AS DELEGATE FOR KEYBOARD HANDLING
    self.editNameTextField.delegate = self;
    self.editURLTextField.delegate = self;

}

//************************************************************************************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************************************************************************
- (void)viewWillAppear:(BOOL)animated{
    //DISPLAY CURRENT VALUES BEFORE EDIT
    self.editNameTextField.text = self.currentProduct.productName;
    self.editURLTextField.text = [self.currentProduct.productURL absoluteString];
}



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
//METHOD TO POP OUT OF EDIT SCREEN
-(void)popToProductViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
//************************************************************************************
//METHOD TO SAVE EDITED PRODUCT
-(void)saveEditedProduct{
    //NEW VALUES
    NSString *editedName = self.editNameTextField.text;
    NSURL *editedURL = [NSURL URLWithString:self.editURLTextField.text];
    
    //OLD VALUES
    NSString *originalName = self.currentProduct.productName;
    NSURL *originalURL = self.currentProduct.productURL;
    
    //SEND OLD AND NEW VALUES TO DAO
//    self.dataManager.editedProductNameDAO = editedName;
//    self.dataManager.editedProductURLDAO = editedURL;
//    self.dataManager.originalProductNameDAO = originalName;
//    self.dataManager.originalProductURLDAO = originalURL;
    
    if([self.editNameTextField isEditing]){
        self.currentProduct.productName = editedName;
        self.dataManager.editingProductNameDAO = YES;
    } else {
        self.currentProduct.productName = originalName;
        self.dataManager.editingProductNameDAO = NO;
    }

    if([self.editURLTextField isEditing]){
        self.currentProduct.productURL = editedURL;
        self.dataManager.editingProductURLDAO = YES;
    } else {
        self.currentProduct.productURL = originalURL;
        self.dataManager.editingProductURLDAO = NO;
    }
    
    //LET DAO KNOW THE CURRENT PRODUCT BEING EDITED
    self.dataManager.productBeingEditedDAO = self.currentProduct;
    
    //SAVE EDITED PRODUCT TO CORE DATA
    [self.dataManager saveEditedProductToCoreData];
    
    [self.navigationController popViewControllerAnimated:YES];

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
    
    if (textField.tag > 0)   // <--- ONLY AFFECTS THE BOTTOM
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
