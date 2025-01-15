defmodule MyMoneyWeb.Dashboard.Menu do
  use MyMoneyWeb, :component

  # alias MyMoneyWeb.Component.Sidebar, as: Sidebar

  @data %{
    menu_items: [
      %{
        title: "Transactions",
        url: "/transactions"
      }
    ]
  }

  def get_data, do: @data

  def menu(assigns) do
    ~H"""
    <Sidebar.sidebar collapsible="icon" id="main-sidebar" class="bg-primary text-white">
      <Sidebar.sidebar_header></Sidebar.sidebar_header>
      <Sidebar.sidebar_content>
        <.nav_main items={get_data().menu_items} />
      </Sidebar.sidebar_content>
      <Sidebar.sidebar_footer>
        <.nav_user user={@current_user} />
      </Sidebar.sidebar_footer>
      <Sidebar.sidebar_rail />
    </Sidebar.sidebar>
    """
  end

  def nav_main(assigns) do
    ~H"""
    <Sidebar.sidebar_menu :for={item <- @items}>
      <Sidebar.sidebar_menu_button tooltip={item.title}>
        <.icon name="hero-academic-cap" type="outline" class="h-4 w-4" />
        <span>
          <%= item.title %>
        </span>
      </Sidebar.sidebar_menu_button>
    </Sidebar.sidebar_menu>
    """
  end

  def nav_user(assigns) do
    ~H"""
    <Sidebar.sidebar_menu>
      <Sidebar.sidebar_menu_item>
        <DropdownMenu.dropdown_menu class="block">
          <.as_child
            tag={&DropdownMenu.dropdown_menu_trigger/1}
            child={&Sidebar.sidebar_menu_button/1}
            size="lg"
            class="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
          >
            <Avatar.avatar class="h-8 w-8 rounded-lg">
              <%!-- <Avatar.avatar_image src={@user.avatar} alt={@user.email} /> --%>
              <Avatar.avatar_fallback class="rounded-lg">
                CN
              </Avatar.avatar_fallback>
            </Avatar.avatar>
            <div class="grid flex-1 text-left text-sm leading-tight">
              <span class="truncate font-semibold">
                <%= @user.id %>
              </span>
              <span class="truncate text-xs">
                <%= @user.email %>
              </span>
            </div>
            <%!-- <.chevrons_up_down class="ml-auto size-4" /> --%>
          </.as_child>
          <DropdownMenu.dropdown_menu_content
            class="w-[--radix-dropdown-menu-trigger-width] min-w-56 rounded-lg"
            side="top"
            align="end"
          >
            <Menu.menu>
              <Menu.menu_label class="p-0 font-normal">
                <div class="flex items-center gap-2 px-1 py-1.5 text-left text-sm">
                  <Avatar.avatar class="h-8 w-8 rounded-lg">
                    <Avatar.avatar_image src="{user.avatar}" alt="{user.name}" />
                    <Avatar.avatar_fallback class="rounded-lg">
                      CN
                    </Avatar.avatar_fallback>
                  </Avatar.avatar>
                  <div class="grid flex-1 text-left text-sm leading-tight">
                    <span class="truncate font-semibold">
                      <%= @user.id %>
                    </span>
                    <span class="truncate text-xs">
                      <%= @user.email %>
                    </span>
                  </div>
                </div>
              </Menu.menu_label>
              <Menu.menu_separator></Menu.menu_separator>
              <.link href={~p"/users/settings"} class="">
                <Menu.menu_item>
                  Settings
                </Menu.menu_item>
              </.link>
              <Menu.menu_separator></Menu.menu_separator>
              <.link href={~p"/users/log_out"} method="delete">
                <Menu.menu_item>
                  Log out
                </Menu.menu_item>
              </.link>
            </Menu.menu>
          </DropdownMenu.dropdown_menu_content>
        </DropdownMenu.dropdown_menu>
      </Sidebar.sidebar_menu_item>
    </Sidebar.sidebar_menu>
    """
  end
end
