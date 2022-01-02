const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;
const process = std.process;

var gpa_allocator = std.heap.GeneralPurposeAllocator(.{}){};
var is_zus_paid_in_full: bool = false;
var is_second_clif: bool = false;

pub fn main() anyerror!void {
    var arena_allocator = std.heap.ArenaAllocator.init(gpa_allocator.allocator());
    defer arena_allocator.deinit();
    const arena = arena_allocator.allocator();

    const args = try process.argsAlloc(arena);

    const gross_income = try fmt.parseInt(u32, args[1], 10);
    const standard_income_cost: f32 = 250.0;

    var month: usize = 0;
    var prev_income_sum: u32 = 0;
    var prev_tax_sum: f32 = 0;
    while (month < 12) : ({
        month += 1;
        prev_income_sum += gross_income;
    }) {
        const zus_due = calcZus(gross_income, prev_income_sum);
        const health_ins_due = (@intToFloat(f32, gross_income) - zus_due) * 0.09;
        const tax_base = @intToFloat(f32, gross_income) - zus_due - standard_income_cost;
        const tax_due = calcTax(tax_base, prev_tax_sum);
        prev_tax_sum += tax_base;
        std.log.info("{d}: zus = {d:.4}, health ins = {d:.4}, tax_base = {d:.4}, tax_due = {d:.4}", .{
            month + 1,
            zus_due,
            health_ins_due,
            tax_base,
            tax_due,
        });
    }
}

fn calcZus(gross_income: u32, prev_income_sum: u32) f32 {
    const max_zus: u32 = 177660;
    const zus_calc_base: u32 = if (prev_income_sum + gross_income > max_zus) blk: {
        if (is_zus_paid_in_full)
            break :blk 0;
        is_zus_paid_in_full = true;
        break :blk max_zus - prev_income_sum;
    } else gross_income;
    return @intToFloat(f32, zus_calc_base) * (0.0976 + 0.015) + @intToFloat(f32, gross_income) * 0.0245;
}

fn calcTax(tax_base: f32, prev_tax_sum: f32) f32 {
    const clif: f32 = 120000;
    const tax: f32 = if (tax_base + prev_tax_sum > clif) blk: {
        if (is_second_clif)
            break :blk tax_base * 0.32;
        is_second_clif = true;
        break :blk (clif - prev_tax_sum) * 0.17 + (tax_base - clif + prev_tax_sum) * 0.32;
    } else tax_base * 0.17;
    return tax - 425;
}
