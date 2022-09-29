// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataLocation{
    /*
           Kontrat           <----                  Kontrata yapılan çağrı
           -------                                      -------------
    Kontrat depolama alanı           Fonksiyon için ayrılan hafıza ve çağrıdaki data alanı


    memory:          Geçici hafıza (fonksiyonların içerisinde oluşturulmuş vb. değişkenler
    storage:         Kalıcı hafıza (Blockzincir)
    calldata:        Çağrıdaki argümanlar (fonksiyon vb. yerlere verilen değişkenler)

    bytes, string, array, struct

    * Değer tipleri (uint, int, bool, bytes32) kontrat üzerinde storage, 
      fonksiyon içinde memory'dir
    
    * mapping'ler her zaman kontrat üzerinde tanımlanır ve storage'dadır.
*/

    uint256 myValue;//Storage da saklanır

    mapping(address=>uint) balances; /*Storage da saklanır. Her zaman kontrat üzerinde tutulur (Fonksiyon içerisinde tanımlanırsa hata alınır)*/
    /*İstisna library içerisinde yazılan fonksiyonlarda mapping'i parametre olarak verilebilir ?(ama fonksiyon içine tanımlanamaz)?*/


    function myFn(uint256 _myValue /*Memmory*/) external pure returns(uint256){
        return _myValue*2;
    }

    

    string myName = "Muhammed"; /*Stroge*/

    function myFn2(string memory _myName) external pure returns(string memory){
        /*Calldata olursa sadece readonly olur yani değiştirilemez*/
        /*string memmory _myName yaparsak değiştirilebilir*/
        return _myName;
    }
}








/*Memory ile stroge farkını gösteriyor

calldata => Fonksiyon içerisine verilen değerleri sadece okucak değiştirmiceksek kullanalım

memory => Fonksiyon içerisine dışarıda tanımlı(Durum degiskeni) veriyi verip üzerinde değişiklik yapıcaksak ama dışarıda ki veri değişmesin istiyosak kullanıcaz. 
(Aynı zamanda string, array gibi kullanıcalar tarafından verilen degiskenlerde de kullanabiliriz.)

storage => Fonksiyon içerisinde dışarıda tanımlı(Durum degiskeni) veriyi degistiriceksek kullanıcaz. Yani disarıda ki veri ile içeride ki ver birbiri ile bağlantılı olur.
*/

struct Student {
    uint8 age;
    uint16 score;
    string name;
}

contract School {
    uint256 totalStudents = 0;              // storage
    mapping(uint256 => Student) students;   // storage

    function addStudent(string calldata name, uint8 age, uint16 score) external {
        uint256 currentId = totalStudents++;
        students[currentId] = Student(age, score, name); 
    }

    function changeStudentInfoStorage(
        uint256 id,                 // memory
        string calldata newName,    // calldata
        uint8 newAge,               // memory
        uint16 newScore             // memory
    ) external {
        Student storage currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;

        //! İnce model pointer mantığına benziyo (callByReferance vs callByValue gibi)

        /*Burda storage üstüne currentstudent oluşturulur 
        ve bu currentstudent student[id]'deki student ile bağlantılı olur
        birinde yapılan değişiklik diğerinide etkiler*/
    }

    /**
        Bu işe yaramayacaktır, çünkü oluşturulan currentStudent ömrü
        fonksiyonun bitişine kadar olur. Fonksiyon bittikten sonra currentStudent silinir.
        burda ki currentStudent ile students[id]'de ki student arasında bir ilişki yoktur
        birinda yapılan degisiklir otekini etkilemez.
    */
    function changeStudentInfoMemory(
        uint256 id,                 // memory
        string calldata newName,    // calldata
        uint8 newAge,               // memory
        uint16 newScore             // memory
    ) external view {
        Student memory currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;
        /*students[id] = currentStudent; Bunu eklersen değişiklik olur
        ama eklemezsen bir değişken fonksiyon çağrılınca oluşturulur ve sonra yok olur*/
    }

    function getStudentName(uint256 id) external view returns(string memory) { 
        return students[id].name;
    }
}