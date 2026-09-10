import SwiftUI

struct ContentView: View {
    @State private var docURL: String = "https://disk.yandex.kz/i/rvROJJyrFbeAmg"
    @State private var isRunning = false
    @State private var statusLog = "Туннель остановлен"

    var body: some View {
        VStack(spacing: 20) {
            Text("OpenFlux Client")
                .font(.largeTitle)
                .bold()

            TextField("URL документа Yandex", text: $docURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: toggleTunnel) {
                Text(isRunning ? "Остановить" : "Запустить туннель")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isRunning ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Text(statusLog)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }

    func toggleTunnel() {
        if !isRunning {
            isRunning = true
            statusLog = "SOCKS5 запущен на 127.0.0.1:1080"
            DispatchQueue.global(qos: .background).async {
                if let cUrl = strdup(docURL) {
                    RunMainClient(cUrl)
                }
            }
        } else {
            isRunning = false
            statusLog = "Перезапустите приложение для смены сессии"
        }
    }
}
