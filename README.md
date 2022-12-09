[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-c66648af7eb3fe8bc4f294546bfd86ef473780cde1dea487d3c4ff354943c9ae.svg)](https://classroom.github.com/online_ide?assignment_repo_id=9457768&assignment_repo_type=AssignmentRepo)
# CSC3170 Course Project

## Project Overall Description

This is our implementation for the course project of CSC3170, 2022 Fall, CUHK(SZ). For details of the project, you can refer to [project-description.md](project-description.md). In this project, we will utilize what we learned in the lectures and tutorials in the course, and implement either one of the following major jobs:

<!-- Please fill in "x" to replace the blank space between "[]" to tick the todo item; it's ticked on the first one by default. -->

- [x] **Application with Database System(s)**
- [ ] **Implementation of a Database System**

## Team Members

Our team consists of the following members, listed in the table below (the team leader is shown in the first row, and is marked with 🚩 behind his/her name):

<!-- change the info below to be the real case -->

| Student ID | Student Name | GitHub Account (in Email) | GitHub id |
| ---------- | ------------ | ------------------------- | --------- |
| 119010363  | 徐亦宸 🚩      | 119010363@link.cuhk.edu.cn        | Xyc-arch |
| 120090881  | 赵健翔         | 2075750149@qq.com          |         |
| 119010449  | 张依扬         | 119010449@link.cuhk.edu.cn        | krinko7 |
| 119010464  | 郑佳辰         | zjc1617018@outlook.com            | 19010464 |
| 119010395  | 姚南君         | annumyao@outlook.com            | annumYao |
| 122400001  | 宋知愉         | zhiyu.son@student.mahidol.ac.th            | Mralwayswins |

## Project Specification

<!-- You should remove the terms/sentence that is not necessary considering your option/branch/difficulty choice -->

After thorough discussion, our team made the choice and the specification information is listed below:

- Our option choice is: **Option 1**
- Our branch choice is: **Branch 1**
- The difficulty level is: **Normal**

## Project Abstract

### **Background**

Database Management Systems (DBMS) are widely used in various fields from keeping books ordered in the library to controlling all personal information on the internet. 
Its ability to manage a complex connection of structured information facilitates information management across a variety of industries, especially for those under sub-contraction mode.
Within this project, we create a database for an organization to realize providing a platform for online circuit manufacture orders.

### **Settings**

Here we provide the basic settings for the organization and manufacture:

Consumers can request some plants with some packages. The package refers to the bundle of chips that a consumer requires to finish and each package has an overall time and expense budget itself. Every chip can be of only one chip type. A chip can be either processed by one plant or multiple plants, but it usually requires the cooperation of different machines. Some specific chip types’ production requires a few operations to be processed in some partial order. A plant holds machines of multiple types. A machine might be able to process different types of operations, but it can only process one operation at the same time. Multiple plants hold the ability to process an operation, which can be assigned to only one plant in a package. One operation can be processed by one machine at the same time.

In order to more clearly illustrate, an ER diagram is provided here.

Moreover, some extensive settings are shown as follows:


+  Sub-contraction-Share Constraint: For some operation types, there might be a quota for different plants to get the appointment.
+  Geometrical Constraint: Considering the location of consumers and plants, those deal for a consumer and a plant that are too far away from each other can not be made
+  Complex Plant: Some plants might hold multiple machine types and can be more flexible in chip processing.
+  Centralized Banking System: A centralized banking system is added. 
+  Set-up Cost for Transportation: Transportation cost considering the distance of their location



### **Functionalities**

Our platform provides the following major functionalities:
+  Consumers can release their package demand information
+  Consumer can appoint some plant for some package manually
+  The assignment and the start-time of some operation with some machine could be further set under the constraint of plant appointment
+  The processing record in end-time and expense of some operation could be written back once it is successfully finished
+  The production information, like the manufacturing capacity of some plants, or the demand changes of some consumers within some period of time can be calculated.
