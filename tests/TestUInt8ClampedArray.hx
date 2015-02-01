
import typedarray.ArrayBuffer;
import typedarray.Uint8ClampedArray;

/**
    Copyright Sven Bergström, Thomas Hourdel 2014
    Created for snow https://github.com/underscorediscovery/snow
    License MIT
**/

class TestUInt8ClampedArray extends mohxa.Mohxa {

    public function new() {

        super();

        describe('Uint8ClampedArray test01', function(){

            log('creating Uint8ClampedArray of 3 elements');

            var x = new Uint8ClampedArray(3);

            log('setting [0] to -17');
            log('setting [1] to 93');
            log('setting [2] to 350');

            x[0] = -17;
            x[1] = 93;
            x[2] = 350;

            it('should be correctly constructed from n elements and set using Array Access, but clamped (no < 0 and no > 255)', function(){
                equal( 0, x[0], 'element [0] == 0' );
                equal( 93, x[1], 'element [1] == 93' );
                equal( 255, x[2], 'element [2] == 255' );
                equal( 3, x.length, 'length == 3' );
            });

        }); //test01

        describe('Uint8ClampedArray test02', function(){

            log('creating Uint8ClampedArray from array of 2 [17,-45.3]');

            var x = Uint8ClampedArray.fromArray([17, -45.3]);

            it('should be correctly constructed from array of Int, clamping negative value', function(){
                equal( 17, x[0], 'element [0] == 17' );
                equal( 0, x[1], 'element [1] == 0' );
                equal( 2, x.length, 'length == 2' );
            });

        }); //test02

        describe('Uint8ClampedArray test03', function(){

            log('creating Uint8ClampedArray x from array of 2 [17,-45.3]');
            log('creating second Uint8ClampedArray y from first array .buffer');

            var x = Uint8ClampedArray.fromArray([17, -45.3]);
            var y = Uint8ClampedArray.fromBuffer(x.buffer);

            it('should share a buffer from other array buffer, wrapped value', function(){

                equal(17, x[0], 'x element [0] == 17');
                equal(0, x[1], 'x element [1] == 0');
                equal(2, x.length, 'x length == 2');

                equal(17, y[0], 'y element [0] == 17');
                equal(0, y[1], 'y element [1] == 0');
                equal(2, y.length, 'y length == 2');

                log('setting x element [0] to -2');

                x[0] = -2;

                equal(0, y[0], 'y element [0] == 0');

            });

        }); //test3

        describe('Uint8ClampedArray test04', function(){

            log('creating Uint8ClampedArray x from array of 2 [17,-45.3]');
            log('creating second Uint8ClampedArray y from first array itself');

            var x = Uint8ClampedArray.fromArray([17, -45.3]);
            var y = Uint8ClampedArray.fromTypedArray(x);

            it('should share a buffer from other array', function(){

                equal(17, x[0], 'x element [0] == 17');
                equal(0, x[1], 'x element [1] == 0');
                equal(2, x.length, 'x length == 2');

                equal(17, y[0], 'y element [0] == 17');
                equal(0, y[1], 'y element [1] == 0');
                equal(2, y.length, 'y length == 2');

                log('setting x element [0] to -2');

                x[0] = -2;

                equal(17, y[0], 'y element [0] == 17');

            });

        }); //test4

        describe('Uint8ClampedArray test05', function(){

            log('creating ArrayBuffer(12) and x,y as Uint8ClampedArray with buffer and mapping');

            var buffer = new ArrayBuffer(12);
            var x = Uint8ClampedArray.fromBuffer(buffer, 0, 2);
            var y = Uint8ClampedArray.fromBuffer(buffer, 4, 1);

            log('setting x[1] = 7');

                x[1] = 7;

            it('should construct from shared ArrayBuffer and have values mapped', function(){

                equal(0, y[0], 'y element 0 == 0');

            });

        }); //test5

        describe('Uint8ClampedArray test06', function(){

            log('creating Uint8ClampedArray(10)');

            var x = new Uint8ClampedArray(10);

            log('calling set([18,93,42],3)');

            x.setFromArray([18, 93, 42], 3);

            it('should set from normal int array', function(){

                equal(18, x[3], 'x[3] == 18');
                equal(93, x[4], 'x[4] == 93');
                equal(42, x[5], 'x[5] == 42');

            });

        }); //test6

        describe('Uint8ClampedArray test07', function(){

            log('creating Uint8ClampedArray(10)');

            var x = new Uint8ClampedArray(10);

            log('calling set(Uint8ClampedArray.fromArray([18, 93, 42]), 3)');

            x.set(Uint8ClampedArray.fromArray([18, 93, 42]), 3);

            it('should set from other Uint8ClampedArray', function(){

                equal(18, x[3], 'x[3] == 18');
                equal(93, x[4], 'x[4] == 93');
                equal(42, x[5], 'x[5] == 42');

            });

        }); //test7

        describe('Uint8ClampedArray test08', function(){

            log('creating x = Uint8ClampedArray([0, 1, 2, 3, 4, 5])');

            var x = Uint8ClampedArray.fromArray([0, 1, 2, 3, 4, 5]);

            log('creating y = x.subarray(2,5)');

            var y = x.subarray(2, 5);

            it('Show map correctly as a buffer view, wrapping values', function(){

                equal(3, y.length, 'y.length == 3');
                equal(2, y[0], 'y[0] == 2');
                equal(3, y[1], 'y[1] == 3');

                log('setting y[0] = -1');

                y[0] = -1;

                equal(0, x[2], 'x[2] == 0');

            });

        }); //test8

    } //new

} //TestUInt8ClampedArray
