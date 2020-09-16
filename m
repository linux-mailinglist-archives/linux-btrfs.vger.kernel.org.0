Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9197E26BAC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgIPDnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgIPDnR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:43:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1288DC061797;
        Tue, 15 Sep 2020 20:43:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so2443670pll.6;
        Tue, 15 Sep 2020 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4G5dTWCVv1NOHS3OxfHw4VPNamJGvm8WlcoiqGKDEiA=;
        b=KE/LPv47oXVIVzAPme4qL2M2JUEKAM2ruFw4CifP+OrXovLTE3+9OJAdmS1aZffxPs
         354JRwOdZ8R7NZY3hm16TAnGV3u68aenDumQ+vfUgmw+/ffLntLbL+A1vrHIO65uUKDo
         yY/kx2DjivoBs6yeEehtTDpTAqMs3cGz/gtkBy+4wORrONq0GZXesiN1s2UhAltESTJj
         2KqpIIcDHPbiC2pzjXsRPbHL8eCdOUTBnfNx/N8f+oHRm25gR21nWp4KeGrtZ41JqiwS
         MvG3E8nu58j4wEOcSXXFb3ozVyQkC3cEAqCBIhaV+1lOCCZjrAL1Y60weA4iG46KamoQ
         QS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4G5dTWCVv1NOHS3OxfHw4VPNamJGvm8WlcoiqGKDEiA=;
        b=i2gqcOPlYqkjeEUIjlVC7VUycDkdAXD9udBBYMW6KqRxbymVA27Hh4PTSp1j9i1coi
         6yCmhu8MaUnaGF2vv0/PdTBWdOLpcns4lDnf2uJfBFaBkIkHkjul39V/qiwRU2/EvHfK
         9Mg915vdPLEbapX1K4TVPPDWqoRTXrOs0Dz5o0O3IoUa3F5yCoTXe+QzyuoQGOwkBFkI
         gqBUNWvGKlSXQyvat51tg5Bf93nWQRA77a6Hi9UB1NZ+t6bNdI2pMZq0uxi3DgVZzDM1
         +57fxT8DGv2vX5DTtcCIXD9/c/KnqRY3oFOj36CGE2I2XST0egU9uh+hv6PwcUMtmvLP
         zvQw==
X-Gm-Message-State: AOAM533rOa9OWR3hZCMjt2xT+ZJmIFss2Pktkuya/NaNlQddwUFGkl6C
        6fAbN92UBk/cS+lGBFwdKJU=
X-Google-Smtp-Source: ABdhPJxxMG1sHnH1sAyJe0cuaB6biIqT0wcpqtHMJ+CXOUKYNB2jPzFXuh7kU4yid2AyFqFG+yCFeQ==
X-Received: by 2002:a17:902:8306:b029:d0:cbe1:e7aa with SMTP id bd6-20020a1709028306b02900d0cbe1e7aamr22151055plb.27.1600227787535;
        Tue, 15 Sep 2020 20:43:07 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:43:07 -0700 (PDT)
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
Subject: [PATCH 6/9] f2fs: zstd: Switch to the zstd-1.4.6 API
Date:   Tue, 15 Sep 2020 20:43:01 -0700
Message-Id: <20200916034307.2092020-9-nickrterrell@gmail.com>
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
code is more efficient because it uses the single-pass API instead of
the streaming API. The streaming API is not necessary because the whole
input and output buffers are available. This saves memory because we
don't need to allocate a buffer for the window. It is also more
efficient because it saves unnecessary memcpy calls.

I've had problems testing this code because I see data truncation before
and after this patchset. Help testing this patch would be much
appreciated.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 fs/f2fs/compress.c | 102 +++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e056f3a2b404..b79efce81651 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -11,7 +11,8 @@
 #include <linux/backing-dev.h>
 #include <linux/lzo.h>
 #include <linux/lz4.h>
-#include <linux/zstd_compat.h>
+#include <linux/zstd.h>
+#include <linux/zstd_errors.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -298,21 +299,21 @@ static const struct f2fs_compress_ops f2fs_lz4_ops = {
 static int zstd_init_compress_ctx(struct compress_ctx *cc)
 {
 	ZSTD_parameters params;
-	ZSTD_CStream *stream;
+	ZSTD_CCtx *ctx;
 	void *workspace;
 	unsigned int workspace_size;
 
 	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, cc->rlen, 0);
-	workspace_size = ZSTD_CStreamWorkspaceBound(params.cParams);
+	workspace_size = ZSTD_estimateCCtxSize_usingCParams(params.cParams);
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
 					workspace_size, GFP_NOFS);
 	if (!workspace)
 		return -ENOMEM;
 
