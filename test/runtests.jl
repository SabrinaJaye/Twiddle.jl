#=
Copyright (c) 2017 Ben J. Ward & Luis Yanes

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
=#

module TestTwiddle

using Twiddle, Base.Test

@testset "Enumerating nibbles" begin
    @test Twiddle.enumerate_nibbles(0x42) == 0x11
    @test Twiddle.enumerate_nibbles(0x4216) == 0x1112
    @test Twiddle.enumerate_nibbles(0x4216CEDF) == 0x11122334
    @test Twiddle.enumerate_nibbles(0x4216CEDF4216CEDF) == 0x1112233411122334
    @test Twiddle.enumerate_nibbles(0x4216CEDF4216CEDF4216CEDF4216CEDF) == 0x11122334111223341112233411122334
end

@testset "Counting nibbles" begin
    @testset "Counting zero nibbles" begin
        @test Twiddle.count_zero_nibbles(0x0F) == 1
        @test Twiddle.count_zero_nibbles(0x0F11) == 1
        @test Twiddle.count_zero_nibbles(0x0F11F111) == 1
        @test Twiddle.count_zero_nibbles(0x0F11F111F11111F1) == 1
        @test Twiddle.count_zero_nibbles(0x0F11F111F11111F10F11F111F11111F1) == 2
    end
    @testset "Counting non-zero nibbles" begin
        @test Twiddle.count_nonzero_nibbles(0x0F) == 1
        @test Twiddle.count_nonzero_nibbles(0x0F11) == 3
        @test Twiddle.count_nonzero_nibbles(0x0F11F111) == 7
        @test Twiddle.count_nonzero_nibbles(0x0F11F111F11111F1) == 15
        @test Twiddle.count_nonzero_nibbles(0x0F11F111F11111F10F11F111F11111F1) == 30
    end
    @testset "Counting one nibbles" begin
        @test Twiddle.count_one_nibbles(0x0F) == 1
        @test Twiddle.count_one_nibbles(0x0F11) == 1
        @test Twiddle.count_one_nibbles(0x0F11F111) == 2
        @test Twiddle.count_one_nibbles(0x0F11F111F11111F1) == 4
        @test Twiddle.count_one_nibbles(0x0F11F111F11111F10F11F111F11111F1) == 8
    end
end

@testset "Counting bitpairs" begin
    @test Twiddle.count_zero_bitpairs(0x185DF69C185DF69C) == 6
    @test Twiddle.count_nonzero_bitpairs(0x185DF69C185DF69C) == 26
    @test Twiddle.count_one_bitpairs(0x185DF69C185DF69C) == 8
end

@testset "Masking nibbles" begin
    @test Twiddle.nibble_mask(0xDD, 0x18) == 0x00
    @test Twiddle.nibble_mask(0xDD, 0x185D) == 0x000F
    @test Twiddle.nibble_mask(0xDD, 0x185DF69C) == 0x000F0000
    @test Twiddle.nibble_mask(0xDD, 0x185DF69C185DF69C) == 0x000F0000000F0000
    @test Twiddle.nibble_mask(0xDD, 0x185DF69C185DF69C185DF69C185DF69C) == 0x000F0000000F0000000F0000000F0000
end

end
