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
@property (strong,nonatomic)UILabel *editNameLabel;
@property (strong,nonatomic)UILabel *editURLLabel;
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
    self.editNameTextField = [self createTextFieldNamed:@"ENTER COMPANY NAME" withXLocation:20.0f withYLocation:130.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:0];   // <---CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD TEXTFIELD FOR EDITCOMPANY EDIT LOGO URL
    self.editLogoURLTextField = [self createTextFieldNamed:@"ENTER COMPANY LOGO URL" withXLocation:20.0F withYLocation:210.0f withWidth:self.textFieldWidth andHeight:self.textFieldHeight withIDTag:1];  // <--- CAN USE ID TAG TO REFER TO THE TEXT FIELD
    
    //ADD EDIT COMPANY LABEL
    self.editNameLabel = [self createLabelNamed:@"Company Name:" withXLocation:20.0f withYLocation:100.0f withWidth:250.0f andHeight:20.0f];
    [self.editNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //ADD EDIT COMPANY LOGO URL LABEL
    self.editURLLabel = [self createLabelNamed:@"Logo URL:" withXLocation:20.0f withYLocation:180.0f withWidth:250.0f andHeight:20.0f];
    [self.editURLLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    //SET TEXTFIELD DELEGATE FOR KEYBOARD HANDLING
    self.editNameTextField.delegate = self;
    self.editLogoURLTextField.delegate = self;
    

}

-(void)viewWillAppear:(BOOL)animated {
    //DISPLAY CURRENT VALUES BEFORE EDIT
    self.editNameTextField.text = self.currentCompany.companyName;
    self.editLogoURLTextField.text = [self.currentCompany.companyLogoURL absoluteString];
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
-(void)popToCompanyViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

//************************************************************************************
//METHOD TO SAVE INFO IN EDIT COMPANY SCREEN
#pragma mark - WORKING EDIT COMPANY
-(void)saveEditedCompany{
    //NEW/EDITED VALUES
    NSString *editedCompanyName = self.editNameTextField.text;
    NSURL *editedCompanyLogoURL = [NSURL URLWithString:self.editLogoURLTextField.text];

    //ORIGINAL VALUES OF THE COMPANY
    NSString *originalName = self.currentCompany.companyName;
    NSURL *originalLogoURL = self.currentCompany.companyLogoURL;
    
    //SEND PROPERTY VALUES TO DAO
    self.dataManager.editedCompanyNameDAO = editedCompanyName;
    self.dataManager.editedCompanyLogoURLDAO = editedCompanyLogoURL;
    self.dataManager.originalCompanyNameDAO = originalName;
    self.dataManager.originalCompanyLogoURLDAO = originalLogoURL;
    
    //SET THE EDITED NEW NAME TO THE COMPANY //IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE THE NAME
    if([self.editNameTextField isEditing]){
        self.currentCompany.companyName = editedCompanyName;
        self.dataManager.editingCompanyNameDAO = YES;
    } else {
        self.currentCompany.companyName = originalName;
        self.dataManager.editingCompanyNameDAO = NO;
    }

    //SET THE EDITED NEW LOGO URL TO THE COMPANY //IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE THE URL
    if([self.editLogoURLTextField isEditing]){
        self.currentCompany.companyLogoURL = editedCompanyLogoURL;
        self.dataManager.editingCompanyLogoURLDAO = YES;
    } else {
        self.currentCompany.companyLogoURL = originalLogoURL;
        self.dataManager.editingCompanyLogoURLDAO = NO;
    }
    
    
//    //CORE DATA HANDLING
//    
//    //EDIT MANAGED PRODUCT
//    ManagedCompany *currentManagedCompany = [self.dataManager.managedCompanyListDAO objectAtIndex:self.dataManager.indexOfLastCompanyTouched];
//    
//    //ORIGINAL VALUES OF CURRENT MANAGED COMPANY
//    NSString *originalMCName = currentManagedCompany.mCName;
//    NSString *originalMCLogoURL = currentManagedCompany.mCLogoURL;
//    
//    //NEW VALUES OF CURRENT MANGED COMPANY
//    NSString *newMCName = editedCompanyName;
//    NSString *newLogoURL = [NSString stringWithFormat:@"%@",editedCompanyLogoURL];
//    
//    //SET THE EDITED NEW MANAGED COMPANY NAME TO REPLACE  ORIGINAL ONE
//    //IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE THE NAME
//    if([self.editNameTextField isEditing]){
//        currentManagedCompany.mCName = newMCName;
//    } else {
//        currentManagedCompany.mCName = originalMCName;
//    }
//    
//    // SET THE EDITED NEW MANAGED COMPANY LOGO URL TO REPLACE ORIGINAL ONE
//    // IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE URL
//    if([self.editLogoURLTextField isEditing]){
//        currentManagedCompany.mCLogoURL = newLogoURL;
//    } else {
//        currentManagedCompany.mCLogoURL = originalMCLogoURL;
//    }
//    
//    //SAVE MANAGED OBJECT
//    [self.dataManager saveManagedObject];
//
    //SAVE EDITED COMPANY TO CORE DATA
    [self.dataManager saveEditedCompanyToCoreData];
    
    //POP OUT OF THE VIEW
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
