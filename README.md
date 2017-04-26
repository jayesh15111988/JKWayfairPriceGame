# JKWayfairPriceGame
A simple price guessing game for Wayfair Products

This README file describes the app, its features and usage. It is organized in following sections.

### 1. Page designs

 * Home page 
    
      Home page will allow users to choose from product categories. User can immediately begin quiz with default category `419247` which is `Blenders`. If user wishes to manually go through subcategories, app will present appropriate categories in sequence. For e.g.

      `Furniture -> Accent Furniture -> Accent Tables -> End Tables -> List of End Tables products`

     When final category with products is reached, user will be redirected to the quiz page. 

     Alternatively, if user is going through subcategories and wishes to back off, category choice state can be reset by pressing `Reset Categories` button on the home page.

     Home page will also present user with game instructions. These instructions will be shown on very first launch. For subsequent launches if user wishes to read them, they can opened by pressing `Information icon` button in top right section of navigation bar

      ![alt text][HomeScreen]

 * Game page
   
     This page will present user with the actual quiz. User will be provided with 4 options along with buttons to finish quiz, skip question or view the product information online. It will also show the availability of the item in the inventory

     ![alt text][GameScreen]

 * Statistics page

     This page will display the game stats at the end. This includes the indicator if given answer was correct or not which is visually indicated by the text color. It will also show the expected and actual value of product sale price

     ![alt text][StatsScreen]
   

### 2. Features and how to use

   *The app works in two modes*

   **1. Default category**<br/>
         In this mode app displays products belonging to default product category. 

   **2. Custom category**<br/>
         In this mode, user is presented with series of subcategories until it reaches the end with collection of products. As soon as this product list is reached, quiz is begun

 Application randomly chooses a product from default 48 products in the inventory and generates 4 random prices. Among these, one of the prices is actual sale price.

 Every correct answers is awarded 10 points. No points are deducted for wrong answer. Alternatively user can skip the question to jump to next one. App generates 3 random prices other than actual sale price within a range of +/-100 plus value of  `Random offset` is added to it.

 This random offset ranges from 2-12 based on the value of correct answers percentages as follows.

 **1. 0 < 40% - 12**<br/>
 **2. 40% < 70% - 8**<br/>
 **3. 70% < 100% - 4**<br/>
 **4. 100% - 2**<br/>

 The goal of this threshold is to group correct and random incorrect choices as close as possible.

 When user presses finish button, app presents following screen with three options

 ![alt text][ResultScreen]


### 3. Technical details

 App uses core data to perform products caching. When user selects any category, all the products from it are stored locally and the quiz is started. When app first launches, it caches all the products belonging to default category (`419247`). When caching is complete, app retrieves records from database and begins the quiz.

 It uses [Mantle](https://github.com/Mantle/Mantle) for object models creation and [MTLManagedObjectAdapter](https://github.com/Mantle/MTLManagedObjectAdapter) to integrate Mantle with CoreData.

 In order to avoid potential memory leaks, I have used `WKWebView` in place of `UIWebView` which is superior in terms of memory consumption and performance. 

 App has also used `UIKitDynamics` to present animations. This includes gravity and snap effects as follows.

 ![alt text][GravityAnimation]

 ![alt text][SnapAnimation]

  App is written with [MVVM](https://www.objc.io/issues/13-architecture/mvvm/) style for easy maintenance and unit testing. In order to facilitate MVVM, I am using [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa/) functional reactive library


### 4. Third party libraries

 App makes use of third party library to improve performance and to ease the burden of extra implementation as follows. 

 1. [SDWebImage](https://github.com/rs/SDWebImage/) - To download and cache remote server images and to provide smooth and consistent UI to user

 2. [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa/) - A functional programming framework to ease observing and reacting to properties change. Use of this framework actually eased the implementation of app with MVVM architecture

 3. [Mantle](https://github.com/Mantle/Mantle) - A model object creation framework to convert dictionaries into native objects

 4. [MTLManagedObjectAdapter](https://github.com/Mantle/MTLManagedObjectAdapter) - A wrapper to integrate Core Data with Mantle

 5. [Alamofire](https://github.com/Alamofire/Alamofire) - A networking framework to download data from remote server in the form of `JSON` payload


### 5. Future enhancements

 1. Writing unit tests to verify the app behavior based on user actions. Since app written with `MVVM` style, it is much more convenient to write tests as compared to regular `MVC` architecture

 2. Mix and match products from several categories - Currently user can go through multiple product subcategories and begin the quiz with products belonging to only one category. However, as a part of future enhancement I would like to combine products from multiple random categories in a single quiz

 3. Caching product subcategories - Currently app stores all products belonging to default category or the product belonging to category for which quiz has already been taken. However, intermediate product category types are fetched from server (Which can also be cached). This will enable user to take the quiz in offline mode assuming caching is complete for given category link

 4. Improvement in code architecture to load and store products in database. In my opinion there is big scope to improve code which is used to load and cache products. Since the code has grown too much, there is scope to divide it further in the smaller modules.

 5. Adding cheat mode - This will allow users to hide any two incorrect options, easing the choice of correct guess

### 6. Copyright info

 1. APIs - App makes use of REST APIs provided by Wayfair to download and display data. This includes endpoints similar to,

     https://www.wayfair.com/v/category/display?category_id=[category_id]&_format=json

 2. Images - App is making use of images which were downloaded from resources below.

     1. http://prologicit.com/
     2. http://www168.lunapic.com
     3. http://www.greenmountainsports.com/

### App demo

![alt text][PriceGuessingGameDemo]

### 7. Supported devices
  App is visually tested on following devices on simulator (running iOS 9.*) and works well without any major glitches
  1. iPhone 4s, 5, 5s (Simulator and an actual device), 6, 6s, 6s Plus
  2. iPad 2, Air 2, Pro 2

[HomeScreen]: https://github.com/jayesh15111988/JKWayfairPriceGame/blob/master/DemoAssets/HomeScreen.png "Home Screen"
[GameScreen]: https://github.com/jayesh15111988/JKWayfairPriceGame/blob/master/DemoAssets/GameScreen.png "Game Screen"
[ResultScreen]: https://github.com/jayesh15111988/JKWayfairPriceGame/blob/master/DemoAssets/ResultScreen.png "Result Screen"
[StatsScreen]: https://github.com/jayesh15111988/JKWayfairPriceGame/blob/master/DemoAssets/StatsScreen.png "Stats Screen"
[GravityAnimation]: https://github.com/jayesh15111988/JKWayfairPriceGame/blob/master/DemoAssets/GravityAnimation.gif "Gravity Animation"
[SnapAnimation]: https://github.com/jayesh15111988/JKWayfairPriceGame/blob/master/DemoAssets/SnapAnimation.gif "Snap Animation"
[PriceGuessingGameDemo]: https://github.com/jayesh15111988/JKWayfairPriceGame/blob/master/DemoAssets/PriceGuessingGameDemo.gif "Price Guessing Game Demo"
