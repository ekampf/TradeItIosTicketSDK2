import UIKit

class TradeItSelectionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adContainer: UIView!

    var initialSelection: String?
    var selections = [String]()
    var onSelected: ((String) -> Void)?
    private var selectionTableViewManager: TradeItSelectionTableViewManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectionTableViewManager = TradeItSelectionTableViewManager(
            selectionTableView: self.tableView,
            selections: self.selections,
            initialSelection: self.initialSelection,
            onSelected: { selection in
                self.onSelected?(selection)
            }
        )

        if let adContainer = self.adContainer {
            TradeItSDK.adService.populate(adContainer: adContainer, rootViewController: self, pageType: .trading, position: .bottom)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.selectionTableViewManager?.update(
            selections: self.selections,
            initialSelection: self.initialSelection
        )
    }
}
