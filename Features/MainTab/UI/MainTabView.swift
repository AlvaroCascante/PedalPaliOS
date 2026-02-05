import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeNavContainer()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            AppointmentsNavContainer()
                .tabItem {
                    Label("Appointments", systemImage: "calendar")
                }
                .tag(1)

            BikesNavContainer()
                .tabItem {
                    Label("Bikes", systemImage: "bicycle")
                }
                .tag(2)

            ProfileNavContainer()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(3)
        }
    }
}

// Small container wrappers that provide a NavigationStack per tab.
// Each feature's primary view lives in its own module/file.

struct HomeNavContainer: View {
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}

struct AppointmentsNavContainer: View {
    var body: some View {
        NavigationStack {
            AppointmentsView()
        }
    }
}

struct BikesNavContainer: View {
    var body: some View {
        NavigationStack {
            BikesView()
        }
    }
}

struct ProfileNavContainer: View {
    var body: some View {
        NavigationStack {
            ProfileView()
        }
    }
}

// MARK: - Previews

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
