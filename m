Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166D26BACA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIPDoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIPDnU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:43:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7AC06178B;
        Tue, 15 Sep 2020 20:43:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so3083570pgo.13;
        Tue, 15 Sep 2020 20:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krGpYOVpUat0gERMlMR1P1lhK//ROWK8HUHnVTxyKd4=;
        b=awgAfqMFGK8yHA1kC0CVgZdnEU8AnnjW634aveD/YajxjIdjnyBcmfkVK0Knyqe+lX
         ljz+UCj2B5zOzqBdmoFJ3K5TNbOqC3eu77I5dV6SNF7fU2eObT28yeZA4crn0+H4i4FQ
         L/D64ccQxJb2Je2cQin3B1utHqJQ1jZnRUhemwrxt8LqTbezkc2BcdP3TmilWrS5BkIk
         Xix9H4iocrKO/j+YljDq79ibMq8FsvREhUAr+/yL6CPNVYMUIEPSItl/+8m/fc1LWvJR
         /f0c2ZAAZz1NghDogu2KP9KiUkVZO6HpIDaDQ5CQCvJ4alrO1dO+24DDWw+x0pfmAeHc
         YqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krGpYOVpUat0gERMlMR1P1lhK//ROWK8HUHnVTxyKd4=;
        b=O9EXHEIrMy4tLY4GINnNGzHrATwuD6+2w+Xm1JVp58Z9tijeKBlbbv5/4YvPwqUNij
         6FpFkHik8pl7+7ocHkHaL0JsgNBNvOUEwtC9y6MXBPZtIA6Akx2mz1Cf9B+lSYXVV0Jt
         1LgO4oVvK84F24G5fFK4eTpeOrF+z3olZBXR/sSlcA21/U2iJH8wfLO3TRxIOxj3XGR8
         +ejRFibJnti71WGuGpaOVFB4J71tVie+0z+iBzIbPpN8U/0jrWLcoJcEdDkFSdGYqYwl
         N5+apNNFdUvR+q1R+sje32SJRfwdNfIUYuWipxsOM3zDHlG7rg52aB3LY+PoLeRRb6Mp
         60tw==
X-Gm-Message-State: AOAM531PIE9dZD3UieTDhkvqMlTIu9s8FoKB/5LHfUE+e9gpDw3l2LbJ
        W11yMMEU5jZVx12/xFwtAZE=
X-Google-Smtp-Source: ABdhPJxeMIvZUhBNjhZ4RS0dPE1GL7YPRAlPaogyaHuOLDoBmglPFfzH1O1sjFJF805vobT2idx0zA==
X-Received: by 2002:a62:19c4:0:b029:13e:d13d:a0fd with SMTP id 187-20020a6219c40000b029013ed13da0fdmr20703922pfz.25.1600227799254;
        Tue, 15 Sep 2020 20:43:19 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:43:18 -0700 (PDT)
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
Subject: [PATCH 8/9] lib: unzstd: Switch to the zstd-1.4.6 API
Date:   Tue, 15 Sep 2020 20:43:05 -0700
Message-Id: <20200916034307.2092020-13-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916034307.2092020-1-nickrterrell@gmail.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
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

