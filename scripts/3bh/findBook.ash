
skill[item] skillbook;
item[skill] repeatBook;
 
foreach it in $items[]
    if ( string_modifier(it,"Skill") != "" )
    {
        skillbook[it]=string_modifier(it,"Skill").to_skill();
        if ( it.reusable )
            repeatBook[string_modifier(it,"Skill").to_skill()]=it;
    }
   
item [int] skillbooksUsed, skillbooksToUse, skillbooksToSave, skillbooksToBuy, skillbooksToGet, libraryBooksUsed, libraryBooksToUse, libraryBooksToSave, skillbooksToBuyForLibrary, skillbooksToGetForLibrary;
foreach it in skillbook
{
    if ( repeatBook contains skillbook[it] )
    {
        if ( have_skill(skillbook[it]) )
        {
            if ( it.reusable )
                libraryBooksUsed[libraryBooksUsed.count()] = it;
        }
        else if ( item_amount(repeatBook[skillbook[it]]) > 0 )
        {
            if ( it.reusable )
                if ( string_modifier(it,"Class") == "" || string_modifier(it,"Class").to_class() == my_class() )
                    libraryBooksToUse[libraryBooksToUse.count()] = it;
                else
                    libraryBooksToSave[libraryBooksToSave.count()] = it;
        }
        else if ( available_amount(it)>0 )
            skillbooksToUse[skillbooksToUse.count()] = it;
        else if ( it.tradeable )
            skillbooksToBuyForLibrary[skillbooksToBuyForLibrary.count()] = it;
        else
            skillbooksToGetForLibrary[skillbooksToGetForLibrary.count()] = it;
    }
    else if ( have_skill(skillbook[it]) )
        skillbooksUsed[skillbooksUsed.count()] = it;
    else if ( available_amount(it)>0 )
    {
        if ( string_modifier(it,"Class") == "" || string_modifier(it,"Class").to_class() == my_class() )
            skillbooksToUse[skillbooksToUse.count()] = it;
        else
            skillbooksToSave[skillbooksToUse.count()] = it;
    }
    else if ( it.tradeable )
        skillbooksToBuy[skillbooksToBuy.count()] = it;
    else
        skillbooksToGet[skillbooksToGet.count()] = it;
}
 
sort skillbooksToBuy by mall_price(value);
sort skillbooksToBuyForLibrary by mall_price(value);
 
print_html("<font color=FF0000>Already Used</font>");
foreach it in skillbooksUsed
    print_html("USED "+skillbooksUsed[it]+" to get "+skillbook[skillbooksUsed[it]]);
print_html("");
foreach it in libraryBooksUsed
    print_html("USED "+libraryBooksUsed[it]+" to get "+skillbook[libraryBooksUsed[it]]);
print_html("");
print_html("<font color=FF0000>Could Use</font>");
foreach it in skillbooksToUse
    print_html("PERM "+skillbooksToUse[it]+" to get "+skillbook[skillbooksToUse[it]]);
print_html("");
print_html("<font color=FF0000>Might as well use</font>");
foreach it in libraryBooksToUse
    print_html("REUSE "+libraryBooksToUse[it]+" to get "+skillbook[libraryBooksToUse[it]]);
print_html("");
print_html("<font color=FF0000>Not the right class, use later</font>");
foreach it in skillbooksToSave
    print_html("SAVE "+skillbooksToSave[it]+" to get "+skillbook[skillbooksToSave[it]]);
foreach it in libraryBooksToSave
    print_html("SAVE "+libraryBooksToSave[it]+" to get "+skillbook[libraryBooksToSave[it]]);
print_html("");
print_html("<font color=FF0000>Skillbooks to buy</font>");
foreach it in skillbooksToBuy
    print_html("BUY "+skillbooksToBuy[it]+" for "+mall_price(skillbooksToBuy[it])+" to get "+skillbook[skillbooksToBuy[it]]);
print_html("");
foreach it in skillbooksToBuyForLibrary
{
    print_html("BUY "+skillbooksToBuyForLibrary[it]+" for "+mall_price(skillbooksToBuyForLibrary[it])+" to add "+repeatBook[skillbook[skillbooksToBuyForLibrary[it]]]+" to the library and get "+skillbook[skillbooksToBuyForLibrary[it]]);
    foreach i in skillbooksToGetForLibrary
        if ( skillbooksToGetForLibrary[i] == repeatBook[skillbook[skillbooksToBuyForLibrary[it]]] )
            remove skillbooksToGetForLibrary[i];
}
print_html("");
print_html("<font color=FF0000>Skillbooks to get</font>");
foreach it in skillbooksToGet
    print_html("GET "+skillbooksToGet[it]+" to get "+skillbook[skillbooksToGet[it]]);
print_html("");
foreach it in skillbooksToGetForLibrary
    print_html("GET "+skillbooksToGetForLibrary[it]+" to add it to the library and get "+skillbook[skillbooksToGetForLibrary[it]]);