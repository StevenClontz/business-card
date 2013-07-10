require 'prawn/qrcode'

qr_content = "http://www.stevenclontz.com"

Prawn::Document::new(:page_size => [112, 112], :margin => 0) do
  print_qr_code(qr_content, :extent=>144, :stroke=>false)
  render_file("qrcode.pdf")
end