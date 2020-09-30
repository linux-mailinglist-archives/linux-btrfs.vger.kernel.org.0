Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21F427E1D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgI3Guk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 02:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgI3GuS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 02:50:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EF9C061755;
        Tue, 29 Sep 2020 23:50:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x5so421236plo.6;
        Tue, 29 Sep 2020 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krGpYOVpUat0gERMlMR1P1lhK//ROWK8HUHnVTxyKd4=;
        b=Wu1wW7kGVUX2hnBN6KUwy3RNOwJdKCSWkRfqt1BdsxEV1wgVF6VdZ8NL/HbGwWmxHw
         AdAXq8grvCkSPFY+1tDKWNvtsGuzSzgeuPhxb1wFZYdMsiAq9SID+Pql3YPWUloILMJf
         fcUgmzRPqruLLP93zxemu5YuwJIqfYbUJwWg4cfweSSj6P+zHCTe7pWXONkForHoTIUb
         RMvm4XvDYv4ejTDvAOt+BCRBzgm2Q97XU1LRQvw2P9NOmrBsJd0sCY7wgBy71PLCEqLB
         Ek484Owhn5P/s0GF9eKQUFYGK2LO7RhES17Vo4zbqACdtEKX26qKGsx+lV1bKUlbxuEI
         J6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krGpYOVpUat0gERMlMR1P1lhK//ROWK8HUHnVTxyKd4=;
        b=aKZQSz25XoPNg2Ea3w86hyQoZ8NAo2V78gEULshXPtqxrfcRVdw80EeX1scdbNvxS2
         uLy9bOIo+BV2uoKIvWc4LTPas5i4Zc9gxo4sr9T8mlQg61hMuNV/wWMxtpJejDZWtnDI
         5wFFun9DMsA1aJyV4K2wQZwuMLyg/wRffG79fM0LVvueSdbHBYBpxyKAd3J1M08qO8Ux
         Uqm612LoDs21PdDD3W86djwA82NMrjmTj37FYhG8ku1mQ7cGkH3AiRenbRpFGbY4sn65
         igee+qQEo4uEsCGLHu3QYpaBRaFlxtxb6wqxyTIKTz3sUHxZMrwSC2igYwIUwY0sAb/y
         NHOw==
X-Gm-Message-State: AOAM530obE50/cgpfeZDMg37iF+B52IDY1eRRAiWVLIVJFyGzvzPETHo
        15DtMy+ZS7MIHHW5pTl4bYc=
X-Google-Smtp-Source: ABdhPJxc5RwMM9+nVdS8pkuhMEUvsg+HwSRqEGKdOiO7375+3pYB55ceWSEbfhp0KE1MZXbDtDiXOA==
X-Received: by 2002:a17:902:ee06:b029:d1:8c50:b1ba with SMTP id z6-20020a170902ee06b02900d18c50b1bamr1160641plb.35.1601448616906;
        Tue, 29 Sep 2020 23:50:16 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id 190sm1100865pfy.22.2020.09.29.23.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:50:16 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 8/9] lib: unzstd: Switch to the zstd-1.4.6 API
Date:   Tue, 29 Sep 2020 23:53:17 -0700
Message-Id: <20200930065318.3326526-9-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930065318.3326526-1-nickrterrell@gmail.com>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
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

