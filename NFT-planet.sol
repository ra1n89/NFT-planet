pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract NFT_planet {
 
    struct Planet{
        string name;
        uint diametr;
        uint distanceFromTheSun;
        
    }

    Planet[] planetsArr;
    mapping (uint=>uint) planetsToOwner;
    mapping (uint=>uint) planetsPrice;
    //mapping (Planet=>uint) planetsPrice;


    modifier checkOwnerAndAccept {

        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}
    
    // Создаём токен
    function createPlanet(string name, uint diametr, uint distanceFromTheSun) public checkOwnerAndAccept  {
         
       
        for (uint i=0; i < planetsArr.length; i++){
            require(name != planetsArr[i].name, 101);
        }
        planetsArr.push(Planet(name, diametr, distanceFromTheSun));
        uint planetID = planetsArr.length - 1;
        planetsToOwner[planetID] = msg.pubkey();
    }

    function getPlanetOwner(uint planetID) public view returns (uint){
        return planetsToOwner[planetID];

    }

    function getPlanetInfo(uint planetID) public view returns (string planetName, uint planetDiametr, uint planetDistance){
        planetName = planetsArr[planetID].name;
        planetDiametr = planetsArr[planetID].diametr;
        planetDistance = planetsArr[planetID].distanceFromTheSun;
        
    }

    function setPlanetPrice(uint planetID, uint price) public checkOwnerAndAccept{
        require(planetsToOwner[planetID]==msg.pubkey(), 101);
        planetsPrice[planetID] = price;
    }

    function getPlanetPrice(uint planetID) public view returns(uint){
        
        return planetsPrice[planetID];
    }

    constructor() public {
        
        require(tvm.pubkey() != 0, 101);
    
        require(msg.pubkey() == tvm.pubkey(), 102);
    
        tvm.accept();
      
    }

   
}
