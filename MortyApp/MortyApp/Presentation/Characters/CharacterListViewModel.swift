import Foundation
import Combine

@MainActor
final class CharacterListViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    @Published var selectedStatus: String = ""
    @Published var selectedSpecies: String = ""
    
    private let useCase: GetCharactersUseCase
    private var page = 1
    
    private var searchTask: Task<Void, Never>?
    
    init(useCase: GetCharactersUseCase) {
        self.useCase = useCase
    }
    
    func initialLoad() async {
        page = 1
        characters = []
        await loadCharacters(reset: true)
    }

    func loadCharacters(reset: Bool = false) async {
        if isLoading { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let newCharacters = try await useCase.execute(
                page: page,
                name: searchText.isEmpty ? nil : searchText,
                status: selectedStatus.isEmpty ? nil : selectedStatus,
                species: selectedSpecies.isEmpty ? nil : selectedSpecies
            )
            if reset {
                characters = newCharacters
            } else {
                characters.append(contentsOf: newCharacters)
            }
            
            page += 1
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func loadNextPage() async {
        await loadCharacters()
    }
    
    func search() {
        searchTask?.cancel()
        
        let currentText = searchText
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 400_000_000)
            
            if Task.isCancelled { return }
            
            await MainActor.run {
                self.page = 1
                self.characters = []
                self.errorMessage = nil
                self.isLoading = false
            }
            
            await loadCharacters(reset: true)
        }
    }

    func refresh() async {
        searchTask?.cancel()
        
        page = 1
        characters = []
        errorMessage = nil
        
        await loadCharacters(reset: true)
    }
}
