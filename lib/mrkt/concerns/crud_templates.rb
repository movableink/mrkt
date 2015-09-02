module Mrkt
  module CrudTemplates

    def get_folder_by_name(name)
      params = {}
      params[:name] = name

      get('/rest/asset/v1/folder/byName.json', params)
    end

    def create_landing_page_template(name, folder_id, description: nil)
      params = {}
      params[:name] = name
      params[:folder] = '{ "id": ' + folder_id.to_s + ', "type": "Folder" }'
      params[:description] = description if description

      post('/rest/asset/v1/landingPageTemplates.json', params)
    end

    def get_landing_page_templates
      get('/rest/asset/v1/landingPageTemplates.json')
    end

    def get_landing_page_template_by_id(id, status: nil)
      params = {}
      params[:status] = status if status

      get("/rest/asset/v1/landingPageTemplate/#{id}.json", params)
    end

    def get_landing_page_id_from_name(name)
      response = get_landing_page_templates
      template = response[:result].detect{ | r | r[:name] == name }
      template[:id]
    end

    def get_landing_page_template_by_name(name)
      get_landing_page_template_by_id(get_landing_page_id_from_name(name))
    end

    def update_landing_page_template_content(id, path_to_file, mime_type)
      url = "/rest/asset/v1/landingPageTemplate/#{id}/content.json"
      post(url, content: Faraday::UploadIO.new(path_to_file, mime_type))
    end

    def approve_landing_page(id)
      get("/rest/asset/v1/landingPageTemplate/#{id}/approveDraft.json")
    end

  end
end
