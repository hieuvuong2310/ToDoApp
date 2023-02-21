# ToDoApp
This app will help user to keep track of their Todo task for the assigned deadline.
To use the app, users first need to sign up/in first to start logging their tasks and their deadline. 
Then users will need to create a new task with a title and deadline. This data will be saved to Firebase database.
The saved tasks will be sorted and classified into 2 sections: today tasks, and other tasks
Then when users want to edit their logged tasks, they need to swipe left to reveal the edit button, then after tapping it, user can edit their tasks and save back to database.

Steps:
1. Login into existing account if you've already had one
![Simulator Screen Shot - Clone 1 of iPhone 14 Pro Max - 2023-02-20 at 23 40 33](https://user-images.githubusercontent.com/88293742/220279449-5413a003-a9d1-4755-b2ea-54923c0ef868.png)

OR
 Create an account by clicking "Create account"
 ![simulator_screenshot_40B599B7-5784-4963-9859-086A1246D812](https://user-images.githubusercontent.com/88293742/220279666-22732773-df86-4dc3-93f4-ec4adaedf06f.png)

2. After successully login your account, you will be directed to a screen where you can add your task by clicking "+" button
![Simulator Screen Shot - Clone 1 of iPhone 14 Pro Max - 2023-02-20 at 23 44 01](https://user-images.githubusercontent.com/88293742/220280194-7085c91d-9a4e-4adf-aea8-dfefae630dd2.png)

3. In the add new task screen, fill out your title and deadline and click save if you want to save to database or cancel if you don't want to save the task
![simulator_screenshot_4C24561E-48F2-40DF-B633-01893D28D87E](https://user-images.githubusercontent.com/88293742/220280383-c8cc5948-c82c-4ba3-b7ee-032319857b11.png)

4. After adding the tasks, you can swipe left to edit the task by clicking the "pencil" icon to edit
![simulator_screenshot_7FDDADC6-4426-4620-B0E5-224C2BE92CCC](https://user-images.githubusercontent.com/88293742/220280521-fe6d0d49-a1ac-4a25-851e-25ec1b3e3d9a.png)

5. After edit and click save, the task will be updated
![Simulator Screen Shot - Clone 1 of iPhone 14 Pro Max - 2023-02-20 at 23 48 08](https://user-images.githubusercontent.com/88293742/220280963-62670e60-de94-4f25-8ecf-04696a51b582.png)
![Simulator Screen Shot - Clone 1 of iPhone 14 Pro Max - 2023-02-20 at 23 48 11](https://user-images.githubusercontent.com/88293742/220280966-587e70f8-66f6-4d46-a632-151c753eb555.png)

7. The task will be classified into today task or other task
![simulator_screenshot_9E5C505D-6F69-4AA8-BCA6-E858649EED58](https://user-images.githubusercontent.com/88293742/220281157-5517a0a1-5026-4180-87b8-90033ebc263c.png)

NOTE: Currently working on the feature sending notification when the task is due as well as allow users to user FaceID when login instead of typing the credentials
