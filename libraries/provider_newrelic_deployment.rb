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

require 'chef/provider'

class Chef
  class Provider
    class NewrelicDeployment < Chef::Provider

      def initialize(new_resource, run_context = nil)
        @new_resource = new_resource
        @run_context = run_context

        super(new_resource, run_context)
      end

      def load_current_resource; end

      def whyrun_supported?
        true
      end

      def action_create
        r = Chef::Resource::Execute.new(
          "Record deployment of #{new_resource.name}",
          run_context
        )
        r.command curl_command
        r.run_action(:run)

        new_resource.updated_by_last_action(true) if r.updated_by_last_action?
      end

      def curl_command
        [
          "curl",
          "-H 'x-api-key:#{new_resource.api_key}'",
          "-d 'deployment[app_name]=#{new_resource.name}'",
          "-d 'deployment[description]=#{new_resource.description}'",
          "-d 'deployment[changelog]=#{new_resource.changelog}'",
          "-d 'deployment[revision]=#{new_resource.revision}'",
          "-d 'deployment[user]=#{new_resource.user}'",
          "https://api.newrelic.com/deployments.xml"
        ].join(' ')
      end
    end
  end
end
