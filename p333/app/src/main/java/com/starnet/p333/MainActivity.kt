package com.starnet.p333


import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import com.starnet.p333.ui.theme.P333Theme

class MainActivity : ComponentActivity() {
    public lateinit var mWebView: WebView
    private var mUploadMessage: ValueCallback<Uri>? = null
    private var mFilePathCallback: ValueCallback<Array<Uri>>? = null
    private val REQUEST_CODE_FILE_CHOOSER = 1
    private  val url="https://81235.net/"
    public lateinit var context: Context
    // 用于保存当前网页的标题

    @SuppressLint("SuspiciousIndentation")
    @OptIn(ExperimentalMaterial3Api::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        context=this


setContent {
    // toolbar.setBackgroundColor(resources.getColor(R.color.purple_200)) // 设置背景颜色

    // setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
//            window.setFlags(
//                WindowManager.LayoutParams.FLAG_FULLSCREEN,
//                WindowManager.LayoutParams.FLAG_FULLSCREEN
//            )
    P333Theme() {
        // A surface container using the 'background' color from the theme
        Surface(
            //modifier = Modifier.fillMaxSize(),
            color = MaterialTheme.colorScheme.background
        ) {
            mWebView = WebView(this)
            setContentView(mWebView)
            initWebViewSettings()
            // 设置 WebViewClient
            mWebView.webViewClient = object : WebViewClient() {
                // 在 WebView 内部打开链接，而不是使用外部浏览器
                override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                    view.loadUrl(url)
                    return true
                }
            }
            mWebView.setWebChromeClient(WebChromeClient()) // 修正了 newWebChromeClient() 的语法
            mWebView.setWebViewClient(WebViewClient())

            mWebView.setWebViewClient(object : WebViewClient() {
                override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                    // 在此处可以处理跨域请求
                    return false // 返回 false 表示继续加载网页
                }
            })

            // 设置 WebChromeClient，用于处理文件上传
            mWebView.webChromeClient = object : WebChromeClient() {
                // For Android 4.1 to 5.0
                fun openFileChooser(uploadMsg: ValueCallback<Uri>, acceptType: String?, capture: String?) {
                    mUploadMessage = uploadMsg
                    val i = Intent(Intent.ACTION_GET_CONTENT)
                    i.addCategory(Intent.CATEGORY_OPENABLE)
                    val type = acceptType ?: "*/*"
                    i.type = type
                    startActivityForResult(Intent.createChooser(i, null), REQUEST_CODE_FILE_CHOOSER)
                }

                // For Android 5.0+
                override fun onShowFileChooser(
                    webView: WebView, filePathCallback: ValueCallback<Array<Uri>>,
                    fileChooserParams: FileChooserParams
                ): Boolean {
                    mFilePathCallback = filePathCallback
                    val intent = Intent(Intent.ACTION_PICK)
                    val acceptTypes = fileChooserParams.acceptTypes
                    val type = if (acceptTypes != null && acceptTypes.isNotEmpty()) {
                        acceptTypes.joinToString(",")
                    } else {
                        "*/*"
                    }
                    intent.type = type
                    startActivityForResult(Intent.createChooser(intent, null), REQUEST_CODE_FILE_CHOOSER)
                    return true
                }
            }
            // mWebView.loadUrl("https://h5.luncky30.com?chn=aHdwZzI2&adjid=g2rft86qlaf4")

            mWebView.loadUrl(url)
            val  js= JSBridge(this,mWebView)
            // 注入 JavaScript 接口
            mWebView.addJavascriptInterface(js, "h5at")

            val params = Bundle()
            params.putString("custom_param_key", "value")
        }
    }

}


    }



    @SuppressLint("SetJavaScriptEnabled")
    private fun initWebViewSettings() {
        val webSettings = mWebView.settings
        webSettings.allowFileAccess=true
        webSettings.allowContentAccess=true
        webSettings.domStorageEnabled=true
        webSettings.javaScriptEnabled = true // 启用 JavaScript
    }
    override fun onDestroy() {
        if (mWebView != null) {
            mWebView.destroy() // 销毁 WebView 防止内存泄漏
        }

        super.onDestroy()
    }

}