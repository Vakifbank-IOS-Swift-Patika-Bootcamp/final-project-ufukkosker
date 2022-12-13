//
//  MainDataProviderProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

protocol MainDataProviderProtocol {
    func fetchCategoryList(request: CategoryListRequestModel, completion: @escaping (Result<CategoryListResponseModel, ApiError>) -> Void)
}
