目前几个问题： 



# 在dynfu提供的docker dynfu-build-env环境中，需要安装Terra和Opt，本来自己编译，结果出错了。
编译 clang/AST/ASTConsumer.h: No such file or directory

# 后来发现原来是个简单的问题
自己更改一下cmakelist的路径就可以找到Opt，都是 $CMAKE_DIR惹的祸，但是又出现了找不到pcl的问题，自己编译PCL则会出现PCL依赖于boost 1.65较高版本问题。

# 在docker dynfu core上面弄出来了，基本上错误如下： 
----------------------+----------+-----------+----------
 PCGStep2_1stHalf_D   |     42   |   25.324ms|  0.6029ms
----------------------+----------+-----------+----------
 computeAdelta_D      |     42   |    0.641ms|  0.0153ms
----------------------+----------+-----------+----------
 computeAdelta_Graph_DataG |     42   |  845.008ms| 20.1192ms
----------------------+----------+-----------+----------
 PCGStep2_2ndHalf_D   |     42   |    1.060ms|  0.0252ms
----------------------+----------+-----------+----------
 computeModelCost_D   |      5   |    2.951ms|  0.5901ms
----------------------+----------+-----------+----------
 computeModelCost_Graph_DataG |      5   |    1.719ms|  0.3439ms
----------------------+----------+-----------+----------
 savePreviousUnknowns_D |      5   |    2.981ms|  0.5963ms
----------------------+----------+-----------+----------
 PCGLinearUpdate_D    |      5   |    0.083ms|  0.0166ms
--------------------------------------------------------
TIMING 9917.745117 3.083552 103.023270 0.098784 107.167290 8452.522461
Per-iter times ms (nonlinear,linear): 216.6490  8566.6729
===Robust Mesh Deformation===
**Final Costs**
Opt GN,Opt LM,CERES
,2.10535324096679687500e+02,
OpenCV Error: Unspecified error (The function is not implemented. Rebuild the library with Windows, GTK+ 2.x or Carbon support. If you are on Ubuntu or Debian, install libgtk2.0-dev and pkg-config, then re-run cmake or configure script) in cvWaitKey, file /opencv-3.2.0/modules/highgui/src/window.cpp, line 654
Exception
出现了Opencv的错误，可能是OpenCV没有编译好


Dynfu
============
Dependencies:
* CUDA-enabled CPU (Kepler or newer) with CUDA 7.5 or higher, required by Opt
* OpenCV 2.4.9 with new Viz module (only opencv_core, opencv_highgui, opencv_imgproc, opencv_viz modules required); make sure that WITH_VTK flag is enabled in CMake during OpenCV configuration

Implicit dependency (needed by opencv_viz):
* VTK 5.8.0 or higher (apt-get install on linux, for Windows please download and compile from www.vtk.org)

## Future additions
* Surface fusion using PSDF for non-rigid surfaces
* Exending the warpfield by adding in new deformation nodes
* Regularisation for the energy function

## References
The CPU warpfield solver is based on [Ceres](https://github.com/ceres-solver/ceres-solver).
```
@misc{ceres-solver,
  author = "Sameer Agarwal and Keir Mierle and Others",
  title = "Ceres Solver",
  howpublished = "\url{http://ceres-solver.org}",
}
```
The GPU warpfield solver is based on [Opt](http://optlang.org).
```
@article{devito2016opt,
  title={Opt: A Domain Specific Language for Non-linear Least Squares Optimization in Graphics and Imaging},
  author={DeVito, Zachary and Mara, Michael and Zoll{\"o}fer, Michael and Bernstein, Gilbert and Theobalt, Christian and Hanrahan, Pat and Fisher, Matthew and Nie{\ss}ner, Matthias},
  journal={arXiv preprint arXiv:1604.06525},
  year={2016}
}
```
The KD-tree is created using [nanoflann](https://github.com/jlblancoc/nanoflann).
```
@misc{blanco2014nanoflann,
  title        = {nanoflann: a {C}++ header-only fork of {FLANN}, a library for Nearest Neighbor ({NN}) wih KD-trees},
  author       = {Blanco, Jose Luis and Rai, Pranjal Kumar},
  howpublished = {\url{https://github.com/jlblancoc/nanoflann}},
  year         = {2014}
}
```
