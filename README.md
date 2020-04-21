# MobileDataUsage
<p align="center">
  <img width="160" height="320" src="videos/Simulator-iPhone11.gif"/>
</p>
<p align="center"> Simulator-iP11 </p>

<p align="center">
  <img width="160" height="320" src="videos/read-device-ip11.gif"/>
</p>
<p align="center"> Real device-iP11 </p>

# Technical notes
- [x] Following VIPER architechture.
- [x] Pull to refresh.
- [x] Network caching.
- [x] UnitTests.
- [x] UITests.
- [x] Swiftlint for coding styles & clean code.
- [x] Support `fastlane`. Run `fastlane scan` in Xcode project directory.
- [x] Prepared to support multi environments (dev and prod).

### Why VIPER??
[VIPER](https://medium.com/@smalam119/viper-design-pattern-for-ios-application-development-7a9703902af6) is a very clean architecture. It isolates each module from others. So changing or fixing bugs are very easy as you only have to update a specific module. Also for having modular approach VIPER creates a very good environment for unit testing.

###### Other Key Advantages of VIPER Architecture:
- Good for large teams.
- Makes it scalable. Enable developers to simultaneously work on it as seamlessly as possible.
- Makes it easy to add new features.
- Makes it easy to write automated tests since your UI logic is separated from the business logic.
- Makes it easier to track issues via crash reports due to the Single Responsibility Principle.
- Makes the source code cleaner, more compact, and reusable.
- Reduces the number of conflicts within the development team.
- Applies SOLID principles.

#### Added VIPER Template
I created a VIPER Xcode template to make the work easier, reduce time for create new files and repeate the same code per module.

[Installation Instruction](https://github.com/m-rec/524ad38f766143bd5e1f804e231ba7a3b8877ce6/tree/master/XCode%20Templates)

To create new module: `Create new Group as your module name ---> Add new File --> Scroll down to select VIPER template --> type your module name.`

### BaseNetworking
A very lightweight URLSession wrapper to work with REST APIs. Easy to use and flexible with diffirent endpoints, methods.

```swift
networkClient.fetch(endPoint: MobileNetworkEndpoint.fetchListMobileData(limit: 20, offset: 20),
                            type: MobileDataResponse.self,
                            loadFromCache: true) { (response) in
                                switch response {
                                case .success(let data):
                                    print(error)
                                case .failure(let error):
                                    print(error)
                                }
        }
```



 ## TestCoverage: 81.52%

Add test cases for each modules or base components to make sure we won't break it after changes. Can run `fastlane scan` 
- [x] NetworkingTests.
- [x] MobileDataTests.
- [x] CollectionCellTests.
- [x] Load data from cache.
- [x] Support Mockable test or load data from local JSON.

### TestCoverage Report
```
SPHTech-Assignment/AppDelegate.swift: 8 of 8 lines (100.00%)
SPHTech-Assignment/Core/Extensions/Collection+Ext.swift: 8 of 12 lines (66.67%)
SPHTech-Assignment/Core/Extensions/UIFont+Ext.swift: 6 of 6 lines (100.00%)
SPHTech-Assignment/Core/Extensions/UITableView+Ext.swift: 8 of 18 lines (44.44%)
SPHTech-Assignment/Core/Extensions/UIView+Ext.swift: 45 of 59 lines (76.27%)
SPHTech-Assignment/Core/Extensions/UIViewController+Ext.swift: 13 of 13 lines (100.00%)
SPHTech-Assignment/Core/Helper/Logger.swift: 76 of 113 lines (67.26%)
SPHTech-Assignment/Core/Helper/NameDescribable.swift: 6 of 6 lines (100.00%)
SPHTech-Assignment/Core/Networking/BaseNetworking/APIEndpoint.swift: 43 of 47 lines (91.49%)
SPHTech-Assignment/Core/Networking/BaseNetworking/NetworkClient.swift: 45 of 57 lines (78.95%)
SPHTech-Assignment/Core/Networking/BaseNetworking/NetworkConfiguration.swift: 20 of 20 lines (100.00%)
SPHTech-Assignment/Core/Networking/BaseNetworking/NetworkError.swift: 12 of 22 lines (54.55%)
SPHTech-Assignment/Core/Networking/BaseNetworking/Reachablility.swift: 18 of 21 lines (85.71%)
SPHTech-Assignment/Core/Networking/Endpoints/MobileNetworkEndpoint.swift: 19 of 19 lines (100.00%)
SPHTech-Assignment/Core/VIPER/Router/NavigationRouter.swift: 23 of 45 lines (51.11%)
SPHTech-Assignment/Core/VIPER/Router/RouterInterfaces.swift: 3 of 22 lines (13.64%)
SPHTech-Assignment/Core/VIPER/Router/ViewRouter.swift: 5 of 11 lines (45.45%)
SPHTech-Assignment/Core/VIPER/View/BaseViewController.swift: 7 of 25 lines (28.00%)
SPHTech-Assignment/Core/VIPER/View/ViewInterface.swift: 3 of 3 lines (100.00%)
SPHTech-Assignment/Models/QuarterRecord.swift: 6 of 6 lines (100.00%)
SPHTech-Assignment/Models/YearRecord.swift: 11 of 11 lines (100.00%)
SPHTech-Assignment/Modules/MobileData/MobileDataDependency.swift: 13 of 13 lines (100.00%)
SPHTech-Assignment/Modules/MobileData/MobileDataInteractor.swift: 68 of 70 lines (97.14%)
SPHTech-Assignment/Modules/MobileData/MobileDataPresenter.swift: 61 of 64 lines (95.31%)
SPHTech-Assignment/Modules/MobileData/MobileDataViewController.swift: 86 of 86 lines (100.00%)
SPHTech-Assignment/Modules/MobileData/Views/MobileDataCell.swift: 105 of 108 lines (97.22%)
SPHTech-Assignment/Modules/MobileData/Views/QuartersStackView.swift: 32 of 35 lines (91.43%)
Tested 750/920 statements
Test Coverage: 81.52%
```
 

