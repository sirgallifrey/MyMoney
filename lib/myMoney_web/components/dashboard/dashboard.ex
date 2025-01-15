defmodule MyMoneyWeb.Dashboard do
  use MyMoneyWeb, :component

  import MyMoneyWeb.Dashboard.Menu

  def dashboard(assigns) do
    ~H"""
      <Sidebar.sidebar_provider>
        <.menu current_user={@current_user}></.menu>
        <Sidebar.sidebar_inset>
          <header class="flex h-16 shrink-0 items-center gap-2 border-b px-4">
            <Sidebar.sidebar_trigger target="main-sidebar" class="-ml-1">
              <%!-- <Lucideicons.panel_left class="w-4 h-4" /> --%>
            </Sidebar.sidebar_trigger>
            <Separator.separator orientation="vertical" class="mr-2 h-4"/>
            <Breadcrumb.breadcrumb>
              <Breadcrumb.breadcrumb_list>
                <Breadcrumb.breadcrumb_item class="hidden md:block">
                  <Breadcrumb.breadcrumb_link href="#">
                    Building Your Application
                  </Breadcrumb.breadcrumb_link>
                </Breadcrumb.breadcrumb_item>
                <Breadcrumb.breadcrumb_separator class="hidden md:block"/>

                <Breadcrumb.breadcrumb_item>
                  <Breadcrumb.breadcrumb_page>
                    Data Fetching
                  </Breadcrumb.breadcrumb_page>
                </Breadcrumb.breadcrumb_item>
              </Breadcrumb.breadcrumb_list>
            </Breadcrumb.breadcrumb>
          </header>
          <main class="px-4 py-20 sm:px-6 lg:px-8">
            <div class="mx-auto max-w-7xl">
              <.flash_group flash={@flash} />
              <%= render_slot(@inner_block) %>
            </div>
          </main>
        </Sidebar.sidebar_inset>
      </Sidebar.sidebar_provider>
    """
  end
end
