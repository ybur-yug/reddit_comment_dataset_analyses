import json
import sys
import pdb
import ast

def load_data(fn):
    loaded_data = []
    with open('data_sample.json') as data_file:
        for row in data_file:
            stripped_row = row.rstrip()
            row_dict = ast.literal_eval(stripped_row)
            loaded_data.append(row_dict)
    return loaded_data

fn = sys.argv[0]

comments = load_data(fn)
pdb.set_trace()
print comments
