import UIKit

class PostTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let favButton = UIButton()
    private var post: Post?

    var canAddFavouritePost: CanAddFavouritePost?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureFavButton()
        configureTitleLabel()
        configureBodyLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Do not use in StoryBoard!")
    }

    func setPost(_ post: Post) {
        self.post = post

        titleLabel.text = post.title
        bodyLabel.text = post.body
    }

    private func configureTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalTo(favButton.snp.leading).offset(-20)
        }
    }

    private func configureBodyLabel() {
        bodyLabel.font = UIFont.systemFont(ofSize: 14)
        bodyLabel.numberOfLines = 0

        addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(favButton.snp.leading).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    private func configureFavButton() {
        favButton.setTitle("FAV", for: .normal)
        favButton.setTitleColor(.blue, for: .normal)
        favButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)

        addSubview(favButton)
        favButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
        }
    }

    @objc
    private func favouriteButtonTapped() {
        guard let post = self.post else {
            return
        }
        
        canAddFavouritePost?.addFavouritePost(post)
    }
}
