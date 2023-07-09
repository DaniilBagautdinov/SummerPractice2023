import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private var nameLabel: UILabel = UILabel()
    private var startDateLabel: UILabel = UILabel()
    private var finishDateLabel: UILabel = UILabel()
    private var desciptionLabel: UILabel = UILabel()
    private var stackView: UIStackView = UIStackView()
    
    var event: EventModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        addViews()
        configureStackView()
        configureLabels()
        configureLayouts()
    }
    
    private func addViews() {
        view.addSubview(stackView)
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(startDateLabel)
        stackView.addArrangedSubview(finishDateLabel)
        stackView.addArrangedSubview(desciptionLabel)
    }
    
    private func configureLabels() {
        nameLabel.numberOfLines = 0
        startDateLabel.numberOfLines = 0
        finishDateLabel.numberOfLines = 0
        desciptionLabel.numberOfLines = 0
        
        nameLabel.text = "Name: \(event?.text ?? "")"
        startDateLabel.text = "Start date: \(event?.dateInterval.start.description ?? "")"
        finishDateLabel.text = "Finish date: \(event?.dateInterval.end.description ?? "")"
        desciptionLabel.text = "Description: \(event?.description ?? "")"
    }
    
    private func configureLayouts() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.trailing.leading.equalToSuperview().inset(32)
        }
    }
}
