//
//  MainFetchable.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

protocol MainFetchable {
    func categoryList(request: CategoryListRequestModel, completion: @escaping (Result<CategoryListResponseModel, ApiError>) -> Void)
}
