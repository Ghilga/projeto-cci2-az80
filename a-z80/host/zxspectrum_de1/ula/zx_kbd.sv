//============================================================================
// ZX Spectrum keyboard input
//
// This module takes scan-codes from the attached PS/2 keyboard and sets
// corresponding ZX key bitfields which are read by the 'IN' instructions.
//
// PS/2      |  ZX Spectrum
// ----------+-----------------
// CTRL      |  CAPS SHIFT
// ALT       |  SYMBOL SHIFT
//
// For convenience, in addition to regular alpha-numeric keys, this code
// simulates several other standard symbols on the PS/2 keyboard.
//
// PS/2      |  ZX Spectrum
// ----------+-----------------
// BACKSPACE |  DELETE
// Arrows Left, Right, Up, Down
// ESC       |  BREAK (CAPS+SPACE)
// SHIFT => PS/2 shift for additional keys: -_ += ;: "' <, >. ?/
//
//  Copyright (C) 2014-2016  Goran Devic
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation; either version 2 of the License, or (at your option)
//  any later version.
//
//  This program is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
//  more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//============================================================================
module zx_keyboard
(
    input wire clk,
    input wire nreset,          // Active low reset

    // Output ZX-specific keyboard codes when requested by the ULA access
    input wire [15:0] A,        // Address bus
    output wire [4:0] key_row,  // Output the state of a requested row of keys

    // Input key scan codes from the PS/2 keyboard
    input wire [7:0] scan_code, // PS/2 scan-code
    input wire scan_code_ready, // Active for 1 clock: a scan code is ready
    input wire scan_code_error, // Error receiving PS/2 keyboard data
    output wire pressed         // Signal that a key is pressed
);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reg [4:0] keys [0:7];       // 8 rows of 5 bits each: contains 0 for a pressed key at a specific location, 1 otherwise

reg released;               // Tracks "released" scan code (F0): contains 0 when a key is pressed, 1 otherwise
reg extended;               // Tracks "extended" scan code (E0)
reg shifted;                // Tracks local "shifted" state

// Calculate a "key is pressed" signal
assign pressed = ~(&keys[7] & &keys[6] & &keys[5] & &keys[4] & &keys[3] & &keys[2] & &keys[1] & &keys[0]);

