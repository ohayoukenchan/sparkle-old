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
    typealias ThisState = BooksState
    weak var weakStateDisposeBag: RxSwift.DisposeBag? // For HasWeakStateDisposeBag
    let reduxStore: ReduxStoreType
    let state: Observable<ThisState>


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
        reduxStore.dispatch(DisposeAction(disposeBag))
        deinitLog()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1.0)
        collectionView.refreshControl = refreshControl

//        addChildHelper(networkErrorViewController)
//        addChildHelper(loadingViewController)
//        addChildHelper(serverErrorViewController)
//        addChildHelper(unknownErrorViewController)

        adapter.collectionView = collectionView
        adapter.rx.setDataSource(dataSource).disposed(by: disposeBag)

        state
            .bind(to: Binder(self) { $0.applyState($1) })
            .disposed(by: disposeBag)
        state
            .map { $0.dataSourceElements }
            .bind(to: adapter.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        state
            .map { $0.shouldShowRefreshing }
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        state
            .map { $0.shouldRequestTrigger }
            .distinctUntilChanged()
            .filterNil()
            .bind(to: Binder(self) { $0.request($1.connectionType) })
            .disposed(by: disposeBag)
        state
            .map { $0.shouldShowErrorNotificationTrigger }
            .distinctUntilChanged()
            .filterNil()
            .bind(to: Binder(self) { $0.showErrorNotification($1) })
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: Binder(self) { me, _ in me.refreshReload() })
            .disposed(by: disposeBag)

//        networkErrorViewController.retryButton.rx.tap
//            .bind(to: Binder(self) { me, _ in me.request(.initialRequest) })
//            .disposed(by: disposeBag)

        request(.initialRequest)
        reduxStore.dispatch(FavoritesState.Action.loadFavoritesActionCreator())

        view.setNeedsUpdateConstraints()
    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }

    func request(_ connectionType: ConnectionType) {
        reduxStore.dispatch(
            ThisState.Action.requestAsyncCreator(
                connectionType: connectionType,
                disposeBag: disposeBag
            )
        )
    }

    func refreshReload() {
        reduxStore.dispatch(
            ThisState.Action.requestAsyncCreator(
                connectionType: .refreshReload,
                disposeBag: disposeBag
            )
        )
    }

    func applyState(_ state: ThisState) {
        loadingViewController.view.isShown = state.shouldShowLoading
        networkErrorViewController.view.isShown = state.shouldShowNetworkError
        serverErrorViewController.view.isShown = state.shouldShowServerError
        unknownErrorViewController.view.isShown = state.shouldShowUnknownError
    }

    func showErrorNotification(_ trigger: ErrorNotificationTrigger) {
        errorNotificationViewController.show(with: trigger.message) // UIViewController+Ex
    }

    override func updateViewConstraints() {
        if didSetupConstraints == false {
            constraintToSafeAreaLayoutGuideAnchorHelper(from: collectionView, to: view)
            didSetupConstraints = true
        }
        super.updateViewConstraints()
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
