//
//  AnalyzeChartViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 18..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit
import Charts

class AnalyzeChartViewController: UIViewController {
    
    var labels = [String : Int]()
    var imageNum: Int?

    var barChartDataEntries = [PieChartDataEntry]()
    
    @IBOutlet weak var pictureLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChart()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateChart() {
        pieChart.chartDescription?.text = "태그 분석 차트"
        pictureLabel.text? = "사진 \(String(describing: imageNum!))"
        tagLabel.text? = "태그 \(labels.count)"
        
        let labelSorted = labels.sorted(by: { $0.value > $1.value })
        
        // DataEntry를 DataEntry 배열에 넣고 이 배열을 ChartDataSet에 넣는다.
        // 그리고 차트에 연결시켜준다.
        for i in 0 ..< 10 {
            
            let tagName = labelSorted[i].key
            let tagValue = Double(labelSorted[i].value)
            
            let dataEntry = PieChartDataEntry(value: tagValue)
            dataEntry.label = tagName
            
            barChartDataEntries.append(dataEntry)
            
        }
        
        
        let chartDataSet = PieChartDataSet(values: barChartDataEntries, label: nil)
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.data = chartData
        
        pieChart.animate(xAxisDuration: 2.0)
    }
    


}
