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

    const gross_income = @intToFloat(f32, try fmt.parseInt(u32, args[1], 10));
    const use_relief: bool = if (args.len > 2) mem.eql(u8, args[2], "relief") else false;
    const standard_income_cost: f32 = 250.0;

    var month: usize = 0;
    var prev_income_sum: f32 = 0;
    var prev_tax_sum: f32 = 0;
    while (month < 12) : ({
        month += 1;
        prev_income_sum += gross_income;
    }) {
        const zus_due = calcZus(gross_income, prev_income_sum);
        const health_ins_due = (gross_income - zus_due) * 0.09;
        const tax_relief = if (use_relief) calcRelief(gross_income) else 0;
        const tax_base = gross_income - zus_due - standard_income_cost - tax_relief;
        const tax_due = calcTax(tax_base, prev_tax_sum);
        const net_pay = gross_income - zus_due - health_ins_due - tax_due;
        prev_tax_sum += tax_base;
        std.log.info("{d}: gross = {d:.4}, zus = {d:.4}, health = {d:.4}, tax_relief = {d:.4}, tax_base = {d:.4}, tax_due = {d:.4}, net = {d:.4}", .{
            month + 1,
            gross_income,
            zus_due,
            health_ins_due,
            tax_relief,
            tax_base,
            tax_due,
            net_pay,
        });
    }
}

fn calcZus(gross_income: f32, prev_income_sum: f32) f32 {
    const max_zus: f32 = 177660;
    const zus_calc_base: f32 = if (prev_income_sum + gross_income > max_zus) blk: {
        if (is_zus_paid_in_full)
            break :blk 0;
        is_zus_paid_in_full = true;
        break :blk max_zus - prev_income_sum;
    } else gross_income;
    return zus_calc_base * (0.0976 + 0.015) + gross_income * 0.0245;
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

fn calcRelief(gross_income: f32) f32 {
    const relief: f32 = blk: {
        if (gross_income >= 5701 and gross_income < 8549) {
            break :blk (gross_income * 0.0668 - 380.50) / 0.17;
        } else if (gross_income >= 8549 and gross_income < 11141) {
            break :blk (gross_income * (-0.0735) + 819.08) / 0.17;
        }
        break :blk 0;
    };
    return relief;
}
