//
//  PhotoListViewModel.swift
//  PhotosChallenge
//
//  Created by Mohamed El Sawy on 15/07/2023.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class PhotoListViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    var photosModelSubject = BehaviorRelay<[Photo]>(value: [])
    
    private var currentPage = 1
    var isFetchingPhotos = false
    var totalPhotos = [Photo]()
    
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }

    func getData() {
        isFetchingPhotos = true
        let params = ["method": "flickr.photos.search", "format": "json", "nojsoncallback": "50", "text": "Color", "page": "\(currentPage)", "per_page": "20", "api_key": "d17378e37e555ebef55ab86c4180e8dc"]
        APIService.instance.getData(NConstants.photoSearch ,PhotoModel.self ,params, URLEncoding(destination: .methodDependent)) { [weak self] (response, error) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            print("🚀 Call Page number : \(self.currentPage)")
            if let error = error {
                print(error)
            } else {
                guard let photosModel = response else { return }
                if photosModel.photos?.photo.count ?? 0 > 0 {
                    self.totalPhotos = photosModel.photos?.photo ?? []
                    self.photosModelSubject.accept(self.photosModelSubject.value + (photosModel.photos?.photo ?? []))
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
            // For Handling Pagination 
            self.currentPage += 1
            self.isFetchingPhotos = false
        }
    }
}
