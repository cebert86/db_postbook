import UIKit

class CommentTableViewCell: UITableViewCell {
    private let usernameLabel = UILabel()
    private let bodyLabel = UILabel()
    private var comment: Comment?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUsernameLabel()
        configureBodyLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Do not use in StoryBoard!")
    }

    func setComment(_ comment: Comment) {
        self.comment = comment

        usernameLabel.text = comment.email
        bodyLabel.text = comment.body
    }

    private func configureUsernameLabel() {
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        usernameLabel.numberOfLines = 0

        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    private func configureBodyLabel() {
        bodyLabel.font = UIFont.systemFont(ofSize: 14)
        bodyLabel.numberOfLines = 0

        addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
