/// PPT模板 - 支持四图片布局和文字添加
///
/// 主要功能：
/// - 支持每页添加四个图片，四等分页面布局
/// - 图片中心对齐，横纵等比例缩放，纵向填满
/// - 支持在页面上添加文字
/// - 提供丰富的参数控制图片位置、缩放等

/// 配置PPT文档
/// ### 参数
/// - `title`: 演示文稿标题
/// - `author`: 作者
/// - `date`: 日期
/// - `theme`: 主题色 (默认: rgb("#1f4e79"))
/// - `font-size`: 基础字体大小 (默认: 12pt)
/// ### 用法
/// ```typst
/// #show: doc => ppt-conf(
///   title: "我的演示文稿",
///   author: "张三",
///   doc
/// )
/// ```
#let ppt-conf(
  title: "演示文稿",
  author: "作者",
  date: none,
  theme: rgb("#1f4e79"),
  font-size: 12pt,
  doc,
) = {
  // 设置页面为16:9横向
  set page(
    paper: "presentation-16-9",
    margin: (x: 1.5cm, y: 1cm),
    numbering: "1",
    header: [
      #set text(size: 10pt, fill: theme)
      #h(1fr) #title #h(1fr)
      #line(length: 100%, stroke: 0.5pt + theme)
    ],
    footer: [
      #set text(size: 8pt, fill: gray)
      #line(length: 100%, stroke: 0.5pt + gray)
      #v(0.2em)
      #author #h(1fr) #if date != none { date } else { datetime.today().display() } #h(1fr) #counter(page).display()
    ],
  )

  set text(
    font: ("Times New Roman", "SimSun"),
    size: font-size,
  )

  set par(justify: true)

  set heading(numbering: "1.")
  show heading: it => [
    #set text(size: if it.level == 1 { 18pt } else { 16pt }, fill: theme, weight: "bold")
    #v(0.5em)
    #it
    #v(0.3em)
  ]

  doc
}

/// 创建四图片布局页面
/// ### 参数
/// - `images`: 图片数组，最多4个 (路径字符串或none)
/// - `captions`: 图片说明数组，对应每个图片
/// - `title`: 页面标题 (可选)
/// - `content`: 页面额外文字内容 (可选)
/// - `image-height`: 图片高度比例 (默认: 35%)
/// - `image-width`: 图片宽度比例 (默认: 40%)
/// - `gap`: 图片间距 (默认: 1em)
/// - `caption-size`: 说明文字大小 (默认: 10pt)
/// - `layout`: 布局方式 ("grid"为2x2网格, "linear"为线性排列) (默认: "grid")
/// ### 用法
/// ```typst
/// #four-image-page(
///   title: "实验结果",
///   images: ("img1.png", "img2.png", "img3.png", "img4.png"),
///   captions: ("图1", "图2", "图3", "图4"),
///   content: [这里是页面的文字说明内容...]
/// )
/// ```
#let four-image-page(
  images: (),
  captions: (),
  title: none,
  content: none,
  image-height: 35%,
  image-width: 40%,
  gap: 1em,
  caption-size: 10pt,
  layout: "grid",
) = {
  pagebreak()

  // 页面标题
  if title != none [
    #align(center)[
      #heading(level: 1)[#title]
    ]
    #v(0.5em)
  ]

  // 主要内容区域
  if layout == "grid" {
    // 2x2网格布局
    grid(
      columns: 2,
      column-gutter: gap,
      row-gutter: gap,
      ..range(4).map(i => {
        if i < images.len() and images.at(i) != none {
          align(center)[
            #image(images.at(i), height: image-height, width: image-width, fit: "contain")
            #if i < captions.len() and captions.at(i) != none [
              #v(0.2em)
              #text(size: caption-size)[#captions.at(i)]
            ]
          ]
        } else {
          // 空白区域
          v(image-height)
        }
      })
    )
  } else if layout == "linear" {
    // 线性排列
    for i in range(calc.min(4, images.len())) {
      if images.at(i) != none {
        align(center)[
          #image(images.at(i), height: image-height, width: image-width, fit: "contain")
          #if i < captions.len() and captions.at(i) != none [
            #v(0.2em)
            #text(size: caption-size)[#captions.at(i)]
          ]
        ]
        v(gap)
      }
    }
  }

  // 页面文字内容
  if content != none [
    #v(1em)
    #content
  ]
}

