package com.starnet.rpx

import android.annotation.SuppressLint
import android.content.ContentValues.TAG
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebResourceError
import android.webkit.WebResourceRequest
import android.webkit.WebResourceResponse
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.ProgressBar
import android.widget.RelativeLayout
import androidx.activity.ComponentActivity
import com.google.firebase.Firebase
import com.google.firebase.FirebaseApp
import com.google.firebase.crashlytics.FirebaseCrashlytics
import com.google.firebase.remoteconfig.ConfigUpdate
import com.google.firebase.remoteconfig.ConfigUpdateListener
import com.google.firebase.remoteconfig.FirebaseRemoteConfig
import com.google.firebase.remoteconfig.FirebaseRemoteConfigException
import com.google.firebase.remoteconfig.remoteConfig
import com.google.firebase.remoteconfig.remoteConfigSettings


class MainActivity : ComponentActivity() {
    public lateinit var mWebView: WebView
    private var mUploadMessage: ValueCallback<Uri>? = null
    private var mFilePathCallback: ValueCallback<Array<Uri>>? = null
    private val REQUEST_CODE_FILE_CHOOSER = 1
     var url = "https://sg568.com/"

    public lateinit var context: Context

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        FirebaseApp.initializeApp(this);
        FirebaseCrashlytics.getInstance().setCrashlyticsCollectionEnabled(true);

        val remoteConfig: FirebaseRemoteConfig = Firebase.remoteConfig
        val configSettings = remoteConfigSettings {
            minimumFetchIntervalInSeconds = 0
        }
        remoteConfig.setConfigSettingsAsync(configSettings)
        var result =  remoteConfig.getString("weburl")
            url =result
        remoteConfig.addOnConfigUpdateListener(object : ConfigUpdateListener {
            override fun onUpdate(configUpdate : ConfigUpdate) {
                Log.d(TAG, "Updated keys: " + configUpdate.updatedKeys);

                if (configUpdate.updatedKeys.contains("weburl")) {
                    val packageName = applicationContext.packageName


                    val launchIntent = packageManager.getLaunchIntentForPackage(packageName)

                    if (launchIntent != null) {
                        // 清除任务栈并创建一个新的任务栈
                        launchIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_NEW_TASK)

                        // 启动应用
                        startActivity(launchIntent)
                    } else {
                        // 应用未安装或其他错误处理
                        // 可以在这里添加适当的处理逻辑
                    }
                    remoteConfig.activate().addOnCompleteListener {

                    }
                }
            }

            override fun onError(error : FirebaseRemoteConfigException) {
                Log.w(TAG, "Config update error with code: " + error.code, error)
            }
        })

        var layout = RelativeLayout(this)

        var progressBar = ProgressBar(this)
        var layoutParams = RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT)
        layoutParams.addRule(RelativeLayout.CENTER_IN_PARENT)
        progressBar.layoutParams = layoutParams

        mWebView = WebView(this)
        mWebView.layoutParams = RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT)

        layout.addView(mWebView)
        layout.addView(progressBar)

        setContentView(layout)

        initWebViewSettings()
        mWebView.clearCache(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val webSettings = mWebView.settings
            mWebView.getSettings().setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }
        mWebView.webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView, newProgress: Int) {
                super.onProgressChanged(view, newProgress)
                progressBar.progress = newProgress
                if (newProgress == 100) {
                    progressBar.visibility = View.GONE
                } else {
                    progressBar.visibility = View.VISIBLE
                }
            }

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

        mWebView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                view.loadUrl(url)
                return true
            }
            override fun onReceivedHttpError(
                view: WebView?,
                request: WebResourceRequest?,
                errorResponse: WebResourceResponse
            ) {
                super.onReceivedHttpError(view, request, errorResponse)
                val crashlytics = FirebaseCrashlytics.getInstance()

                // 记录异常信息到 Crashlytics
                crashlytics.log("WebView error occurred: $errorResponse")

                // 如果你希望将异常报告到 Crashlytics，可以使用 recordException 方法
                val exception = Exception("WebView error occurred")
                crashlytics.recordException(exception)
                Log.e("WebViewError", "HTTP Error: " + errorResponse.statusCode)
            }
            override fun onReceivedError(
                view: WebView?,
                request: WebResourceRequest?,
                error: WebResourceError?
            ) {
                super.onReceivedError(view, request, error)
                val crashlytics = FirebaseCrashlytics.getInstance()

                // 记录异常信息到 Crashlytics
                crashlytics.log("WebView error occurred: $error")

                // 如果你希望将异常报告到 Crashlytics，可以使用 recordException 方法
                val exception = Exception("WebView error occurred")
                crashlytics.recordException(exception)

            }
        }

        mWebView.loadUrl(url)
        val  js=JSBridge(this,mWebView)
        // 注入 JavaScript 接口
        mWebView.addJavascriptInterface(js, "h5at")
    }



    @SuppressLint("SetJavaScriptEnabled")
    private fun initWebViewSettings() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            mWebView.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
        }

        android.webkit.CookieManager.getInstance().removeAllCookies(null);
        android.webkit.CookieManager.getInstance().flush();
        val webSettings = mWebView.settings
        webSettings.allowFileAccess = true
        webSettings.allowContentAccess = true
        webSettings.allowContentAccess = true
        webSettings.domStorageEnabled = true

        webSettings.javaScriptEnabled = true // 启用 JavaScript
        webSettings.setLoadsImagesAutomatically(true);
        webSettings.setRenderPriority(WebSettings.RenderPriority.HIGH);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            webSettings.setEnableSmoothTransition(true);
        }
    }

    override fun onDestroy() {
        if (this::mWebView.isInitialized) {
            mWebView.destroy() // 销毁 WebView 防止内存泄漏
        }

        super.onDestroy()
    }

    override fun onBackPressed() {
        if (mWebView.canGoBack()) {
            // 如果可以回退，则执行回退操作
            mWebView.goBack();
        } else {
            // 如果不能回退，则执行默认的返回操作
            super.onBackPressed();
        }
    }
}