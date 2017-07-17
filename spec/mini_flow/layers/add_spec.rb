module MiniFlow
  module Layers

    describe Add do
      describe "on forward 2 values" do
        before(:each) do
          @x, @y= Input.new, Input.new
          @add = Add.new(@x, @y)
        end

        it "should return 2 if feeded 1 and 1" do
          @x.value= 1; @y.value= 1
          rs= @add.forward
          expect(rs).to equal(2)
        end
        it "should return 13 if feeded 10 and 3" do
          @x.value= 10; @y.value= 3
          rs= @add.forward
          expect(rs).to equal(13)
        end
        it "should return 0 if feeded 25 and -25" do
          @x.value= -25; @y.value= 25
          rs= @add.forward
          expect(rs).to equal(0)
        end

      end
      describe "on forward 3 values" do
        before(:each) do
        end

        it "should return 13 if feeded 10 and 3" do
          @x, @y, @z= Input.new, Input.new, Input.new
          @add = Add.new(@x, @y, @z)

          @x.value, @y.value, @z.value= 11, 22, 33
          rs= @add.forward

          expect(rs).to equal(66)
        end

      end
    end

  end
end
