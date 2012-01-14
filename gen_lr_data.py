import random
import math
import sys

num_dims = 500
num_examples = 700000
output_file = open("lr_data.txt", 'w')
output_weight_file = open("lr_weight.txt", 'w')

def gen_rand_vector(dim):
	w = []
	for i in range(0, num_dims):
		w.append(random.gauss(0, 1))
	return(w)

def vector_to_string(v):
	ret_str = ""
	for val in v:
		ret_str = ret_str + str(val) + ","
	ret_str = ret_str[0:len(ret_str) - 1]
	return(ret_str)

def write_example_to_file(x, y):
	to_write = str(y) + "," + vector_to_string(x) + "\n"
	output_file.write(to_write)

def inner_product(w, x):
	ip = 0;
	for i in range(0, len(w)):
		ip = ip + w[i] * x[i]
	return(ip)

def sample(w, x):
	inner_p = inner_product(w, x)
	p = 1 / (1 + math.exp(-inner_p))
	y = (random.random() < p)
	return int(y)

if __name__ == "__main__":
	# Generate W
	w = gen_rand_vector(num_dims)
	output_weight_file.write(vector_to_string(w) + "\n")
	output_weight_file.close()

	# Generate the data
	for i in range(0, num_examples):
		x = gen_rand_vector(num_dims)
		y = sample(w, x)
		write_example_to_file(x, y)	



