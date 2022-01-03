# calctax

Simple tax calculator for employees in Poland after Nowy Lad changes in 2022. My wife asked me to figure
out some tax questions for her, and it was easier to implement a simple calculator in Zig
than fighting with a spreadsheet, so there you go...

## Example

```
zig build run -- 7800
info: 1: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 2: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 3: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 4: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 5: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 6: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 7: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 8: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 9: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 10: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 11: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
info: 12: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 0.0000, tax_base = 6480.6201, tax_due = 676.7054, net = 5448.1587
```

It is also possible to include the monthly tax relief in your calculations by setting `-r` flag:

```
zig build run -- 7800 -r
info: 1: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 2: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 3: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 4: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 5: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 6: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 7: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 8: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 9: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 10: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 11: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
info: 12: gross = 7800.0000, zus = 1069.3800, health = 605.7559, tax_relief = 826.7057, tax_base = 5653.9146, tax_due = 536.1655, net = 5588.6987
```
