package com.starnet.p333

import android.content.ClipboardManager
import android.content.Context
import android.content.Intent
import android.webkit.JavascriptInterface
import android.webkit.WebView

class JSBridge(private val context: Context,private val webView:WebView) {
    @JavascriptInterface
    fun getDeviceId(): String {
        return android.provider.Settings.Secure.getString(context.contentResolver, android.provider.Settings.Secure.ANDROID_ID)
    }

    @JavascriptInterface
    fun getDeviceModel(): String {
        return android.os.Build.MODEL
    }

    @JavascriptInterface
    fun getDeviceBrand(): String {
        return android.os.Build.BRAND
    }

    @JavascriptInterface
    fun getPackageName(): String {
        return context.packageName
    }
    @JavascriptInterface
    fun openUrlWebView(url: String) {
        webView.loadUrl(url)
    }
    @JavascriptInterface
    fun openUrlByBrowser(url: String) {

        val intent = Intent(Intent.ACTION_VIEW, android.net.Uri.parse(url))
        context.startActivity(intent)
    }

    @JavascriptInterface
    fun copyText(text: String) {
        val clipboard = context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        clipboard.text = text
    }

    @JavascriptInterface
    fun getClipboardText(): String {
        val clipboard = context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        return clipboard.primaryClip?.getItemAt(0)?.text?.toString() ?: ""
    }
}
