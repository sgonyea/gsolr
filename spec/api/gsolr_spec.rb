describe GSolr do
  
  context :connect do
    
    it 'does not care about valid/live URLs yet' do
      lambda{GSolr.connect :url=>'http://blah.blah.blah:666/solr'}.should_not raise_error
    end
    
    it 'should create an instance of GSolr::Connection::NetHttp as the #connection' do
      expected_class = GSolr::Connection::NetHttp
      GSolr.connect.connection.should be_a(expected_class)
      GSolr.connect(:url=>'blah').connection.should be_a(expected_class)
    end
    
  end
  
  context :escape do
  
    it "should escape properly" do
      GSolr.escape('Trying & % different "characters" here!').should == "Trying\\ \\&\\ \\%\\ different\\ \\\"characters\\\"\\ here\\!"
    end
  
    it 'should escape' do
      expected = "http\\:\\/\\/lucene\\.apache\\.org\\/solr"
      GSolr.escape("http://lucene.apache.org/solr").should == expected
    end
  end
  
end