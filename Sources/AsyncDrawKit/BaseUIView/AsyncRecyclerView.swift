/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

open class AsyncRecyclerView: UIScrollView {
    
    internal typealias UIViews = Array<UIView>

    private var reuseCells: Dictionary<String, UIView> = Dictionary<String, UIView>()
    
    private var cellHs: Array<CGFloat> = Array<CGFloat>()
    
    private var recyclerCells: UIViews = UIViews()
    private var visibleCells: UIViews = UIViews()
    
    public weak var dataSource: AsyncRecyclerViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func register(_ cellClass: UIView, forCellReuseIdentifier identifier: String) {
        reuseCells[identifier] = cellClass
    }
    
    open func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UIView {
        if var reusableCells = reuseCells[identifier], !reusableCells.isEmpty {
            let cell = reusableCells.removeLast()
            if let cell = cell as? AsyncRecyclerViewCellDelegate {
                cell.prepareForReuse()
            }
            return cell
        } else {
            let cellClass = NSClassFromString(identifier) as! UIView.Type
            if let cell = cellClass as? AsyncRecyclerViewCellDelegate {
                cell.prepareForReuse()
            }
            return cellClass.init()
        }
    }
    
    open func reloadData() {
        // 先移除所有子视图
        subviews.forEach { $0.removeFromSuperview() }
        
        guard let adapter = self.adapter else { return }
        
        // 从代理获取行数
        let numberOfRows = adapter.numberOfRows(in: self)
        
        // 创建和展示所有的单元格
        for row in 0..<numberOfRows {
            let indexPath = IndexPath(row: row, section: 0)
            let cell = adapter.recyclerView(self, cellForRowAt: indexPath)
            
            // 设置单元格的frame等其他设置
            // ...
            
            addSubview(cell)
        }
    }
    
    // 准备复用单元格：当单元格移出视图时调用
    open func prepareForReuse(cell: UIView) {
        if let reuseIdentifier = cell.reuseIdentifier {
            var cellsForReuse = reuseCells[reuseIdentifier, default: []]
            cellsForReuse.append(cell)
            reuseCells[reuseIdentifier] = cellsForReuse
        }
    }

}
