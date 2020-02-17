defmodule DigitalPublicWorksWeb.PageControllerTest do
  use DigitalPublicWorksWeb.ConnCase

  describe "index" do
    test "shows featured projects", %{conn: conn} do
      title = "Featured Title"
      insert(:project, %{title: title, is_featured: true})

      conn = get(conn, Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ title
    end

    test "doesn't show non featured projects", %{conn: conn} do
      title = "Non-Featured Title"
      insert(:project, %{title: title})

      conn = get(conn, Routes.page_path(conn, :index))
      assert !(html_response(conn, 200) =~ title)
    end
  end
end
