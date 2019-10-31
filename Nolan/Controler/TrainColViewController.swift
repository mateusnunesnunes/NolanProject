
import UIKit
import AVFoundation

/*Na presente classe são utilizados dois layouts, uma
 de segmented control, sendo que essa aplica o mesmo
 conceito de uma sgc nativa, e um layout editável de
 collection,sendo que essa é uma subclasse de CollectionView
 e aplica praticamente os mesmos métodos que seu pai.
 *///teste
class TrainColViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout  {
    //variaveis de ligados a elementos que estão na ViewController
    @IBOutlet weak var viewMainTrain: UIView!
    @IBOutlet weak var viewSegmented: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //constante chamada model do tipo Model() e singleton tipo Singleton()
    var sessions = Singleton.shared.poses
    let model = Model()
    
    //Funcao chamada toda vez que a tela é carregada
    override func viewDidLoad() {
        super.viewDidLoad()
                //Configurações SegmentedControl
        let codeSegmented = CustomSegmentedControl(frame:CGRect(x: 0, y: 10, width: (self.view.frame.width), height: 50),buttonTitle: ["Train","Feed","Tonnig"])
        codeSegmented.backgroundColor = .clear
        viewSegmented.addSubview(codeSegmented)
        
//        viewMainTrain.layer.borderWidth = 2
//        viewMainTrain.layer.borderColor = UIColor.black.cgColor
        print("teste")
        //Configurando a collection view
        model.buildDataSource()
        //Config datasource e delegate
        collectionView.dataSource  = self
        collectionView.delegate = self
        //Chama a funcao setupCollectionView presente abaixo
        setupCollectionView()
        //Chama a funcao registerNibs presente abaixo
        registerNibs()
    }
    
    //O aplicativo nunca chama esse metodo diretamente, só é chamado quando o sistema avalia a memória disponivel como baixa
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //funcao para configurar a collectionView
    func setupCollectionView(){
        // Cria o layout
        let layout = CHTCollectionViewWaterfallLayout()
        // Edita o layout individual como espaco entre as celulas
        layout.minimumColumnSpacing = 25.0
        layout.minimumInteritemSpacing = 25.0
        // CollectionView atributos
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        //Adiciona o layout watterFall na collection presente na view
        collectionView.collectionViewLayout = layout
    }
    
    func registerNibs(){
        //Referencia a xib ImageUICollectionViewCell e registra ela na collection view presente na viewPrincipal
        let viewNib = UINib(nibName: "ImageUICollectionViewCell", bundle: nil)
        collectionView.register(viewNib, forCellWithReuseIdentifier: "cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //retorna o numero de itens em uma secao
        return model.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Cria a celula e retorna a celula
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageUICollectionViewCell
        // Adiciona as imagem presentes no array
        cell.image.image = model.images[indexPath.row]
        //cell.backgroundColor = .lightGray
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    //**Tamanho para as celular utilizando o layout waterFall*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // cria o tamanho da celula de acordo com o tamanho da imagem e a retorna
        
        var imageSize = model.images[indexPath.row].size
//        imageSize.width -= 30
//        imageSize.height -= 30
        return imageSize
    }
    
//      TODO: instanciar a sessaoViewControler
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sessaoViewController = storyBoard.instantiateViewController(withIdentifier: "sessao") as! SessaoViewController
        sessaoViewController.indice = indexPath.item
        self.present(sessaoViewController, animated: true, completion: nil)
    }
}
