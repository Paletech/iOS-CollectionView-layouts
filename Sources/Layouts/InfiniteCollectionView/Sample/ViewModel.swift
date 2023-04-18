import Foundation

class ViewModel {
    
    var sections = Bundle.main.decode([MSection].self, from: "model.json")
    
    init() {}
    
    func getFirstModel() -> SectionDataSource<MChat, WaitingChatCell> {
        let firstOne = SectionDataSource(layout: Layout.firstSection(),
                             data: sections[0].items,
                             imitateInfinityCount: 10,
                             cell: WaitingChatCell.self) { item, cell in
                            cell.configure(with: item)}
        return firstOne
    }
    
    func getSecondModel() -> SectionDataSource<MChat, ActiveChatCell> {
        let secondOne = SectionDataSource(layout: Layout.secondSection(),
                             data: sections[1].items,
                             cell: ActiveChatCell.self) { item, cell in
                            cell.configure(with: item)}
        return secondOne
    }
}
