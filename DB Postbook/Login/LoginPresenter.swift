protocol LoginPresenter {
    var view: LoginViewController? { set get }
    
    func loginButtonTapped(userId: Int)
}
