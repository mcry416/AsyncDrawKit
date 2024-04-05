![](https://img.shields.io/badge/Swift-5.0+-red)
![](https://img.shields.io/badge/Platform-iOS11+-green)
![](https://img.shields.io/badge/Swift_Package_Manager-Compatible-blue)
![](https://img.shields.io/badge/Super%20Fast-FC180A)
![](https://img.shields.io/badge/Low%20Memory-8A2BE2)
![](https://img.shields.io/badge/Author:%20mcry416@outlook.com-FF7E30)

![](https://s21.ax1x.com/2024/04/05/pFb5jsK.png)

 # AsyncDrawKit

Provide an async draw view component for iOS, to be your application run so fast.

# Usage

- Swift Package Manage: 

Xcode-> File-> Add Packages-> Input url-> `https://github.com/mcry416/AsyncDrawKit`, and waiting for fetch the base.

- Load the source code manually:

Drag the root folder into yout project directly.

- Use it as UIKit easily:
```
import AsyncDrawKit

let imageView = AsyncImageView()

// set local image
imageView.image = UIImage(named: "background_image")

// set network image
imageView.sg_setImage("https://www.test.com/test.jpg")

// use the way of downsample to set local image
imageView.imageNamed = "background_image"

// set an image where located in Bundle.
imageView.imageFiled = "bundle_image"
```

# Which features it has?

- `AsyncImageView`: Provide a view that look likes `UIImageView` to load image. 

The following table is a comparison between the two.

|  | `AsyncImageView` | `UIImageView` |
|-|-|-|
| set local image | support | support |
| set network image | support | n/a |
| decode speed | fast | medium |
| stable memory consume | low | high |
| peak memory consume | high | medium |
| image cache | support | support |
| resolving power | auto-fit / full resolution | full resolution |

- `NodeRootView`: Provide an async draw container to load various basic visual components.

The following table was feature decribtion.

|   | Layout  | Event  | Function  |
|:----------|:----------|:----------|:----------|
| NodeView    | only frame    | support   | provide a view container  |
| NodeLabel    | only frame    | support    | provide a view to show text    |
| NodeButton    | only frame    | support    | provide a contianer to action event    |
| NodeImageView    | only frame    | support    | provide a view to show image    |

- Memory cache and mange.

You can set the cache strategy manually, or clear the cache in memory.

- Others: Some functions waiting for yout to discovery.

# Requirements

- iOS 11+
- Swift 5.0+

# Test

- The size of `300 * 300` for JPEG photo in UITableView, `AsyncImageView` is better perfomance than `UIImageView` in memory consume. 

# Attention

- It may not perform as well as `UIImageView` at lower image resolutions.
- Do not support Objective-C environment , but you can edit the concrete class to add `ObjcMembers` to use it, it do not have any matter.
- The reusable strategy for `AsyncImageView` has some problems in Cell when set a network image

# Contact

- Any question or suggestions mail to me at: mcry416@outlook.com 

# License

AsyncDrawKit is released under the MIT license.
