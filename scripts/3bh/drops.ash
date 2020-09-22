boolean equiphat(){
    if (equipped_amount($item[dice-print do-rag])>0){
        return true;
    }
    if(can_equip($item[dice-print do-rag])){
        equip($item[dice-print do-rag]);
        return true;
    }

    if (can_equip($item[Crown of Thrones ])){
        equip($item[Crown of Thrones ]);
        if (my_enthroned_familiar()!=$familiar[Garbage Fire])
            return enthrone_familiar($familiar[Garbage Fire]);
    }
    return false;
}
boolean equipback(){
    if (equipped_amount($item[Crown of Thrones])==1){
        if (can_equip($item[Camp Scout Backpack]))
            equip($item[Camp Scout Backpack]);  
            return true;     
    } else {
        if (can_equip($item[Buddy Bjorn]))
            equip($item[Buddy Bjorn]);
        if (my_bjorned_familiar()!=$familiar[Warbear Drone])
            return bjornify_familiar($familiar[Warbear Drone]);
    }
    return false;
}
boolean equipshirt(){
    if (can_equip($item[sea salt scrubs])) {
        equip($item[sea salt scrubs]);
        return true;
    }
    return false;
    
}
boolean equipweapon(){
    if (can_equip($item[Staff of the Roaring Hearth])){
        equip($item[Staff of the Roaring Hearth]);
        return true;
    }

    if (can_equip($item[Staff of Kitchen Royalty])){
        equip($item[Staff of Kitchen Royalty]);
        return true;
    }

    if (can_equip($item[Fourth of May Cosplay Saber])){
        equip($item[Fourth of May Cosplay Saber]);
        return true;
    }
    return false;

}
boolean equipoffhand(){
    if (can_equip($item[KoL Con 13 snowglobe])){
        equip($item[KoL Con 13 snowglobe]);
        return true;
    }

    if (can_equip($item[latte lovers members mug])){
        equip($item[latte lovers members mug]);
        return true;
    }
    return false;

}
boolean equippants(){
    if (can_equip($item[pantogram pants])){
        if (item_amount( $item[pantogram pants] ) > 0){
            equip($item[pantogram pants]);
            return true;
        }
    }
    if (can_equip($item[pantsgiving])){
        equip($item[pantsgiving]);
        return true;
    }
    return false;

}
boolean equipacc1(){
    if (can_equip($item[lucky gold ring])){
        equip($item[lucky gold ring],$slot[acc1]);
        return true;
    }
    if (can_equip($item[Powerful Glove])){
        equip($item[Powerful Glove],$slot[acc1]);
        return true; 
    }
    return false;

}
boolean equipacc2(){
    if (can_equip($item[mafia thumb ring])){
        equip($item[mafia thumb ring],$slot[acc2]);
        return true;
    }
    if (can_equip($item[Mr. Cheeng's spectacles])){
        equip($item[Mr. Cheeng's spectacles],$slot[acc2]);
        return true;
    }
    return false;

}
boolean equipacc3(){
    if (equipped_amount($item[Mr. Cheeng's spectacles])==0){
        if (can_equip($item[Mr. Cheeng's spectacles])){
            equip($item[Mr. Cheeng's spectacles],$slot[acc3]);
            return true;
        }
    }
    if (can_equip($item[Mr. Screege's spectacles])){
        equip($item[Mr. Screege's spectacles],$slot[acc3]);
        return true;
    }
    return false;

}


void main () {

equiphat();
equipback();
equipshirt();
equipweapon();
equipoffhand();
equippants();
equipacc1();
equipacc2();
equipacc3();
}