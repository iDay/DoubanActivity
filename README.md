DoubanActivity
==============
![ios6](https://raw.github.com/iDay/DoubanActivity/master/6-1.png)
![ios6](https://raw.github.com/iDay/DoubanActivity/master/6-2.png)
![ios6](https://raw.github.com/iDay/DoubanActivity/master/6-3.png)
![ios6](https://raw.github.com/iDay/DoubanActivity/master/6-4.png)
![ios7](https://raw.github.com/iDay/DoubanActivity/master/7-1.png)
![ios7](https://raw.github.com/iDay/DoubanActivity/master/7-2.png)
![ios7](https://raw.github.com/iDay/DoubanActivity/master/7-3.png)
![ios7](https://raw.github.com/iDay/DoubanActivity/master/7-4.png)

## Requirements

* iOS 6.0+
* ARC
* [REComposeViewController](https://github.com/romaonthego/REComposeViewController)

## Installation

#### From [CocoaPods](http://www.cocoapods.org)

`pod 'DoubanActivity'`

#### From source

* Drag the `DoubanActivity/` folder to your project
* Download [REComposeViewController](https://github.com/romaonthego/REComposeViewController) and follow its install instructions
* Add the `MobileCoreServices.framework`,`SystemConfiguration.framework`,`Security.framework`,`CFNetwork.framework`,`libz.dylib`,`libxml2.framework`,`QuartzGraphics.framework` to your project

## Getting Started

### Send Text with Image

````objective-c
UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"Title here", [UIImage imageNamed:@"OAuth"]] applicationActivities:@[[[DoubanActivity alloc] initWithViewController:self apiKey:@"04e0b2ab7ca02a8a0ea2180275e07f9e" privateKey:@"4275ee2fa3689a2f"]]];
    activityView.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint];
[self presentViewController:activityView animated:YES completion:nil];
````

### Send link with Image

````objective-c
UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"Title here", [NSURL URLWithString:@"http://www.google.com"], [NSURL URLWithString:@"https://www.google.com/images/srpr/logo11w.png"]] applicationActivities:@[[[DoubanActivity alloc] initWithViewController:self apiKey:@"04e0b2ab7ca02a8a0ea2180275e07f9e" privateKey:@"4275ee2fa3689a2f"]]];
[self presentViewController:activityView animated:YES completion:nil];
````