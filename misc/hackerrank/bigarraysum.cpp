#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

long long int recursiveArraySum(vector<int> &array, int n);

int main(){
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int arr_i = 0;arr_i < n;arr_i++){
       cin >> arr[arr_i];
    }
    
    // Divide and conquer perhaps? But like recursively...
    cout << recursiveArraySum(arr, n) << endl;
    return 0;
}

long long int recursiveArraySum(vector<int> &array, int n)
{
	if (n > 2)
    {
       int halfway = floor(n/2);
       
		 // find middle index
        vector<int> first(halfway);
        vector<int> second(n-halfway);
 
        for (int i = 0; i < n; i++) 
        {
            if (i < halfway) { first[i] = array[i];}
            else {second[i-halfway] = array[i];}
        }
        
        return recursiveArraySum(first, halfway) + recursiveArraySum(second, n-halfway);
        
    }
    else if (n == 1)
    {
        return array[0];
    }
    
    return (long long int) array[0] + array[1];
    
}

