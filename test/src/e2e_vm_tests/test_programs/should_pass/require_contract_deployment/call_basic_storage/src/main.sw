script;
use basic_storage_abi::{StoreU64, Quad};
use std::assert::assert;

fn main() -> u64 {
    let addr = abi(StoreU64, 0x06ee714ac67bc939377e34466b2461daaa0914eaf3f1390e54ede488a63114b8);
    let key = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    let value = 4242;

    addr.store_u64(key, value);

    let res = addr.get_u64(key);
    assert(res == value);

    let key = 0x00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    addr.intrinsic_store_word(key, value);
    let res = addr.intrinsic_load_word(key);
    assert(res == value);

    let key = 0x11ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    let q = Quad { v1: 1, v2: 2, v3: 4, v4: 100 };
    addr.intrinsic_store_quad(key, q);
    let r = addr.intrinsic_load_quad(key);
    assert(q.v1 == r.v1 && q.v2 == r.v2 && q.v3 == r.v3 && q.v4 == r.v4);

    addr.test_storage_exhaustive();

    res
}