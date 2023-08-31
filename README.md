![](https://img.shields.io/badge/Swift-5.0+-red)
![](https://img.shields.io/badge/Platform-iOS11+-green)
![](https://img.shields.io/badge/Swift_Package_Manager-Compatible-blue)
![](https://img.shields.io/badge/Super%20Fast-FC180A)
![](https://img.shields.io/badge/Low%20Memory-8A2BE2)
![](https://img.shields.io/badge/Author:%20mcry416@outlook.com-FF7E30)
 # AsyncDrawKit

SGAsyncView view class that draw in sub-thread.

# How to use(SPM depency)?

- Depency load: Xcode-> File-> Add Packages-> Input url-> `https://github.com/mcry416/AsyncDrawKit`, and waiting for fetch base.
- Use it as UIKit easily:
```
import AsyncDrawKit

lazy var asyncImageView: AsyncImageView = {
    let imageView = AsyncImageView()
    imageView.image = UIImage(named: "background_image")
//  imageView.sg_setImage("https://www.test.com/test.jpg")
    return imageView
}()
```

# Which features it has?

- Async draw widget(`AsyncLabel`, `AysncImageView`).
- Async root draw context(`NodeLabel`,`NodeImageView`,`NodeButton`).
- Convenience `setImage` with an URL string for `AsyncImageView`.
- High performance than UIKit in process speed,  and extremly low memory consume in specific widget size.

# Requirements
- iOS 11+
- Swift 5.0+

# Test:

- The size of `300 * 300` for JPEG photo in UITableView, `AsyncImageView` is better perfomance than `UIImageView` in memory consume. 

# Attention:

- Do not use it into your project directly!!!
- It may not perform as well as UIImageView at lower image resolutions.
- This is a demo and no any verify in reality project.
- Some issues waitting for repair.

# Contact:

- Any question or suggestions mail to me at: mcry416@outlook.com

# License

AsyncDrawKit is released under the MIT license.