/// 自定义图片位置页面
/// ### 参数
/// - `title`: 页面标题
/// - `content`: 文字内容
/// - `images`: 图片配置数组，每个元素包含:
///   - `path`: 图片路径
///   - `x`: x坐标 (百分比或绝对值)
///   - `y`: y坐标 (百分比或绝对值)
///   - `width`: 宽度 (默认: 30%)
///   - `height`: 高度 (默认: 30%)
///   - `caption`: 说明文字
/// ### 用法
/// ```typst
/// #custom-layout-page(
///   title: "自定义布局",
///   content: [文字内容...],
///   images: (
///     (path: "img1.png", x: 10%, y: 20%, width: 25%, caption: "图1"),
///     (path: "img2.png", x: 60%, y: 20%, width: 25%, caption: "图2"),
///   )
/// )
/// ```
#let custom-layout-page(
  title: none,
  content: none,
  images: (),
) = {
  pagebreak()

  // 页面标题
  if title != none [
    #align(center)[
      #heading(level: 1)[#title]
    ]
    #v(0.5em)
  ]

  // 使用place来自定义图片位置
  for img-config in images {
    place(
      dx: img-config.at("x", default: 0%),
      dy: img-config.at("y", default: 0%),
      align(center)[
        #image(
          img-config.path,
          width: img-config.at("width", default: 30%),
          height: img-config.at("height", default: 30%),
          fit: "contain",
        )
        #if "caption" in img-config [
          #v(0.2em)
          #text(size: 10pt)[#img-config.caption]
        ]
      ],
    )
  }

  // 文字内容
  if content != none [
    #content
  ]
}

/// 纯文字页面
/// ### 参数
/// - `title`: 页面标题
/// - `content`: 主要内容
/// - `columns`: 分栏数 (默认: 1)
/// ### 用法
/// ```typst
/// #text-page(
///   title: "介绍",
///   content: [页面文字内容...],
///   columns: 2
/// )
/// ```
#let text-page(
  title: none,
  content: [],
  columns: 1,
) = {
  pagebreak()

  if title != none [
    #align(center)[
      #heading(level: 1)[#title]
    ]
    #v(0.5em)
  ]

  if columns > 1 [
    #columns(columns)[#content]
  ] else [
    #content
  ]
}

/// 标题页
/// ### 参数
/// - `main-title`: 主标题
/// - `subtitle`: 副标题
/// - `author`: 作者
/// - `institution`: 机构
/// - `date`: 日期
/// - `logo`: 机构logo路径 (可选)
/// ### 用法
/// ```typst
/// #title-page(
///   main-title: "我的演示文稿",
///   subtitle: "副标题",
///   author: "张三",
///   institution: "北京大学物理学院"
/// )
/// ```
#let title-page(
  main-title: "",
  subtitle: none,
  author: "",
  institution: "",
  date: none,
  logo: none,
) = {
  pagebreak()

  align(center + horizon)[
    #if logo != none [
      #image(logo, width: 15%)
      #v(1em)
    ]

    #text(size: 24pt, weight: "bold")[#main-title]

    #if subtitle != none [
      #v(0.5em)
      #text(size: 18pt)[#subtitle]
    ]

    #v(2em)
    #text(size: 16pt)[#author]

    #v(0.5em)
    #text(size: 14pt)[#institution]

    #v(1em)
    #text(size: 12pt)[#if date != none { date } else { datetime.today().display() }]
  ]
}

/// 目录页
/// ### 参数
/// - `outline-title`: 目录标题 (默认: "目录")
/// - `depth`: 目录深度 (默认: 2)
/// ### 用法
/// ```typst
/// #outline-page()
/// ```
#let outline-page(
  outline-title: "目录",
  depth: 2,
) = {
  pagebreak()

  align(center)[
    #heading(level: 1)[#outline-title]
  ]

  v(1em)

  outline(
    depth: depth,
    indent: true,
  )
}
