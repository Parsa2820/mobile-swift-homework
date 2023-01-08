# mobile-swift-homework

**Mobile Programming Course Swift Homework**

**Parsa Mohammadian - 98102284**

**Sara Azarnoush - 98170668**

Fall 2022

## Introduction

This project is a simple command line application written in Swift that can be used to check the price of cryptocurrencies. It uses [Twelve Data API](https://twelvedata.com/) to fetch the data.

## Technical Details

We have implemented the project using proper design patterns and principles in order to make it easily extensible to be used in SwiftUI application. All the classes are designed with MVC pattern in mind and to be independent of each other. 

> **Note:** This application needs a valid API key in `twelvedata.com-api-key` similiar to `twelvedata.com-api-key.example` file. You can get a free API key from [Twelve Data API](https://twelvedata.com/) website.

> **Another Note:** This application stores its data in `cryptocurrency-swift.json` file. In order to reset the data, you can delete this file.

## Build and Run

You can build and run the project with Swift version 5.7.2 using below command:

```bash
$ swift run
```

In order to see debug information during the execution, you should pass proper arguments to Swift compiler as below:

```bash
$ swift run -Xswiftc -DDEV
```

## Screenshots

Although the project is a command line application, we have added some screenshots to show how it works.

<div align="center">
    <img src="Screenshots/1.png" width="80%" />
    <img src="Screenshots/2.png" width="80%" />
    <img src="Screenshots/3.png" width="80%" />
</div>
