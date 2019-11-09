
import UIKit

class CustomSegmentedControl: UIView {
    
    
    //variaveis para configurar a segmented
    //A segmented possui uma lista de titulos e uma lista de buttons
    private var buttonTitles:[String]!
    private var buttons:[UIButton]!
    private var selectorView:UIView!
    var textColor:UIColor = .gray
    var selectorViewColor:UIColor = UIColor(displayP3Red: 226/255, green: 117/255, blue: 113/255, alpha: 1)
    var selectorTextColor:UIColor = UIColor(displayP3Red: 226/255, green: 117/255, blue: 113/255, alpha: 1)
    
    var colors = [UIColor(displayP3Red: 226/255, green: 117/255, blue: 113/255, alpha: 1), UIColor(displayP3Red: 78/255, green: 174/255, blue: 167/255, alpha: 1), .blue]
    
    var delegate:CustomSegmentedControlDelegate?
    //funcao que vai ser chamada quando a view for atualizada
    private func updateView(){
        //toda vez que a tela for carregada as tres funcoes principais serao chamadas em ordem
        createButton()
        configSelectorView()
        configStackView()
    }
    //funcao para configurar a linha
    private func configStackView(){
        let stack = UIStackView(arrangedSubviews: buttons)
        //configurando a distribuicao da linha, alinhamento e eixo
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        //setando as constraints da linha para se adequar a view pai
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    //funcao configurar a view de selecao
    private func configSelectorView(){
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        //configurando largura da linha
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height - 10, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    //funcao criar botão
    private func createButton(){
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        //para cada elemento na lista buttonTitle está configurando o titulo e a cor
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            //adicionando o target apontado pra funcao buttonAction para cada botao
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)),for:.touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    //funcao que é chamada quando os botoes sao clickados
    @objc func buttonAction(sender:UIButton){
        //a funcao recebe o objeto botão que foi clickado guardando na variavel SENDER
        for(buttonIndex,btn)in buttons.enumerated(){
            //for que lê todos os botoes que estão na lista, enquanto ele lê, está zerando as caracteristicas do botao
            btn.setTitleColor(textColor, for: .normal)
            btn.titleLabel!.font = UIFont.systemFont(ofSize: 15,weight: .regular)
            //condicao -- se botao que foi clickado é igual ao botao que o for está lendo
            if btn == sender{
                //posicionando a linha no botao que foi clickado, utilizando animação
                
                Singleton.shared.loadDataTrainView(id: Int(CGFloat(buttonIndex)))
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
//                UIView.animate(withDuration: 0.1){
//                    self.selectorView.frame.origin.x = selectorPosition
//                }
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.selectorView.frame.origin.x = selectorPosition
                }, completion: nil)
                
                self.selectorView.frame.origin.x = selectorPosition
                btn.titleLabel!.font = UIFont.systemFont(ofSize: 17,weight: .bold)
                
                btn.setTitleColor(colors[buttonIndex], for: .normal)
                
                UIView.animate(withDuration: 0.35) {
                    self.selectorView.backgroundColor = self.colors[buttonIndex]
                }
            }
        }
        delegate?.segmentedChange()
    }
    //funcoes que sao chamadas para criar o layout da segmented
    convenience init (frame:CGRect,buttonTitle:[String]){
        self.init(frame:frame)
        self.buttonTitles = buttonTitle
    }
    override func draw(_ rect:CGRect){
        super.draw(rect)
        updateView()
    }
    func setButtonTitles(buttonTitles:[String]){
        self.buttonTitles = buttonTitles
        updateView()
    }
}
