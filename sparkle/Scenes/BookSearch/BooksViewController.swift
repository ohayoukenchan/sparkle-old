//
//  BookSearchViewController.swift
//  sparkle
//45`
//  Created by  ohayoukenchan on 2020/06/12.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import UIKit
import TwitterKit
import ReSwift
import ReSwiftRouter
import RxSwift
import RxCocoa
import RxOptional
import Redux
import SparkleClient
import SVProgressHUD
import IGListKit

final class BooksViewController: UIViewController, HasWeakStateDisposeBag {
    let reduxStore: RxReduxStore
    typealias ThisState = BooksState
   // let state: Observable<AuthenticationState>
    let state: Observable<ThisState>
    weak var weakStateDisposeBag: RxSwift.DisposeBag? // For HasWeakStateDisposeBag

    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var didSetupConstraints = false

    private let disposeBag = DisposeBag()

    lazy var dataSource: DataSource = .init(reduxStore, disposeBag: disposeBag)
    lazy var adapter: IGListKit.ListAdapter = .init(updater: IGListKit.ListAdapterUpdater(), viewController: self)
    lazy var loadingViewController: LoadingViewController = .init()
    lazy var networkErrorViewController: NetworkErrorViewController = .init()
    lazy var serverErrorViewController: ServerErrorViewController = .init()
    lazy var unknownErrorViewController: UnknownErrorViewController = .init()
    lazy var refreshControl: UIRefreshControl = .init()

    init(reduxStore: RxReduxStore, state: Observable<ThisState>, disposeBag: RxSwift.DisposeBag) {
        self.reduxStore = reduxStore
        self.state = state
        self.weakStateDisposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
        initLog()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        deinitLog()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        print("\(self.state)DDDDDDDDDDDDDDDDDDDDDDDDDDDDD")
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1.0)
        collectionView.refreshControl = refreshControl

        addChildHelper(networkErrorViewController)
        addChildHelper(loadingViewController)
        addChildHelper(serverErrorViewController)
        addChildHelper(unknownErrorViewController)

        adapter.collectionView = collectionView
        adapter.rx.setDataSource(dataSource).disposed(by: disposeBag)

        view.setNeedsUpdateConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension BooksViewController {
    final class DataSource: AdapterDataSource {
        override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
            switch object {
            case let o as DiffableWrap<TitleSectionController.Element>:
                return TitleSectionController(o, reduxStore: reduxStore, disposeBag: disposeBag)
            case let o as DiffableWrap<NoticeSectionController.Element>:
                return NoticeSectionController(o, reduxStore: reduxStore, disposeBag: disposeBag)
            case let o as DiffableWrap<RepositoryHeaderSectionController.Element>:
                return RepositoryHeaderSectionController(o, reduxStore: reduxStore, disposeBag: disposeBag)
            case let o as DiffableWrap<PublicRepositorySectionController.Element>:
                return PublicRepositorySectionController(o, reduxStore: reduxStore, disposeBag: disposeBag)
            case let o as DiffableWrap<AdvertisingSectionController.Element>:
                return AdvertisingSectionController(o, reduxStore: reduxStore, disposeBag: disposeBag)
            case let o as DiffableWrap<ShowMoreRepositorySectionController.Element>:
                return ShowMoreRepositorySectionController(o, reduxStore: reduxStore, disposeBag: disposeBag)
            default:
                assertionFailureUnreachable(); return SpaceBoxSectionController()
            }
        }
    }
}


//class SplashViewController: UIViewController, Routable {
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        //store.subscribe(self)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        fooButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
//            print("HOOOOOOOO")
//            //store.dispatch(SplashState.routesChange())
//        }).disposed(by: self.disposeBag)
//
//
//        counterUpButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
//            print("SSSSSSS")
//            //store.dispatch(increase)
//            //store.dispatch(CounterState.counterActionIncrease())
//        }).disposed(by: self.disposeBag)
//
//
//        counterDownButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
//            //store.dispatch(CounterState.counterActionDecrease())
//            //store.dispatch(decrease)
//        }).disposed(by: self.disposeBag)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        //store.unsubscribe(self)
//    }
//
//}
//
////extension SplashViewController: StoreSubscriber {
////
////    typealias StoreSubscriberStateType = AppState
////
////    func newState(state: AppState) {
////
////        switch state.viewState.currentViewState {
////            case .Requesting:
////                SVProgressHUD.sparkle.show()
////            case .Working:
////                SVProgressHUD.dismiss()
////            case .Blank:
////                print("aaa")
////            case .Error(_):
////                print("aaa")
////        }
////
////        if (state.searchBooksState.books.count > 0) {
////            currentViewStateLabel.text = state.searchBooksState.books[0].title
////        }
////        counterLabel.text = "\(state.counterState.counter)"
////    }
////}
