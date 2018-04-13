//
//  ViewController.swift
//  miniBrowser
//
//  Created by jeeah on 2018. 4. 10..
//  Copyright © 2018년 jeeah. All rights reserved.
//

import UIKit
import WebKit           //웹뷰 사용하기 위한 프레임워크


class ViewController: UIViewController,UITextFieldDelegate, WKNavigationDelegate {
    @IBOutlet weak var bookMarkSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var spinningActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let initialURL = "https://www.facebook.com"
        let myURL = URL(string:initialURL)
        let myRequest = URLRequest(url: myURL!)
        mainWebView.load(myRequest)   // 비동기 백그라운드 쓰레드. 로딩이 완료되면 메인쓰레드에 로딩 완료 되었다고 알려줌
        urlTextField.text = initialURL
        mainWebView.navigationDelegate = self
    }
    
    
    
   
 
    @IBAction func bookMarkAction(_ sender: Any) {
        let bookMarkURL = bookMarkSegmentedControl.titleForSegment(at: bookMarkSegmentedControl.selectedSegmentIndex)       //세그먼티드컨트 눌렀을 때 해당하는 인덱스 값의 title 가져옴
        let urlString = "https://www.\(bookMarkURL!).com"
        mainWebView.load(URLRequest(url: URL(string: urlString)!))  //해당 url로 로딩
        urlTextField.text = urlString
    }
    
    
    //텍스트필드에 입력한 url로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var urlString = "\(urlTextField.text!)"
        if !urlString.hasPrefix("https://"){            //입력한 url 앞에 https 가 없으면
            urlString = "https://\(urlTextField.text!)"
        }
        urlTextField.text = urlString
        mainWebView.load(URLRequest(url: URL(string: urlString)!))
        textField.resignFirstResponder()        //키보드 내려 주기
        return true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinningActivityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinningActivityIndicatorView.stopAnimating()
    }
    
    
    
    @IBAction func goBackAction(_ sender: Any) {
        mainWebView.goBack()
    }
    @IBAction func goForwardAction(_ sender: Any) {
        mainWebView.goForward()
    }
    @IBAction func stopLoadingAction(_ sender: Any) {
        mainWebView.stopLoading()
    }
    @IBAction func reloadAction(_ sender: Any) {
        mainWebView.reload()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

