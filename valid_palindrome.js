// A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and
// removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric
// characters include letters and numbers.

// Given a string s, return true if it is a palindrome, or false otherwise.
var isPalindrome = function(s) {
  const sanitized = s.replace(/[^a-z0-9]/gi, "").toLowerCase()
  const max = sanitized.length

  let is_palindrome = true;
  let index = 0;
  let end_index = max - 1;

  while (index < end_index) {
    const begining = sanitized[index];
    const end = sanitized[end_index]

    if (begining === end) {
      index += 1
      end_index -= 1
      continue
    } else {
      return false
    }
  }
  return is_palindrome
};

console.log(isPalindrome("A man, a plan, a canal: Panama"));
console.log(isPalindrome("A man, a plan, a canal: Panama nawTSDknd['3284u5y7t376"));
