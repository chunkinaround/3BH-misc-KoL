import <CONSUME/INFO.ash>
import <CONSUME/CONSTANTS.ash>
import <CONSUME/RECORDS.ash>
import <CONSUME/HELPERS.ash>

int price;
string executestring;

void main(item command)
{

	item it = command;
		int [item] ingredients = get_ingredients(it);
		if(ingredients.count() > 0)
		{
			int ingredientsPrice = 0;
			foreach ingredient,amount in ingredients
			{
				ingredientsPrice += amount * item_price(ingredient);
				print("Ingredient: " +ingredient + " price is: " +ingredientsPrice);
			}
			print("Cost to craft is: "+ingredientsPrice);
			if(ingredientsPrice < 15000)
			{
			executestring = ("make "+it);
			cli_execute(executestring);
			}
		}
}
