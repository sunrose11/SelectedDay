# SelectedDay
![你的小可爱已上线](http://upload-images.jianshu.io/upload_images/7882691-886183f3a8e30c93.GIF?imageMogr2/auto-orient/strip)
>根据用户需求我们需要做个显示日期和星期的预约栏目 需要向用户展现5天内的日期。话不多说上代码
```
// nowDay 是传入的需要计算的日期
    func getLastDay(_ nowDay: String) -> Array<String> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // 先把传入的时间转为 date
        let date = dateFormatter.date(from: nowDay)
        var weekArray = [String]()
        for i in 0..<5{//可以根据需要获取到第几天内的自己手动
            let nextTime: TimeInterval = TimeInterval(24*60*60*i) // 这是后一天的时间，明天
            let lastDate = date?.addingTimeInterval(nextTime)
            let lastDay = dateFormatter.string(from: lastDate!)
            let weekStr = self.getWeekDay(dateTime: lastDay)
            let appendStr = lastDay.suffix(from: lastDay.index(lastDay.startIndex, offsetBy:5))
           let moonDay = self.dateToString(format: "yyyy-MM-dd")?.description//获取今天的时间
            if lastDay == moonDay{
                weekArray.append(appendStr+"\n今天")
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
```
获取到的数据样式是这样的，那我再说一句 如果你的需求是排除周末 可以再做更多的判断，如果还要排除节假日那么就加油吧！可能过几天我会做一版本 看我懒不懒吧
![样式.png](https://upload-images.jianshu.io/upload_images/7882691-0c9a1faa05bd8bdc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>***需要的人可以直接copy走吧！记得帮我点点❤ 爱你哟!***
外加git地址:https://github.com/sunrose11/SelectedDay

![](http://upload-images.jianshu.io/upload_images/7882691-ca45d1830b9b562a.gif?imageMogr2/auto-orient/strip)
