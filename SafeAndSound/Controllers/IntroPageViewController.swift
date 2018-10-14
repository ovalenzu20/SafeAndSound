//
//  IntroPageViewController.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/14/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit

class IntroPageViewController: UIPageViewController {

    var introPageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate   = self
        
        if let firstViewController = introPages.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        self.configurePageControl()
        // Do any additional setup after loading the view.
    }
    
    func configurePageControl() {
        introPageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 30,width: UIScreen.main.bounds.width, height: 30))
        self.introPageControl.numberOfPages = introPages.count
        self.introPageControl.currentPage = 0
        self.introPageControl.tintColor = UIColor.white
        self.introPageControl.pageIndicatorTintColor = UIColor.white
        self.introPageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(introPageControl)
    }

    fileprivate lazy var introPages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "page1"),
            self.getViewController(withIdentifier: "page2"),
            self.getViewController(withIdentifier: "page3"),
            self.getViewController(withIdentifier: "page4")
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

}

extension IntroPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = introPages.index(of: viewController)!
        let previousIndex = currentIndex - 1
        return (previousIndex == -1) ? nil : introPages[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = introPages.index(of: viewController)!
        let nextIndex = currentIndex + 1
        return (nextIndex == introPages.count) ? nil : introPages[nextIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.introPageControl.currentPage = introPages.index(of: pageContentViewController)!
    }
}
