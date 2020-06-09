Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397061F3896
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgFIKtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 06:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIKrs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 06:47:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E823C03E97C
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 03:47:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so1831685ejd.13
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jun 2020 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nJBKYN0yMS8AJgBotdxC1qOHMAr254b0bdL2BOSVBX8=;
        b=q35TGCGg2mkkEjc2wKlEhVaWy46yXIz+7jdW6N6OkmJb73py5fZiUzxTInYQq0bo+F
         D97pelWumzAAEdcO8aFTs9/xmUjvxBzF5dgRrVlNpV0QPs4BmirmqiXT60dogulqVqDk
         /2/8mlHTtSWjanvIyzfTh11muRWkGWkVC1kL+s9b3aXLnqcsYKp4KBrqOK4Gd54yPPet
         n8MSEc59ajB3s538tDFCCfQD/bylg4wisxrZJMp9ApiHtzVsi+QMSeyoo0xeNqwe8zhv
         TTgpCcwVcQ1EuY5KZIhARuAFN4xdFt8NdIM8OlX4WRiuMtUaKoYHy93CvXg2HxkKZOv8
         12mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nJBKYN0yMS8AJgBotdxC1qOHMAr254b0bdL2BOSVBX8=;
        b=TN3HafqQoGj2IWZ85hHYi5SKgkBhbaVOu/6NhE9NDKJ55ENVbXwD3oI4bA7NsZkmst
         df6Beg9p2ra63K2zhE9+Zu75GcXvjgQDRzp7zN+ooG5ItH/klcW5WV2ieCW11OUWNWgy
         5rzy0ZtFnpOWMVJ7zGuaAUouTZVvqbgIcMHTjouKpObYGH30/R+VlYW4Gqd0BaiPYbnI
         pv8Sx8f6jho36VtfxcGy91dIhoW8oP01F8hx2UawB1gdBQ2MsDE4LiwGED7BeeBuZlgr
         P74tfVwWbI3+UDcUyYjyX/PCwH4DXBqZvtKSs6S6Vt3OYnLQYqDay5wq6kDKG0NHbSWB
         T95w==
X-Gm-Message-State: AOAM532x75zsPWxV7r+V0V993mtsC7LomcTMNICRAZvOyIelwSGZxxbp
        x4ooL6/eML7NxgXbuukUo4Rjkg==
X-Google-Smtp-Source: ABdhPJwbs89Sxz204nqQDsKgXCoF+iaDYcP3btNQRBahLuS6eOL/DHBbG2RDImrJGYxnwGfYKSDVQg==
X-Received: by 2002:a17:906:e247:: with SMTP id gq7mr24263420ejb.107.1591699661849;
        Tue, 09 Jun 2020 03:47:41 -0700 (PDT)
Received: from localhost.localdomain (hst-221-69.medicom.bg. [84.238.221.69])
        by smtp.gmail.com with ESMTPSA id qt19sm12267763ejb.14.2020.06.09.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 03:47:41 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 4/7] printk: Add pr_debug_level macro over dynamic one
Date:   Tue,  9 Jun 2020 13:46:01 +0300
Message-Id: <20200609104604.1594-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce new pr_debug_level macro over dynamic_debug level one
to allow dynamic debugging to show only important messages.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 include/linux/printk.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index ceea84aa705b..2a6eca56010f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -416,12 +416,18 @@ extern int kptr_restrict;
  */
 #define pr_debug(fmt, ...)			\
 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
+#define pr_debug_level(lvl, fmt, ...) \
+	dynamic_pr_debug_level(lvl, fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define pr_debug(fmt, ...) \
 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_level(lvl, fmt, ...) \
+	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define pr_debug(fmt, ...) \
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_level(lvl, fmt, ...) \
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /*
-- 
2.17.1

