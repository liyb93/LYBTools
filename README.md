# LYBTools
Mac端命令行工具

## 功能预览

![preview](https://raw.githubusercontent.com/liyb93/LYBTools/master/preview.png)

## 功能

- xml/json转plist
- xml/plist转json
- json/plist转xml
- 图片切圆角
- App图标生成

## 使用

- xml/json转plist

  ```shell
  $lybtools -plist 文件路径 输出路径
  ```

- xml/plist转json

  ```shell
  $lybtools -json 文件路径 输出路径
  ```

- json/plist转xml

  ```shell
  $lybtools -xml 文件路径 输出路径
  ```

- 图片切圆角

  ```shell
  $lybtools -imgcut 文件路径 输出路径 圆角半径
  ```

- App图标生成

  ```shell
  /*
  	app类型(默认为0,可不传)
  	0:  只生成iphone
  	1:  只生成ipad
  	2:  只生成mac
  	3:  生成iphone与ipad
  	4:  生成iphone与mac
  	5:  生成ipad与mac
  	6:  生成iphone、ipad与mac
  */
  $lybtools -icon 文件路径 输出路径 app类型
  ```

