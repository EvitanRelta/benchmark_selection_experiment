given 8 network
select eps values
select 30 images


# TODO
- change WRALU to use custom 1000 mnist/cifar10 datasets
- ask about cutoff

# MNIST
5x100 FCNN, DiffAI
eps 0.08
https://files.sri.inf.ethz.ch/eran/nets/onnx/mnist/mnist_relu_5_100.onnx

6x200 FCNN, None
eps 0.016
https://files.sri.inf.ethz.ch/eran/nets/onnx/mnist/mnist_relu_6_200.onnx

ConvSmall, None
eps 0.11
https://files.sri.inf.ethz.ch/eran/nets/onnx/mnist/convSmallRELU__Point.onnx

ConvMed, None
eps 0.1
https://files.sri.inf.ethz.ch/eran/nets/onnx/mnist/convMedGRELU__Point.onnx

ConvBig, DiffAI
eps 0.306
https://files.sri.inf.ethz.ch/eran/nets/onnx/mnist/convBigRELU__DiffAI.onnx



# CIFAR10
ConvMed, PGD eps=0.0078
eps 0.006
https://files.sri.inf.ethz.ch/eran/nets/onnx/cifar/convMedGRELU__PGDK_w_0.0078.onnx

ConvBig, DiffAI
0.00784313725
https://files.sri.inf.ethz.ch/eran/nets/onnx/cifar/convBigRELU__DiffAI.onnx



Both Epsilon: 0.0033

https://github.com/ChristopherBrix/vnncomp2022_benchmarks/tree/main/benchmarks/sri_resnet_a/onnx
https://github.com/ChristopherBrix/vnncomp2022_benchmarks/tree/main/benchmarks/sri_resnet_b/onnx

https://github.com/ChristopherBrix/vnncomp2022_benchmarks/raw/main/benchmarks/sri_resnet_a/onnx/resnet_3b2_bn_mixup_adv_4.0_bs128_lr-1.onnx.gz
https://github.com/ChristopherBrix/vnncomp2022_benchmarks/raw/main/benchmarks/sri_resnet_b/onnx/resnet_3b2_bn_mixup_ssadv_4.0_bs128_lr-1_v2.onnx.gz

run on first 200 images out of the 1000 images from the CSV files

verified falsified or unknown
time


when running AB crown, print the pytorch model to see if thrs SUB and DIV layers.
If no, it doesn't have the norm layers, use MNIST_ERAN
If yes, it has the norm layers, use MNIST_ERAN_UN

fix gurobi
None, None

For AB crown, YAML config file:
```yaml
model:
  onnx_path: your_path_to_onnx_model_make_sure_the_same_as_wralu
  input_shape: [1, 1, 28, 28] # update to your own path
# For resnet A and B
# model:
#   onnx_quirks: "{'Reshape': {'fix_batch_size': True}}"
data:
  dataset: MNIST_ERAN
  start: 0
  end: 200
specification:
  epsilon: 0.0033
attack:
  pgd_restarts: 100
solver:
  batch_size: 2048
  beta-crown:
    iteration: 20
bab:
  timeout: 300
  branching:
    reduceop: max
```
