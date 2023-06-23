// Given head, the head of a linked list, determine if the linked list has a cycle in it.

// There is a cycle in a linked list if there is some node in the list that can be reached
// again by continuously following the next pointer. Internally, pos is used to denote the
// index of the node that tail's next pointer is connected to. Note that pos is not passed
// as a parameter.

// Return true if there is a cycle in the linked list. Otherwise, return false.

var hasCycle = function(head) {
  let seen = {}
  // So the problem here is can you have two different nodes with the same value?
  // like what is the notion of identity?
  while (head.next) {
    if (seen[head.val]) {
      return true
    } else {
     seen[head.val] = true
     continue
    }
  }
};

const head = [3,2,0,-4]
console.log(hasCycle(head));
