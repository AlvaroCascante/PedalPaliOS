import SwiftUI

struct AppointmentsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Appointments")
                .font(.largeTitle)
                .bold()

            NavigationLink("View appointment") {
                VStack {
                    Text("Appointment Details")
                    Text("This is a placeholder detail view for Appointments tab.")
                }
                .navigationTitle("Appointment Details")
                .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Appointments")
    }
}

struct AppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppointmentsView()
        }
    }
}
