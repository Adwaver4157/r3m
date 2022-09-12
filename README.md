# R3M: A Universal Visual Representation for Robot Manipulation

This project studies how to learn generalizable visual representation for robotics from videos of humans and natural language. It contains pre-trained representation on the Ego4D dataset trained in the [R3M paper](https://arxiv.org/abs/2203.12601)

![](https://cs.stanford.edu/~surajn/images/r3m_robot_teaser_2.gif)

## Installation

### How to reproduce BC with R3M
1. Clone a forked version of r3m repository
```bash
git clone -b reproduce https://github.com/Adwaver4157/r3m.git
```

2. Download datasets, in this example, download drawer-open[left] demo dataset
```bash
cd r3m
mkdir -p dataset/final_paths_multiview_meta_200/left_cap2
cd dataset/final_paths_multiview_meta_200/left_cap2
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1237SZJY24IWpqEUZ4qMQOXaccciMg9Ze' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1237SZJY24IWpqEUZ4qMQOXaccciMg9Ze" -O drawer-open-v2-goal-observable.pickle && rm -rf /tmp/cookies.txt
cd ../../../
```

3. Clone [this image](https://hub.docker.com/repository/docker/adwaver4157/r3m) and run docker container
```bash
docker pull adwaver4157/r3m:latest
docker run -it --rm --name username_r3m \
               --gpus all --shm-size=16gb \
               --net=host \
               --mount type=bind,source="$(pwd)",target=/root/workspace \
               adwaver4157/r3m:latest
```

4. Install some libraries in Docker container
```bash
bash install.sh
```

5. Run BC file
```bash
cd evaluation
python r3meval/core/launcher.py
```

If you get some pytorch errors, you should try to reinstall pytorch as follows then you may become able to run the script.
```bash
pip3 install torch==1.8.2 torchvision==0.9.2 torchaudio==0.8.2 --extra-index-url https://download.pytorch.org/whl/lts/1.8/cu111
```

## Using the representation

To use the model in your code simply run:
```
from r3m import load_r3m
r3m = load_r3m("resnet50") # resnet18, resnet34
r3m.eval()
```

Further example code to use a pre-trained representation is located in the example [here](https://github.com/facebookresearch/r3m/blob/main/r3m/example.py).

If you have any issue accessing or downloading R3M please contact Suraj Nair: surajn (at) stanford (dot) edu


## License

R3M is licensed under the MIT license.

## Ackowledgements

Parts of this code are adapted from the DrQV2 [codebase](https://github.com/facebookresearch/drqv2)
