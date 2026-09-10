import SwiftUI

struct ContentView: View {
    @State private var docURL: String = "https://disk.yandex.kz/i/rvROJJyrFbeAmg"
    @State private var isRunning = false
    @State private var status = "Отключено"

    var body: some View {
        VStack(spacing: 24) {
            Text("OpenFlux")
                .font(.system(size: 32, weight: .bold))
            
            TextField("URL Яндекс Документа", text: $docURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: toggleTunnel) {
                Text(isRunning ? "Остановить" : "Подключить")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isRunning ? Color.red : Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            Text(status)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
    }

    func toggleTunnel() {
        if !isRunning {
            isRunning = true
            status = "SOCKS5 запущен на 127.0.0.1:1080"
            DispatchQueue.global(qos: .background).async {
                if let cStr = strdup(docURL) {
                    RunMainClient(cStr)
                }
            }
        } else {
            isRunning = false
            status = "Для смены сессии перезапустите приложение"
        }
    }
}
