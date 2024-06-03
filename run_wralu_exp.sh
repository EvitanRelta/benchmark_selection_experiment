#!/bin/bash
set -e
source ~/venv_3dot8/bin/activate

# Get directory of this script.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd /home/shauntan/WraLU/experiments
if [ -d "./logs" ]; then
  echo "Please delete the \"logs\" dir first at WraLU's \"/experiments/logs\"."
  exit 1
fi

# Common arguments.
common_args="--ns 20 --k 3 --s 1 --convex_method sci --domain refinepoly --use_cutoff_of 0.05 --samples_start 0 --samples_num 200"


# MNIST models.
mkdir -p "$script_dir/results/wralu/mnist"

python experiment_normal_cpu.py \
  --dataset mnist \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/mnist/mnist_relu_5_100.onnx" \
  --epsilon 0.08 \
  $common_args &> "$script_dir/results/wralu/mnist/mnist_relu_5_100.log"
mv "/home/shauntan/WraLU/experiments/logs/mnist/"* "$script_dir/results/wralu/mnist/"

python experiment_normal_cpu.py \
  --dataset mnist \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/mnist/mnist_relu_6_200.onnx" \
  --epsilon 0.016 \
  $common_args &> "$script_dir/results/wralu/mnist/mnist_relu_6_200.log"
mv "/home/shauntan/WraLU/experiments/logs/mnist/"* "$script_dir/results/wralu/mnist/"

python experiment_normal_cpu.py \
  --dataset mnist \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/mnist/convSmallRELU__Point.onnx" \
  --epsilon 0.11 \
  $common_args &> "$script_dir/results/wralu/mnist/convSmallRELU__Point.log"
mv "/home/shauntan/WraLU/experiments/logs/mnist/"* "$script_dir/results/wralu/mnist/"

python experiment_normal_cpu.py \
  --dataset mnist \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/mnist/convMedGRELU__Point.onnx" \
  --epsilon 0.1 \
  $common_args &> "$script_dir/results/wralu/mnist/convMedGRELU__Point.log"
mv "/home/shauntan/WraLU/experiments/logs/mnist/"* "$script_dir/results/wralu/mnist/"

python experiment_normal_cpu.py \
  --dataset mnist \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/mnist/convBigRELU__DiffAI.onnx" \
  --epsilon 0.306 \
  $common_args &> "$script_dir/results/wralu/mnist/convBigRELU__DiffAI.log"
mv "/home/shauntan/WraLU/experiments/logs/mnist/"* "$script_dir/results/wralu/mnist/"



# CIFAR10 models.
mkdir -p "$script_dir/results/wralu/cifar10"

python experiment_normal_cpu.py \
  --dataset cifar10 \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/cifar10/convMedGRELU__PGDK_w_0.onnx" \
  --epsilon 0.006 \
  $common_args &> "$script_dir/results/wralu/cifar10/convMedGRELU__PGDK_w_0.log"
mv "/home/shauntan/WraLU/experiments/logs/cifar10/"* "$script_dir/results/wralu/cifar10/"

python experiment_normal_cpu.py \
  --dataset cifar10 \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/cifar10/convBigRELU__DiffAI.onnx" \
  --epsilon 0.00784313725 \
  $common_args &> "$script_dir/results/wralu/cifar10/convBigRELU__DiffAI.log"
mv "/home/shauntan/WraLU/experiments/logs/cifar10/"* "$script_dir/results/wralu/cifar10/"



# ResNet models.
mkdir -p "$script_dir/results/wralu/resnet"

python experiment_normal_cpu.py \
  --dataset cifar10 \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/resnet/resnet_3b2_bn_mixup_adv_4.0_bs128_lr-1.onnx" \
  --epsilon 0.0033 \
  $common_args &> "$script_dir/results/wralu/resnet/resnet_3b2_bn_mixup_adv_4.0_bs128_lr-1.log"
mv "/home/shauntan/WraLU/experiments/logs/cifar10/"* "$script_dir/results/wralu/resnet/"

python experiment_normal_cpu.py \
  --dataset cifar10 \
  --net_file "/home/shauntan/benchmark_selection_experiment/models/resnet/resnet_3b2_bn_mixup_ssadv_4.0_bs128_lr-1_v2.onnx" \
  --epsilon 0.0033 \
  $common_args &> "$script_dir/results/wralu/resnet/resnet_3b2_bn_mixup_ssadv_4.0_bs128_lr-1_v2.log"
mv "/home/shauntan/WraLU/experiments/logs/cifar10/"* "$script_dir/results/wralu/resnet/"