-	stream = ZSTD_initCStream(params, 0, workspace, workspace_size);
-	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initCStream failed\n",
+	ctx = ZSTD_initStaticCCtx(workspace, workspace_size);
+	if (!ctx) {
+		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_inittaticCStream failed\n",
 				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
 				__func__);
 		kvfree(workspace);
@@ -320,7 +321,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	}
 
 	cc->private = workspace;
-	cc->private2 = stream;
+	cc->private2 = ctx;
 
 	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
 	return 0;
@@ -335,65 +336,48 @@ static void zstd_destroy_compress_ctx(struct compress_ctx *cc)
 
 static int zstd_compress_pages(struct compress_ctx *cc)
 {
-	ZSTD_CStream *stream = cc->private2;
-	ZSTD_inBuffer inbuf;
-	ZSTD_outBuffer outbuf;
-	int src_size = cc->rlen;
-	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
-	int ret;
-
-	inbuf.pos = 0;
-	inbuf.src = cc->rbuf;
-	inbuf.size = src_size;
-
-	outbuf.pos = 0;
-	outbuf.dst = cc->cbuf->cdata;
-	outbuf.size = dst_size;
-
-	ret = ZSTD_compressStream(stream, &outbuf, &inbuf);
-	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
-		return -EIO;
-	}
-
-	ret = ZSTD_endStream(stream, &outbuf);
+	ZSTD_CCtx *ctx = cc->private2;
+	const size_t src_size = cc->rlen;
+	const size_t dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
+	ZSTD_parameters params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, src_size, 0);
+	size_t ret;
+
+	ret = ZSTD_compress_advanced(
+			ctx, cc->cbuf->cdata, dst_size, cc->rbuf, src_size, NULL, 0, params);
 	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_endStream returned %d\n",
+		/*
+		 * there is compressed data remained in intermediate buffer due to
+		 * no more space in cbuf.cdata
+		 */
+		if (ZSTD_getErrorCode(ret) == ZSTD_error_dstSize_tooSmall)
+			return -EAGAIN;
+		/* other compression errors return -EIO */
+		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compress_advanced failed, err: %s\n",
 				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+				__func__, ZSTD_getErrorName(ret));
 		return -EIO;
 	}
 
-	/*
-	 * there is compressed data remained in intermediate buffer due to
-	 * no more space in cbuf.cdata
-	 */
-	if (ret)
-		return -EAGAIN;
-
-	cc->clen = outbuf.pos;
+	cc->clen = ret;
 	return 0;
 }
 
 static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 {
-	ZSTD_DStream *stream;
+	ZSTD_DCtx *ctx;
 	void *workspace;
 	unsigned int workspace_size;
 
-	workspace_size = ZSTD_DStreamWorkspaceBound(MAX_COMPRESS_WINDOW_SIZE);
+	workspace_size = ZSTD_estimateDCtxSize();
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
 					workspace_size, GFP_NOFS);
 	if (!workspace)
 		return -ENOMEM;
 
-	stream = ZSTD_initDStream(MAX_COMPRESS_WINDOW_SIZE,
-					workspace, workspace_size);
-	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initDStream failed\n",
+	ctx = ZSTD_initStaticDCtx(workspace, workspace_size);
+	if (!ctx) {
+		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initStaticDCtx failed\n",
 				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
 				__func__);
 		kvfree(workspace);
@@ -401,7 +385,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 	}
 
 	dic->private = workspace;
-	dic->private2 = stream;
+	dic->private2 = ctx;
 
 	return 0;
 }
@@ -415,28 +399,18 @@ static void zstd_destroy_decompress_ctx(struct decompress_io_ctx *dic)
 
 static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 {
-	ZSTD_DStream *stream = dic->private2;
-	ZSTD_inBuffer inbuf;
-	ZSTD_outBuffer outbuf;
-	int ret;
-
-	inbuf.pos = 0;
-	inbuf.src = dic->cbuf->cdata;
-	inbuf.size = dic->clen;
-
-	outbuf.pos = 0;
-	outbuf.dst = dic->rbuf;
-	outbuf.size = dic->rlen;
+	ZSTD_DCtx *ctx = dic->private2;
+	size_t ret;
 
-	ret = ZSTD_decompressStream(stream, &outbuf, &inbuf);
+	ret = ZSTD_decompressDCtx(ctx, dic->rbuf, dic->rlen, dic->cbuf->cdata, dic->clen);
 	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
+		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_decompressDCtx failed, err: %s\n",
 				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+				__func__, ZSTD_getErrorName(ret));
 		return -EIO;
 	}
 
-	if (dic->rlen != outbuf.pos) {
+	if (dic->rlen != ret) {
 		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD invalid rlen:%zu, "
 				"expected:%lu\n", KERN_ERR,
 				F2FS_I_SB(dic->inode)->sb->s_id,
-- 
2.28.0

