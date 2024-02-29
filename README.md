# Connect4Model
Logic For Systems Curiosity Modeling Project


As part of your project submission, we request a one page README.md file that provides a comprehensive overview of your implementation. This document should effectively communicate your approach and insights to someone who might be new to your chosen topic. At a minimum, you should address each of the following points:


Project Objective: What are you trying to model? Include a brief description that would give someone unfamiliar with the topic a basic understanding of your goal.


Model Design and Visualization: Give an overview of your model design choices, what checks or run statements you wrote, and what we should expect to see from an instance produced by the Sterling visualizer. How should we look at and interpret an instance created by your spec? Did you create a custom visualization, or did you use the default?


Signatures and Predicates: At a high level, what do each of your sigs and preds represent in the context of the model? Justify the purpose for their existence and how they fit together.


Testing: What tests did you write to test your model itself? What tests did you write to verify properties about your domain area? Feel free to give a high-level overview of this.


For our curiosity modeling project, we decided to model the popular kid's game Connect 4. Connect 4 is composed of a 6x7 grid of circles, where one player must drop
a piece into a given column, where it will fall as far as it can, afterwhich their opponenent will do the same with the opposite color. In order to win, a player must 'connect 4' pieces together in the grid, horizonally, diagonlly, or vertically before their opponent. This did not seem so intuitive at the beginning as we had to take
gravity and more complicated win conditions than we had seen before when modeling, as well as apply linearity concepts we were still growing with. We found inductive reasoning to be quite powerful for the model as a whole.


We wanted to apply a lot of what we had been discussing in class and stretch it further. Given the tic tac toe lab and exercise, we felt that connect four shared enough
similarities, and enough differences, to be an adequate way to engage with forge/froglet. We wanted to explore traces in a slightly more complex system, without biting off more than we can chew, and were also curious about the strengths, and limits, of induction (it's quite strong). What resulted is a fully working model of connect 4
that logically simulates falling with induction, and also checks for winning horizontally, diagonally, and vertically inductively. Our model was based largely off of in class notes with core changes coming in the added complexity and physics of the system.


Due to a few inductive tricks and some help in hours for traces, we felt that we were able to quite soundly model connect 4. As we finished our model, we decided to add
a visualizer of the final state board to help us in our visual debugging process (as well as to add more to the user experience for our project). Because we only had two players, it was actually quite hard to see which pieces were where, as the graph lines were overlapping, and the table was tedious to read. Our visualizer expedited our process, but we also realized that there was an occasionaly incosistency within the visualizer, where red pieces would show up as yellow, or vice versa, or not at all. As a result, our ground truths were always based off table values and tests.


We modeled our signatures and predicates based off of tic tac toe, with R and Y being the players, the board as the 6x7 grid, and the game itself when we wanted to simulate linearity. We also have wellformed predicates to ensure the states are behaving correctly (more comments in c4.frg), a move predicate, an initialization for the
game state, a gametrace, and a few run statements for you to use at your discretion (commented out intially). We realized as we were working that most turn based games
follow a pretty similar model to tic tac toe, and as such had to do very little extrapolation, as mentioned above.


We created 4 test suites, for wellformed, balanced, winning, and move, in addition to quality testing by eye. While all of our tests pass, we encountered a bizarre bug
within our testing file that made it difficult to add more tests than we already had. We tried deleting the file, rewriting the file, etc. but to no avail. That being said, we believe our tests demonstrate adequate soundness for a model of such complexity, regardless of the bug. We added some notes detailing our issue for your convenience if that is helpful for any of you at all!


Run this project like any other forge project! We've added a few run statements for you to play with as you please, but feel free to add more as well.


Thanks!









