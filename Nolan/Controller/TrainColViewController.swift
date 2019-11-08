
import UIKit
import AVFoundation

/** Na presente classe são utilizados dois layouts, uma
 de segmented control, sendo que essa aplica o mesmo
 conceito de uma sgc nativa, e um layout editável de
 collection,sendo que essa é uma subclasse de CollectionView
 e aplica praticamente os mesmos métodos que seu pai.
 */
class TrainColViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout,CustomSegmentedControlDelegate {
    func segmentedChange() {
        if !Singleton.shared.firstLoad{
            self.data =  Singleton.shared.data
            collectionView.reloadData()
        }
    }
    
    //variaveis de ligados a elementos que estão na ViewController
    @IBOutlet weak var viewMainTrain: UIView!
    @IBOutlet weak var viewSegmented: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //constante chamada model do tipo Model() e singleton tipo Singleton()
    var data = Singleton.shared.sessions.filter({$0.category == "Focus"})
    let model = Model()
    var codeSegmented: CustomSegmentedControl!
    //Funcao chamada toda vez que a tela é carregada
    override func viewDidLoad() {
        super.viewDidLoad()
                //Configurações SegmentedControl
        self.codeSegmented = CustomSegmentedControl(frame:CGRect(x: 0, y: 10, width: (self.view.frame.width), height: 50),buttonTitle: ["Focus","Concentration","Balance"])
        codeSegmented.backgroundColor = .clear
        viewSegmented.addSubview(codeSegmented)
        codeSegmented.delegate = self
        //Configurando a collection view
        model.buildDataSource()
        //Config datasource e delegate
        collectionView.dataSource  = self
        collectionView.delegate = self
        
        //Chama a funcao setupCollectionView presente abaixo
        setupCollectionView()
        //Chama a funcao registerNibs presente abaixo
        registerNibs()
        Singleton.shared.firstLoad = false
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageUICollectionViewCell
        
        if indexPath.item < self.data.count{
            cell.image.image = self.data[indexPath.item].photo
        }
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = .none
        
        cell.layer.cornerRadius = 8
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 3
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.25
        
        return cell
    }
    
    //**Tamanho para as celular utilizando o layout waterFall*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // cria o tamanho da celula de acordo com o tamanho da imagem e a retorna
        
        var imageSize = CGSize(width: 0, height: 0)
        if indexPath.item < self.data.count{
             imageSize = data[indexPath.row].photo.size
        }
       
       
        return imageSize
    }
    
    
    // ==========  Segue stuff =========
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singletonIndex = indexPath.item
        print("Performing segue to session")
        self.performSegue(withIdentifier: "showSession", sender: singletonIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing segue to session")
        if segue.identifier == "showSession" {
            if let destination = segue.destination as? SessaoViewController, let index = sender as? Int {
                
                print("Index \(index) set in SessaoViewController")
                destination.sessionIndex = index
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    
}
