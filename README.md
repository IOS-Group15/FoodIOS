# Personal Budget Management
Original App Design Project - README Template
===

# Pokket

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

Pokket simplifies financial tracking and budgeting by allowing users to set up and manage monthly budgets for various categories like food, entertainment, and utilities. Users can easily log expenses by scanning receipts or entering details manually, and the app deducts these amounts from the corresponding budget category. It also provides notifications to help users stay within their spending limits, and the budget automatically resets at user-defined intervals. Pokket combines convenience and control, making it easier for users to manage their finances efficiently in one place.


### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Personal Finance, Productivity
- **Mobile:** Yes, it's only for iPhones.
- **Story:**  The app helps iPhone users manage money better.
- **Market:**  It's for anyone with an iPhone who wants to control spending.
- **Habit:** Use it every day or just sometimes.
- **Scope:** It does essential money tasks on iPhones.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can sign up for a new account to begin managing their budget efficiently.
- [x] User can securely log in to access their budget information, ensuring privacy and data security.
- [x] User can track their expenses over a budget period to monitor their spending.
- [x] User can accurately categorize their expenses, providing insights into spending habits for better financial management.
- [x] User can see monthly budgets for different expense categories, enabling them to control their spending effectively.
- [ ] User receives notifications when they exceed their budget limits, helping them avoid overspending and stay within their financial boundaries.
- [ ] User can track their progress towards financial goals, fostering motivation and accountability in achieving desired objectives.

**Optional Nice-to-have Stories**

- [x] User can persist their user information across working sessions for convenience.
- [ ] User can customize their budget period, displaying the total days left in the budget period for effective budget planning and management.
- [ ] User has the option to pay with third-party platforms such as PayPal or Venmo, offering flexibility and convenience in payment methods.
- [ ] User can export their budget data (such as expenses and savings) to an Excel (.xlsx) file for further analysis or record-keeping.

### 2. Screen Archetypes
- [x] **Login Screen**
  * User can login
- [x] **Registration Screen**
  * User can create a new account
- [ ] **Dashboard Screen**
  * User can view an overview of their budget and financial progress.
- [x] **Expense Screen**
  * User can track and categorize their expenses.
- [x] **Add a Transaction Screen**
  * User can add a transaction to their expenses.
- [x] **Budget Screen**
  * User can see their budget for different expense categories.
- [x] **Add a Budget Screen**
  * User can add a budget limit for different expense categories.
- [ ] **Settings Screen**
  * User can access and adjust app settings.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

- [x] **Dashboard Tab**: Dashboard Screen
- [x] **Expense Tab**: Expense Screen
- [x] **Budget Tab**: Budget Screen
- [x] **Settings Tab**: Settings Screen

**Flow Navigation** (Screen to Screen)

- [ ] [**Sign In Button**]
  * Leads to [**Dashboard Screen**]
- [ ] [**Sign Up Button**]
  * Leads to [**Registration Screen**]
- [ ] [**Dashboard**]
  * No further navigation.
- [ ] [**Add Transition Button (Transaction Tab)**]
  * Leads to [**Add Transition Screen**] to add a new transaction.
- [ ] [**Create New Budget Button (Budget Tab)**]
  * Leads to [**Create New Budget Screen**] to add a new budget.
- [ ] [**Profile Settings Cell**]
  * Leads to [**Profile Settings Screen**] for updating profile information.
- [ ] [**Profile Notification  Cell**]
  * Leads to [**Notification Settings Screen**] for managing notifications.
- [ ] [**Profile Link Account Cell**]
  * Leads to [**Link Account Screen**] to connect external accounts.



## Wireframes

### Digital Wireframes & Mockups
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/a594813f-571b-4c63-943e-2156dee943ac" alt="Pokket Mobile_Page_01" width="20%">
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/5142ca69-4304-4ca4-848e-130ca781465f" alt="Pokket Mobile_Page_02" width="20%">
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/e1c6aac4-f30f-442f-b175-d21c1c97ccfe" alt="Pokket Mobile_Page_05" width="20%">
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/75cd070f-38c3-4981-bd72-fae0a4ec9802" alt="Pokket Mobile_Page_06" width="20%">
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/a46b2b20-d8dc-40c5-8dcf-3b4ceec8851d" alt="Pokket Mobile_Page_07" width="20%">
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/f6a828d4-d13e-43da-9e9f-a3f708e01182" alt="Pokket Mobile_Page_08" width="20%">
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/d479371a-92ac-4b55-8e2d-983e042aa937" alt="Pokket Mobile_Page_09" width="20%">
<img src="https://github.com/IOS-Group15/Personal-Budget-Management/assets/38261965/182efffd-6bf3-4791-a48a-0e9d6e2b865d" alt="Pokket Mobile_Page_10" width="20%">



### Interactive Prototype

<div>
    <a href="https://www.loom.com/share/4172c5074feb474883b9d85081731ac6">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/4172c5074feb474883b9d85081731ac6-with-play.gif">
    </a>
  </div>

## Sprint 1
<div>
    <a href="https://www.loom.com/share/f9dd9f0171b44d179575e8c440f0fcf3">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/f9dd9f0171b44d179575e8c440f0fcf3-with-play.gif">
    </a>
  </div>

## Sprint 2
<div>
    <a href="https://www.loom.com/share/f9dd9f0171b44d179575e8c440f0fcf3">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/f9dd9f0171b44d179575e8c440f0fcf3-with-play.gif">
    </a>
  </div>


## Schema 


### Models

[Model Name, e.g., User]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |
| ...      | ...    | ...                          


### Networking

- [List of network requests by screen]
- [Example: `[GET] /users` - to retrieve user data]
- ...
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
