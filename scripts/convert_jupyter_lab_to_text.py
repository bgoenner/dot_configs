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

    for cell in src_file['cells']:
        if cell['cell_type'] == 'code':
            write_py_code_cell(cell, owFile)

    owFile.close()


def write_py_code_cell(cell, ofile):

    ofile.write('#################\n')
    ofile.write(f"# id:{cell['id']}"+'\n')
    ofile.write("\n")
    for line in cell['source']:
        ofile.write(line)
    ofile.write('\n')
    ofile.write(f'# end: {cell["id"]}'+'\n')
    ofile.write('#################\n')


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("--infile", required=True)
    parser.add_argument("-f", "--force", required=False,
                        action='store_true', default=False)
    parser.add_argument("-i", "--include_outputs", default=False,
                        action='store_true')
    args = parser.parse_args()

    convert_ipynb_file(
        args.infile,
        args.force
    )
