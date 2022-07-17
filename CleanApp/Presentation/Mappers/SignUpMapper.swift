import Domain

struct SignUpMapper {
    
    static func toAddAccountModel(_ model: SignUpModel) -> AddAccountModel {
        return AddAccountModel(
            name: model.name!, email: model.emaail!,
            password: model.password!, passwordConfirmation: model.passwordConfimation!
        )
    }
}
