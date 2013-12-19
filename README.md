Associated Objects
==============

Companion materials for Chris's talk on Objective-C Associative Reference APIs and Associated Objects.

The sample code is included with this repository and is described below. First, here are the links relevant to the talk:

* [Slides](http://cl.ly/3g380Y0O1u3q)
* [Objective-C Runtime Documentation](https://developer.apple.com/library/mac/documentation/cocoa/Reference/ObjCRuntimeRef/Reference/reference.html)
* [Brent Simmons Giving Excellent Advice](http://inessential.com/2013/10/20/why_is_using_associated_objects_a_hack_)

Xcode Project
=============

Due to the nature of the "lightning" talk, I wasn't able to do any code demos. That's fitting for this sample project because it is really quite simple this time.

There is a single table view controller that, as you might imagine, simply coordinates an ultra-basic UITableView. To demonstrate Associated Objects, we are attaching two different strings to each UITableViewCell. Namely, we are associating a string each time the cell is being dequeued for configuration/drawing, and another to keep track of what the **last** NSIndexPath row was for that cell.

The intention here is to keep track of where each individual cell instance has been and where it is being reused.

Scroll freely through the table, then select an index to get an idea for how far that cell has moved (logically), just from a slight scroll.

The project only demos **strong** associations and doesn't really ever remove the associations explicitly, but it should be enough of a starting point to get some sort of idea.

Pull requests are always welcome if you see anything that needs to be addressed! 