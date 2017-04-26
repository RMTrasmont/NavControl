//
//  NewProductsViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "NewProductsViewController.h"
@interface NewProductsViewController ()

@property (nonatomic)float textFieldWidth;
@property (nonatomic)float textFieldHeight;
@property (strong,nonatomic)UITextField *theNewProductTextField;
@property (strong,nonatomic)UITextField *theNewProductURLTextField;
@property (strong,nonatomic)UITextField *theNewProductImageURLTextField;
@property (strong,nonatomic)UILabel *productNameLabel;
@property (strong,nonatomic)UILabel *productURLLabel;
@property (strong,nonatomic)UILabel *prodductImageURLLabel;
@property (nonatomic)DAO *dataManager;

@end

@implementation NewProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataManager = [DAO sharedManager];
    
    //ADD BACKGROUND COLOR
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //ADD HEADER TITLE
    [self.navigationItem setTitle:@"New Product"];
    
    
    //ADD CANCEL BUTTON TO TOP LEFT W/ ACTION
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                               target:self
                                               action:@selector(popBackProductsView)]                                                autorelease];
    
    //ADD SAVE BUTTON W/ ACTION
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                              target:self
                                              action:@selector(saveNewProduct)]                                             autorelease];
    
    
    //SET PROPORTIONS FOR WIDTH
    [self proportionalWidth:0.90f];
    
    //SET PROPORTIONS FOR HEIGHT
    [self proportionalHeight:0.075f];
    
    //MAKE TEXTFIELD FOR PRODUCT NAME
    self.theNewProductTextField = [self createTextFieldNamed:@"ENTER PRODUCT NAME" withXLocation:20.0f withYLocation:130.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0]; // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //MAKE TEXTFIELD FOR PRODUCT URL
    self.theNewProductURLTextField = [self createTextFieldNamed:@"ENTER PRODUCT URL" withXLocation:20.0F withYLocation:210.0F withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];
    
    //MAKE TEXTFIELD FOR PRODUCT IMAGE URL
    self.theNewProductImageURLTextField = [self createTextFieldNamed:@"ENTER IMAGE URL" withXLocation:20.F withYLocation:290.0F withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:2];
    
    
    //MAKE PRODUCT NAME LABEL
    self.productNameLabel = [self createLabelNamed:@"New Product:" withXLocation:20.0f withYLocation:100.0f withWidth:250.0f andHeight:20.0f];
    [self.productNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //MAKE PRODUCT URL LABEL
    self.productURLLabel = [self createLabelNamed:@"New URL:" withXLocation:20.0f withYLocation:180.0f withWidth:250.0f andHeight:20.0f];
    [self.productURLLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //MAKE PRODUCT IMAGE URL LABEL
    self.prodductImageURLLabel = [self createLabelNamed:@"Image URL:" withXLocation:20.0f withYLocation:260.0f withWidth:250.0f andHeight:20.0f];
    [self.prodductImageURLLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //SET TEXTFIELD AS DELEGATE FOR MOVING KEYBOARD
    self.theNewProductTextField.delegate = self;
    self.theNewProductURLTextField.delegate = self;
    self.theNewProductImageURLTextField.delegate = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//METHOD TO POP BACK TO PRODUCTS VIEW
-(void)popBackProductsView{
    [self.navigationController popViewControllerAnimated:YES];
}

//METHOD TO SAVE NEW PRODUCT
-(void)saveNewProduct{ 

    //SET THE TEXT FIELD INPUT TO LOCAL VARIABLES PRODUCT NAME & URL
    self.productName = self.theNewProductTextField.text;
    self.productURL = [NSURL URLWithString:self.theNewProductURLTextField.text];
    self.productImageURL = [NSURL URLWithString:self.theNewProductImageURLTextField.text];
    
    //CREATE NEW PRODUCT USING DAO MEHTOD & GIVE IT LOCAL NAME & URL VARIABLE
    Product *madeProduct = [self.dataManager makeNewProductWithName:self.productName withWebURL:self.productURL andImageURL:self.productImageURL];
    
    //LET DAO KNOW OF THE NEW PRODUCT
    self.dataManager.theNewProductDAO = madeProduct;
    
        //IF THE COMPANY PRODUCTS ARRAY IS EMPTY, MAKE A NEW ARRAY THEN ADD THE PRODUCT
    if(self.dataManager.currentCompanyDAO.companyProductList == 0 ){
        self.dataManager.currentCompanyDAO.companyProductList = [NSMutableArray arrayWithObject:madeProduct];
    } else {
        //ADDS PRODUCTS TO ALREADY EXISTING COMPANY W/ EXISTING ARRAY OF PRODUCTS
        [self.dataManager.currentCompanyDAO.companyProductList addObject:madeProduct];
    }
    
    //SEGUE "POP" VIEW TO BE BACK AT PRODUCTS VIEW CONTROLLER SCREEN
    [self.navigationController popViewControllerAnimated:YES];
}

//METHOD TO CREATE TEXTFIELD
-(UITextField *)createTextFieldNamed:(NSString *)placeHolder withXLocation:(float)x withYLocation:(float)y withWidth:(float)width andHeight:(float)height withIDTag:(int)tag{
    
    CGRect newTextFieldFrame = CGRectMake(x,y,width,height);
    UITextField *newTextField = [[[UITextField alloc] initWithFrame:newTextFieldFrame]autorelease];
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

//METHODS TO SET THE TEXTFIELD HEIGHT AND WIDTH PROPORTIONAL TO THE HEIGHT AND WIDTH OF THE VIEW
-(void)proportionalWidth:(float)percent{
    _textFieldWidth = self.view.frame.size.width * percent;
}

-(void)proportionalHeight:(float)percent{
    _textFieldHeight = self.view.frame.size.height * percent;
}

//METHOD TO CREATE LABEL
-(UILabel *)createLabelNamed:(NSString *)labelName withXLocation:(float)x withYLocation:(float)y withWidth:(float)width andHeight:(float)height{
    CGRect newLabelFrame = CGRectMake(x,y,width,height);
    UILabel *newLabel = [[[UILabel alloc]initWithFrame:newLabelFrame]autorelease];
    newLabel.text = labelName;
    [self.view addSubview:newLabel];
    return newLabel;
}

//OVERRIDE METHOD TO MAKE KEYBOARD DISAPEAR WHEN CLICKING OUTSIDE OF TEXTFIELD
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

//TEXTFIELD & KEYBOARD METHODS
//METHOD TO MOVE TEXTFIELD UP WHEN CLICKED
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag > 0)
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

-(void)dealloc{
    [_productName release];
    [_productURL release];
    [_productImageURL release];
    [_theNewProductTextField release];
    [_theNewProductURLTextField release];
    [_theNewProductImageURLTextField release];
    [_productNameLabel release];
    [_productURLLabel release];
    [_prodductImageURLLabel release];
    [super dealloc];
}


@end
