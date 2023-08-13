use traits::Into;
use integer::{u128s_from_felt252, U128sFromFelt252Result};
use debug::PrintTrait;

// Full random felt
fn hash_random(seed: felt252) -> felt252 {
    pedersen(seed, 1)
}

// Random u128 - Easier math
fn hash_random_u128(seed: u128) -> u128 {
    let hash = pedersen(seed.into(), 1);
    match u128s_from_felt252(hash) {
        U128sFromFelt252Result::Narrow(x) => x,
        U128sFromFelt252Result::Wide((_, x)) => x,
    }
}

// High level random in a range
// Only one random number per hash might be inefficient.
fn hash_random_range(seed: u128, min: u128, max: u128) -> u128 {
    let rnd = hash_random_u128(seed);
    let range = max - min + 1; // + 1 to include max
    min + rnd % range
}

#[test]
#[available_gas(20000)]
fn test_hash_rnd() {
    let rnd = hash_random(25);
    assert(rnd == 0x7f25249bc3b57d4a9cb82bd75d25579ab9d03074bff6ee2d4dbc374dbf3f846, '');
}

#[test]
#[available_gas(20000)]
fn test_hash_rnd_u128() {
    let rnd = hash_random_u128(25);
    assert(rnd == 0xab9d03074bff6ee2d4dbc374dbf3f846, '');
}

#[test]
#[available_gas(120000)]
fn test_hash_rnd_range() {
    assert(0x2 == hash_random_range(4, 1, 9), '');
    assert(0x6 == hash_random_range(5, 1, 9), '');
    assert(0x4 == hash_random_range(6, 1, 9), '');
    assert(0x3 == hash_random_range(7, 1, 9), '');
}
