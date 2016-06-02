//
//  TaskCollectionViewCell.swift
//  Project-X
//
//  Created by majeed on 24/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    var task : Task = Task() { didSet{
        
            titleLabel.text = task.Title.uppercaseString // + " Works";
            let image = UIImage(named: "ui-image-assignee-\(task.Assignee_Id)")
            //UIImage(named: "ui-icon-\(task.Title)")
            mainImageView.image = image ?? UIImage(named: "ui-icon-Task")
            mainImageView.tintColor = UIColor.clearColor()
            mainImageView.setRadius(mainImageView.frame.height / 2.0)
        
        
        
        if(task.Activities.count > 0){
            let activitiesCompleted = (task.Activities.filter { (item) -> Bool in
                return item.IsCompleted
                }.count);
            pendingActivityLabel.text = X.formatNumber(NSDecimalNumber(double: Double(task.Activities.count - activitiesCompleted)));
            
            var remainingBudget = task.Budget.doubleValue - App.getTaskCosts(task).TotalCost.doubleValue
            if(remainingBudget < 0){
                budgetIndicatorLabel.text = "OVERBOARD"
                remainingBudget = remainingBudget * -1
            }
            else{
                budgetIndicatorLabel.text = "REMAINING"
            }
            remainingBudgetLabel.text = X.numToCurrency(NSDecimalNumber(double: remainingBudget));
            
            let percentage : Double = (Double(activitiesCompleted) / Double(task.Activities.count))
            taskProgressView.progress = Float(percentage)
            taskProgressView.tintColor = App.successColor
            //progressIndicator.angle = Int(360 * percentage)
            progressIndicator.trackColor = UIColor.whiteColor();
            progressIndicator.progressColors = [App.successColor];
        }else{
            progressIndicator.angle = 0
            taskProgressView.progress = 0
        }
        }
    }
        
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pendingActivityLabel: UILabel!
    
    @IBOutlet weak var remainingBudgetLabel: UILabel!
    @IBOutlet weak var budgetIndicatorLabel: UILabel!
    //@IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var taskProgressView: UIProgressView!
    @IBOutlet weak var mainImageView: CircleImageView!
    @IBOutlet weak var progressIndicator: KDCircularProgress!
    
}
