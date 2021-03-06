module SpreeShopifyImporter
  module Importers
    class ReturnAuthorizationImporter < BaseImporter
      def initialize(shopify_refund, parent_feed, spree_order)
        @shopify_refund = shopify_refund
        @parent_feed = parent_feed
        @spree_order = spree_order
      end

      def import!
        data_feed = process_data_feed

        creator.new(data_feed, @spree_order).create
      end

      private

      def create_data_feed
        SpreeShopifyImporter::DataFeeds::Create.new(@shopify_refund, @parent_feed).save!
      end

      def update_data_feed(old_data_feed)
        SpreeShopifyImporter::DataFeeds::Update.new(old_data_feed, @shopify_refund, @parent_feed).update!
      end

      def creator
        SpreeShopifyImporter::DataSavers::ReturnAuthorizations::ReturnAuthorizationCreator
      end

      def shopify_object
        @shopify_refund
      end
    end
  end
end
