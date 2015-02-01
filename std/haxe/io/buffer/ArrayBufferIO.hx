package haxe.io.buffer;

class ArrayBufferIO {

    #if !no_typedarray_inline inline #end
    public static function getInt8( buffer:ArrayBuffer, byteOffset:Int ) : Int {

        #if cpp
            return untyped __global__.__hxcpp_memory_get_byte(buffer.getData(), byteOffset);
        #else
            var val:Int = buffer.get(byteOffset);
            return ((val & 0x80) != 0) ?(val - 0x100) : val;
        #end

    }

    #if !no_typedarray_inline inline #end
    public static function setInt8( buffer:ArrayBuffer, byteOffset:Int, value:Int ) {

        #if cpp
            untyped __global__.__hxcpp_memory_set_byte(buffer.getData(), byteOffset, value);
        #elseif neko
            untyped __dollar__sset(buffer.b, byteOffset, value & 0xff);
        #end

        return value;

    }

    #if !no_typedarray_inline inline #end
    public static function getUint8( buffer:ArrayBuffer, byteOffset:Int ) : Null<UInt> {

        #if cpp
            return untyped __global__.__hxcpp_memory_get_byte(buffer.getData(), byteOffset) & 0xff;
        #else
            return buffer.get( byteOffset );
        #end

    }

    #if !no_typedarray_inline inline #end
    public static function setUint8Clamped( buffer:ArrayBuffer, byteOffset:Int, value:UInt ) : UInt {

        return setUint8( buffer, byteOffset, _clamp(value) );

    }

    #if !no_typedarray_inline inline #end
    public static function setUint8( buffer:ArrayBuffer, byteOffset:Int, value:UInt ) : UInt {

        #if cpp
            untyped __global__.__hxcpp_memory_set_byte(buffer.getData(), byteOffset, value);
        #else
            buffer.set( byteOffset, value );
        #end

        return value;

    }

    public static  function getInt16( buffer:ArrayBuffer, byteOffset:Int, littleEndian:Bool=true ) : Int {

        #if cpp
            untyped return __global__.__hxcpp_memory_get_i16(buffer.getData(), byteOffset);
        #else
            var ch1 = buffer.get(byteOffset    );
            var ch2 = buffer.get(byteOffset + 1);

            var val =
                if(littleEndian)
                    ((ch2 << 8) | ch1) else
                    ((ch1 << 8) | ch2);

            return
                ((val & 0x8000) != 0) ?
                    ( val - 0x10000 ) : ( val );
        #end

    }

    public static function setInt16( buffer:ArrayBuffer, byteOffset:Int, value:Int, littleEndian:Bool=true ) {

        #if cpp
            untyped __global__.__hxcpp_memory_set_i16(buffer.getData(), byteOffset, value);
        #elseif neko
            untyped var b = buffer.b;
            if(littleEndian) {
                untyped __dollar__sset(b, byteOffset  , (value     ) & 0xff);
                untyped __dollar__sset(b, byteOffset+1, (value >> 8) & 0xff);
            } else {
                untyped __dollar__sset(b, byteOffset  , (value >> 8) & 0xff);
                untyped __dollar__sset(b, byteOffset+1, (value     ) & 0xff);
            }
        #else
            trace ("unimplemented");
        #end


        return value;

    }

    #if !no_typedarray_inline inline #end
    public static function getUint16( buffer:ArrayBuffer, byteOffset:Int, littleEndian:Bool=true ) : Null<UInt> {

        #if cpp
            untyped return __global__.__hxcpp_memory_get_ui16(buffer.getData(), byteOffset) & 0xffff;
        #else

            var ch1 = buffer.get(byteOffset    );
            var ch2 = buffer.get(byteOffset + 1);

            return
                if(littleEndian)
                    ((ch2 << 8) | ch1) else
                    ((ch1 << 8) | ch2);

        #end

    }

