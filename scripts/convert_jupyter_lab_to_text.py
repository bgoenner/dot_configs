#!/bin/python3
import os
import json
import argparse


def convert_ipynb_file(infile, forced=False):
    src_file = json.load(open(infile, 'r'))

    if infile[-6:] != '.ipynb':
        raise ValueError("Expecting a file of exentension '.ipynb'")
    of_py = infile[:-6] + '.py'

    if os.path.exists(of_py) and not forced:
        raise Exception(
            f"Output file {of_py} exists, use '-f' or '--force' to overwrite")

    owFile = open(of_py, 'w')
    print(f"Writing to {of_py}")

    first_cell = True
    for cell in src_file['cells']:
        if cell['cell_type'] == 'code':
            write_py_code_cell(cell, owFile, first_cell)
        first_cell = False

    owFile.close()


def write_py_code_cell(cell, ofile, fcell):

    if fcell:
        ofile.write("""# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.3.4
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %%
""")
        for line in cell['source']:
            ofile.write(line)
        ofile.write('\n')
    else:
        ofile.write('\n')
        ofile.write(f"# %% id:{cell['id']}"+'\n')
        ofile.write("\n")
        for line in cell['source']:
            ofile.write(line)
        ofile.write('\n')
    # ofile.write(f'# %% end: {cell["id"]}'+'\n')
    # ofile.write('#################\n')


if __name__ == "__main__":
    parser=argparse.ArgumentParser()

    parser.add_argument("--infile", required=True)
    parser.add_argument("-f", "--force", required=False,
                        action='store_true', default=False)
    parser.add_argument("-i", "--include_outputs", default=False,
                        action='store_true')
    args=parser.parse_args()

    convert_ipynb_file(
        args.infile,
        args.force
    )
