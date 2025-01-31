require "active_support"
require "rails/engine"
require "scaffolding"

module BulletTrain
  module SuperScaffolding
    class Engine < ::Rails::Engine
      initializer "bullet_train.super_scaffolding.register_template_path" do |app|
        # Templates from the application itself should always be highest priority.
        # This allows application developers to locally overload any template from any package.
        BulletTrain::SuperScaffolding.template_paths << Rails.root.to_s
      end

      initializer "bullet_train.super_scaffolding.templates.register_api_endpoints" do |app|
        if defined?(BulletTrain::Api)
          BulletTrain::Api.endpoints << "Api::V1::Scaffolding::AbsolutelyAbstract::CreativeConceptsEndpoint"
          BulletTrain::Api.endpoints << "Api::V1::Scaffolding::CompletelyConcrete::TangibleThingsEndpoint"
        end
      end

      initializer "bullet_train.super_scaffolding.register" do |app|
        # Older versions of Bullet Train have a `BulletTrain` module, but it doesn't have `linked_gems`.
        if BulletTrain.respond_to?(:linked_gems)
          BulletTrain.linked_gems << "bullet_train-super_scaffolding"
        end
      end
    end
  end
end