// Output requested row of keys continously
assign key_row =
    (~A[8]  ? keys[0] : 5'b11111) &
    (~A[9]  ? keys[1] : 5'b11111) &
    (~A[10] ? keys[2] : 5'b11111) &
    (~A[11] ? keys[3] : 5'b11111) &
    (~A[12] ? keys[4] : 5'b11111) &
    (~A[13] ? keys[5] : 5'b11111) &
    (~A[14] ? keys[6] : 5'b11111) &
    (~A[15] ? keys[7] : 5'b11111);

always @(posedge clk or negedge nreset)
begin
    if (!nreset) begin
        released <= 0;
        extended <= 0;
        shifted  <= 0;

        keys[0] <= '1;
        keys[1] <= '1;
        keys[2] <= '1;
        keys[3] <= '1;
        keys[4] <= '1;
        keys[5] <= '1;
        keys[6] <= '1;
        keys[7] <= '1;
    end else
    if (scan_code_ready) begin
        if (scan_code==8'hE0) // Extended code prefix byte
            extended <= 1;
        else if (scan_code==8'hF0) // Break code prefix byte
            released <= 1;
        else begin
            // Cancel release/extended flags for the next clock
            extended <= 0;
            released <= 0;

            if (extended) begin
                // Extended keys
                case (scan_code)
                    8'h6B:  begin                       // LEFT
                            keys[0][0] <= released;     // CAPS SHIFT
                            keys[3][4] <= released;     // 5
                            end
                    8'h72:  begin                       // DOWN
                            keys[0][0] <= released;     // CAPS SHIFT
                            keys[4][4] <= released;     // 6
                            end
                    8'h75:  begin                       // UP
                            keys[0][0] <= released;     // CAPS SHIFT
                            keys[4][3] <= released;     // 7
                            end
                    8'h74:  begin                       // RIGHT
                            keys[0][0] <= released;     // CAPS SHIFT
                            keys[4][2] <= released;     // 8
                            end
                endcase
            end
            else begin
                // For each PS/2 scan-code, set the ZX keyboard matrix state
                case (scan_code)
                    8'h12:  shifted <= !released;       // Local SHIFT key (left)
                    8'h59:  shifted <= !released;       // Local SHIFT key (right)

                    8'h14:  keys[0][0] <= released;     // CAPS SHIFT = Left or right Ctrl

                    8'h1A:  keys[0][1] <= released;     // Z
                    8'h22:  keys[0][2] <= released;     // X
                    8'h21:  keys[0][3] <= released;     // C
                    8'h2A:  keys[0][4] <= released;     // V

                    8'h1C:  keys[1][0] <= released;     // A
                    8'h1B:  keys[1][1] <= released;     // S
                    8'h23:  keys[1][2] <= released;     // D
                    8'h2B:  keys[1][3] <= released;     // F
                    8'h34:  keys[1][4] <= released;     // G

                    8'h15:  keys[2][0] <= released;     // Q
                    8'h1D:  keys[2][1] <= released;     // W
                    8'h24:  keys[2][2] <= released;     // E
                    8'h2D:  keys[2][3] <= released;     // R
                    8'h2C:  keys[2][4] <= released;     // T

                    8'h16:  keys[3][0] <= released;     // 1
                    8'h1E:  keys[3][1] <= released;     // 2
                    8'h26:  keys[3][2] <= released;     // 3
                    8'h25:  keys[3][3] <= released;     // 4
                    8'h2E:  keys[3][4] <= released;     // 5

                    8'h45:  keys[4][0] <= released;     // 0
                    8'h46:  keys[4][1] <= released;     // 9
                    8'h3E:  keys[4][2] <= released;     // 8
                    8'h3D:  keys[4][3] <= released;     // 7
                    8'h36:  keys[4][4] <= released;     // 6

                    8'h4D:  keys[5][0] <= released;     // P
                    8'h44:  keys[5][1] <= released;     // O
                    8'h43:  keys[5][2] <= released;     // I
                    8'h3C:  keys[5][3] <= released;     // U
                    8'h35:  keys[5][4] <= released;     // Y

                    8'h5A:  keys[6][0] <= released;     // ENTER
                    8'h4B:  keys[6][1] <= released;     // L
                    8'h42:  keys[6][2] <= released;     // K
                    8'h3B:  keys[6][3] <= released;     // J
                    8'h33:  keys[6][4] <= released;     // H

                    8'h29:  keys[7][0] <= released;     // SPACE
                    8'h11:  keys[7][1] <= released;     // SYMBOL SHIFT (Red) = Left and right Alt
                    8'h3A:  keys[7][2] <= released;     // M
                    8'h31:  keys[7][3] <= released;     // N
                    8'h32:  keys[7][4] <= released;     // B

                    8'h66:  begin                       // BACKSPACE
                            keys[0][0] <= released;
                            keys[4][0] <= released;
                            end
                    8'h76:  begin                       // ESC -> BREAK
                            keys[0][0] <= released;     // CAPS SHIFT
                            keys[7][0] <= released;     // SPACE
                            end
                    // With shifted keys, we need to make inactive (set to 1) other corresponding key
                    // Otherwise, it will stay active if the shift was released first
                    8'h4E:  begin                       // - or (shifted) _
                            keys[7][1] <= released;     // SYMBOL SHIFT (Red)
                            keys[4][0] <= shifted ? released : 1'b1;     // 0
                            keys[6][3] <= shifted ? 1'b1 : released;     // J
                            end
                    8'h55:  begin                       // = or (shifted) +
                            keys[7][1] <= released;     // SYMBOL SHIFT (Red)
                            keys[6][2] <= shifted ? released : 1'b1;     // K
                            keys[6][1] <= shifted ? 1'b1 : released;     // L
                            end
                    8'h52:  begin                       // ' or (shifted) "
                            keys[7][1] <= released;     // SYMBOL SHIFT (Red)
                            keys[5][0] <= shifted ? released : 1'b1;     // P
                            keys[4][3] <= shifted ? 1'b1 : released;     // 7
                            end
                    8'h4C:  begin                       // ; or (shifted) :
                            keys[7][1] <= released;     // SYMBOL SHIFT (Red)
                            keys[0][1] <= shifted ? released : 1'b1;     // Z
                            keys[5][1] <= shifted ? 1'b1 : released;     // O
                            end
                    8'h41:  begin                       // , or (shifted) <
                            keys[7][1] <= released;     // SYMBOL SHIFT (Red)
                            keys[2][3] <= shifted ? released : 1'b1;     // R
                            keys[7][3] <= shifted ? 1'b1 : released;     // N
                            end
                    8'h49:  begin                       // . or (shifted) >
                            keys[7][1] <= released;     // SYMBOL SHIFT (Red)
                            keys[2][4] <= shifted ? released : 1'b1;     // T
                            keys[7][2] <= shifted ? 1'b1 : released;     // M
                            end
                    8'h4A:  begin                       // / or (shifted) ?
                            keys[7][1] <= released;     // SYMBOL SHIFT (Red)
                            keys[0][3] <= shifted ? released : 1'b1;     // C
                            keys[0][4] <= shifted ? 1'b1 : released;     // V
                            end
                endcase
            end
        end
    end
end

endmodule
