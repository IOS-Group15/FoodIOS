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
- **Category:** [e.g., Social, Entertainment, Education]
- **Mobile:** [Is it a mobile application only?]
- **Story:**  [What story does your app tell?]
- **Market:** [Target audience for the app]
- **Habit:** [Is it a daily use app or occasional use?]
- **Scope:** [Is it a broad or narrow app in terms of features?]

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can sign up for a new account to begin managing their budget efficiently.
* User can securely log in to access their budget information, ensuring privacy and data security.
* User can track their expenses over a budget period to monitor their spending.
* User can accurately categorize their expenses, providing insights into spending habits for better financial management.
* User can set monthly budgets for different expense categories, enabling them to control their spending effectively.
* User receives notifications when they exceed their budget limits, helping them avoid overspending and stay within their financial boundaries.
* User can track their progress towards financial goals, fostering motivation and accountability in achieving desired objectives.

**Optional Nice-to-have Stories**

* User can persist their user information across working sessions for convenience.
* User can customize their budget period, displaying the total days left in the budget period for effective budget planning and management.
* User has the option to pay with third-party platforms such as PayPal or Venmo, offering flexibility and convenience in payment methods.
* User can export their budget data (such as expenses and savings) to an Excel (.xlsx) file for further analysis or record-keeping.

### 2. Screen Archetypes
- [ ] **Login Screen**
  * User can login
- [ ] **Registration Screen**
  * User can create a new account
- [ ] **Dashboard Screen**
  * User can view an overview of their budget and financial progress.
- [ ] **Expense Screen**
  * User can track and categorize their expenses.
- [ ] **Add a Transaction Screen**
  * User can add a transaction to their expenses.
- [ ] **Budget Screen**
  * User can set and manage their budget for different expense categories.
- [ ] **Add a Budget Screen**
  * User can add a budget limit for different expense categories.
- [ ] **Settings Screen**
  * User can access and adjust app settings.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

- [ ] **Dashboard Tab**: Dashboard Screen
- [ ] **Expense Tab**: Expense Screen
- [ ] **Budget Tab**: Budget Screen
- [ ] **Settings Tab**: Settings Screen

**Flow Navigation** (Screen to Screen)

- [ ] [**Screen Name**]
  * Leads to [**Next Screen**]
- [ ] [**Another Screen Name**]
  * Leads to [**Another Screen**] 


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
