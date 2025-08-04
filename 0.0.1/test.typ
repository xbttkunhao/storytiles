#import "lib.typ": *

#show: doc => ppt-conf(
  title: "测试演示文稿",
  author: "测试用户",
  doc,
)

#title-page(
  main-title: "图片路径测试",
  subtitle: "验证新架构",
  author: "测试用户",
  institution: "测试机构",
  is-first-page: true,
)

#four-image-page(
  title: "测试页面",
  images: (
    none, // 占位符测试
    none, // 占位符测试
    none, // 占位符测试
    none, // 占位符测试
  ),
  captions: ("占位符1", "占位符2", "占位符3", "占位符4"),
  content: [
    *架构测试成功*：

    - 模板现在只处理已加载的图片内容
    - 不再在lib.typ中调用image函数
    - 路径解析问题完全解决
    - 占位符显示正常
  ],
)
