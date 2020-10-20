print("***********************Update Values in Dictionaries and Lists***********************")


x = [ [5,2,3], [10,8,9] ]
students = [
     {'first_name':  'Michael', 'last_name' : 'Jordan'},
     {'first_name' : 'John', 'last_name' : 'Rosales'}
]
sports_directory = {
    'basketball' : ['Kobe', 'Jordan', 'James', 'Curry'],
    'soccer' : ['Messi', 'Ronaldo', 'Rooney']
}
z = [ {'x': 10, 'y': 20} ] # dictionary inside list

# Change the value 10 in x to 15. Once you're done, x should now be [ [5,2,3], [15,8,9] ].
z[0]['x']= 15
print(z)
# Change the last_name of the first student from 'Jordan' to 'Bryant'
students[0]['last_name'] = 'Bryant'
print (students)
# In the sports_directory, change 'Messi' to 'Andres'
sports_directory['soccer'][0] = 'Andres'
print (sports_directory)

# Change the value 20 in z to 30
z[0]['y']= 30
print(z)

print("***************************/n Iterate Through a List of Dictionaries ***********************")

def iterateDictionary (list):
    for i in range(len(list)):
        print("first_name -", list[i]['first_name'], ", last_name -", list[i]['last_name'])



students = [
         {'first_name':  'Michael', 'last_name' : 'Jordan'},
         {'first_name' : 'John', 'last_name' : 'Rosales'},
         {'first_name' : 'Mark', 'last_name' : 'Guillen'},
         {'first_name' : 'KB', 'last_name' : 'Tonel'}
    ]
iterateDictionary(students)
# should output: (it's okay if each key-value pair ends up on 2 separate lines;
# bonus to get them to appear exactly as below!)

print("***************************/n Get Values From a List of Dictionaries***********************")
def iterateDictionary2(key_name, list):
        for i in range(len(list)):
            print(list[i][key_name])

iterateDictionary2('first_name', students)

print("***************************/n Iterate Through a Dictionary with List Values***********************")
def printInfo (list):
    for key, val in list.items():
        print(key, " = ", val)

dojo = {
   'locations': ['San Jose', 'Seattle', 'Dallas', 'Chicago', 'Tulsa', 'DC', 'Burbank'],
   'instructors': ['Michael', 'Amy', 'Eduardo', 'Josh', 'Graham', 'Patrick', 'Minh', 'Devon']
}
printInfo(dojo)










#