    #if !no_typedarray_inline inline #end
    public static function setUint16( buffer:ArrayBuffer, byteOffset:Int, value:UInt, littleEndian:Bool=true ) : UInt {

        #if cpp
            untyped __global__.__hxcpp_memory_set_ui16(buffer.getData(), byteOffset, value);
        #else
            setInt16(buffer, byteOffset, value, littleEndian);
        #end

        return value;

    }

    #if !no_typedarray_inline inline #end
    public static function getInt32( buffer:ArrayBuffer, byteOffset:Int, littleEndian:Bool=true ) : Int {

        #if cpp
            untyped return __global__.__hxcpp_memory_get_i32(buffer.getData(), byteOffset);
        #elseif neko
            return buffer.getI32( byteOffset );
        #else
            trace ("unimplemented");
            return 0;
        #end

    }

    #if !no_typedarray_inline inline #end
    public static function setInt32( buffer:ArrayBuffer, byteOffset:Int, value:Int, littleEndian:Bool=true ) {

        #if cpp
            untyped __global__.__hxcpp_memory_set_i32(buffer.getData(), byteOffset, value);
        #elseif neko
            buffer.setI32( byteOffset, value );
        #else
            trace ("unimplemented");
        #end

        return value;

    }

    #if !no_typedarray_inline inline #end
    public static function getUint32( buffer:ArrayBuffer, byteOffset:Int, littleEndian:Bool=true ) : Null<UInt> {

        #if cpp
            untyped return __global__.__hxcpp_memory_get_ui32(buffer.getData(), byteOffset);
        #elseif neko
            return buffer.getI32( byteOffset );
        #else
            trace ("unimplemented");
            return 0;
        #end

    }

    #if !no_typedarray_inline inline #end
    public static function setUint32( buffer:ArrayBuffer, byteOffset:Int, value:UInt, littleEndian:Bool=true ) : UInt {

        #if cpp
            untyped __global__.__hxcpp_memory_set_ui32(buffer.getData(), byteOffset, value);
        #elseif neko
            buffer.setI32( byteOffset, value );
        #else
            trace ("unimplemented");
        #end

        return value;

    }

    #if !no_typedarray_inline inline #end
    public static function getFloat32( buffer:ArrayBuffer, byteOffset:Int, littleEndian:Bool=true ) : Float {

        #if cpp
            untyped return __global__.__hxcpp_memory_get_float(buffer.getData(), byteOffset);
        #else
            return buffer.getFloat( byteOffset );
        #end

    }

    #if !no_typedarray_inline inline #end
    public static function setFloat32( buffer:ArrayBuffer, byteOffset:Int, value:Float, littleEndian:Bool=true ) : Float {

        #if cpp
            untyped __global__.__hxcpp_memory_set_float(buffer.getData(), byteOffset, value);
        #else
            buffer.setFloat( byteOffset, value );
        #end

        return value;

    }

    #if !no_typedarray_inline inline #end
    public static function getFloat64( buffer:ArrayBuffer, byteOffset:Int, littleEndian:Bool=true ) : Float {

        #if cpp
            untyped return __global__.__hxcpp_memory_get_double(buffer.getData(), byteOffset);
        #else
            return buffer.getDouble( byteOffset );
        #end

    }

    #if !no_typedarray_inline inline #end
    public static function setFloat64( buffer:ArrayBuffer, byteOffset:Int, value:Float, littleEndian:Bool=true ) : Float {

        #if cpp
            untyped __global__.__hxcpp_memory_set_double(buffer.getData(), byteOffset, value);
        #else
            buffer.setDouble( byteOffset, value );
        #end

        return value;

    }

//Internal

    #if !no_typedarray_inline inline #end
    //clamp a Int to a 0-255 Uint8 (for Uint8Clamped array)
    static function _clamp(_in:Float) : Int {

        var _out = Std.int(_in);
        _out = _out > 255 ? 255 : _out;
        return _out < 0 ? 0 : _out;

    } //_clamp

}