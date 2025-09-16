# Mornhouse iOS Test Task

Test task for the position of an iOS Developer.

## Description
The app displays **interesting facts about numbers**.  
Users can enter a number to get a fact or generate a random number and view its fact.  

The project is implemented in **Swift** using **SwiftUI** and follows the **MVVM architecture**.

## Features
- Enter a number and get a fact from [numbersapi.com](http://numbersapi.com)  
- Generate a random number and fetch its fact  
- History of user requests (number + preview of the fact)  
- Tap history item to open detail screen  
- Detail screen displays full fact text  
- Data persistence with **CoreData** and **UserDefaults** (use one of them)  

## API Endpoints
- Fact about specific number: `http://numbersapi.com/{number}`  
- Fact about random number: `http://numbersapi.com/random/math`  

## Requirements
- Swift  
- Xcode  
- MVVM project structure  
- Asynchronous API requests **Async/Await**
- CoreData for history storage (optional)  

## Screens
1. **Main Screen**  
   - Number input  
   - "Get fact" button  
   - "Get fact about random number" button  
   - History list of user requests
     
2. **Detail Screen**  
   - Displays number and full fact text  
   - Option to return to main screen
     
3. **Additional**
   - User can delete history item. 
