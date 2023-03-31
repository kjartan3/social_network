require 'user_repository'
require 'user'

describe UserRepository do
  def reset_social_network_table
      seed_sql = File.read('spec/seeds_sn.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
      connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_social_network_table
  end

  it "Gets all users" do
    repo = UserRepository.new

    all_users = repo.all
    
    expect(all_users.length).to eq 2

    expect(all_users[0].id).to eq 1
    expect(all_users[0].username).to eq 'John'
    expect(all_users[0].email).to eq 'John@mail.com'

    expect(all_users[1].id).to eq 2
    expect(all_users[1].username).to eq 'Terry'
    expect(all_users[1].email).to eq 'Terry@mail.com'
  end

  it "Gets a single user" do
    repo = UserRepository.new

    user = repo.find(1)
    
    expect(user.id).to eq 1
    expect(user.username).to eq 'John'
    expect(user.email).to eq 'John@mail.com'
  end

  it "Creates a new user" do
    repo = UserRepository.new

    new_user = User.new
    new_user.username = 'Bishop'
    new_user.email = 'Bishop@mail.com'

    repo.create(new_user)
    
    user = repo.find(3)
    
    expect(user.id).to eq 3
    expect(user.username).to eq 'Bishop'
    expect(user.email).to eq 'Bishop@mail.com'
  end

  it "Deletes a user" do
    repo = UserRepository.new
    repo.delete(1)
    
    all_users = repo.all

    expect(all_users.length).to eq 1
  end
end
