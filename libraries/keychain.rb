module Logstash
  module Keychain
    # Grab the content of any keys matching the given group_name for the environment. We treat the _default 
    # environment as a global namespace, so if there are any keys with the same group_name there (that aren't
    # overridden by keys of the same name in the node's environment), they will be included.
    #
    # Examples (run from a "dev" environment):
    #
    #   _default: { name:key1, group:x, content:"AAAA" }, { name:key2, group:x, content:"BBBB" }
    #  >>> keychain_key_for_group("x") => "AAAA\nBBBB"
    #
    #  _default: { name:key1, group:x, content:"AAAA" }, { name:key2, group:x, content:"BBBB" }
    #  dev: { name:key3, group:x, content:"CCCC" }
    #  >>> keychain_key_for_group("x") => "AAAA\nBBBB\nCCCC"
    #
    #  _default: { name:key1, group:x, content:"AAAA" }, { name:key2, group:x, content:"BBBB" }
    #  dev: { name:key3, group:x, content:"CCCC" }, { name: key2, group:x, content:"FFFF" }
    #  >>> keychain_key_for_group("x") => "AAAA\nFFFF\nCCCC"
    def keychain_key_for_group(group_name)
      keychain_key_with("group:#{group_name}")
    end

    def keychain_key_by_name(name)
      keychain_key_with("name:#{name}")
    end
    
    def keychain_key_with(condition)
      found_keys = {}

      ["_default", node.chef_environment].uniq.each do |current_environment|
        search(:keychain, "chef_environment:#{current_environment} AND #{condition}").each do |key_record|
          key = Chef::EncryptedDataBagItem.load(:keychain_keys, key_record.id)
          found_keys[key_record['name']] = key["content"]
        end
      end

      found_keys.values.join("\n")
    end
    
    def keychain_password(username)
      search(:keychain, "chef_environment:#{node.chef_environment} AND group:admin-passwords AND name:#{username}").map do |password_record|
        databag = Chef::EncryptedDataBagItem.load(:keychain_keys, password_record.id)
        password = databag["content"].strip
      end.first
    end
  end
end