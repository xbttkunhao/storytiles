// PPT模板使用示例
#import "lib.typ": *

#show: doc => ppt-conf(
  title: "近代物理实验演示",
  author: "张三",
  theme: rgb("#1f4e79"),
  font-size: 12pt,
  doc,
)

// 标题页
#title-page(
  main-title: "近代物理实验",
  subtitle: "光电效应实验报告",
  author: "张三",
  institution: "北京大学物理学院",
  // logo: "logo.png" // 如果有logo的话
)

// 目录页
#outline-page()

// 四图片页面示例
#four-image-page(
  title: "实验装置与结果",
  images: (
    "image1.png", // 替换为实际图片路径
    "image2.png",
    "image3.png",
    "image4.png",
  ),
  captions: (
    "实验装置图",
    "光电流与电压关系",
    "截止电压与频率关系",
    "数据拟合结果",
  ),
  content: [
    本页展示了光电效应实验的主要装置和关键结果。从实验数据可以看出，光电流与逆向电压呈线性关系，截止电压与光频率也呈良好的线性关系，验证了爱因斯坦光电效应方程。
  ],
)

// 自定义布局页面示例
#custom-layout-page(
  title: "自定义图片布局",
  content: [
    #v(50%)
    这个页面演示了如何自定义图片的位置。你可以精确控制每张图片的位置、大小和说明文字。
  ],
  images: (
    (
      path: "image1.png",
      x: 10%,
      y: 15%,
      width: 35%,
      height: 25%,
      caption: "左上角图片",
    ),
    (
      path: "image2.png",
      x: 55%,
      y: 15%,
      width: 35%,
      height: 25%,
      caption: "右上角图片",
    ),
  ),
)

// 纯文字页面示例
#text-page(
  title: "理论背景",
  content: [
    = 光电效应的发现

    光电效应是指当光照射到金属表面时，金属会发射电子的现象。这一现象最早由海因里希·赫兹在1887年发现。

    = 经典物理学的困难

    按照经典电磁理论，光的能量应该与光强成正比，因此：
    - 光电子的动能应该随光强增加而增加
    - 任何频率的光，只要强度足够，都应该能产生光电效应

    然而实验结果却表明：
    - 光电子的最大动能只与光的频率有关，与光强无关
    - 存在截止频率，低于此频率的光无论多强都不能产生光电效应

    = 爱因斯坦的解释

    1905年，爱因斯坦提出光量子假说，成功解释了光电效应：

    $ E = h f = frac{1}{2} m v^2 + W $

    其中：
    - $E = h f$ 是光子能量
    - $frac{1}{2} m v^2$ 是光电子动能
    - $W$ 是金属的逸出功
  ],
  columns: 1,
)

// 线性布局的四图片页面
#four-image-page(
  title: "数据处理流程",
  images: (
    "step1.png",
    "step2.png",
    "step3.png",
    "step4.png",
  ),
  captions: (
    "步骤1：数据采集",
    "步骤2：数据清洗",
    "步骤3：拟合分析",
    "步骤4：结果验证",
  ),
  layout: "linear", // 使用线性布局而不是网格布局
  image-height: 20%, // 调整图片高度
  gap: 0.5em, // 减小间距
  content: [
    上述四个步骤展示了完整的数据处理流程。每个步骤都很关键，确保最终结果的准确性和可靠性。
  ],
)
