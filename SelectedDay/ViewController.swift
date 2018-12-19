//
//  ViewController.swift
//  SelectedDay
//
//  Created by sunrose on 2018/12/19.
//  Copyright © 2018 叶熙文. All rights reserved.
//
//MAEK: - 很重要的事
//************************************************************
//备注区：日历部分不是本人demo里面的自己写的是别人的！没有改名，只是对里面有些方法进行了调整
//如有需要自行去git查找，我只是一个搬砖的 把他们很好的磨合到一起，然后改成我需要的
//************************************************************

import UIKit

class ViewController: UIViewController {

    var nameArr = [String]()
    var btnArr = [UIButton]()
    var screenSize : CGSize {
        get {
            return UIScreen.main.bounds.size
        }
    }
    var W : CGFloat {
        
        return  UIScreen.main.bounds.width / 375
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moonDay = self.dateToString(format: "yyyy-MM-dd")?.description
        nameArr = self.getLastDay(moonDay ?? "")
        for (i,name) in nameArr.enumerated() {
            let btn = UIButton.init(frame: CGRect(x: (screenSize.width-35*W)/CGFloat(nameArr.count)*CGFloat(i), y: 100, width: screenSize.width/CGFloat(nameArr.count), height: 40))
            btn.setTitle(name , for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.numberOfLines = 0
            btn.titleLabel?.textAlignment = NSTextAlignment.center
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13*W)
            view.addSubview(btn)
            btnArr.append(btn)
        }
        
        let riliBtn = UIButton.init(frame: CGRect(x: screenSize.width-35*W, y:100+(40-18)/2, width: 18, height: 18))
        riliBtn.setImage(UIImage.init(named: "日历(2)"), for: .normal)
        view.addSubview(riliBtn)
        riliBtn.addTarget(self, action: #selector(riliBtnAction), for: .touchUpInside)
        
    }
    
    @objc func riliBtnAction(){
        
        let calendar = PGActionSheetCalendar()
        calendar.didSelectDateComponents = {components in
            print("year = ", components.year!,"month = ", components.month!,  "day = ", components.day!)

            let year = components.year!.description
            let month = components.month!.description
            let day = components.day!.description
            self.nameArr = self.getLastDay(year+"-"+month+"-"+day)
            for (i,btn) in self.btnArr.enumerated(){
                btn.setTitle(self.nameArr[i] , for: .normal)
            }
        }
        present(calendar, animated: true, completion: nil)
        let label = calendar.titleLabel
        label.text = "demo"
    }
    
    // nowDay 是传入的需要计算的日期
    func getLastDay(_ nowDay: String) -> Array<String> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // 先把传入的时间转为 date
        let date = dateFormatter.date(from: nowDay)
        var weekArray = [String]()
        for i in 0..<5{
            let nextTime: TimeInterval = TimeInterval(24*60*60*i) // 这是后一天的时间，明天
            let lastDate = date?.addingTimeInterval(nextTime)
            let lastDay = dateFormatter.string(from: lastDate!)
            let weekStr = self.getWeekDay(dateTime: lastDay)
            let appendStr = lastDay.suffix(from: lastDay.index(lastDay.startIndex, offsetBy:5))
            let moonDay = self.dateToString(format: "yyyy-MM-dd")?.description
            if lastDay == moonDay{
                weekArray.append(appendStr+"\n今天")
            }else{
                weekArray.append(appendStr+"\n"+weekStr)
            }
        }
        return weekArray
    }
    
    func getWeekDay(dateTime:String)->String{
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let date = dateFmt.date(from: dateTime)
        let interval = Int(date!.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 5)%7+7)%7
        let weekDays = ["周日","周一","周二","周三","周四","周五","周六"]
        return weekDays[weekday]
    }
    //获取当时时间
    func dateToString(format:String!)->String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return  dateFormatter.string(from: Date())
    }
}
