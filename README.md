# MiniFlowRb
Basic TensorFlow version in Ruby to learn two concepts at the heart of neural networks - backpropagation and differentiable graphs.

This Neural Network library is built following the MiniFlow lesson in the Self-driving Car Nanodegree at Udacity.
The introduction in the lesson is as follows:

> Backpropagation is the process by which neural networks update the weights of the network over time.
>
>Differentiable graphs are graphs where the nodes are differentiable functions. They are also useful as visual aids for understanding and calculating complicated derivatives. This is the fundamental abstraction of TensorFlow - it's a framework for creating differentiable graphs.
>
>With graphs and backpropagation, you will be able to create your own nodes and properly compute the derivatives. Even more importantly, you will be able to think and reason in terms of these graphs.

# Example
To execute the MiniFlow stochastic gradient descent algorithm with the Housing Values in Suburbs of Boston
go inside the lib/ dir and execute:
```
$ ruby boston_housing_values.rb 5
Epoch: 1, Loss: 484.843
Epoch: 2, Loss: 412.195
Epoch: 3, Loss: 407.268
Epoch: 4, Loss: 402.490
Epoch: 5, Loss: 397.644
```
where 20 is the number of epochs. This argument is optional and defaults to 10 epochs.

On each epoch:
- shuffles all 506 rows on the dataset (overfitting the model)
- fits the model (forward pass)
- performs backpropagation to make the network learn (backward pass)
- loss is computed

# Author
[Oliver Valls](https://github.com/tramuntanal)
