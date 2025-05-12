from pynq import Overlay
from pynq import allocate
from PIL import Image
import numpy as np
import os
import matplotlib.pyplot as plt
import time

# Load bitstream
overlay = Overlay("design_1_wrapper.bit")
conv_ip = overlay.conv2d_edge_0  # Replace with actual IP name if different

# Directories
input_dir = "/home/xilinx/jupyter_notebooks/pictures_input"
output_dir = "/home/xilinx/jupyter_notebooks/outputs"
os.makedirs(output_dir, exist_ok=True)

# Image dimensions
IMG_HEIGHT = 256
IMG_WIDTH = 256

# Helper: write 64-bit address into two 32-bit registers
def write_addr(ip, reg_low, reg_high, addr):
    setattr(ip.register_map, reg_low, addr & 0xFFFFFFFF)
    setattr(ip.register_map, reg_high, (addr >> 32) & 0xFFFFFFFF)

# Process each image
for img_name in os.listdir(input_dir):
    if not img_name.lower().endswith((".png", ".jpg", ".bmp")):
        continue

    # Load and preprocess image
    img_path = os.path.join(input_dir, img_name)
    img = Image.open(img_path).convert("L").resize((IMG_WIDTH, IMG_HEIGHT))
    img_array = np.array(img).astype(np.uint8)

    # Allocate buffers
    in_buffer = allocate(shape=(IMG_HEIGHT, IMG_WIDTH), dtype=np.uint8)
    out_buffer = allocate(shape=(IMG_HEIGHT - 2, IMG_WIDTH - 2), dtype=np.uint8)

    np.copyto(in_buffer, img_array)

    # Write input/output addresses
    write_addr(conv_ip, "input_r_1", "input_r_2", in_buffer.physical_address)
    write_addr(conv_ip, "output_r_1", "output_r_2", out_buffer.physical_address)

    # Start IP and wait for completion
    start_time = time.time()
    conv_ip.register_map.CTRL.AP_START = 1
    while not conv_ip.register_map.CTRL.AP_DONE:
        pass
    elapsed = time.time() - start_time

    # Save and show results
    out_img = Image.fromarray(out_buffer)
    out_img.save(os.path.join(output_dir, f"output_{img_name}"))

    plt.figure(figsize=(8, 4))
    plt.subplot(1, 2, 1)
    plt.imshow(img_array, cmap='gray')
    plt.title("Input")

    plt.subplot(1, 2, 2)
    plt.imshow(out_buffer, cmap='gray')
    plt.title("Output")
    plt.show()

    print(f"Processed {img_name} → saved output. Processing time: {elapsed:.4f} seconds")

    # Optional: Free buffers
    in_buffer.freebuffer()
    out_buffer.freebuffer()

