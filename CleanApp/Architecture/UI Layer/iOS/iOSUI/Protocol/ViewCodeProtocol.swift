
protocol ViewCodeProtocol {
    func configureViewCode()
    func configureHierarchy()
    func configureConstraint()
    func configureStyle()
}

extension ViewCodeProtocol {
    func configureViewCode() {
        configureHierarchy()
        configureConstraint()
        configureStyle()
    }
    
    func configureStyle() {}
}
