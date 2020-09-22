Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E1B274AC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 23:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgIVVGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgIVVGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:06:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E9C0613D0;
        Tue, 22 Sep 2020 14:06:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so2085555pjg.1;
        Tue, 22 Sep 2020 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krGpYOVpUat0gERMlMR1P1lhK//ROWK8HUHnVTxyKd4=;
        b=BWzf+T/n2kbFP0tByp9/Jj9Wok9svu79fWXRTG9+przzI26Wwi9XywjndiuHBMJjd5
         +LNbN8ae8kf9EFs0aL4J/l0Cuj+MS4Q+HYB3PvpbTpkc7t8X/646ZwKWiRE2aIQ5tKoE
         XH4yjWacRXjeTTALpzhzI/6K9eept34kFVOYaG/c/DAum0CvTWisUUoWXXQ8UgwwKasb
         ZrnfFWT4aa+WPtdMe2styka5E1D4AzDdPq8WMjzJcOkdTxlzbH+wPZx7KFevGNK+cxN+
         9AkwOmHx7Yk5hTKAdWR3bcoW5UtqGLtpiqPIYligeiOKjLeGpoXXx+21Y5eKgVRL9TuP
         XFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krGpYOVpUat0gERMlMR1P1lhK//ROWK8HUHnVTxyKd4=;
        b=T+rLDFcgvjOIJAnly8L0nfTaUA2wjC4JOQ7tsM0n7qIdHL2HPE9DKKWXNTqigATALw
         kGU4nqv38VvugUor1QgAFeVRJuBhChaIF2FJnqTRLTkwvr+oav4R4ZGWc51k05fWcqj7
         /gnqjbA4PQ6mKBaZ3NWS+pVP1rAZD8jWct5PiNR6QUXJph8F0hGACYnuDVCciLCnyK9Y
         rHRZ3hLYJxXQPP0xriuPAZ/vRXQoqmVqBITnuR/hUfk959HwWNc1oAd4nEZ7oAZTshLX
         n/EtM4gsBFEr8NWe+oKWVwHuhU8Ay5WKBQ78APcAEt02sTlSNISFlM3HHhnsibcGt/go
         MXKg==
X-Gm-Message-State: AOAM5316CCN0P7qDtCoiLS/6mWbLACB7uUf4z95ZfxDoLMBJte75+ZlF
        7FYxlsOqbsZmkCZmW/U85cQ=
X-Google-Smtp-Source: ABdhPJw8m2iBA2+aOJR+wkwV3XyuTSZLKB0OYrh4Sz3KjUcIV0mUpuLoIuh/IHHxxuh13lJQBUDCEA==
X-Received: by 2002:a17:90a:7487:: with SMTP id p7mr5440688pjk.189.1600808809074;
        Tue, 22 Sep 2020 14:06:49 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i15sm16118945pfk.145.2020.09.22.14.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:06:48 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: [PATCH v2 8/9] lib: unzstd: Switch to the zstd-1.4.6 API
Date:   Tue, 22 Sep 2020 14:09:23 -0700
Message-Id: <20200922210924.1725-9-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922210924.1725-1-nickrterrell@gmail.com>
References: <20200922210924.1725-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Move away from the compatibility wrapper to the zstd-1.4.6 API. This
code is functionally equivalent.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/decompress_unzstd.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index a79f705f236d..d4685df0e120 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -73,7 +73,8 @@
 
 #include <linux/decompress/mm.h>
 #include <linux/kernel.h>
-#include <linux/zstd_compat.h>
+#include <linux/zstd.h>
+#include <linux/zstd_errors.h>
 
 /* 128MB is the maximum window size supported by zstd. */
 #define ZSTD_WINDOWSIZE_MAX	(1 << ZSTD_WINDOWLOG_MAX)
@@ -120,9 +121,9 @@ static int INIT decompress_single(const u8 *in_buf, long in_len, u8 *out_buf,
 				  long out_len, long *in_pos,
 				  void (*error)(char *x))
 {
-	const size_t wksp_size = ZSTD_DCtxWorkspaceBound();
+	const size_t wksp_size = ZSTD_estimateDCtxSize();
 	void *wksp = large_malloc(wksp_size);
-	ZSTD_DCtx *dctx = ZSTD_initDCtx(wksp, wksp_size);
+	ZSTD_DCtx *dctx = ZSTD_initStaticDCtx(wksp, wksp_size);
 	int err;
 	size_t ret;
 
@@ -165,7 +166,6 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
 {
 	ZSTD_inBuffer in;
 	ZSTD_outBuffer out;
-	ZSTD_frameParams params;
 	void *in_allocated = NULL;
 	void *out_allocated = NULL;
 	void *wksp = NULL;
@@ -229,36 +229,24 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
 	out.size = out_len;
 
 	/*
-	 * We need to know the window size to allocate the ZSTD_DStream.
-	 * Since we are streaming, we need to allocate a buffer for the sliding
-	 * window. The window size varies from 1 KB to ZSTD_WINDOWSIZE_MAX
-	 * (8 MB), so it is important to use the actual value so as not to
-	 * waste memory when it is smaller.
+	 * Zstd determines the workspace size from the window size written
+	 * into the frame header. This ensures that we use the minimum value
+	 * possible, since the window size varies from 1 KB to ZSTD_WINDOWSIZE_MAX
+	 * (1 GB), so it is very important to use the actual value.
 	 */
-	ret = ZSTD_getFrameParams(&params, in.src, in.size);
+	wksp_size = ZSTD_estimateDStreamSize_fromFrame(in.src, in.size);
 	err = handle_zstd_error(ret, error);
 	if (err)
 		goto out;
-	if (ret != 0) {
-		error("ZSTD-compressed data has an incomplete frame header");
-		err = -1;
-		goto out;
-	}
-	if (params.windowSize > ZSTD_WINDOWSIZE_MAX) {
-		error("ZSTD-compressed data has too large a window size");
+	wksp = large_malloc(wksp_size);
+	if (wksp == NULL) {
+		error("Out of memory while allocating ZSTD_DStream");
 		err = -1;
 		goto out;
 	}
-
-	/*
-	 * Allocate the ZSTD_DStream now that we know how much memory is
-	 * required.
-	 */
-	wksp_size = ZSTD_DStreamWorkspaceBound(params.windowSize);
-	wksp = large_malloc(wksp_size);
-	dstream = ZSTD_initDStream(params.windowSize, wksp, wksp_size);
+	dstream = ZSTD_initStaticDStream(wksp, wksp_size);
 	if (dstream == NULL) {
-		error("Out of memory while allocating ZSTD_DStream");
+		error("ZSTD_initStaticDStream failed");
 		err = -1;
 		goto out;
 	}
-- 
2.28.0

