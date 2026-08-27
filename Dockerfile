FROM ghcr.io/open-webui/open-webui:main

# Install system dependencies required by pytesseract (OCRed text in PDFs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages missing from the base image for office file editing
#   docx-revisions  — Word track changes (redlines)
#   odfpy           — LibreOffice ODF read/write (.odt, .ods, .odp)
#   PyMuPDF         — PDF merge/split/sticky notes
#   pytesseract     — OCR via tesseract binary
#   qrcode          — QR code generation
RUN pip install --no-cache-dir \
    docx-revisions \
    odfpy \
    PyMuPDF \
    pytesseract \
    qrcode