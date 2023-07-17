//
//  PhotoListViewController.swift
//  PhotosChallenge
//
//  Created by Mohamed El Sawy on 15/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class PhotoListViewController: UIViewController {

    @IBOutlet weak var photosContainerView: UIView!
    @IBOutlet weak var photosTableView: UITableView!
    
    let photoTableViewCell = "PhotoTableViewCell"
    let photoListViewModel = PhotoListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindToHiddenTable()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToPhotoSelection()
        getPhotos()
    }
    func setupTableView() {
        photosTableView.register(UINib(nibName: photoTableViewCell, bundle: nil), forCellReuseIdentifier: photoTableViewCell)
        photosTableView.estimatedRowHeight = 44
        photosTableView.rowHeight = UITableView.automaticDimension
        photosTableView.translatesAutoresizingMaskIntoConstraints = false
        photosTableView.delegate = self
    }
    func bindToHiddenTable() {
        photoListViewModel.isTableHiddenObservable.bind(to: self.photosContainerView.rx.isHidden).disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        photoListViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        self.photoListViewModel.photosModelSubject
            .bind(to: self.photosTableView
                .rx
                .items(cellIdentifier: photoTableViewCell,
                       cellType: PhotoTableViewCell.self)) { row, photo, cell in
                // Add a fixed Ad Banner image every five cells.
                let index = row + 1
                if (index % 6 == 0 && index != 0) {
                    cell.singlePhoto.image = UIImage(named: "bannner")
                } else {
                    // Using KingFisher for Caching Images
                    let urlString = "http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
                    let imgURL = KF.ImageResource(downloadURL: URL(string: urlString)! , cacheKey: urlString)
                    cell.singlePhoto.kf.setImage(with: imgURL)
                }
            }.disposed(by: disposeBag)
    }
    func subscribeToPhotoSelection() {
        Observable
            .zip(photosTableView.rx.itemSelected, photosTableView.rx.modelSelected(Photo.self))
            .bind { [weak self] selectedIndex, photo in
                guard let self = self else { return }
                let urlString = "http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
                let vc = PhotoViewerViewController(with: URL(string: urlString)!)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    func getPhotos() {
        photoListViewModel.getData()
    }
}
// Using DataSource Prefetching For Handling Pagination
extension PhotoListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= photoListViewModel.totalPhotos.count - 3 && !photoListViewModel.isFetchingPhotos {
                getPhotos()
                break
            }
        }
    }
}
extension PhotoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
