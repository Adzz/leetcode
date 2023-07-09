// The trick here is
var maxArea = function(heights) {
    let right_index = heights.length - 1
    let left_index = 0
    let max_area = 0

    while (left_index < right_index) {
        let left = heights[left_index]
        let right = heights[right_index]

        let height = Math.min(left, right);
        let base = (right_index - left_index);
        let area = base * height;

        max_area = Math.max(max_area, area);

        if (right > left) {
         left_index += 1;
        } else {
          right_index -= 1;
        }
    }

    return max_area
};

console.log(maxArea([1,8,6,2,5,4,8,3,7])) // 49
console.log(maxArea([1,1])) // 1

