//
//  NewProductsViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "NewProductsViewController.h"
#define kOFFSET_FOR_KEYBOARD 50.0
@interface NewProductsViewController ()

@property (nonatomic)float textFieldWidth;
@property (nonatomic)float textFieldHeight;
@property (strong,nonatomic)UITextField *theNewProductTextField;
@property (strong,nonatomic)UITextField *theNewProductURLTextField;
@property (strong,nonatomic)UILabel *productNameLabel;
@property (strong,nonatomic)UILabel *productURLLabel;
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
                                               action:@selector(segueBackProductsView)]   //<---MAKE & DEFINE METHOD
                                               autorelease];
    
    //ADD SAVE BUTTON W/ ACTION
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                              target:self
                                              action:@selector(saveNewProduct)]   //<---MAKE & DEFINE METHOD
                                             autorelease];
    
    
    //SET PROPORTIONS FOR WIDTH
    [self proportionalWidth:0.90f];
    
    //SET PROPORTIONS FOR HEIGHT
    [self proportionalHeight:0.075f];
    
    //MAKE TEXTFIELD FOR PRODUCT NAME
    self.theNewProductTextField = [self createTextFieldNamed:@"ENTER PRODUCT NAME" withXLocation:20.0f withYLocation:130.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0]; // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //MAKE TEXTFIELD FOR PRODUCT URL
    self.theNewProductURLTextField = [self createTextFieldNamed:@"ENTER PRODUCT URL" withXLocation:20.0F withYLocation:210.0F withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];
    
    //MAKE PRODUCT NAME LABEL
    self.productNameLabel = [self createLabelNamed:@"New Product:" withXLocation:20.0f withYLocation:100.0f withWidth:250.0f andHeight:20.0f];
    [self.productNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //MAKE PRODUCT URL LABEL
    self.productNameLabel = [self createLabelNamed:@"New URL:" withXLocation:20.0f withYLocation:180.0f withWidth:250.0f andHeight:20.0f];
    [self.productURLLabel setFont:[UIFont boldSystemFontOfSize:16]];
    

}

//************************************************************************************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//************************************************************************************
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//************************************************************************************
//METHOD TO SEGUE BACK TO PRODUCTS VIEW
-(void)segueBackProductsView{
    [self.navigationController popViewControllerAnimated:YES];
}

//************************************************************************************
//METHOD TO SAVE NEW PRODUCT
-(void)saveNewProduct{ 
    
    //GET TEXT ENTERED IN TEXTFIELD
    NSString *newproduct = self.theNewProductTextField.text;
    NSLog(@"%@",newproduct);
    
    NSURL *productURL = [NSURL URLWithString:self.theNewProductURLTextField.text];
    NSLog(@"%@",productURL);
    
    //SET THE TEXT FIELD INPUT TO LOCAL VARIABLES PRODUCT NAME & URL
    self.productName = self.theNewProductTextField.text;
    self.productURL = [NSURL URLWithString:self.theNewProductURLTextField.text];
    
    //CREATE NEW PRODUCT USING DAO MEHTOD & GIVE IT LOCAL NAME & URL VARIABLE
    Product *madeProduct = [self.dataManager makeNewProductWithName:self.productName andURL:self.productURL];
    
    //ADD PRODUCT TO COMPANY PRODUCTS ARRAY BY USING THE VARIABLE LAST TOUCHED INDEXPATH ROW IN COMPANY VIEWCONTROLLER

    
        //IF THE COMPANY PRODUCTS ARRAY IS EMPTY, MAKE A NEW ARRAY THEN ADD THE PRODUCT
    if(self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList.count == 0 ){
        self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList = [NSMutableArray arrayWithObject:madeProduct];
    } else {
        //ADDS PRODUCTS TO ALREADY EXISTING COMPANY W/ EXISTING ARRAY OF PRODUCTS
        [self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList addObject:madeProduct];
    }
    
    //SEGUE "POP" VIEW TO BE BACK AT PRODUCTS VIEW CONTROLLER SCREEN
    [self.navigationController popViewControllerAnimated:YES];
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
//METHODS TO SET THE TEXTFIELD HEIGHT AND WIDTH PROPORTIONAL TO THE HEIGHT AND WIDTH OF THE VIEW
-(void)proportionalWidth:(float)percent{
    _textFieldWidth = self.view.frame.size.width * percent;
}

-(void)proportionalHeight:(float)percent{
    _textFieldHeight = self.view.frame.size.height * percent;
}

//************************************************************************************
//OVERRIDE METHOD TO MAKE KEYBOARD DISAPEAR WHEN BACKGROUND IS TOUCHED
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
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
    //ENTER MOST BOTTOM TEXTFIELD
    if ([sender isEqual:self.theNewProductURLTextField])
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
