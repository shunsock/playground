fn main() {
    // Simple Pattern
    assert_eq!(true, is_palindrome_simple(121));
    assert_eq!(false, is_palindrome_simple(-121));
    assert_eq!(false, is_palindrome_simple(10));
    assert_eq!(false, is_palindrome_simple(i32::MAX));
    assert_eq!(false, is_palindrome_simple(i32::MIN));
    // Faster Pattern
    assert_eq!(true, is_palindrome_faster(121));
    assert_eq!(false, is_palindrome_faster(-121));
    assert_eq!(false, is_palindrome_faster(10));
    assert_eq!(false, is_palindrome_faster(i32::MAX));
    assert_eq!(false, is_palindrome_faster(i32::MIN));
}

pub fn is_palindrome_simple(x: i32) -> bool {
    let x_str: String = x.to_string();
    let reversed_x_str: String = x_str.chars().rev().collect();
    x_str == reversed_x_str
}

pub fn is_palindrome_faster(x: i32) -> bool {
    x == palindrome(x)
}

pub fn palindrome(x: i32) -> i32 {
    let mut operated: i32 = x;
    let mut reverse: i64 = 0;
    while operated > 0{
        let reminder = operated % 10;
        operated = operated / 10; // 整数除算
        reverse = 10 * reverse + reminder as i64;
    }
    reverse as i32
}
