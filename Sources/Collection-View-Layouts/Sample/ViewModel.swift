import Collection_View_Layouts
import Foundation

class ViewModel {
    
    var sections = Bundle.main.decode([MSection].self, from: "model.json")
    
    init() {}
    
    func getFirstModel() -> Model<MChat, WaitingChatCell> {
        let firstOne = Model(layout: Layout.firstSection(),
                             data: sections[0].items,
                             infinite: true,
                             cell: WaitingChatCell.self) { item, cell in
                            cell.configure(with: item)}
        return firstOne
    }
    
    func getSecondModel() -> Model<MChat, ActiveChatCell> {
        let secondOne = Model(layout: Layout.secondSection(),
                             data: sections[1].items,
                             infinite: false,
                             cell: ActiveChatCell.self) { item, cell in
                            cell.configure(with: item)}
        return secondOne
    }
}
