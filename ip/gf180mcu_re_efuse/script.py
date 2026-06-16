import pya

ly = pya.Layout()

ly.read("gds/efuse_spi_mem_256x8.gds")

top = ly.top_cell()

layer = ly.layer(41, 0) # Via 4

iter = top.begin_shapes_rec(layer)

while not iter.at_end():
    if iter.shape().is_box():
        dbox = iter.shape().dbox.transformed(iter.dtrans())
        print(f"        RECT {dbox.p1.x:.3f} {dbox.p1.y:.3f} {dbox.p2.x:.3f} {dbox.p2.y:.3f} ;")
    iter.next()
