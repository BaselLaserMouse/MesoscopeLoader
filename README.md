# Mesoscope loader

This toolbox provides functions to load mesoscope data in Matlab. It relies on
lazy data structures to load on demand images from sequences.

## Dependencies

The toolbox requires Matlab (tested on Matlab 2016b) and the following
packages:

- [TIFFStack](https://github.com/DylanMuir/TIFFStack)
- [MappedTensor](https://github.com/DylanMuir/MappedTensor)
- [TensorStack class](https://github.com/DylanMuir/TensorStack)
- [TensorView class](https://bitbucket.org/lasermouse/TensorView)
- [uipickfiles](http://www.mathworks.com/matlabcentral/fileexchange/10867-uipickfiles--uigetfile-on-steroids)
  (optional, used in example)


## Installation

Retrieve a copy if this repository, cloning it with git.
This can be achieved by to typing the following command in a terminal:
```
git clone https://github.com/BaselLaserMouse/MesoscopeLoader
```

Then, in Matlab, go to the toolbox folder and use the `toolbox_setup` function
to download the dependencies and properly configure Matlab search path.
Do not forget to save Matlab search path for future use.

**Do not** manually add the repository folder to the path, as the hidden *.git*
folder will likely cause troubles.


## Getting started

Loading stacks of images relies on the `stacksload` function. Then, one needs
to (virtually) split each ScanImage ROI using the `split_mroi_stack` function.

Typical use look like this:

```matlab
% load a set of .tif files
stackfolder = uigetdir;  % can be replaced by uipickfiles, much better
[stack, header] = stacksload(stackfolder);
% get each ScanImage ROI in a different stack object
meso_stacks = split_mroi_stack(stack, header)
```

Documentation of each function be can accessed from Matlab command line using
`help <function name>` and `doc <function name>`.
