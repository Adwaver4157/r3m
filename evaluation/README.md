# Evaluation Code for R3M

The codebase contains the evaluation codebase from the paper [R3M: A Universal Visual Representation for Robot Manipulation](https://sites.google.com/view/robot-r3m/).

It trains policies from pixels with behavior cloning using pre-collected demonstrations, evaluating the policies in the environment at regular intervals. It allows for selecting different visual representations to use during imitation. 

## Environment Installation

The first step to running the code involves installing the evaluation environments.

For metaworld environments, install the environments by cloning this [fork of the metaworld repo](https://github.com/suraj-nair-1/metaworld) and installing via `pip install -e .`

In order to install the Franka Kitchen and Adroit environments, first install the `mjrl` repo using instructions [here](https://github.com/aravindr93/mjrl).
Then install the stable branch of the `mj_envs` repo [here](https://github.com/vikashplus/mj_envs/tree/stable). 

In order to match the R3M experiments where the Franka Kitchen is randomized in space, be sure to add the line 
```
FIXED_ENTRY_POINT = RANDOM_DESK_ENTRY_POINT
```
here https://github.com/vikashplus/mj_envs/blob/stable/mj_envs/envs/relay_kitchen/__init__.py#L160. This changes the default behavior of the environment from a fixed kitchen ot one where the kitchen moves around in, making the task more visually challenging.

## Installing R3M

To use the R3M model, simply follow the installation process in the parent directory [here](https://github.com/facebookresearch/r3m).

## Downloading Demonstration Data

All demonstrations are located [here](https://drive.google.com/drive/folders/108VW5t5JV8uNtkWvfZxEvY2P2QkC_tsf?usp=sharing). Then change the path [here]() to point to where the demonstration data is located. Make sure the data is saved with the same folder structure as on the google drive, e.g. `<PATH TO DEMOS>/final_paths_multiview_meta_200/<CAMERA>/<TASK>.pickle`.

## Install and Run Eval Code

If the above was all done correctly, you should be able to simply run `pip install -e .` in this directory.

## Verifying Correct Installation

While running all experiments can be time consuming, a simple check to make sure things are behaving as expected is to download the demos for the kitchen sliding door task, and run:

```
python hydra_launcher.py hydra/launcher=local hydra/output=local env="kitchen_sdoor_open-v3" camera="left_cap2" pixel_based=true embedding=resnet50 num_demos=5 env_kwargs.load_path=r3m bc_kwargs.finetune=false proprio=9 job_name=r3m_repro seed=125
```
and 
```
python hydra_launcher.py hydra/launcher=local hydra/output=local env="kitchen_sdoor_open-v3" camera="left_cap2" pixel_based=true embedding=resnet50 num_demos=5 env_kwargs.load_path=clip bc_kwargs.finetune=false proprio=9 job_name=r3m_repro seed=125
```

You should see R3M get ~60% success on the first eval, while CLIP will get ~30%.


## Commands for All Experiments

For running kitchen environments run:
```
python hydra_launcher.py --multirun hydra/launcher=local hydra/output=local env=["kitchen_knob1_on-v3","kitchen_light_on-v3","kitchen_sdoor_open-v3","kitchen_ldoor_open-v3","kitchen_micro_open-v3"] camera=["default","left_cap2","right_cap2"] pixel_based=true embedding=resnet50 num_demos=25 env_kwargs.load_path=r3m bc_kwargs.finetune=false proprio=9 job_name=try_r3m
```

For running metaworld environments run:

```
python hydra_launcher.py --multirun hydra/launcher=local hydra/output=local env=["assembly-v2-goal-observable","bin-picking-v2-goal-observable","button-press-topdown-v2-goal-observable","drawer-open-v2-goal-observable","hammer-v2-goal-observable"] camera=["left_cap2","right_cap2","top_cap2"] pixel_based=true embedding=resnet50 num_demos=25 env_kwargs.load_path=r3m bc_kwargs.finetune=false proprio=4 job_name=try_r3m
```

For running the Adroit pen task:
```
python hydra_launcher.py --multirun hydra/launcher=local hydra/output=local env=pen-v0 camera=["view_1","top","view_4"] pixel_based=true embedding=resnet50 num_demos=25 env_kwargs.load_path=r3m bc_kwargs.finetune=false proprio=24 job_name=try_r3m
```

For running the Adroit relocate task:
```
python hydra_launcher.py --multirun hydra/launcher=local hydra/output=local env=relocate-v0 camera=["view_1","top","view_4"] pixel_based=true embedding=resnet50 num_demos=25 env_kwargs.load_path=r3m bc_kwargs.finetune=false proprio=30 job_name=try_r3m
```