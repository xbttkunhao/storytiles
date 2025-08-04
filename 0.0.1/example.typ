// PPT模板使用示例 - 路径处理说明
// ⚠️ 重要：图片路径相对于模板目录解析，不是主文件目录！
// 推荐使用绝对路径避免路径问题
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
  subtitle: "光电效应报告",
  author: "张三",
  institution: "北京大学物理学院",
  is-first-page: true, // 指定这是第一页，不需要分页
  // logo: "C:/path/to/your/logo.png" // 使用绝对路径（推荐）
)

// 目录页
#outline-page()

// 四图片页面示例 - 正确的路径使用方法
// ⚠️ 路径说明：图片路径相对于模板目录，不是主文件目录
// 解决方案：使用绝对路径
#four-image-page(
  title: "实验装置与结果",
  images: (
    // 正确做法：在主文件中直接加载图片，然后传递给模板
    image("images/setup.png"), // 相对路径从主文件目录解析
    image("images/result.png"), // 相对路径从主文件目录解析
    none, // 占位符示例
    image("data/fitting.png"), // 相对路径从主文件目录解析
  ),
  captions: (
    "实验装置图",
    "光电流与电压关系",
    "截止电压与频率关系",
    "数据拟合结果",
  ),
  content: [
    *路径解析完美解决*：

    1. *新架构*：在主文件中直接调用 `image()` 函数加载图片
    2. *优势*：路径从主文件目录正确解析，无需任何特殊处理
    3. *语法*：`image("images/pic.png")` 直接传递给模板

    *示例*：
    ```typst
    // 在主文件中加载图片
    #let img1 = image("images/pic1.png")   // 从主文件目录解析
    #let img2 = image("data/chart.png")    // 从主文件目录解析

    #four-image-page(
      title: "我的图片",
      images: (img1, img2, none, none),    // 传递已加载的图片内容
    )
    ```

    *核心原理*：模板函数只处理已加载的图片内容，不再处理路径字符串
  ],
)

// 页眉页脚控制示例
#four-image-page(
  title: "无页眉页脚模式",
  show-header: false, // 隐藏页眉
  show-footer: false, // 隐藏页脚
  images: (
    image("images/large1.png"),
    image("images/large2.png"),
    none,
    image("images/large4.png"),
  ),
  captions: ("大图1", "大图2", "", "大图4"),
  content: [
    *页眉页脚控制功能*：

    - `show-header: false` 隐藏页眉
    - `show-footer: false` 隐藏页脚
    - 图片自动放大填充更多空间
    - 适合图片展示页面
  ],
)

// 全屏图片模式
#four-image-page(
  show-header: false,
  show-footer: false,
  images: (
    image("images/fullscreen1.png"),
    image("images/fullscreen2.png"),
    image("images/fullscreen3.png"),
    image("images/fullscreen4.png"),
  ),
  captions: ("", "", "", ""), // 无说明文字
  title: none, // 无标题
  content: none, // 无额外内容
)

// 自定义布局页面示例 - 演示路径处理
#custom-layout-page(
  title: "自定义图片布局",
  content: [
    #v(50%)
    这个页面演示了新的图片处理架构：
    - 在主文件中加载图片，路径从主文件目录解析
    - 模板函数只处理已加载的图片内容
    - 完全解决了路径解析问题
    - 友好的错误处理，不会中断编译
  ],
  images: (
    (
      content: none, // 显示占位符
      x: 10%,
      y: 15%,
      width: 35%,
      height: 25%,
      caption: "占位符示例",
    ),
    (
      content: none, // image("images/pic.png") - 在主文件中加载
      x: 55%,
      y: 15%,
      width: 35%,
      height: 25%,
      caption: "图片示例",
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

// 线性布局的四图片页面 - 演示混合路径类型
#four-image-page(
  title: "数据处理流程",
  images: (
    none, // "C:/Users/YourName/Pictures/step1.png" - 绝对路径示例（推荐）
    none, // 占位符
    // "C:/Users/YourName/Documents/data/step3.png", // 绝对路径示例（推荐）
    none, // 临时用占位符
    // "/absolute/path/step4.png", // 绝对路径示例
    none, // 临时用占位符
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
    这个示例展示了不同类型的图片路径处理：

    1. *相对路径*：`"step1.png"` - 注意：相对于模板目录，不是主文件目录
    2. *占位符*：`none` - 显示友好的占位符
    3. *绝对路径*：推荐使用，请取消注释并修改为实际路径
    4. *路径说明*：详细说明请查看"路径使用说明.md"文件

    *重要*：推荐使用绝对路径避免路径解析问题！
  ],
)
