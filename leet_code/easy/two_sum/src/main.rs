fn main() {
    println!("{:?}", two_sum(vec![2, 7, 11, 15], 9));
    println!("{:?}", two_sum(vec![3, 2, 4], 6));
    println!("{:?}", two_sum(vec![3, 3], 6));
}

pub fn two_sum(nums: Vec<i32>, target: i32) -> Vec<i32> {
    let length: usize = nums.len();
    for i in 0..length {
        for j in 0..length {
            if i == j { continue; }
            if nums[i] + nums[j] == target {
                return vec![
                    i.try_into().unwrap(),
                    j.try_into().unwrap(),
                ];
            }
        }
    }
    Vec::new()
}
