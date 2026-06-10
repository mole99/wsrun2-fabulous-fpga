# GF_IOBUF

The GF_IOBUF primitive is used to interface the fabric with external signals through the package pins.

![GF_IOBUF](images/svg/GF_IOBUF.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| IN            | input     | 1     | The input of the IOBUF primitive from the fabric (therefore the output the the PAD). |
| OUT           | output    | 1     | The output of the IOBUF primitive to the fabric (therefore the input from the PAD). |
| EN            | input     | 1     | The output enable for the output driver. |
| CLK           | input     | 1     | The clock for the flip-flops. When none of the registers are enabled, it can be tied low. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| IN_REG        | 1     | Register the IN signal.  |
| OUT_REG       | 1     | Register the OUT signal. |
| EN_REG        | 1     | Register the EN signal.  |
| CS            | 1     | Input type (0=CMOS Buffer, 1=Schmitt Trigger). |
| SL            | 1     | Slew rate (0=fast, 1=slow). |
| PU            | 1     | Pull-up (0=disabled, 1=enabled). |
| PD            | 1     | Pull-down (0=disabled, 1=enabled).  |

Note that the registers are physically close to the input/output drivers and therefore allow for a low skew.
