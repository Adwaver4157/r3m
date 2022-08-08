#!/bin/bash
cd /mj_envs
pip install -e .
cd /metaworld
pip install -e .
cd ~/workspace
pip install -e .
cd evaluation
pip install -e .
pip install wandb
git config --global --add safe.directory /root/workspace
