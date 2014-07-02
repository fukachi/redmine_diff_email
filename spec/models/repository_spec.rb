require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Repository do

  before :all do
    @project_parent = FactoryGirl.create(:project, :identifier => 'project1')
  end

  context "common_tests" do
    before do
      @repository = FactoryGirl.create(:repository, :project_id => @project_parent.id, :is_default => true)
    end

    subject { @repository }

    ## Test attributes
    it { should be_valid }

    it { should respond_to(:is_diff_email) }
    it { should respond_to(:is_diff_email_attached) }


    it "should have diff_email disabled" do
      expect(@repository.is_diff_email).to be false
    end


    it "should have diff_email_attached disabled" do
      expect(@repository.is_diff_email_attached).to be false
    end


    describe "when is_diff_email is true" do
      before do
        @repository.is_diff_email = true
        @repository.save
      end

      it "should have diff_email enabled" do
        expect(@repository.is_diff_email).to be true
      end
    end


    describe "when is_diff_email_attached is true" do
      before do
        @repository.is_diff_email_attached = true
        @repository.save
      end

      it "should have diff_email_attached enabled" do
        expect(@repository.is_diff_email_attached).to be true
      end
    end

  end

end
