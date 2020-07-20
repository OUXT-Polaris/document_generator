import argparse

tocttree_template = ".. toctree::\n\
    :maxdepth: 2\n\
    :caption: Contents:\n"

indicies_template = \
"* :ref:`genindex`\n\
* :ref:`modindex`\n\
* :ref:`search`\n"

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='tools for generating .rst files for document_generator')
    parser.add_argument('package_name', help='list of the targets')
    parser.add_argument('target_list', help='list of the targets')
    parser.add_argument('output_dir', help='output directory of index.rst')
    args = parser.parse_args()
    rst_string = tocttree_template
    target_list = args.target_list.split(",")
    for target in target_list:
        content_str = "\n"+\
        target + ": documentation_"+target+"_\n\n" +\
        ".. _documentation_"+target+": ../../" + target + "/" + target + "/html/index.html\n"
        rst_string = rst_string + content_str
    
    rst_string = rst_string + "\n" +  indicies_template
    print(rst_string)
    with open(args.output_dir+"/index.rst", mode='w') as f:
        f.write(rst_string)