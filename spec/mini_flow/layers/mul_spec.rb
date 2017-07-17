module MiniFlow
  module Layers

    describe Mul do
      describe "on forward 2 values" do
        before(:each) do
          @x, @y= Input.new, Input.new
          @mul= Mul.new(@x, @y)
        end

        it "should return 2 if feeded 1 and 2" do
          @x.value= 1; @y.value= 2
          rs= @mul.forward
          expect(rs).to equal(2)
        end
        it "should return 24 if feeded 6 and 4" do
          @x.value= 6; @y.value= 4
          rs= @mul.forward
          expect(rs).to equal(24)
        end
        it "should return 625 if feeded 25 and -25" do
          @x.value= -25; @y.value= 25
          rs= @mul.forward
          expect(rs).to equal(-625)
        end

      end
    end

  end
end
