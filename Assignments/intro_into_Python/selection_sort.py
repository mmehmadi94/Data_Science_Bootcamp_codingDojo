arr = [5,8,1,9,2,4,3]


for i in range (0, len(arr)):
   min = i
   for j in range (i+1 , len(arr)):
      if arr[min] > arr[j]:
          min = j
   arr[i], arr[min] = arr[min], arr[i]
   print ("iteration", arr)


