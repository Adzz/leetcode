// I guess we assume the nums is sorted?
// We want to stop checking as soon as we get to a right that is greater than target
// and stop the whole loop if the left ever gets larger than the target.

var twoSum = function(nums, target) {
   const sorted = nums.map((n, i) => {
      return {original_index: i, value: n}
    }).sort((l, r) => {
     return l.value - r.value
   })

    let firstNumb = 0;
    let nextNumb = 1;
    let maxIndex = nums.length - 1
    let searching = true;

    while (searching) {
      const left = sorted[firstNumb];
      const right = sorted[nextNumb];
      const total = left.value + right.value

      if (total === target) {
        searching = false;
        return [left.original_index, right.original_index]
      } else if (total < target) {
        if (nextNumb < maxIndex) {
          nextNumb += 1
          continue
        }

        if (nextNumb === maxIndex) {
          firstNumb += 1
          nextNumb = firstNumb + 1
          continue
        }
      } else {
        // ie total > target
       if (firstNumb < maxIndex) {
          firstNumb += 1
          nextNumb = firstNumb + 1
          continue
        }
      }
    }
}

console.log(twoSum([2, 7, 11, 15], 9));
console.log(twoSum([3, 2, 4], 6));
console.log(twoSum([0, 4, 3, 0], 0));
console.log(twoSum([-3,4,3,90], 0));

// We made our lives hard with the above. The insight is actually that for each integer there
// is one number that we are looking for that works, which is target - n. So for each number
// we can collect the list of those numbers and if we ever encounter a number that is in that
// list then we have an answer... This is much simpler.










