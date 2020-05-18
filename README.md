# Welcome to the Dosis Coding Challenge
------------------------
## Instructions:
  ### Setup
  Please follow these steps to get setup: 
  1) `bundle`
  2) `rails db:reset` or `rails db:drop db:create db:migrate db:seed`
  3) `rails s`
   ..**It might take a moment to seed the data**
  
 
  
 -----------------------

 ## Welcome to the first page - The Bee Hive!
 ### It should look something like:
 ![Index Page](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/index_page.jpg)

 ## The color palette that I am using for this project is:
 ![Color Palette](https://github.com/Micjoey/Dosis/blob/d5ea864106322a707ae7459c6d90ca818482a8c1/app/assets/images/color_palette.png)
 
 From this page, you will be able to see all the bees that are part of the hive.
 You'll also be able to select the bee that you wish to view.

 ![Selecting Bee](https://github.com/Micjoey/Dosis/blob/217b95613292bd077cb3c3f8c0e1773de1dbe325/app/assets/images/selecting_bee.png)

 ----------
 ### Relevant Code:
 ![Index Code](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/index_code.png)
 ------
 -------------
 ### Bee Page:
![Show Page](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/show_bee_page.png)

In the top left of the page, you will find a standard go back button.

![Go Back Button](https://github.com/Micjoey/Dosis/blob/d5ea864106322a707ae7459c6d90ca818482a8c1/app/assets/images/go_back_button.png)

Directly below the go back button, you'll find the information on the bee. 
In this section, you'll be able to change which comb the bee resides in, and see the information that is correlated between the comb and bee.

![Change Comb](https://github.com/Micjoey/Dosis/blob/d5ea864106322a707ae7459c6d90ca818482a8c1/app/assets/images/change_comb_button.png)

Moving down on the page, you have the simulate week button. 

![Simulate Week](https://github.com/Micjoey/Dosis/blob/d5ea864106322a707ae7459c6d90ca818482a8c1/app/assets/images/simulate_week_button.png)


To simulate the week, I somewhat differed from the README, and that is my apologies.
-----
When you press the simulate week button, it will:
1) First, identify which bee and comb it is working with. 
2) Determine the `nectar_consumption`
3) Create a range_variance dependent if the bee has too much nectar consumed that week or not. To condense the code, the main lines are:
If a bee has too much nectar (drunk) it will potentially do better but most likely will do poorly
`range_variance = rand(-15..15) /100.00` 
if the nectar is less than or equal to the current_bee_nectar than the bee will have a standard range of obtaining pollen
`range_variance = rand(-5..40) /100.00`
4) Determine the pollen gathered off of how much pollen was consumed that week
5) Devise advisement so that the bee will achieve better efficiency. **This is where I deviated from the readme**
----

Every three weeks, there will be a notification regarding what is advised for the bee. This is calculated through find the current combs sweet spot dividing it by the max nectar able to be given. Then times that by 20,000.
`((1-(current_comb.sweet_spot/20,000).ceil) * 20000).ceil`

The advisement looks like:
![advisement](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/advisement.png)

If you accept the advisement, it will update that bee's nectar tolerance. If you decline, nothing will happen, and the bee will continue on as usual.

----
The graph itself looks like: 

![graph](https://github.com/Micjoey/Dosis/blob/d5ea864106322a707ae7459c6d90ca818482a8c1/app/assets/images/graph_and_data.png)

The graph has two view modes (enhanced and regular), which you can flip between using the button.

![graph button](https://github.com/Micjoey/Dosis/blob/d5ea864106322a707ae7459c6d90ca818482a8c1/app/assets/images/graph_and_button.png)

The enhanced graph looks as follows: 

![enhanced view](https://github.com/Micjoey/Dosis/blob/d5ea864106322a707ae7459c6d90ca818482a8c1/app/assets/images/graph_and_button.png)

The regular view looks like:

![regular view](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/regular_graph.png)

---

## Cool Code
### Advisement Pop Up Code

To allow the form to update the bee instantly when the new week is generated. I used the `controller create method` of the `PollenCollection` to also update the bee if it contained the `"Yes"` value.

![pop up](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/pop_up_logic.png)
![Pollen create](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/PollenCreation.png)


-----

To Keep code clean and DRY I used partials and modules.
![partial](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/partial.png)
![module one](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/module_one.png)
![module two](https://github.com/Micjoey/Dosis/blob/master/app/assets/images/module_two.png)

By importing the module into the other module, I was able to include both modules into
the main class module.

Advisement Module --> Worker Bee Helper Module --> Worker Bee Class
