Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7847E2A3C7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 07:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgKCGCg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 01:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgKCGC2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 01:02:28 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6388DC061A49;
        Mon,  2 Nov 2020 22:02:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r10so12826703pgb.10;
        Mon, 02 Nov 2020 22:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z11dyIW9wYOT1WRGrY3n/HRYqfGSZJkJPYcfMlfSK1k=;
        b=fqlEVbK35EPh+UkmbfTOML9wO/Yu6UWciXnYiqqdEFBWDytHVrYmbYSbG12dv3lj29
         ijQLun9BJcZFWXiFfb7KP6SyOle0F7XUCtEdyucxYLOXj8HjJeyih7omsHvYll7LqUXo
         Ezth8S3rW1LfHcLdV+yztMhArCw4MGetq8yF2xgV953ex+dYZdd95rMdMI/ZjReJM31v
         OLpBsuFM19OuIh9mQqk1Ibz47smDqth/3X5EdOHwsL24siNZb4S+19Bxoqf/gbZeNE66
         tS4lJIZ8sg6y5/BkJic3oQgWYhl+xHOgAJppgO4t86xw4TwHcW3qcydvarNH2ufdjq/e
         DuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z11dyIW9wYOT1WRGrY3n/HRYqfGSZJkJPYcfMlfSK1k=;
        b=fUrXlGrfrT0/chZXLdoDZkOTDjwEiZUf4mpPg9DjYVKHdoOWxxAcDnzTo8qZP3Lh62
         LQ95O/8TKYdMdLD40bMj4YGkzb/vGbuAoEK6qoDj8rrV9oKXEwYJkIwTWS9Uk/z6XtmX
         4fmH34LOLV9fzC/4KwhjdRjrNcC9S4F9TfmsCekKiqiyEajqQbgau3JqRkQwbV2V4eVx
         vIarYu30mce7yjDyieThOcONWgPvSS+0ORKHmbw7J+MRymmsBkFuJdC3RootFW9yc6fj
         vhamsluca5qBcdzYrPZ53nCN2exjQmHFer/j3ts4q0k2TPiuM1uS5IRvuNByQIg0S7TO
         TdOA==
X-Gm-Message-State: AOAM531FNOAupjK58Oge71fGD+Ax3TOPlGq79IVfDKc1xmFBZQiKpSn5
        LqOwv6xmczQu9QTd7SiZA1s=
X-Google-Smtp-Source: ABdhPJzczT8OSnH39dRzgGhVfqu8jd5/AMVdwt8aIEY9Xprsdx50dQXpPz4sAoL7yZ+FMm8SFeMYSw==
X-Received: by 2002:a62:4e0f:0:b029:156:13e0:efa7 with SMTP id c15-20020a624e0f0000b029015613e0efa7mr24248296pfb.73.1604383346862;
        Mon, 02 Nov 2020 22:02:26 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b16sm15647269pfp.195.2020.11.02.22.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:02:26 -0800 (PST)
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
Subject: [PATCH v5 8/9] lib: unzstd: Switch to the zstd-1.4.6 API
Date:   Mon,  2 Nov 2020 22:05:34 -0800
Message-Id: <20201103060535.8460-9-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103060535.8460-1-nickrterrell@gmail.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
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
index 3c6ad01ffcd5..efbe66501b34 100644
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
@@ -234,36 +234,24 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
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

