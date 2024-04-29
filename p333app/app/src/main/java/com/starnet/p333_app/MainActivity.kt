package com.starnet.p333_app

import android.net.http.SslError
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.webkit.SslErrorHandler
import android.webkit.WebResourceError
import android.webkit.WebResourceRequest
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.viewinterop.AndroidView
import com.starnet.p333_app.ui.theme.P333appTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            P333appTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    AndroidView(
                        factory = { context ->
                            WebView(context).apply {

                                webViewClient = object : WebViewClient() {
                                    override fun onReceivedError(view: WebView?, request: WebResourceRequest?, error: WebResourceError?) {
                                        // 查看错误信息
                                        Log.e("WebViewError", "Failed to load page: ${error?.description}")
                                    }
                                    override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                                        // 在 WebView 中加载页面
                                        view?.loadUrl(request?.url.toString())
                                        return false
                                    }
                                    override fun onReceivedSslError(view: WebView?, handler: SslErrorHandler?, error: SslError?) {
                                        // 处理 SSL 错误，可以选择接受证书
                                        handler?.proceed()
                                    }



                                }
                                settings.javaScriptEnabled = true


                                settings.domStorageEnabled=true
                                settings.useWideViewPort=true
                                settings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
                                settings.userAgentString = "Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; LGMS323 Build/KOT49I.MS32310c) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/120.0.0.0 Mobile Safari/537.36"

//                                settings.allowFileAccess = true
//                                settings.allowContentAccess = true
//                                settings.allowContentAccess = true
//                                settings.domStorageEnabled = true
                                // Add other WebView settings if needed
                            }
                        },
                        update = { webView ->
                            // Load the URL or perform other WebView operations
                         webView.loadUrl("https://aff.p333h.bet/en-ph/home")
                         // webView.loadUrl("https://www.google.com")
                        }

                    )
                }
            }
        }
    }
}



@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    P333appTheme {

    }
}