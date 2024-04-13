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

[Provide a brief description of your app, its purpose, and functionality.]

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

[Add picture of your hand sketched wireframes in this section]

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

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
