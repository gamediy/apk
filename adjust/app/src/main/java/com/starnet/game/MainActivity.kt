package com.starnet.game

import android.annotation.SuppressLint
import android.content.ContentValues.TAG
import android.content.Context
import android.content.Intent
import android.content.pm.ActivityInfo
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toolbar
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.adjust.sdk.Adjust
import com.adjust.sdk.AdjustEvent
import com.adjust.sdk.webbridge.AdjustBridge
import com.google.android.gms.tasks.Task
import com.google.firebase.analytics.ktx.analytics
import com.google.firebase.ktx.Firebase
import com.google.firebase.remoteconfig.FirebaseRemoteConfig
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings
import com.starnet.game.ui.theme.WebviewTheme


class MainActivity : ComponentActivity() {
    public lateinit var mWebView: WebView
    private var mUploadMessage: ValueCallback<Uri>? = null
    private var mFilePathCallback: ValueCallback<Array<Uri>>? = null
    private val REQUEST_CODE_FILE_CHOOSER = 1

    public lateinit var context: Context
    // 用于保存当前网页的标题

    @SuppressLint("SuspiciousIndentation")
    @OptIn(ExperimentalMaterial3Api::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
         context=this
        val adjustEvent = AdjustEvent("zi00b2")
      Adjust.trackEvent(adjustEvent)
        setContent {
            val toolbar = Toolbar(this)
            toolbar.title = "您的标题" // 设置标题文本
            // toolbar.setBackgroundColor(resources.getColor(R.color.purple_200)) // 设置背景颜色
            setActionBar(toolbar)
            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
            window.setFlags(
                WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN
            )
            WebviewTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
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
                    AdjustBridge.registerAndGetInstance(getApplication(),mWebView);
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
                    mWebView.loadUrl("https://h5.luncky30.com?chn=aHdwZzI2&adjid=g2rft86qlaf4")
                    val  js=JSBridge(this)
                    // 注入 JavaScript 接口
                    mWebView.addJavascriptInterface(js, "h5at")

                    val params = Bundle()
                    params.putString("custom_param_key", "value")
                   val  firebaseAnalytics = Firebase.analytics
                    firebaseAnalytics.logEvent("open_game", params)
                    val configSettings = FirebaseRemoteConfigSettings.Builder()
                        .setMinimumFetchIntervalInSeconds(0) // Fetch every time
                        .build()

                    val mFirebaseRemoteConfig = FirebaseRemoteConfig.getInstance()
                    mFirebaseRemoteConfig.setConfigSettingsAsync(configSettings)
                    mFirebaseRemoteConfig.setDefaultsAsync(R.xml.remote_config_defaults)
                    var string = mFirebaseRemoteConfig.getString("test")
                        print(string)
                    mFirebaseRemoteConfig.fetchAndActivate()
                        .addOnCompleteListener(
                            this
                        ) { task: Task<Boolean> ->
                            if (task.isSuccessful) {
                                val updated = task.result
                                Log.d(TAG, "Config params updated: $updated")
                                var string = mFirebaseRemoteConfig.getString("test")
                                Log.d(TAG,mFirebaseRemoteConfig.getString("test"))
                            } else {
                                Log.e(TAG, "Error fetching config", task.exception)
                            }
                        }
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
        AdjustBridge.unregister()
        super.onDestroy()
    }



}



