//
//  K.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation

struct K {
    static let AppEnvironmentDEV = "DEV"
    static let AppEnvironmentPROD = "PROD"
    static let AppEnvironmentQA = "QA"
    static let AppEnvironmentUAT = "UAT"
    
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apiKey = "ab65056aec4718c09214d4a7eccd5880"
    
    
    struct Common {
        static let inactivitySeconds = 100
        static let secondsToExtend = 30
        static let secondsToRenewToken = 30
        static let isProductionEnv = false
        static let maximumPaymentAmount = 9999.00
        static let minimumPaymentAmount = 1.00
        static let paymentMaxDigitsAmount = 7
        static let cardValidationChargeAmount = 1.00
        static let labelConfidenceThreshold = 0.35
        static let recurrentChargesMaxMonths = 96
        static let minExpirationDateEmailPayment = 7
        static let defaultMinimumPurchaseAmount = 8.00
        static let toastTime = 1.5
        static let toastTimeLong = 2.0
        
        static let allowedCharacters = " abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789áéíóúüÁÉÍÓÚÜ_-.,"
        static let allowedCharactersEnglishAlphanumeric = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        static let allowedCharactersNames = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let allowedCharactersNoAccents = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        static let allowedCharactersAddress = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.,#"
        static let allowedCharactersEmail = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@_.-"
        static let allowedCharactersUsername = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        static let allowedCharactersPassword = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$&"
        static let allowedCharactersNumber = "0123456789"
        static let passwordRequiredSpecialCharacters = "@.,$!%*?&"
        static let notAllowedCharacters = "-/:;()'\"[]{}#^+¡=_|~<>€£¥¿•©®™✓÷×*π∞≈°—–’“”‘’„‹›«»\\`§₩₽¢…"
        static let defaultLatitude = 13.7012319
        static let defaultLongitude = -89.2246634
    }
    
    static var screenWidth: CGFloat = 0
    
    static let dateFormatApp = "MM-yyyy"
    static let dateFormatDisplay = "dd/MM/yyyy"
    static let dateFormatDisplayShort = "dd/MM/yy"
    static let dateFormatServer = "yyyy-MM-dd'T'HH:mm:ss"
    static let dateFormatAppMask = "##-####"
    static let appMinDate = "01-01-1900"
    
    static let googleMapsApiKey = "AIzaSyAyYAQkiGzGLlWK9yLN9sMFeHxRNdhCxZc"
    static let geocodingURL = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    struct Dimmensions {
        static let textFieldHeight : CGFloat = 45.0
        static let buttonHeight: CGFloat = 45.0
    }
    
    struct UserDefaultsKeys {
        static let minPurchaseAmount = "minimumPurchaseAmount"
    }
}
