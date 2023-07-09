import UIKit
import SnapKit

class NewEventViewController: UIViewController {
    
    private var nameLabel: UILabel = UILabel()
    private var nameTextField: UITextField = UITextField()
    private var descriptionLabel: UILabel = UILabel()
    private var descriptionTextView: UITextView = UITextView()
    private var startDateLabel: UILabel = UILabel()
    private var startDatePicker: UIDatePicker = UIDatePicker()
    private var finishDateLabel: UILabel = UILabel()
    private var finishDatePicker: UIDatePicker = UIDatePicker()
    private var saveButton: UIButton = UIButton()
    
    private var stackView: UIStackView = UIStackView()
    
    weak var delegate: CalendarViewControllerDelegate?
    
    var dismissClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        addViews()
        configureStackView()
        configureLabels()
        configureTextFields()
        configureDatePickers()
        configureButton()
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
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(startDateLabel)
        stackView.addArrangedSubview(startDatePicker)
        stackView.addArrangedSubview(finishDateLabel)
        stackView.addArrangedSubview(finishDatePicker)
        stackView.addArrangedSubview(saveButton)
    }
    
    private func configureLabels() {
        nameLabel.text = "Name:"
        descriptionLabel.text = "Description:"
        startDateLabel.text = "Start date:"
        finishDateLabel.text = "Finish date:"
    }
    
    private func configureTextFields() {
        nameTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
    }
    
    private func configureDatePickers() {
        startDatePicker.minimumDate = Date(timeIntervalSinceNow: TimeInterval())
        finishDatePicker.minimumDate = Date(timeIntervalSinceNow: TimeInterval() + 60)
    }
    
    private func configureButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    private func configureLayouts() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
    }
    
    @objc private func saveButtonAction() {
        if finishDatePicker.date.timeIntervalSince1970 <= startDatePicker.date.timeIntervalSince1970 {
            let alertController = UIAlertController(title: "Oops.. it seems you made a mistake",
                                                    message: "Finish date can't be less than start date",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
                alertController.dismiss(animated: true)
            }))
            
            present(alertController, animated: true)
        } else {
            delegate?.addNewEvent(event: EventModel( dateInterval: DateInterval(start: startDatePicker.date, end: finishDatePicker.date), name: nameTextField.text ?? "", description: descriptionTextView.text))
            dismissClosure?()
        }
    }
}
