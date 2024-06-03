#!/bin/bash
set -e

PYTHON_PATH="/home/shauntan/miniconda3/envs/alpha-beta-crown/bin/python"

# Get directory of this script.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd /home/shauntan/alpha-beta-CROWN/complete_verifier


# MNIST models.
mkdir -p "$script_dir/results/alpha_beta_crown/mnist"

models=(
  "mnist_relu_5_100"
  "mnist_relu_6_200"
  "convSmallRELU__Point"
  "convMedGRELU__Point"
  "convBigRELU__DiffAI"
)

for model in "${models[@]}"
do
  $PYTHON_PATH abcrown.py --config "/home/shauntan/benchmark_selection_experiment/models/mnist/$model.yaml" &> out.log
  mv out.log "$script_dir/results/alpha_beta_crown/mnist/$model.log"
  mv out.pkl "$script_dir/results/alpha_beta_crown/mnist/$model.pkl"
  mv out.txt "$script_dir/results/alpha_beta_crown/mnist/$model.txt"
done


# CIFAR10 models.
mkdir -p "$script_dir/results/alpha_beta_crown/cifar10"

models=(
  "convMedGRELU__PGDK_w_0.0078"
  "convBigRELU__DiffAI"
)

for model in "${models[@]}"
do
  $PYTHON_PATH abcrown.py --config "/home/shauntan/benchmark_selection_experiment/models/cifar10/$model.yaml" &> out.log
  mv out.log "$script_dir/results/alpha_beta_crown/cifar10/$model.log"
  mv out.pkl "$script_dir/results/alpha_beta_crown/cifar10/$model.pkl"
  mv out.txt "$script_dir/results/alpha_beta_crown/cifar10/$model.txt"
done



# ResNet models.
mkdir -p "$script_dir/results/alpha_beta_crown/resnet"

models=(
  "resnet_3b2_bn_mixup_adv_4.0_bs128_lr-1"
  "resnet_3b2_bn_mixup_ssadv_4.0_bs128_lr-1_v2"
)

for model in "${models[@]}"
do
  $PYTHON_PATH abcrown.py --config "/home/shauntan/benchmark_selection_experiment/models/resnet/$model.yaml" &> out.log
  mv out.log "$script_dir/results/alpha_beta_crown/resnet/$model.log"
  mv out.pkl "$script_dir/results/alpha_beta_crown/resnet/$model.pkl"
  mv out.txt "$script_dir/results/alpha_beta_crown/resnet/$model.txt"
done
