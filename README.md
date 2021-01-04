# LYBTools

Mac端命令行工具

## 功能预览

![preview](https://raw.githubusercontent.com/liyb93/LYBTools/main/preview.png)

## 功能

- xml/json转plist
- xml/plist转json
- json/plist转xml
- 图片切圆角
- App图标生成

## 使用

- xml/json转plist

  ```shell
  $lybtools -plist 文件路径 输出路径(可选)
  ```

- xml/plist转json

  ```shell
  $lybtools -json 文件路径 输出路径(可选)
  ```

- json/plist转xml

  ```shell
  $lybtools -xml 文件路径 输出路径(可选)
  ```

- 图片切圆角

  ```shell
  $lybtools -imgcut 文件路径 输出路径(可选) 圆角半径
  ```

- App图标生成

  ```shell
  /*
  	图标类型(默认为0,可不传,以英文逗号","分隔)
  	0:  iphone
  	1:  ipad
  	2:  mac
  	3:  carplay
  	4:  watch
  	5:  android
  */
  $lybtools -icon 文件路径 输出路径 图标类型
  ```

