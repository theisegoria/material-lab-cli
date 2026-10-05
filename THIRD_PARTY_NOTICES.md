# Third-party notices

The material-lab command-line tool is licensed under its own terms (see [LICENSE](LICENSE)). It bundles one third-party model, listed below with its licence.

## MoGe-2 (Microsoft)

- Model: MoGe-2 ViT-S with normal head (`Ruicheng/moge-2-vits-normal`). Bundled, converted to Core ML, as `share/material-lab/MoGe2Normals.mlmodelc`.
- Source: https://github.com/microsoft/MoGe (commit `74fbce054ebed49800de42d0ad0e83495065719a`)
- Weights SHA-256: `79a16621928c2bf0ed04659218c55c01075e950507f40bb3332fb4c873d3e1dc`
- Licence: MIT License, Copyright (c) Microsoft Corporation.

> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## DINOv2 (Meta AI)

The MoGe-2 encoder includes DINOv2 modules, licensed under the Apache License 2.0 (https://www.apache.org/licenses/LICENSE-2.0), Copyright (c) Meta Platforms, Inc. and affiliates. The converted model contains weights derived from these modules. No DINOv2 source code is redistributed here.

## References (no code redistributed)

Material Lab implements published methods from their papers:

- GTAO (Jimenez et al. 2016), cross-checked against Intel's MIT-licensed XeGTAO
- Histogram-preserving blending (Heitz & Neyret 2018)
- Image-quilting minimum-error boundary cuts (Efros & Freeman 2001)
