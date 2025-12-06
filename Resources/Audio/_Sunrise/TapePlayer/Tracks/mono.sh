#!/bin/bash
for file in *.ogg; do
    if [ -f "$file" ]; then
        echo "Processing: $file"
        temp_file="${file%.ogg}_$$.ogg"
        
        # Convert to mono
        ffmpeg -i "$file" -ac 1 -c:a libvorbis -q:a 6 "$temp_file" 2>/dev/null
        
        if [ $? -eq 0 ] && [ -f "$temp_file" ]; then
            # Replace original
            mv "$temp_file" "$file"
            echo "✓ Converted: $file"
        else
            echo "✗ Failed to convert: $file"
            [ -f "$temp_file" ] && rm "$temp_file"
        fi
    fi
done
