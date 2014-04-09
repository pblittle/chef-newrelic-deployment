# encoding: utf-8
#
# Author:: P. Barrett Little (<barrett@barrettlittle.com>)
#
# Copyright 2013, P. Barrett Little
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/resource'

class Chef
  class Resource
    class NewrelicDeployment < Chef::Resource

      def initialize(name, run_context = nil)
        super

        @resource_name = :newrelic_deployment
        @provider = Chef::Provider::NewrelicDeployment
        @action = :create
        @allowed_actions.push :create
      end

      def app_name(arg = nil)
        set_or_return(
          :app_name,
          arg,
          :kind_of => [String],
          :required => true,
          :name_attribute => true
        )
      end

      def api_key(arg = nil)
        set_or_return(
          :api_key,
          arg,
          :kind_of => [String],
          :required => true
        )
      end

      def changelog(arg = nil)
        set_or_return(
          :changelog,
          arg,
          :kind_of => [String]
        )
      end

      def description(arg = nil)
        set_or_return(
          :description,
          arg,
          :kind_of => [String]
        )
      end

      def environment(arg = nil)
        set_or_return(
          :environment,
          arg,
          :kind_of => [String]
        )
      end

      def revision(arg = nil)
        set_or_return(
          :revision,
          arg,
          :kind_of => [String]
        )
      end

      def user(arg = nil)
        set_or_return(
          :user,
          arg,
          :kind_of => [String]
        )
      end
    end
  end
end
