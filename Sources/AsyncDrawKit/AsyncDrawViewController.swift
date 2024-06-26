/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

internal let kSCREEN_WIDTH:  CGFloat = UIScreen.main.bounds.width
internal let kSCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height

public class AsyncDrawViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 20, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 20)
        tableView.register(AsyncCell.self, forCellReuseIdentifier: "ASYNC")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ASYNC", for: indexPath) as! AsyncCell
//        cell.asyncImageView.image = UIImage(named: "font")
//        cell.asyncImageView2.image = UIImage(named: "taylor")
//        cell.asyncImageView3.image = UIImage(named: "root")
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 20 {
            dismiss(animated: true)
        }
    }

}

fileprivate class AsyncCell: UITableViewCell {
    
    lazy var myImageView: UIImageView = { UIImageView() }()
    lazy var myImageView2: UIImageView = { UIImageView() }()
    lazy var myImageView3: UIImageView = { UIImageView() }()
    
    lazy var asyncImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.image = UIImage(named: "font")
        return imageView
    }()
    lazy var asyncImageView2: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.image = UIImage(named: "taylor")
        return imageView
    }()
    lazy var asyncImageView3: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.image = UIImage(named: "root")
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        self.contentView.addSubview(myImageView)
//        self.contentView.addSubview(myImageView2)
//        self.contentView.addSubview(myImageView3)
//        myImageView.frame = CGRect(x: 20, y: 5, width: 90, height: 90)
//        myImageView2.frame = CGRect(x: myImageView.frame.maxX + 20, y: 5, width: 90, height: 90)
//        myImageView3.frame = CGRect(x: myImageView2.frame.maxX + 20, y: 5, width: 180, height: 90)
        
        self.contentView.addSubview(asyncImageView)
        self.contentView.addSubview(asyncImageView2)
        self.contentView.addSubview(asyncImageView3)
        asyncImageView.frame = CGRect(x: 20, y: 5, width: 90, height: 90)
        asyncImageView2.frame = CGRect(x: asyncImageView.frame.maxX + 20, y: 5, width: 90, height: 90)
        asyncImageView3.frame = CGRect(x: asyncImageView2.frame.maxX + 20, y: 5, width: 180, height: 90)
    }
    
}

class NodeCell: UITableViewCell {
    
    lazy var nodeView: NodeRootView = {
        let view = NodeRootView()
        view.frame = CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 100)
        return view
    }()
    
    lazy var nodeLabel: NodeLabel = {
        let label = NodeLabel()
        label.text = "Node Label"
        label.frame = CGRect(x: 118, y: 10, width: 100, height: 20)
        return label
    }()
    
    lazy var nodeTitle: NodeLabel = {
        let label = NodeLabel()
        label.text = "Taylor Swift - <1989> land to Music."
        label.frame = CGRect(x: 118, y: 100 - 10 - 20, width: 200, height: 20)
        return label
    }()
    
    lazy var nodeImageView: NodeImageView = {
        let imageView = NodeImageView()
        imageView.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        imageView.contents = UIImage(named: "taylor")
        imageView.setOnClickListener {

        }
        return imageView
    }()
    
    lazy var nodeButton: NodeButton = {
        let button = NodeButton()
        button.text = "Buy"
        button.backgroundColor = .orange
        button.textColor = .white
        button.frame = CGRect(x: kSCREEN_WIDTH - 60, y: 65, width: 40, height: 19)
        button.setOnClickListener {

        }
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.contentView.addSubview(nodeView)
        self.nodeView.addSubNode(nodeLabel)
        self.nodeView.addSubNode(nodeImageView)
        self.nodeView.addSubNode(nodeTitle)
        self.nodeView.addSubNode(nodeButton)
    }
    
}
