# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Yoobin Jin
* *email:* ybcjin@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The vessel and camera are aligned at all times, even when the vessel is moving at hyper speed. The crosshair is also already drawn as indicated in the instructions.
I thought it was nice that the crosshair was white instead of black since it's easier to see. Also, the zoomed out camera makes it easier to see that the vessel is traveling even if the camera doesn't appear to be moving relative to the vessel, which I thought was also a nice touch.

___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [X] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
When the frame border box dimensions/positions are not adjusted, the box is the size of the window/screen. In this case, the code correctly keeps the vessel within the bounds of the screen. Even when the vessel tries to move beyond the bounds, it remains inside the box and in view of the camera.

However, I believe there are some major issues related to the inflexibility of the frame box's dimensions and related calculations for positioning the camera/vessel. For example, the frame border box's dimensions seem to be [hard coded in the script](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/frame_scroll.gd#L31) so that the frame box is the same as the window. Consequently, after I try to adjust the frame box border values in the inspector, the vessel/camera do not behave as expected. For example, the frame border can be off-screen. The vessel also can be outside of the box if it's moving at hyperspeed, though it does travel back inside the box eventually.
The frame border box is also not drawn even when `draw_camera_logic` is true and when the `top_left` and `bottom_right` values are adjusted to be smaller than the window size. When the box is supposed to be smaller (based on the values of `top_left` and `bottom_right`), the vessel doesn't seem to respect the closer boundaries, instead going off the screen.

There are a few minor issues as well. For example, the vessel's movement is jittery when moving against the camera border. Also, when transitioning from the previous camera to this camera, sometimes the camera is positioned far enough away that the vessel isn't actually in view of the camera, so we have to wait for the vessel to catch up and be within view again.
___
### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera correctly lags behind the vessel, even when it's moving at hyper speed. When the vessel stops moving, the camera quickly (but smoothly) catches up with the vessel. The crosshair is also already drawn.

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [X] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Most of the time, the camera correctly moves ahead of the vessel. However, the main reason why I gave this stage a "Good" was the camera *lags behind* the vessel when it's going at hyper speed (though, once the vessel stops going at hyper speed, the camera returns to being ahead of the vessel).
A minor issue is that it seems like the camera doesn't immediately stop in place when the vessel does. Instead, the camera seems to keep moving for a bit before waiting for the catchup delay duration. The issue could be caused by the timer calculations being based on the total `delta` rather than using a timer signal.

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [X] Unsatisfactory

___
#### Justification ##### 
Stage 5 is not implemented.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
In `flerp_camera.gd`, a [private function](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/flerp_camera.gd#L21) shows up before the built-in virtual method `_process()`, when it should be the other way around.
The student does not put two empty lines between functions, such as [between `_ready()` and `_process()`](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/plerp_camera.gd#L37) in `plerp_camera.gd` or between [`_process()` and `push_target()`](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/frame_scroll.gd#L22) in `frame_scroll.gd`.

#### Style Guide Exemplars ####
As far as I can tell, the code follows rules about naming conventions/case for functions and variables. Exported variables are before private variables, and the variables are all also clearly typed.
There are spaces between operators/operands for readability. There are also [blank lines between logical chunks](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/plerp_camera.gd#L51) within a function, as shown in `plerp_camera.gd` for example. 

Also, in `flerp_camera.gd`, the student correctly follows the style guide for a [multiline statement](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/flerp_camera.gd#L51). In the same script, the public function also correctly follows the built-in functions. In the same code on [line 43](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/flerp_camera.gd#L43), the student is careful to use `not` instead of `!`.
___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
As mentioned earlier in the peer review, the autoscroll camera has some [hardcoded numbers](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/frame_scroll.gd#L31) that make the code less flexible because you can't have frame boxes of different dimensions. Also, by directly using the numbers instead of using a constant, the code is less readable. For example, it's not immediately clear to the reader what `27` or `15` mean, or their significance.
In `flerp_camera.gd`, the student depends on `delta` for the timer mechanism, but I think that might be too finnicky and less reliable or consistent. I think it would be better to use a timer signal instead.

In `flerp_camera.gd`, the [public variables](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/flerp_camera.gd#L9) that are not exported could be private (prefixed with a `_`) since they are only used within the script.

In `flerp_camera.gd`, I think [`_process()`](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/flerp_camera.gd#L42) would benefit from having more comments as well for clarity.

The repo only seems to have one commit besides the initial commit. It would be better to have more frequent commits for more detailed commit messages.

#### Best Practices Exemplars ####
`plerp_camera.gd` has a good amount of high-level commenting, particularly in [`_process()`](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/plerp_camera.gd#L39).
The functions are also generally pretty short and readable, making the code feel more manageable. For example, I'm impressed by the length of [`_process()`](https://github.com/ensemble-ai/exercise-2-camera-control-hamzaahmed1234/blob/7e7b93df158722584d23ffefb22efa5a0f84aec4/Obscura/scripts/camera_controllers/flerp_camera.gd#L42) in `flerp_camera.gd`. While I did use a different method for my calculations, my code was pretty long and somewhat complex/confusing (especially for a first-time viewer). However, the student's code feels much less intimidating.
