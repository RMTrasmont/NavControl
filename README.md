Assignment Detail 

Language Objective - C

Assignment 1: Initial Setup

• Create a git repository
• Add all the existing files of this project to the repo and commit them.
• Take a look at the design and assets card in your resources list on this board. This will give you an idea of the overall concept of the project.Your app should utilize the design and assets in order to make your application look exactly the same and work exactly like the design laid out in the pdf.

Assignment 2: Add Basic Features

• Create and switch to a branch named assignment2-initial-setup
• Add 3 products for each company
• Show the logo for each company and each product (similar to the UITableView Project
• Add a 3rd level to the app so that a web page related to the product is shown when a product is selected using the class WKWebView (NOT UIWebView)
• Enable delete functionality so that companies and products can be deleted.
• Make sure that when you leave the view and come back that the product is still deleted
• The deleted product should only come back if you restart the app
• Allow the user to rearrange the order of the cells
• Add, commit and then push your work to your github repository on the assignment2-initial-setup branch
• Make sure you can recreate this project on a different computer using github.
• Add a link to your github rep in the comments section of this card
• On your local machine switch back to the master branch
• Merge the assignment2-initial-setup into the master branch
• now push from the master branch to the master branch

Assignment 3: Refactor your project to use an Object Oriented Approach with a DAO

• Create a branch named assignment-3-OOP
• Create a Company class and a Product class
• Refactor the project to be object-oriented, so that each company is a Company object and each product is a Product object.
• The Company class should have a products property (an array of Product objects).
• Add a Data Access Object (DAO). The DAO is a separate class where all the Companies and Products are created.
• Make sure you are extremely clear about the MVC design pattern.
• Refactor the app so that the companies and products are actually created in the DAO, and NOT in the view controller.
• Ensure that there can only ever be one instance of the DAO class. In other words, it should follow the Singleton design pattern. You should be able to explain the benefits of this pattern.
• Commit and then push your work to github as you implement various features. Make sure whatever you commit is in working condition
• Once the assignment is complete, tag this branch with a label e.g. “assignment3-V1”. Understand the purpose of tags.
• follow the steps necessary to merge this branch back to master and push your changes
• Make sure you can recreate this project on a different computer using github.

Assignment 4: Adding and Editing

• Enable ‘add’ functionality so that users can add new companies and products and define their properties with a form.
• Enable ‘edit’ functionality so that users can update the properties of existing companies and products with a form.
• Using NSNotification center make sure that when a user taps in a textfield to make the keyboard appear that the view adjusts accordingly to raise the view/textfield upward. Simply positioning your textfields up high to avoid the problem is *NOT* an acceptable workaround.

Assignment 5: Stock quotes

• Continue on the branch for assignment3-main-branch above
• Use an online API to get stock quotes for each company
• Display the current stock price next to the company name.
• You should only make one request to get data for all the companies.
• This should update whenever the company view is displayed.
• Make the request asynchronously using NSURLSession.
• Add and commit to git, push to github on assignment3-main-branch
• Merge to master and push to master

Assignment 6: Core Data

• Create a new branch called ‘core-data’
• When your app loads it should check to see if data is saved in Core Data.
• If it’s not there, the app should create the data using hard coded values and save it to Core Data.
• If it is there, it should only read the data to create objects and not use the hard coded values.
• The NSManaged Object for Company should have a relationship in Core Data with the NSManagaed Object for Product.
• If all above steps are done correctly, this should not require any changes to the View Controllers. This means that the View Controllers should not interact with NSManagedObjects—only NSObjects
• If you delete a product and restart the app, the product should still be deleted
• Add undo functionality

Assignment 7: Memory Mangement

• Using XCode's 'Instruments' tool, ensure that there are no objects allocated that should not be there, and that there are no leaks
• Zip up your project at this time so you can always go back.
• Add and commit your changes

Completion 8: Checklist

• Using NSNotification center, when a user taps in a textfield that is low on the screen and the keyboard appears, the view should get pushed up to ensure that the textfields stay in view (just putting all your textfields up high to start with is not an acceptable solution). Tapping outside of textfield should lower keyboard and view.
• Go back through your project and make it so that each transition between views has a different kind of animation.
• Your application should utilize the assets and design found here https://trello.com/c/RpaqG8Hb in order to make your application look exactly like, and work exactly like the design laid out in the pdf.
• App should work with or without internet. Stock quotes should start showing once network is back without restarting
• Stock quotes should refresh every x-seconds
• In the Core Data version, View Controllers should not interact with NSManagedObjects directly
• Understand forward class declaration and why we need it.
• Profile your app using Instruments and make sure you have only the required objects in memory


