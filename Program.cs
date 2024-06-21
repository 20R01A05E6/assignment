public class Program
{
    public static double TotalCost = 0
        ;
    public static void AddItemToCart(string itemName, double price)
    {
        TotalCost += price;
        Console.WriteLine("Added " + itemName + " to cart. Total Cost: " + TotalCost);
    }
    public static void RemoveItemFromCart(string itemName)
    {
        TotalCost -= 5.99;
        Console.WriteLine("Removed " + itemName + " from cart. Total Cost: " + TotalCost);
    }

    public static void Main(string[] args)
    {
        AddItemToCart("Item-1", 10.99);
        AddItemToCart("Item-2", 5.99);
        AddItemToCart("Item-3", 6.49);
        AddItemToCart("Item-4", 7.36);
        AddItemToCart("Item-5", 40.22);
        RemoveItemFromCart("Item 1");

        Console.WriteLine("Total Cost: " + TotalCost);
    }
}