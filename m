Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7736F387
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 03:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhD3B1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 21:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhD3B1G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 21:27:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0632C06138D;
        Thu, 29 Apr 2021 18:26:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s20so19911268plr.13;
        Thu, 29 Apr 2021 18:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfEzSh+tpyZOeDqIvk93XLtpZMbnKoMpB+75PM5yg5c=;
        b=CBlGpsljybsyddcOlyw3WSNv64CIPxOMTf/HW2zR1rJHOGfjX5lNqbwdU3W4mYchwm
         hnuXTmWNkjARxLc+m8CiRY2qRlZIuxbIZZiDBsQyiIXH5qVid1M6H55qt3LM9IVkYMmD
         DKRD2Qp5Gc+W/P0kGMxZJXpH5A4Bn5corePq7OAf0/yQk1QWZrM5C4A8WjZ6Nwp28CJs
         yL62k4I94kGijzDxSPz4aEKW54mkqwjN6VUmG/8QEK8TEp6mE1s76wHskmxZBh03uQk3
         1h375Pos0rYGEfamSpLXTIkJwwlZGIzaNuVOJjkb3ByB83hk2fRM6KiG+gUD2n7ZxnN4
         zjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfEzSh+tpyZOeDqIvk93XLtpZMbnKoMpB+75PM5yg5c=;
        b=QVmmQo98gqJDV2ny2hDUb74mGZoBuaRUwMQz68I3nyYrhu7o8BV8LAZ+4kc9ttmYYI
         V75av1+uAib6poD5wYZulQWg0qgqbV7ky8D4KZH9q///bE9heFgCtbWi6E14bwiMsPYh
         kTRc/Y+DAsA3oF12dpJy99vXCoD/PmhJgqsyc3XqDsIYRZtG7lpsX+ZB8x/eAn2Cgelt
         uOCNnnGewqapdpUQ7jJP7ItB+FG1ySm9jFgTFmKq5BpLX2mIy7MrP/sRrnK6yPYKyODx
         Lmekc1By9xsm3Onn4a/UmUEHXRwN8freESdNqIPl8shoJnekupoF7Ih/OcHbB7WzINkW
         mtLg==
X-Gm-Message-State: AOAM532Qx7yo+fbEq4OW4wg4bCmdkLYLHrS1nbb4a6mlwvv++wnV62FK
        1DmUGeQt9UcKleHltwTc7Xw=
X-Google-Smtp-Source: ABdhPJzq+/O0OTGnKx7RJp7Tw6hFaCj4UGcALIkOp5Z03bTt88h+6njcpmiCQBYNb6cyRgoVswzEYA==
X-Received: by 2002:a17:90b:e95:: with SMTP id fv21mr2746286pjb.107.1619745975938;
        Thu, 29 Apr 2021 18:26:15 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b186sm311004pfb.27.2021.04.29.18.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 18:26:15 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v11 1/4] lib: zstd: Add kernel-specific API
Date:   Thu, 29 Apr 2021 18:31:54 -0700
Message-Id: <20210430013157.747152-2-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430013157.747152-1-nickrterrell@gmail.com>
References: <20210430013157.747152-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

This patch:
- Moves `include/linux/zstd.h` -> `include/linux/zstd_lib.h`
- Updates modified zstd headers to yearless copyright
- Adds a new API in `include/linux/zstd.h` that is functionally
  equivalent to the in-use subset of the current API. Functions are
  renamed to avoid symbol collisions with zstd, to make it clear it is
  not the upstream zstd API, and to follow the kernel style guide.
- Updates all callers to use the new API.

There are no functional changes in this patch. Since there are no
functional change, I felt it was okay to update all the callers in a
single patch. Once the API is approved, the callers are mechanically
changed.

This patch is preparing for the 3rd patch in this series, which updates
zstd to version 1.4.10. Since the upstream zstd API is no longer exposed
to callers, the update can happen transparently.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 crypto/zstd.c              |   28 +-
 fs/btrfs/zstd.c            |   68 +-
 fs/f2fs/compress.c         |   56 +-
 fs/f2fs/super.c            |    2 +-
 fs/pstore/platform.c       |    2 +-
 fs/squashfs/zstd_wrapper.c |   16 +-
 include/linux/zstd.h       | 1243 ++++++++----------------------------
 include/linux/zstd_lib.h   | 1157 +++++++++++++++++++++++++++++++++
 lib/decompress_unzstd.c    |   42 +-
 lib/zstd/compress.c        |  123 ++--
 lib/zstd/decompress.c      |  112 ++--
 11 files changed, 1691 insertions(+), 1158 deletions(-)
 create mode 100644 include/linux/zstd_lib.h

diff --git a/crypto/zstd.c b/crypto/zstd.c
index 1a3309f066f7..154a969c83a8 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -18,22 +18,22 @@
 #define ZSTD_DEF_LEVEL	3
 
 struct zstd_ctx {
-	ZSTD_CCtx *cctx;
-	ZSTD_DCtx *dctx;
+	zstd_cctx *cctx;
+	zstd_dctx *dctx;
 	void *cwksp;
 	void *dwksp;
 };
 
-static ZSTD_parameters zstd_params(void)
+static zstd_parameters zstd_params(void)
 {
-	return ZSTD_getParams(ZSTD_DEF_LEVEL, 0, 0);
+	return zstd_get_params(ZSTD_DEF_LEVEL, 0);
 }
 
 static int zstd_comp_init(struct zstd_ctx *ctx)
 {
 	int ret = 0;
-	const ZSTD_parameters params = zstd_params();
-	const size_t wksp_size = ZSTD_CCtxWorkspaceBound(params.cParams);
+	const zstd_parameters params = zstd_params();
+	const size_t wksp_size = zstd_cctx_workspace_bound(&params.cParams);
 
 	ctx->cwksp = vzalloc(wksp_size);
 	if (!ctx->cwksp) {
@@ -41,7 +41,7 @@ static int zstd_comp_init(struct zstd_ctx *ctx)
 		goto out;
 	}
 
-	ctx->cctx = ZSTD_initCCtx(ctx->cwksp, wksp_size);
+	ctx->cctx = zstd_init_cctx(ctx->cwksp, wksp_size);
 	if (!ctx->cctx) {
 		ret = -EINVAL;
 		goto out_free;
@@ -56,7 +56,7 @@ static int zstd_comp_init(struct zstd_ctx *ctx)
 static int zstd_decomp_init(struct zstd_ctx *ctx)
 {
 	int ret = 0;
-	const size_t wksp_size = ZSTD_DCtxWorkspaceBound();
+	const size_t wksp_size = zstd_dctx_workspace_bound();
 
 	ctx->dwksp = vzalloc(wksp_size);
 	if (!ctx->dwksp) {
@@ -64,7 +64,7 @@ static int zstd_decomp_init(struct zstd_ctx *ctx)
 		goto out;
 	}
 
-	ctx->dctx = ZSTD_initDCtx(ctx->dwksp, wksp_size);
+	ctx->dctx = zstd_init_dctx(ctx->dwksp, wksp_size);
 	if (!ctx->dctx) {
 		ret = -EINVAL;
 		goto out_free;
@@ -152,10 +152,10 @@ static int __zstd_compress(const u8 *src, unsigned int slen,
 {
 	size_t out_len;
 	struct zstd_ctx *zctx = ctx;
-	const ZSTD_parameters params = zstd_params();
+	const zstd_parameters params = zstd_params();
 
-	out_len = ZSTD_compressCCtx(zctx->cctx, dst, *dlen, src, slen, params);
-	if (ZSTD_isError(out_len))
+	out_len = zstd_compress_cctx(zctx->cctx, dst, *dlen, src, slen, &params);
+	if (zstd_is_error(out_len))
 		return -EINVAL;
 	*dlen = out_len;
 	return 0;
@@ -182,8 +182,8 @@ static int __zstd_decompress(const u8 *src, unsigned int slen,
 	size_t out_len;
 	struct zstd_ctx *zctx = ctx;
 
-	out_len = ZSTD_decompressDCtx(zctx->dctx, dst, *dlen, src, slen);
-	if (ZSTD_isError(out_len))
+	out_len = zstd_decompress_dctx(zctx->dctx, dst, *dlen, src, slen);
+	if (zstd_is_error(out_len))
 		return -EINVAL;
 	*dlen = out_len;
 	return 0;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 8e9626d63976..14418b02c189 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -28,10 +28,10 @@
 /* 307s to avoid pathologically clashing with transaction commit */
 #define ZSTD_BTRFS_RECLAIM_JIFFIES (307 * HZ)
 
-static ZSTD_parameters zstd_get_btrfs_parameters(unsigned int level,
+static zstd_parameters zstd_get_btrfs_parameters(unsigned int level,
 						 size_t src_len)
 {
-	ZSTD_parameters params = ZSTD_getParams(level, src_len, 0);
+	zstd_parameters params = zstd_get_params(level, src_len);
 
 	if (params.cParams.windowLog > ZSTD_BTRFS_MAX_WINDOWLOG)
 		params.cParams.windowLog = ZSTD_BTRFS_MAX_WINDOWLOG;
@@ -48,8 +48,8 @@ struct workspace {
 	unsigned long last_used; /* jiffies */
 	struct list_head list;
 	struct list_head lru_list;
-	ZSTD_inBuffer in_buf;
-	ZSTD_outBuffer out_buf;
+	zstd_in_buffer in_buf;
+	zstd_out_buffer out_buf;
 };
 
 /*
@@ -155,12 +155,12 @@ static void zstd_calc_ws_mem_sizes(void)
 	unsigned int level;
 
 	for (level = 1; level <= ZSTD_BTRFS_MAX_LEVEL; level++) {
-		ZSTD_parameters params =
+		zstd_parameters params =
 			zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
 		size_t level_size =
 			max_t(size_t,
-			      ZSTD_CStreamWorkspaceBound(params.cParams),
-			      ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT));
+			      zstd_cstream_workspace_bound(&params.cParams),
+			      zstd_dstream_workspace_bound(ZSTD_BTRFS_MAX_INPUT));
 
 		max_size = max_t(size_t, max_size, level_size);
 		zstd_ws_mem_sizes[level - 1] = max_size;
@@ -371,7 +371,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	ZSTD_CStream *stream;
+	zstd_cstream *stream;
 	int ret = 0;
 	int nr_pages = 0;
 	struct page *in_page = NULL;  /* The current page to read */
@@ -381,7 +381,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	unsigned long len = *total_out;
 	const unsigned long nr_dest_pages = *out_pages;
 	unsigned long max_out = nr_dest_pages * PAGE_SIZE;
-	ZSTD_parameters params = zstd_get_btrfs_parameters(workspace->req_level,
+	zstd_parameters params = zstd_get_btrfs_parameters(workspace->req_level,
 							   len);
 
 	*out_pages = 0;
@@ -389,10 +389,10 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = 0;
 
 	/* Initialize the stream */
-	stream = ZSTD_initCStream(params, len, workspace->mem,
+	stream = zstd_init_cstream(&params, len, workspace->mem,
 			workspace->size);
 	if (!stream) {
-		pr_warn("BTRFS: ZSTD_initCStream failed\n");
+		pr_warn("BTRFS: zstd_init_cstream failed\n");
 		ret = -EIO;
 		goto out;
 	}
@@ -418,11 +418,11 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	while (1) {
 		size_t ret2;
 
-		ret2 = ZSTD_compressStream(stream, &workspace->out_buf,
+		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
-		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_compressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+		if (zstd_is_error(ret2)) {
+			pr_debug("BTRFS: zstd_compress_stream returned %d\n",
+					zstd_get_error_code(ret2));
 			ret = -EIO;
 			goto out;
 		}
@@ -487,10 +487,10 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	while (1) {
 		size_t ret2;
 
-		ret2 = ZSTD_endStream(stream, &workspace->out_buf);
-		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_endStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+		ret2 = zstd_end_stream(stream, &workspace->out_buf);
+		if (zstd_is_error(ret2)) {
+			pr_debug("BTRFS: zstd_end_stream returned %d\n",
+					zstd_get_error_code(ret2));
 			ret = -EIO;
 			goto out;
 		}
@@ -550,17 +550,17 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	u64 disk_start = cb->start;
 	struct bio *orig_bio = cb->orig_bio;
 	size_t srclen = cb->compressed_len;
-	ZSTD_DStream *stream;
+	zstd_dstream *stream;
 	int ret = 0;
 	unsigned long page_in_index = 0;
 	unsigned long total_pages_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
 	unsigned long buf_start;
 	unsigned long total_out = 0;
 
-	stream = ZSTD_initDStream(
+	stream = zstd_init_dstream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
 	if (!stream) {
-		pr_debug("BTRFS: ZSTD_initDStream failed\n");
+		pr_debug("BTRFS: zstd_init_dstream failed\n");
 		ret = -EIO;
 		goto done;
 	}
@@ -576,11 +576,11 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	while (1) {
 		size_t ret2;
 
-		ret2 = ZSTD_decompressStream(stream, &workspace->out_buf,
+		ret2 = zstd_decompress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
-		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_decompressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+		if (zstd_is_error(ret2)) {
+			pr_debug("BTRFS: zstd_decompress_stream returned %d\n",
+					zstd_get_error_code(ret2));
 			ret = -EIO;
 			goto done;
 		}
@@ -626,17 +626,17 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	ZSTD_DStream *stream;
+	zstd_dstream *stream;
 	int ret = 0;
 	size_t ret2;
 	unsigned long total_out = 0;
 	unsigned long pg_offset = 0;
 	char *kaddr;
 
-	stream = ZSTD_initDStream(
+	stream = zstd_init_dstream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
 	if (!stream) {
-		pr_warn("BTRFS: ZSTD_initDStream failed\n");
+		pr_warn("BTRFS: zstd_init_dstream failed\n");
 		ret = -EIO;
 		goto finish;
 	}
@@ -660,15 +660,15 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 
 		/* Check if the frame is over and we still need more input */
 		if (ret2 == 0) {
-			pr_debug("BTRFS: ZSTD_decompressStream ended early\n");
+			pr_debug("BTRFS: zstd_decompress_stream ended early\n");
 			ret = -EIO;
 			goto finish;
 		}
-		ret2 = ZSTD_decompressStream(stream, &workspace->out_buf,
+		ret2 = zstd_decompress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
-		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_decompressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+		if (zstd_is_error(ret2)) {
+			pr_debug("BTRFS: zstd_decompress_stream returned %d\n",
+					zstd_get_error_code(ret2));
 			ret = -EIO;
 			goto finish;
 		}
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 77fa342de38f..b0678900d6b3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -351,8 +351,8 @@ static const struct f2fs_compress_ops f2fs_lz4_ops = {
 
 static int zstd_init_compress_ctx(struct compress_ctx *cc)
 {
-	ZSTD_parameters params;
-	ZSTD_CStream *stream;
+	zstd_parameters params;
+	zstd_cstream *stream;
 	void *workspace;
 	unsigned int workspace_size;
 	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
@@ -361,17 +361,17 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	if (!level)
 		level = F2FS_ZSTD_DEFAULT_CLEVEL;
 
-	params = ZSTD_getParams(level, cc->rlen, 0);
-	workspace_size = ZSTD_CStreamWorkspaceBound(params.cParams);
+	params = zstd_get_params(F2FS_ZSTD_DEFAULT_CLEVEL, cc->rlen);
+	workspace_size = zstd_cstream_workspace_bound(&params.cParams);
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
 					workspace_size, GFP_NOFS);
 	if (!workspace)
 		return -ENOMEM;
 
-	stream = ZSTD_initCStream(params, 0, workspace, workspace_size);
+	stream = zstd_init_cstream(&params, 0, workspace, workspace_size);
 	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initCStream failed\n",
+		printk_ratelimited("%sF2FS-fs (%s): %s zstd_init_cstream failed\n",
 				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
 				__func__);
 		kvfree(workspace);
@@ -394,9 +394,9 @@ static void zstd_destroy_compress_ctx(struct compress_ctx *cc)
 
 static int zstd_compress_pages(struct compress_ctx *cc)
 {
-	ZSTD_CStream *stream = cc->private2;
-	ZSTD_inBuffer inbuf;
-	ZSTD_outBuffer outbuf;
+	zstd_cstream *stream = cc->private2;
+	zstd_in_buffer inbuf;
+	zstd_out_buffer outbuf;
 	int src_size = cc->rlen;
 	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
 	int ret;
@@ -409,19 +409,19 @@ static int zstd_compress_pages(struct compress_ctx *cc)
 	outbuf.dst = cc->cbuf->cdata;
 	outbuf.size = dst_size;
 
-	ret = ZSTD_compressStream(stream, &outbuf, &inbuf);
-	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
+	ret = zstd_compress_stream(stream, &outbuf, &inbuf);
+	if (zstd_is_error(ret)) {
+		printk_ratelimited("%sF2FS-fs (%s): %s zstd_compress_stream failed, ret: %d\n",
 				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
 
-	ret = ZSTD_endStream(stream, &outbuf);
-	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_endStream returned %d\n",
+	ret = zstd_end_stream(stream, &outbuf);
+	if (zstd_is_error(ret)) {
+		printk_ratelimited("%sF2FS-fs (%s): %s zstd_end_stream returned %d\n",
 				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
 
@@ -438,22 +438,22 @@ static int zstd_compress_pages(struct compress_ctx *cc)
 
 static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 {
-	ZSTD_DStream *stream;
+	zstd_dstream *stream;
 	void *workspace;
 	unsigned int workspace_size;
 	unsigned int max_window_size =
 			MAX_COMPRESS_WINDOW_SIZE(dic->log_cluster_size);
 
-	workspace_size = ZSTD_DStreamWorkspaceBound(max_window_size);
+	workspace_size = zstd_dstream_workspace_bound(max_window_size);
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
 					workspace_size, GFP_NOFS);
 	if (!workspace)
 		return -ENOMEM;
 
-	stream = ZSTD_initDStream(max_window_size, workspace, workspace_size);
+	stream = zstd_init_dstream(max_window_size, workspace, workspace_size);
 	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initDStream failed\n",
+		printk_ratelimited("%sF2FS-fs (%s): %s zstd_init_dstream failed\n",
 				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
 				__func__);
 		kvfree(workspace);
@@ -475,9 +475,9 @@ static void zstd_destroy_decompress_ctx(struct decompress_io_ctx *dic)
 
 static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 {
-	ZSTD_DStream *stream = dic->private2;
-	ZSTD_inBuffer inbuf;
-	ZSTD_outBuffer outbuf;
+	zstd_dstream *stream = dic->private2;
+	zstd_in_buffer inbuf;
+	zstd_out_buffer outbuf;
 	int ret;
 
 	inbuf.pos = 0;
@@ -488,11 +488,11 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 	outbuf.dst = dic->rbuf;
 	outbuf.size = dic->rlen;
 
-	ret = ZSTD_decompressStream(stream, &outbuf, &inbuf);
-	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
+	ret = zstd_decompress_stream(stream, &outbuf, &inbuf);
+	if (zstd_is_error(ret)) {
+		printk_ratelimited("%sF2FS-fs (%s): %s zstd_decompress_stream failed, ret: %d\n",
 				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 82592b19b4e0..cab242150f86 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -525,7 +525,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
-	if (!level || level > ZSTD_maxCLevel()) {
+	if (!level || level > zstd_max_clevel()) {
 		f2fs_info(sbi, "invalid zstd compress level: %d", level);
 		return -EINVAL;
 	}
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d963ae7902f9..67b194ba1b03 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -218,7 +218,7 @@ static int zbufsize_842(size_t size)
 #if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
 static int zbufsize_zstd(size_t size)
 {
-	return ZSTD_compressBound(size);
+	return zstd_compress_bound(size);
 }
 #endif
 
diff --git a/fs/squashfs/zstd_wrapper.c b/fs/squashfs/zstd_wrapper.c
index b7cb1faa652d..6967c0aae801 100644
--- a/fs/squashfs/zstd_wrapper.c
+++ b/fs/squashfs/zstd_wrapper.c
@@ -34,7 +34,7 @@ static void *zstd_init(struct squashfs_sb_info *msblk, void *buff)
 		goto failed;
 	wksp->window_size = max_t(size_t,
 			msblk->block_size, SQUASHFS_METADATA_SIZE);
-	wksp->mem_size = ZSTD_DStreamWorkspaceBound(wksp->window_size);
+	wksp->mem_size = zstd_dstream_workspace_bound(wksp->window_size);
 	wksp->mem = vmalloc(wksp->mem_size);
 	if (wksp->mem == NULL)
 		goto failed;
@@ -63,15 +63,15 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	struct squashfs_page_actor *output)
 {
 	struct workspace *wksp = strm;
-	ZSTD_DStream *stream;
+	zstd_dstream *stream;
 	size_t total_out = 0;
 	int error = 0;
-	ZSTD_inBuffer in_buf = { NULL, 0, 0 };
-	ZSTD_outBuffer out_buf = { NULL, 0, 0 };
+	zstd_in_buffer in_buf = { NULL, 0, 0 };
+	zstd_out_buffer out_buf = { NULL, 0, 0 };
 	struct bvec_iter_all iter_all = {};
 	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 
-	stream = ZSTD_initDStream(wksp->window_size, wksp->mem, wksp->mem_size);
+	stream = zstd_init_dstream(wksp->window_size, wksp->mem, wksp->mem_size);
 
 	if (!stream) {
 		ERROR("Failed to initialize zstd decompressor\n");
@@ -116,14 +116,14 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 		}
 
 		total_out -= out_buf.pos;
-		zstd_err = ZSTD_decompressStream(stream, &out_buf, &in_buf);
+		zstd_err = zstd_decompress_stream(stream, &out_buf, &in_buf);
 		total_out += out_buf.pos; /* add the additional data produced */
 		if (zstd_err == 0)
 			break;
 
-		if (ZSTD_isError(zstd_err)) {
+		if (zstd_is_error(zstd_err)) {
 			ERROR("zstd decompression error: %d\n",
-					(int)ZSTD_getErrorCode(zstd_err));
+					(int)zstd_get_error_code(zstd_err));
 			error = -EIO;
 			break;
 		}
diff --git a/include/linux/zstd.h b/include/linux/zstd.h
index e87f78c9b19c..9fbc7729b0a0 100644
--- a/include/linux/zstd.h
+++ b/include/linux/zstd.h
@@ -1,138 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
+ * Copyright (c) Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
- * This source code is licensed under the BSD-style license found in the
- * LICENSE file in the root directory of https://github.com/facebook/zstd.
- * An additional grant of patent rights can be found in the PATENTS file in the
- * same directory.
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation. This program is dual-licensed; you may select
- * either version 2 of the GNU General Public License ("GPL") or BSD license
- * ("BSD").
+ * This source code is licensed under both the BSD-style license (found in the
+ * LICENSE file in the root directory of https://github.com/facebook/zstd) and
+ * the GPLv2 (found in the COPYING file in the root directory of
+ * https://github.com/facebook/zstd). You may select, at your option, one of the
+ * above-listed licenses.
  */
 
-#ifndef ZSTD_H
-#define ZSTD_H
+#ifndef LINUX_ZSTD_H
+#define LINUX_ZSTD_H
 
-/* ======   Dependency   ======*/
-#include <linux/types.h>   /* size_t */
+/**
+ * This is a kernel-style API that wraps the upstream zstd API, which cannot be
+ * used directly because the symbols aren't exported. It exposes the minimal
+ * functionality which is currently required by users of zstd in the kernel.
+ * Expose extra functions from lib/zstd/zstd.h as needed.
+ */
 
+/* ======   Dependency   ====== */
+#include <linux/types.h>
+#include <linux/zstd_lib.h>
 
-/*-*****************************************************************************
- * Introduction
+/* ======   Helper Functions   ====== */
+/**
+ * zstd_compress_bound() - maximum compressed size in worst case scenario
+ * @src_size: The size of the data to compress.
  *
- * zstd, short for Zstandard, is a fast lossless compression algorithm,
- * targeting real-time compression scenarios at zlib-level and better
- * compression ratios. The zstd compression library provides in-memory
- * compression and decompression functions. The library supports compression
- * levels from 1 up to ZSTD_maxCLevel() which is 22. Levels >= 20, labeled
- * ultra, should be used with caution, as they require more memory.
- * Compression can be done in:
- *  - a single step, reusing a context (described as Explicit memory management)
- *  - unbounded multiple steps (described as Streaming compression)
- * The compression ratio achievable on small data can be highly improved using
- * compression with a dictionary in:
- *  - a single step (described as Simple dictionary API)
- *  - a single step, reusing a dictionary (described as Fast dictionary API)
- ******************************************************************************/
-
-/*======  Helper functions  ======*/
+ * Return:    The maximum compressed size in the worst case scenario.
+ */
+size_t zstd_compress_bound(size_t src_size);
 
 /**
- * enum ZSTD_ErrorCode - zstd error codes
+ * zstd_is_error() - tells if a size_t function result is an error code
+ * @code:  The function result to check for error.
  *
- * Functions that return size_t can be checked for errors using ZSTD_isError()
- * and the ZSTD_ErrorCode can be extracted using ZSTD_getErrorCode().
+ * Return: Non-zero iff the code is an error.
+ */
+unsigned int zstd_is_error(size_t code);
+
+/**
+ * enum zstd_error_code - zstd error codes
  */
-typedef enum {
-	ZSTD_error_no_error,
-	ZSTD_error_GENERIC,
-	ZSTD_error_prefix_unknown,
-	ZSTD_error_version_unsupported,
-	ZSTD_error_parameter_unknown,
-	ZSTD_error_frameParameter_unsupported,
-	ZSTD_error_frameParameter_unsupportedBy32bits,
-	ZSTD_error_frameParameter_windowTooLarge,
-	ZSTD_error_compressionParameter_unsupported,
-	ZSTD_error_init_missing,
-	ZSTD_error_memory_allocation,
-	ZSTD_error_stage_wrong,
-	ZSTD_error_dstSize_tooSmall,
-	ZSTD_error_srcSize_wrong,
-	ZSTD_error_corruption_detected,
-	ZSTD_error_checksum_wrong,
-	ZSTD_error_tableLog_tooLarge,
-	ZSTD_error_maxSymbolValue_tooLarge,
-	ZSTD_error_maxSymbolValue_tooSmall,
-	ZSTD_error_dictionary_corrupted,
-	ZSTD_error_dictionary_wrong,
-	ZSTD_error_dictionaryCreation_failed,
-	ZSTD_error_maxCode
-} ZSTD_ErrorCode;
+typedef ZSTD_ErrorCode zstd_error_code;
 
 /**
- * ZSTD_maxCLevel() - maximum compression level available
+ * zstd_get_error_code() - translates an error function result to an error code
+ * @code:  The function result for which zstd_is_error(code) is true.
  *
- * Return: Maximum compression level available.
+ * Return: A unique error code for this error.
  */
-int ZSTD_maxCLevel(void);
+zstd_error_code zstd_get_error_code(size_t code);
+
 /**
- * ZSTD_compressBound() - maximum compressed size in worst case scenario
- * @srcSize: The size of the data to compress.
+ * zstd_get_error_name() - translates an error function result to a string
+ * @code:  The function result for which zstd_is_error(code) is true.
  *
- * Return:   The maximum compressed size in the worst case scenario.
+ * Return: An error string corresponding to the error code.
  */
-size_t ZSTD_compressBound(size_t srcSize);
+const char *zstd_get_error_name(size_t code);
+
 /**
- * ZSTD_isError() - tells if a size_t function result is an error code
- * @code:  The function result to check for error.
+ * zstd_min_clevel() - minimum allowed compression level
  *
- * Return: Non-zero iff the code is an error.
+ * Return: The minimum allowed compression level.
  */
-static __attribute__((unused)) unsigned int ZSTD_isError(size_t code)
-{
-	return code > (size_t)-ZSTD_error_maxCode;
-}
+int zstd_min_clevel(void);
+
 /**
- * ZSTD_getErrorCode() - translates an error function result to a ZSTD_ErrorCode
- * @functionResult: The result of a function for which ZSTD_isError() is true.
+ * zstd_max_clevel() - maximum allowed compression level
  *
- * Return:          The ZSTD_ErrorCode corresponding to the functionResult or 0
- *                  if the functionResult isn't an error.
+ * Return: The maximum allowed compression level.
  */
-static __attribute__((unused)) ZSTD_ErrorCode ZSTD_getErrorCode(
-	size_t functionResult)
-{
-	if (!ZSTD_isError(functionResult))
-		return (ZSTD_ErrorCode)0;
-	return (ZSTD_ErrorCode)(0 - functionResult);
-}
+int zstd_max_clevel(void);
+
+/* ======   Parameter Selection   ====== */
 
 /**
- * enum ZSTD_strategy - zstd compression search strategy
+ * enum zstd_strategy - zstd compression search strategy
  *
- * From faster to stronger.
+ * From faster to stronger. See zstd_lib.h.
  */
-typedef enum {
-	ZSTD_fast,
-	ZSTD_dfast,
-	ZSTD_greedy,
-	ZSTD_lazy,
-	ZSTD_lazy2,
-	ZSTD_btlazy2,
-	ZSTD_btopt,
-	ZSTD_btopt2
-} ZSTD_strategy;
+typedef ZSTD_strategy zstd_strategy;
 
 /**
- * struct ZSTD_compressionParameters - zstd compression parameters
+ * struct zstd_compression_parameters - zstd compression parameters
  * @windowLog:    Log of the largest match distance. Larger means more
  *                compression, and more memory needed during decompression.
- * @chainLog:     Fully searched segment. Larger means more compression, slower,
- *                and more memory (useless for fast).
+ * @chainLog:     Fully searched segment. Larger means more compression,
+ *                slower, and more memory (useless for fast).
  * @hashLog:      Dispatch table. Larger means more compression,
  *                slower, and more memory.
  * @searchLog:    Number of searches. Larger means more compression and slower.
@@ -141,1017 +99,342 @@ typedef enum {
  * @targetLength: Acceptable match size for optimal parser (only). Larger means
  *                more compression, and slower.
  * @strategy:     The zstd compression strategy.
+ *
+ * See zstd_lib.h.
  */
-typedef struct {
-	unsigned int windowLog;
-	unsigned int chainLog;
-	unsigned int hashLog;
-	unsigned int searchLog;
-	unsigned int searchLength;
-	unsigned int targetLength;
-	ZSTD_strategy strategy;
-} ZSTD_compressionParameters;
+typedef ZSTD_compressionParameters zstd_compression_parameters;
 
 /**
- * struct ZSTD_frameParameters - zstd frame parameters
- * @contentSizeFlag: Controls whether content size will be present in the frame
- *                   header (when known).
- * @checksumFlag:    Controls whether a 32-bit checksum is generated at the end
- *                   of the frame for error detection.
- * @noDictIDFlag:    Controls whether dictID will be saved into the frame header
- *                   when using dictionary compression.
+ * struct zstd_frame_parameters - zstd frame parameters
+ * @contentSizeFlag: Controls whether content size will be present in the
+ *                   frame header (when known).
+ * @checksumFlag:    Controls whether a 32-bit checksum is generated at the
+ *                   end of the frame for error detection.
+ * @noDictIDFlag:    Controls whether dictID will be saved into the frame
+ *                   header when using dictionary compression.
  *
- * The default value is all fields set to 0.
+ * The default value is all fields set to 0. See zstd_lib.h.
  */
-typedef struct {
-	unsigned int contentSizeFlag;
-	unsigned int checksumFlag;
-	unsigned int noDictIDFlag;
-} ZSTD_frameParameters;
+typedef ZSTD_frameParameters zstd_frame_parameters;
 
 /**
- * struct ZSTD_parameters - zstd parameters
+ * struct zstd_parameters - zstd parameters
  * @cParams: The compression parameters.
  * @fParams: The frame parameters.
  */
-typedef struct {
-	ZSTD_compressionParameters cParams;
-	ZSTD_frameParameters fParams;
-} ZSTD_parameters;
+typedef ZSTD_parameters zstd_parameters;
 
 /**
- * ZSTD_getCParams() - returns ZSTD_compressionParameters for selected level
- * @compressionLevel: The compression level from 1 to ZSTD_maxCLevel().
- * @estimatedSrcSize: The estimated source size to compress or 0 if unknown.
- * @dictSize:         The dictionary size or 0 if a dictionary isn't being used.
+ * zstd_get_params() - returns zstd_parameters for selected level
+ * @level:              The compression level
+ * @estimated_src_size: The estimated source size to compress or 0
+ *                      if unknown.
  *
- * Return:            The selected ZSTD_compressionParameters.
+ * Return:              The selected zstd_parameters.
  */
-ZSTD_compressionParameters ZSTD_getCParams(int compressionLevel,
-	unsigned long long estimatedSrcSize, size_t dictSize);
+zstd_parameters zstd_get_params(int level,
+	unsigned long long estimated_src_size);
 
-/**
- * ZSTD_getParams() - returns ZSTD_parameters for selected level
- * @compressionLevel: The compression level from 1 to ZSTD_maxCLevel().
- * @estimatedSrcSize: The estimated source size to compress or 0 if unknown.
- * @dictSize:         The dictionary size or 0 if a dictionary isn't being used.
- *
- * The same as ZSTD_getCParams() except also selects the default frame
- * parameters (all zero).
- *
- * Return:            The selected ZSTD_parameters.
- */
-ZSTD_parameters ZSTD_getParams(int compressionLevel,
-	unsigned long long estimatedSrcSize, size_t dictSize);
+/* ======   Single-pass Compression   ====== */
 
-/*-*************************************
- * Explicit memory management
- **************************************/
+typedef ZSTD_CCtx zstd_cctx;
 
 /**
- * ZSTD_CCtxWorkspaceBound() - amount of memory needed to initialize a ZSTD_CCtx
- * @cParams: The compression parameters to be used for compression.
+ * zstd_cctx_workspace_bound() - max memory needed to initialize a zstd_cctx
+ * @parameters: The compression parameters to be used.
  *
  * If multiple compression parameters might be used, the caller must call
- * ZSTD_CCtxWorkspaceBound() for each set of parameters and use the maximum
+ * zstd_cctx_workspace_bound() for each set of parameters and use the maximum
  * size.
  *
- * Return:   A lower bound on the size of the workspace that is passed to
- *           ZSTD_initCCtx().
+ * Return:      A lower bound on the size of the workspace that is passed to
+ *              zstd_init_cctx().
  */
-size_t ZSTD_CCtxWorkspaceBound(ZSTD_compressionParameters cParams);
+size_t zstd_cctx_workspace_bound(const zstd_compression_parameters *parameters);
 
 /**
- * struct ZSTD_CCtx - the zstd compression context
- *
- * When compressing many times it is recommended to allocate a context just once
- * and reuse it for each successive compression operation.
- */
-typedef struct ZSTD_CCtx_s ZSTD_CCtx;
-/**
- * ZSTD_initCCtx() - initialize a zstd compression context
- * @workspace:     The workspace to emplace the context into. It must outlive
- *                 the returned context.
- * @workspaceSize: The size of workspace. Use ZSTD_CCtxWorkspaceBound() to
- *                 determine how large the workspace must be.
- *
- * Return:         A compression context emplaced into workspace.
- */
-ZSTD_CCtx *ZSTD_initCCtx(void *workspace, size_t workspaceSize);
-
-/**
- * ZSTD_compressCCtx() - compress src into dst
- * @ctx:         The context. Must have been initialized with a workspace at
- *               least as large as ZSTD_CCtxWorkspaceBound(params.cParams).
- * @dst:         The buffer to compress src into.
- * @dstCapacity: The size of the destination buffer. May be any size, but
- *               ZSTD_compressBound(srcSize) is guaranteed to be large enough.
- * @src:         The data to compress.
- * @srcSize:     The size of the data to compress.
- * @params:      The parameters to use for compression. See ZSTD_getParams().
- *
- * Return:       The compressed size or an error, which can be checked using
- *               ZSTD_isError().
- */
-size_t ZSTD_compressCCtx(ZSTD_CCtx *ctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize, ZSTD_parameters params);
-
-/**
- * ZSTD_DCtxWorkspaceBound() - amount of memory needed to initialize a ZSTD_DCtx
- *
- * Return: A lower bound on the size of the workspace that is passed to
- *         ZSTD_initDCtx().
- */
-size_t ZSTD_DCtxWorkspaceBound(void);
-
-/**
- * struct ZSTD_DCtx - the zstd decompression context
- *
- * When decompressing many times it is recommended to allocate a context just
- * once and reuse it for each successive decompression operation.
- */
-typedef struct ZSTD_DCtx_s ZSTD_DCtx;
-/**
- * ZSTD_initDCtx() - initialize a zstd decompression context
- * @workspace:     The workspace to emplace the context into. It must outlive
- *                 the returned context.
- * @workspaceSize: The size of workspace. Use ZSTD_DCtxWorkspaceBound() to
- *                 determine how large the workspace must be.
- *
- * Return:         A decompression context emplaced into workspace.
- */
-ZSTD_DCtx *ZSTD_initDCtx(void *workspace, size_t workspaceSize);
-
-/**
- * ZSTD_decompressDCtx() - decompress zstd compressed src into dst
- * @ctx:         The decompression context.
- * @dst:         The buffer to decompress src into.
- * @dstCapacity: The size of the destination buffer. Must be at least as large
- *               as the decompressed size. If the caller cannot upper bound the
- *               decompressed size, then it's better to use the streaming API.
- * @src:         The zstd compressed data to decompress. Multiple concatenated
- *               frames and skippable frames are allowed.
- * @srcSize:     The exact size of the data to decompress.
- *
- * Return:       The decompressed size or an error, which can be checked using
- *               ZSTD_isError().
- */
-size_t ZSTD_decompressDCtx(ZSTD_DCtx *ctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize);
-
-/*-************************
- * Simple dictionary API
- **************************/
-
-/**
- * ZSTD_compress_usingDict() - compress src into dst using a dictionary
- * @ctx:         The context. Must have been initialized with a workspace at
- *               least as large as ZSTD_CCtxWorkspaceBound(params.cParams).
- * @dst:         The buffer to compress src into.
- * @dstCapacity: The size of the destination buffer. May be any size, but
- *               ZSTD_compressBound(srcSize) is guaranteed to be large enough.
- * @src:         The data to compress.
- * @srcSize:     The size of the data to compress.
- * @dict:        The dictionary to use for compression.
- * @dictSize:    The size of the dictionary.
- * @params:      The parameters to use for compression. See ZSTD_getParams().
- *
- * Compression using a predefined dictionary. The same dictionary must be used
- * during decompression.
- *
- * Return:       The compressed size or an error, which can be checked using
- *               ZSTD_isError().
- */
-size_t ZSTD_compress_usingDict(ZSTD_CCtx *ctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize, const void *dict, size_t dictSize,
-	ZSTD_parameters params);
-
-/**
- * ZSTD_decompress_usingDict() - decompress src into dst using a dictionary
- * @ctx:         The decompression context.
- * @dst:         The buffer to decompress src into.
- * @dstCapacity: The size of the destination buffer. Must be at least as large
- *               as the decompressed size. If the caller cannot upper bound the
- *               decompressed size, then it's better to use the streaming API.
- * @src:         The zstd compressed data to decompress. Multiple concatenated
- *               frames and skippable frames are allowed.
- * @srcSize:     The exact size of the data to decompress.
- * @dict:        The dictionary to use for decompression. The same dictionary
- *               must've been used to compress the data.
- * @dictSize:    The size of the dictionary.
- *
- * Return:       The decompressed size or an error, which can be checked using
- *               ZSTD_isError().
- */
-size_t ZSTD_decompress_usingDict(ZSTD_DCtx *ctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize, const void *dict, size_t dictSize);
-
-/*-**************************
- * Fast dictionary API
- ***************************/
-
-/**
- * ZSTD_CDictWorkspaceBound() - memory needed to initialize a ZSTD_CDict
- * @cParams: The compression parameters to be used for compression.
+ * zstd_init_cctx() - initialize a zstd compression context
+ * @workspace:      The workspace to emplace the context into. It must outlive
+ *                  the returned context.
+ * @workspace_size: The size of workspace. Use zstd_cctx_workspace_bound() to
+ *                  determine how large the workspace must be.
  *
- * Return:   A lower bound on the size of the workspace that is passed to
- *           ZSTD_initCDict().
- */
-size_t ZSTD_CDictWorkspaceBound(ZSTD_compressionParameters cParams);
-
-/**
- * struct ZSTD_CDict - a digested dictionary to be used for compression
+ * Return:          A zstd compression context or NULL on error.
  */
-typedef struct ZSTD_CDict_s ZSTD_CDict;
+zstd_cctx *zstd_init_cctx(void *workspace, size_t workspace_size);
 
 /**
- * ZSTD_initCDict() - initialize a digested dictionary for compression
- * @dictBuffer:    The dictionary to digest. The buffer is referenced by the
- *                 ZSTD_CDict so it must outlive the returned ZSTD_CDict.
- * @dictSize:      The size of the dictionary.
- * @params:        The parameters to use for compression. See ZSTD_getParams().
- * @workspace:     The workspace. It must outlive the returned ZSTD_CDict.
- * @workspaceSize: The workspace size. Must be at least
- *                 ZSTD_CDictWorkspaceBound(params.cParams).
+ * zstd_compress_cctx() - compress src into dst with the initialized parameters
+ * @cctx:         The context. Must have been initialized with zstd_init_cctx().
+ * @dst:          The buffer to compress src into.
+ * @dst_capacity: The size of the destination buffer. May be any size, but
+ *                ZSTD_compressBound(srcSize) is guaranteed to be large enough.
+ * @src:          The data to compress.
+ * @src_size:     The size of the data to compress.
+ * @parameters:   The compression parameters to be used.
  *
- * When compressing multiple messages / blocks with the same dictionary it is
- * recommended to load it just once. The ZSTD_CDict merely references the
- * dictBuffer, so it must outlive the returned ZSTD_CDict.
- *
- * Return:         The digested dictionary emplaced into workspace.
+ * Return:        The compressed size or an error, which can be checked using
+ *                zstd_is_error().
  */
-ZSTD_CDict *ZSTD_initCDict(const void *dictBuffer, size_t dictSize,
-	ZSTD_parameters params, void *workspace, size_t workspaceSize);
+size_t zstd_compress_cctx(zstd_cctx *cctx, void *dst, size_t dst_capacity,
+	const void *src, size_t src_size, const zstd_parameters *parameters);
 
-/**
- * ZSTD_compress_usingCDict() - compress src into dst using a ZSTD_CDict
- * @ctx:         The context. Must have been initialized with a workspace at
- *               least as large as ZSTD_CCtxWorkspaceBound(cParams) where
- *               cParams are the compression parameters used to initialize the
- *               cdict.
- * @dst:         The buffer to compress src into.
- * @dstCapacity: The size of the destination buffer. May be any size, but
- *               ZSTD_compressBound(srcSize) is guaranteed to be large enough.
- * @src:         The data to compress.
- * @srcSize:     The size of the data to compress.
- * @cdict:       The digested dictionary to use for compression.
- * @params:      The parameters to use for compression. See ZSTD_getParams().
- *
- * Compression using a digested dictionary. The same dictionary must be used
- * during decompression.
- *
- * Return:       The compressed size or an error, which can be checked using
- *               ZSTD_isError().
- */
-size_t ZSTD_compress_usingCDict(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize, const ZSTD_CDict *cdict);
+/* ======   Single-pass Decompression   ====== */
 
+typedef ZSTD_DCtx zstd_dctx;
 
 /**
- * ZSTD_DDictWorkspaceBound() - memory needed to initialize a ZSTD_DDict
+ * zstd_dctx_workspace_bound() - max memory needed to initialize a zstd_dctx
  *
- * Return:  A lower bound on the size of the workspace that is passed to
- *          ZSTD_initDDict().
- */
-size_t ZSTD_DDictWorkspaceBound(void);
-
-/**
- * struct ZSTD_DDict - a digested dictionary to be used for decompression
+ * Return: A lower bound on the size of the workspace that is passed to
+ *         zstd_init_dctx().
  */
-typedef struct ZSTD_DDict_s ZSTD_DDict;
+size_t zstd_dctx_workspace_bound(void);
 
 /**
- * ZSTD_initDDict() - initialize a digested dictionary for decompression
- * @dictBuffer:    The dictionary to digest. The buffer is referenced by the
- *                 ZSTD_DDict so it must outlive the returned ZSTD_DDict.
- * @dictSize:      The size of the dictionary.
- * @workspace:     The workspace. It must outlive the returned ZSTD_DDict.
- * @workspaceSize: The workspace size. Must be at least
- *                 ZSTD_DDictWorkspaceBound().
- *
- * When decompressing multiple messages / blocks with the same dictionary it is
- * recommended to load it just once. The ZSTD_DDict merely references the
- * dictBuffer, so it must outlive the returned ZSTD_DDict.
+ * zstd_init_dctx() - initialize a zstd decompression context
+ * @workspace:      The workspace to emplace the context into. It must outlive
+ *                  the returned context.
+ * @workspace_size: The size of workspace. Use zstd_dctx_workspace_bound() to
+ *                  determine how large the workspace must be.
  *
- * Return:         The digested dictionary emplaced into workspace.
+ * Return:          A zstd decompression context or NULL on error.
  */
-ZSTD_DDict *ZSTD_initDDict(const void *dictBuffer, size_t dictSize,
-	void *workspace, size_t workspaceSize);
+zstd_dctx *zstd_init_dctx(void *workspace, size_t workspace_size);
 
 /**
- * ZSTD_decompress_usingDDict() - decompress src into dst using a ZSTD_DDict
- * @ctx:         The decompression context.
- * @dst:         The buffer to decompress src into.
- * @dstCapacity: The size of the destination buffer. Must be at least as large
- *               as the decompressed size. If the caller cannot upper bound the
- *               decompressed size, then it's better to use the streaming API.
- * @src:         The zstd compressed data to decompress. Multiple concatenated
- *               frames and skippable frames are allowed.
- * @srcSize:     The exact size of the data to decompress.
- * @ddict:       The digested dictionary to use for decompression. The same
- *               dictionary must've been used to compress the data.
+ * zstd_decompress_dctx() - decompress zstd compressed src into dst
+ * @dctx:         The decompression context.
+ * @dst:          The buffer to decompress src into.
+ * @dst_capacity: The size of the destination buffer. Must be at least as large
+ *                as the decompressed size. If the caller cannot upper bound the
+ *                decompressed size, then it's better to use the streaming API.
+ * @src:          The zstd compressed data to decompress. Multiple concatenated
+ *                frames and skippable frames are allowed.
+ * @src_size:     The exact size of the data to decompress.
  *
- * Return:       The decompressed size or an error, which can be checked using
- *               ZSTD_isError().
+ * Return:        The decompressed size or an error, which can be checked using
+ *                zstd_is_error().
  */
-size_t ZSTD_decompress_usingDDict(ZSTD_DCtx *dctx, void *dst,
-	size_t dstCapacity, const void *src, size_t srcSize,
-	const ZSTD_DDict *ddict);
+size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, size_t dst_capacity,
+	const void *src, size_t src_size);
 
-
-/*-**************************
- * Streaming
- ***************************/
+/* ======   Streaming Buffers   ====== */
 
 /**
- * struct ZSTD_inBuffer - input buffer for streaming
+ * struct zstd_in_buffer - input buffer for streaming
  * @src:  Start of the input buffer.
  * @size: Size of the input buffer.
  * @pos:  Position where reading stopped. Will be updated.
  *        Necessarily 0 <= pos <= size.
+ *
+ * See zstd_lib.h.
  */
-typedef struct ZSTD_inBuffer_s {
-	const void *src;
-	size_t size;
-	size_t pos;
-} ZSTD_inBuffer;
+typedef ZSTD_inBuffer zstd_in_buffer;
 
 /**
- * struct ZSTD_outBuffer - output buffer for streaming
+ * struct zstd_out_buffer - output buffer for streaming
  * @dst:  Start of the output buffer.
  * @size: Size of the output buffer.
  * @pos:  Position where writing stopped. Will be updated.
  *        Necessarily 0 <= pos <= size.
+ *
+ * See zstd_lib.h.
  */
-typedef struct ZSTD_outBuffer_s {
-	void *dst;
-	size_t size;
-	size_t pos;
-} ZSTD_outBuffer;
+typedef ZSTD_outBuffer zstd_out_buffer;
 
+/* ======   Streaming Compression   ====== */
 
-
-/*-*****************************************************************************
- * Streaming compression - HowTo
- *
- * A ZSTD_CStream object is required to track streaming operation.
- * Use ZSTD_initCStream() to initialize a ZSTD_CStream object.
- * ZSTD_CStream objects can be reused multiple times on consecutive compression
- * operations. It is recommended to re-use ZSTD_CStream in situations where many
- * streaming operations will be achieved consecutively. Use one separate
- * ZSTD_CStream per thread for parallel execution.
- *
- * Use ZSTD_compressStream() repetitively to consume input stream.
- * The function will automatically update both `pos` fields.
- * Note that it may not consume the entire input, in which case `pos < size`,
- * and it's up to the caller to present again remaining data.
- * It returns a hint for the preferred number of bytes to use as an input for
- * the next function call.
- *
- * At any moment, it's possible to flush whatever data remains within internal
- * buffer, using ZSTD_flushStream(). `output->pos` will be updated. There might
- * still be some content left within the internal buffer if `output->size` is
- * too small. It returns the number of bytes left in the internal buffer and
- * must be called until it returns 0.
- *
- * ZSTD_endStream() instructs to finish a frame. It will perform a flush and
- * write frame epilogue. The epilogue is required for decoders to consider a
- * frame completed. Similar to ZSTD_flushStream(), it may not be able to flush
- * the full content if `output->size` is too small. In which case, call again
- * ZSTD_endStream() to complete the flush. It returns the number of bytes left
- * in the internal buffer and must be called until it returns 0.
- ******************************************************************************/
+typedef ZSTD_CStream zstd_cstream;
 
 /**
- * ZSTD_CStreamWorkspaceBound() - memory needed to initialize a ZSTD_CStream
- * @cParams: The compression parameters to be used for compression.
+ * zstd_cstream_workspace_bound() - memory needed to initialize a zstd_cstream
+ * @cparams: The compression parameters to be used for compression.
  *
  * Return:   A lower bound on the size of the workspace that is passed to
- *           ZSTD_initCStream() and ZSTD_initCStream_usingCDict().
- */
-size_t ZSTD_CStreamWorkspaceBound(ZSTD_compressionParameters cParams);
-
-/**
- * struct ZSTD_CStream - the zstd streaming compression context
+ *           zstd_init_cstream().
  */
-typedef struct ZSTD_CStream_s ZSTD_CStream;
+size_t zstd_cstream_workspace_bound(const zstd_compression_parameters *cparams);
 
-/*===== ZSTD_CStream management functions =====*/
 /**
- * ZSTD_initCStream() - initialize a zstd streaming compression context
- * @params:         The zstd compression parameters.
- * @pledgedSrcSize: If params.fParams.contentSizeFlag == 1 then the caller must
- *                  pass the source size (zero means empty source). Otherwise,
- *                  the caller may optionally pass the source size, or zero if
- *                  unknown.
- * @workspace:      The workspace to emplace the context into. It must outlive
- *                  the returned context.
- * @workspaceSize:  The size of workspace.
- *                  Use ZSTD_CStreamWorkspaceBound(params.cParams) to determine
- *                  how large the workspace must be.
+ * zstd_init_cstream() - initialize a zstd streaming compression context
+ * @parameters        The zstd parameters to use for compression.
+ * @pledged_src_size: If params.fParams.contentSizeFlag == 1 then the caller
+ *                    must pass the source size (zero means empty source).
+ *                    Otherwise, the caller may optionally pass the source
+ *                    size, or zero if unknown.
+ * @workspace:        The workspace to emplace the context into. It must outlive
+ *                    the returned context.
+ * @workspace_size:   The size of workspace.
+ *                    Use zstd_cstream_workspace_bound(params->cparams) to
+ *                    determine how large the workspace must be.
  *
- * Return:          The zstd streaming compression context.
+ * Return:            The zstd streaming compression context or NULL on error.
  */
-ZSTD_CStream *ZSTD_initCStream(ZSTD_parameters params,
-	unsigned long long pledgedSrcSize, void *workspace,
-	size_t workspaceSize);
+zstd_cstream *zstd_init_cstream(const zstd_parameters *parameters,
+	unsigned long long pledged_src_size, void *workspace, size_t workspace_size);
 
 /**
- * ZSTD_initCStream_usingCDict() - initialize a streaming compression context
- * @cdict:          The digested dictionary to use for compression.
- * @pledgedSrcSize: Optionally the source size, or zero if unknown.
- * @workspace:      The workspace to emplace the context into. It must outlive
- *                  the returned context.
- * @workspaceSize:  The size of workspace. Call ZSTD_CStreamWorkspaceBound()
- *                  with the cParams used to initialize the cdict to determine
- *                  how large the workspace must be.
- *
- * Return:          The zstd streaming compression context.
- */
-ZSTD_CStream *ZSTD_initCStream_usingCDict(const ZSTD_CDict *cdict,
-	unsigned long long pledgedSrcSize, void *workspace,
-	size_t workspaceSize);
-
-/*===== Streaming compression functions =====*/
-/**
- * ZSTD_resetCStream() - reset the context using parameters from creation
- * @zcs:            The zstd streaming compression context to reset.
- * @pledgedSrcSize: Optionally the source size, or zero if unknown.
+ * zstd_reset_cstream() - reset the context using parameters from creation
+ * @cstream:          The zstd streaming compression context to reset.
+ * @pledged_src_size: Optionally the source size, or zero if unknown.
  *
  * Resets the context using the parameters from creation. Skips dictionary
- * loading, since it can be reused. If `pledgedSrcSize` is non-zero the frame
+ * loading, since it can be reused. If `pledged_src_size` is non-zero the frame
  * content size is always written into the frame header.
  *
- * Return:          Zero or an error, which can be checked using ZSTD_isError().
+ * Return:            Zero or an error, which can be checked using
+ *                    zstd_is_error().
  */
-size_t ZSTD_resetCStream(ZSTD_CStream *zcs, unsigned long long pledgedSrcSize);
+size_t zstd_reset_cstream(zstd_cstream *cstream,
+	unsigned long long pledged_src_size);
+
 /**
- * ZSTD_compressStream() - streaming compress some of input into output
- * @zcs:    The zstd streaming compression context.
- * @output: Destination buffer. `output->pos` is updated to indicate how much
- *          compressed data was written.
- * @input:  Source buffer. `input->pos` is updated to indicate how much data was
- *          read. Note that it may not consume the entire input, in which case
- *          `input->pos < input->size`, and it's up to the caller to present
- *          remaining data again.
+ * zstd_compress_stream() - streaming compress some of input into output
+ * @cstream: The zstd streaming compression context.
+ * @output:  Destination buffer. `output->pos` is updated to indicate how much
+ *           compressed data was written.
+ * @input:   Source buffer. `input->pos` is updated to indicate how much data
+ *           was read. Note that it may not consume the entire input, in which
+ *           case `input->pos < input->size`, and it's up to the caller to
+ *           present remaining data again.
  *
  * The `input` and `output` buffers may be any size. Guaranteed to make some
  * forward progress if `input` and `output` are not empty.
  *
- * Return:  A hint for the number of bytes to use as the input for the next
- *          function call or an error, which can be checked using
- *          ZSTD_isError().
+ * Return:   A hint for the number of bytes to use as the input for the next
+ *           function call or an error, which can be checked using
+ *           zstd_is_error().
  */
-size_t ZSTD_compressStream(ZSTD_CStream *zcs, ZSTD_outBuffer *output,
-	ZSTD_inBuffer *input);
+size_t zstd_compress_stream(zstd_cstream *cstream, zstd_out_buffer *output,
+	zstd_in_buffer *input);
+
 /**
- * ZSTD_flushStream() - flush internal buffers into output
- * @zcs:    The zstd streaming compression context.
- * @output: Destination buffer. `output->pos` is updated to indicate how much
- *          compressed data was written.
+ * zstd_flush_stream() - flush internal buffers into output
+ * @cstream: The zstd streaming compression context.
+ * @output:  Destination buffer. `output->pos` is updated to indicate how much
+ *           compressed data was written.
  *
- * ZSTD_flushStream() must be called until it returns 0, meaning all the data
- * has been flushed. Since ZSTD_flushStream() causes a block to be ended,
+ * zstd_flush_stream() must be called until it returns 0, meaning all the data
+ * has been flushed. Since zstd_flush_stream() causes a block to be ended,
  * calling it too often will degrade the compression ratio.
  *
- * Return:  The number of bytes still present within internal buffers or an
- *          error, which can be checked using ZSTD_isError().
- */
-size_t ZSTD_flushStream(ZSTD_CStream *zcs, ZSTD_outBuffer *output);
-/**
- * ZSTD_endStream() - flush internal buffers into output and end the frame
- * @zcs:    The zstd streaming compression context.
- * @output: Destination buffer. `output->pos` is updated to indicate how much
- *          compressed data was written.
- *
- * ZSTD_endStream() must be called until it returns 0, meaning all the data has
- * been flushed and the frame epilogue has been written.
- *
- * Return:  The number of bytes still present within internal buffers or an
- *          error, which can be checked using ZSTD_isError().
+ * Return:   The number of bytes still present within internal buffers or an
+ *           error, which can be checked using zstd_is_error().
  */
-size_t ZSTD_endStream(ZSTD_CStream *zcs, ZSTD_outBuffer *output);
+size_t zstd_flush_stream(zstd_cstream *cstream, zstd_out_buffer *output);
 
 /**
- * ZSTD_CStreamInSize() - recommended size for the input buffer
- *
- * Return: The recommended size for the input buffer.
- */
-size_t ZSTD_CStreamInSize(void);
-/**
- * ZSTD_CStreamOutSize() - recommended size for the output buffer
+ * zstd_end_stream() - flush internal buffers into output and end the frame
+ * @cstream: The zstd streaming compression context.
+ * @output:  Destination buffer. `output->pos` is updated to indicate how much
+ *           compressed data was written.
  *
- * When the output buffer is at least this large, it is guaranteed to be large
- * enough to flush at least one complete compressed block.
+ * zstd_end_stream() must be called until it returns 0, meaning all the data has
+ * been flushed and the frame epilogue has been written.
  *
- * Return: The recommended size for the output buffer.
+ * Return:   The number of bytes still present within internal buffers or an
+ *           error, which can be checked using zstd_is_error().
  */
-size_t ZSTD_CStreamOutSize(void);
+size_t zstd_end_stream(zstd_cstream *cstream, zstd_out_buffer *output);
 
+/* ======   Streaming Decompression   ====== */
 
-
-/*-*****************************************************************************
- * Streaming decompression - HowTo
- *
- * A ZSTD_DStream object is required to track streaming operations.
- * Use ZSTD_initDStream() to initialize a ZSTD_DStream object.
- * ZSTD_DStream objects can be re-used multiple times.
- *
- * Use ZSTD_decompressStream() repetitively to consume your input.
- * The function will update both `pos` fields.
- * If `input->pos < input->size`, some input has not been consumed.
- * It's up to the caller to present again remaining data.
- * If `output->pos < output->size`, decoder has flushed everything it could.
- * Returns 0 iff a frame is completely decoded and fully flushed.
- * Otherwise it returns a suggested next input size that will never load more
- * than the current frame.
- ******************************************************************************/
+typedef ZSTD_DStream zstd_dstream;
 
 /**
- * ZSTD_DStreamWorkspaceBound() - memory needed to initialize a ZSTD_DStream
- * @maxWindowSize: The maximum window size allowed for compressed frames.
+ * zstd_dstream_workspace_bound() - memory needed to initialize a zstd_dstream
+ * @max_window_size: The maximum window size allowed for compressed frames.
  *
- * Return:         A lower bound on the size of the workspace that is passed to
- *                 ZSTD_initDStream() and ZSTD_initDStream_usingDDict().
+ * Return:           A lower bound on the size of the workspace that is passed
+ *                   to zstd_init_dstream().
  */
-size_t ZSTD_DStreamWorkspaceBound(size_t maxWindowSize);
+size_t zstd_dstream_workspace_bound(size_t max_window_size);
 
 /**
- * struct ZSTD_DStream - the zstd streaming decompression context
- */
-typedef struct ZSTD_DStream_s ZSTD_DStream;
-/*===== ZSTD_DStream management functions =====*/
-/**
- * ZSTD_initDStream() - initialize a zstd streaming decompression context
- * @maxWindowSize: The maximum window size allowed for compressed frames.
- * @workspace:     The workspace to emplace the context into. It must outlive
- *                 the returned context.
- * @workspaceSize: The size of workspace.
- *                 Use ZSTD_DStreamWorkspaceBound(maxWindowSize) to determine
- *                 how large the workspace must be.
- *
- * Return:         The zstd streaming decompression context.
- */
-ZSTD_DStream *ZSTD_initDStream(size_t maxWindowSize, void *workspace,
-	size_t workspaceSize);
-/**
- * ZSTD_initDStream_usingDDict() - initialize streaming decompression context
- * @maxWindowSize: The maximum window size allowed for compressed frames.
- * @ddict:         The digested dictionary to use for decompression.
- * @workspace:     The workspace to emplace the context into. It must outlive
- *                 the returned context.
- * @workspaceSize: The size of workspace.
- *                 Use ZSTD_DStreamWorkspaceBound(maxWindowSize) to determine
- *                 how large the workspace must be.
+ * zstd_init_dstream() - initialize a zstd streaming decompression context
+ * @max_window_size: The maximum window size allowed for compressed frames.
+ * @workspace:       The workspace to emplace the context into. It must outlive
+ *                   the returned context.
+ * @workspaceSize:   The size of workspace.
+ *                   Use zstd_dstream_workspace_bound(max_window_size) to
+ *                   determine how large the workspace must be.
  *
- * Return:         The zstd streaming decompression context.
+ * Return:           The zstd streaming decompression context.
  */
-ZSTD_DStream *ZSTD_initDStream_usingDDict(size_t maxWindowSize,
-	const ZSTD_DDict *ddict, void *workspace, size_t workspaceSize);
+zstd_dstream *zstd_init_dstream(size_t max_window_size, void *workspace,
+	size_t workspace_size);
 
-/*===== Streaming decompression functions =====*/
 /**
- * ZSTD_resetDStream() - reset the context using parameters from creation
- * @zds:   The zstd streaming decompression context to reset.
+ * zstd_reset_dstream() - reset the context using parameters from creation
+ * @dstream: The zstd streaming decompression context to reset.
  *
  * Resets the context using the parameters from creation. Skips dictionary
  * loading, since it can be reused.
  *
- * Return: Zero or an error, which can be checked using ZSTD_isError().
+ * Return:   Zero or an error, which can be checked using zstd_is_error().
  */
-size_t ZSTD_resetDStream(ZSTD_DStream *zds);
+size_t zstd_reset_dstream(zstd_dstream *dstream);
+
 /**
- * ZSTD_decompressStream() - streaming decompress some of input into output
- * @zds:    The zstd streaming decompression context.
- * @output: Destination buffer. `output.pos` is updated to indicate how much
- *          decompressed data was written.
- * @input:  Source buffer. `input.pos` is updated to indicate how much data was
- *          read. Note that it may not consume the entire input, in which case
- *          `input.pos < input.size`, and it's up to the caller to present
- *          remaining data again.
+ * zstd_decompress_stream() - streaming decompress some of input into output
+ * @dstream: The zstd streaming decompression context.
+ * @output:  Destination buffer. `output.pos` is updated to indicate how much
+ *           decompressed data was written.
+ * @input:   Source buffer. `input.pos` is updated to indicate how much data was
+ *           read. Note that it may not consume the entire input, in which case
+ *           `input.pos < input.size`, and it's up to the caller to present
+ *           remaining data again.
  *
  * The `input` and `output` buffers may be any size. Guaranteed to make some
  * forward progress if `input` and `output` are not empty.
- * ZSTD_decompressStream() will not consume the last byte of the frame until
+ * zstd_decompress_stream() will not consume the last byte of the frame until
  * the entire frame is flushed.
  *
- * Return:  Returns 0 iff a frame is completely decoded and fully flushed.
- *          Otherwise returns a hint for the number of bytes to use as the input
- *          for the next function call or an error, which can be checked using
- *          ZSTD_isError(). The size hint will never load more than the frame.
- */
-size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output,
-	ZSTD_inBuffer *input);
-
-/**
- * ZSTD_DStreamInSize() - recommended size for the input buffer
- *
- * Return: The recommended size for the input buffer.
- */
-size_t ZSTD_DStreamInSize(void);
-/**
- * ZSTD_DStreamOutSize() - recommended size for the output buffer
- *
- * When the output buffer is at least this large, it is guaranteed to be large
- * enough to flush at least one complete decompressed block.
- *
- * Return: The recommended size for the output buffer.
- */
-size_t ZSTD_DStreamOutSize(void);
-
-
-/* --- Constants ---*/
-#define ZSTD_MAGICNUMBER            0xFD2FB528   /* >= v0.8.0 */
-#define ZSTD_MAGIC_SKIPPABLE_START  0x184D2A50U
-
-#define ZSTD_CONTENTSIZE_UNKNOWN (0ULL - 1)
-#define ZSTD_CONTENTSIZE_ERROR   (0ULL - 2)
-
-#define ZSTD_WINDOWLOG_MAX_32  27
-#define ZSTD_WINDOWLOG_MAX_64  27
-#define ZSTD_WINDOWLOG_MAX \
-	((unsigned int)(sizeof(size_t) == 4 \
-		? ZSTD_WINDOWLOG_MAX_32 \
-		: ZSTD_WINDOWLOG_MAX_64))
-#define ZSTD_WINDOWLOG_MIN 10
-#define ZSTD_HASHLOG_MAX ZSTD_WINDOWLOG_MAX
-#define ZSTD_HASHLOG_MIN        6
-#define ZSTD_CHAINLOG_MAX     (ZSTD_WINDOWLOG_MAX+1)
-#define ZSTD_CHAINLOG_MIN      ZSTD_HASHLOG_MIN
-#define ZSTD_HASHLOG3_MAX      17
-#define ZSTD_SEARCHLOG_MAX    (ZSTD_WINDOWLOG_MAX-1)
-#define ZSTD_SEARCHLOG_MIN      1
-/* only for ZSTD_fast, other strategies are limited to 6 */
-#define ZSTD_SEARCHLENGTH_MAX   7
-/* only for ZSTD_btopt, other strategies are limited to 4 */
-#define ZSTD_SEARCHLENGTH_MIN   3
-#define ZSTD_TARGETLENGTH_MIN   4
-#define ZSTD_TARGETLENGTH_MAX 999
-
-/* for static allocation */
-#define ZSTD_FRAMEHEADERSIZE_MAX 18
-#define ZSTD_FRAMEHEADERSIZE_MIN  6
-#define ZSTD_frameHeaderSize_prefix 5
-#define ZSTD_frameHeaderSize_min ZSTD_FRAMEHEADERSIZE_MIN
-#define ZSTD_frameHeaderSize_max ZSTD_FRAMEHEADERSIZE_MAX
-/* magic number + skippable frame length */
-#define ZSTD_skippableHeaderSize 8
-
-
-/*-*************************************
- * Compressed size functions
- **************************************/
-
-/**
- * ZSTD_findFrameCompressedSize() - returns the size of a compressed frame
- * @src:     Source buffer. It should point to the start of a zstd encoded frame
- *           or a skippable frame.
- * @srcSize: The size of the source buffer. It must be at least as large as the
- *           size of the frame.
- *
- * Return:   The compressed size of the frame pointed to by `src` or an error,
- *           which can be check with ZSTD_isError().
- *           Suitable to pass to ZSTD_decompress() or similar functions.
- */
-size_t ZSTD_findFrameCompressedSize(const void *src, size_t srcSize);
-
-/*-*************************************
- * Decompressed size functions
- **************************************/
-/**
- * ZSTD_getFrameContentSize() - returns the content size in a zstd frame header
- * @src:     It should point to the start of a zstd encoded frame.
- * @srcSize: The size of the source buffer. It must be at least as large as the
- *           frame header. `ZSTD_frameHeaderSize_max` is always large enough.
- *
- * Return:   The frame content size stored in the frame header if known.
- *           `ZSTD_CONTENTSIZE_UNKNOWN` if the content size isn't stored in the
- *           frame header. `ZSTD_CONTENTSIZE_ERROR` on invalid input.
- */
-unsigned long long ZSTD_getFrameContentSize(const void *src, size_t srcSize);
-
-/**
- * ZSTD_findDecompressedSize() - returns decompressed size of a series of frames
- * @src:     It should point to the start of a series of zstd encoded and/or
- *           skippable frames.
- * @srcSize: The exact size of the series of frames.
- *
- * If any zstd encoded frame in the series doesn't have the frame content size
- * set, `ZSTD_CONTENTSIZE_UNKNOWN` is returned. But frame content size is always
- * set when using ZSTD_compress(). The decompressed size can be very large.
- * If the source is untrusted, the decompressed size could be wrong or
- * intentionally modified. Always ensure the result fits within the
- * application's authorized limits. ZSTD_findDecompressedSize() handles multiple
- * frames, and so it must traverse the input to read each frame header. This is
- * efficient as most of the data is skipped, however it does mean that all frame
- * data must be present and valid.
- *
- * Return:   Decompressed size of all the data contained in the frames if known.
- *           `ZSTD_CONTENTSIZE_UNKNOWN` if the decompressed size is unknown.
- *           `ZSTD_CONTENTSIZE_ERROR` if an error occurred.
- */
-unsigned long long ZSTD_findDecompressedSize(const void *src, size_t srcSize);
-
-/*-*************************************
- * Advanced compression functions
- **************************************/
-/**
- * ZSTD_checkCParams() - ensure parameter values remain within authorized range
- * @cParams: The zstd compression parameters.
- *
- * Return:   Zero or an error, which can be checked using ZSTD_isError().
- */
-size_t ZSTD_checkCParams(ZSTD_compressionParameters cParams);
-
-/**
- * ZSTD_adjustCParams() - optimize parameters for a given srcSize and dictSize
- * @srcSize:  Optionally the estimated source size, or zero if unknown.
- * @dictSize: Optionally the estimated dictionary size, or zero if unknown.
- *
- * Return:    The optimized parameters.
- */
-ZSTD_compressionParameters ZSTD_adjustCParams(
-	ZSTD_compressionParameters cParams, unsigned long long srcSize,
-	size_t dictSize);
-
-/*--- Advanced decompression functions ---*/
-
-/**
- * ZSTD_isFrame() - returns true iff the buffer starts with a valid frame
- * @buffer: The source buffer to check.
- * @size:   The size of the source buffer, must be at least 4 bytes.
- *
- * Return: True iff the buffer starts with a zstd or skippable frame identifier.
- */
-unsigned int ZSTD_isFrame(const void *buffer, size_t size);
-
-/**
- * ZSTD_getDictID_fromDict() - returns the dictionary id stored in a dictionary
- * @dict:     The dictionary buffer.
- * @dictSize: The size of the dictionary buffer.
- *
- * Return:    The dictionary id stored within the dictionary or 0 if the
- *            dictionary is not a zstd dictionary. If it returns 0 the
- *            dictionary can still be loaded as a content-only dictionary.
+ * Return:   Returns 0 iff a frame is completely decoded and fully flushed.
+ *           Otherwise returns a hint for the number of bytes to use as the
+ *           input for the next function call or an error, which can be checked
+ *           using zstd_is_error(). The size hint will never load more than the
+ *           frame.
  */
-unsigned int ZSTD_getDictID_fromDict(const void *dict, size_t dictSize);
+size_t zstd_decompress_stream(zstd_dstream *dstream, zstd_out_buffer *output,
+	zstd_in_buffer *input);
 
-/**
- * ZSTD_getDictID_fromDDict() - returns the dictionary id stored in a ZSTD_DDict
- * @ddict: The ddict to find the id of.
- *
- * Return: The dictionary id stored within `ddict` or 0 if the dictionary is not
- *         a zstd dictionary. If it returns 0 `ddict` will be loaded as a
- *         content-only dictionary.
- */
-unsigned int ZSTD_getDictID_fromDDict(const ZSTD_DDict *ddict);
+/* ======   Frame Inspection Functions ====== */
 
 /**
- * ZSTD_getDictID_fromFrame() - returns the dictionary id stored in a zstd frame
- * @src:     Source buffer. It must be a zstd encoded frame.
- * @srcSize: The size of the source buffer. It must be at least as large as the
- *           frame header. `ZSTD_frameHeaderSize_max` is always large enough.
+ * zstd_find_frame_compressed_size() - returns the size of a compressed frame
+ * @src:      Source buffer. It should point to the start of a zstd encoded
+ *            frame or a skippable frame.
+ * @src_size: The size of the source buffer. It must be at least as large as the
+ *            size of the frame.
  *
- * Return:   The dictionary id required to decompress the frame stored within
- *           `src` or 0 if the dictionary id could not be decoded. It can return
- *           0 if the frame does not require a dictionary, the dictionary id
- *           wasn't stored in the frame, `src` is not a zstd frame, or `srcSize`
- *           is too small.
+ * Return:    The compressed size of the frame pointed to by `src` or an error,
+ *            which can be check with zstd_is_error().
+ *            Suitable to pass to ZSTD_decompress() or similar functions.
  */
-unsigned int ZSTD_getDictID_fromFrame(const void *src, size_t srcSize);
+size_t zstd_find_frame_compressed_size(const void *src, size_t src_size);
 
 /**
- * struct ZSTD_frameParams - zstd frame parameters stored in the frame header
+ * struct zstd_frame_params - zstd frame parameters stored in the frame header
  * @frameContentSize: The frame content size, or 0 if not present.
  * @windowSize:       The window size, or 0 if the frame is a skippable frame.
  * @dictID:           The dictionary id, or 0 if not present.
  * @checksumFlag:     Whether a checksum was used.
  */
-typedef struct {
-	unsigned long long frameContentSize;
-	unsigned int windowSize;
-	unsigned int dictID;
-	unsigned int checksumFlag;
-} ZSTD_frameParams;
+typedef ZSTD_frameParams zstd_frame_header;
 
 /**
- * ZSTD_getFrameParams() - extracts parameters from a zstd or skippable frame
- * @fparamsPtr: On success the frame parameters are written here.
- * @src:        The source buffer. It must point to a zstd or skippable frame.
- * @srcSize:    The size of the source buffer. `ZSTD_frameHeaderSize_max` is
- *              always large enough to succeed.
+ * zstd_get_frame_header() - extracts parameters from a zstd or skippable frame
+ * @params:   On success the frame parameters are written here.
+ * @src:      The source buffer. It must point to a zstd or skippable frame.
+ * @src_size: The size of the source buffer.
  *
- * Return:      0 on success. If more data is required it returns how many bytes
- *              must be provided to make forward progress. Otherwise it returns
- *              an error, which can be checked using ZSTD_isError().
+ * Return:    0 on success. If more data is required it returns how many bytes
+ *            must be provided to make forward progress. Otherwise it returns
+ *            an error, which can be checked using zstd_is_error().
  */
-size_t ZSTD_getFrameParams(ZSTD_frameParams *fparamsPtr, const void *src,
-	size_t srcSize);
-
-/*-*****************************************************************************
- * Buffer-less and synchronous inner streaming functions
- *
- * This is an advanced API, giving full control over buffer management, for
- * users which need direct control over memory.
- * But it's also a complex one, with many restrictions (documented below).
- * Prefer using normal streaming API for an easier experience
- ******************************************************************************/
-
-/*-*****************************************************************************
- * Buffer-less streaming compression (synchronous mode)
- *
- * A ZSTD_CCtx object is required to track streaming operations.
- * Use ZSTD_initCCtx() to initialize a context.
- * ZSTD_CCtx object can be re-used multiple times within successive compression
- * operations.
- *
- * Start by initializing a context.
- * Use ZSTD_compressBegin(), or ZSTD_compressBegin_usingDict() for dictionary
- * compression,
- * or ZSTD_compressBegin_advanced(), for finer parameter control.
- * It's also possible to duplicate a reference context which has already been
- * initialized, using ZSTD_copyCCtx()
- *
- * Then, consume your input using ZSTD_compressContinue().
- * There are some important considerations to keep in mind when using this
- * advanced function :
- * - ZSTD_compressContinue() has no internal buffer. It uses externally provided
- *   buffer only.
- * - Interface is synchronous : input is consumed entirely and produce 1+
- *   (or more) compressed blocks.
- * - Caller must ensure there is enough space in `dst` to store compressed data
- *   under worst case scenario. Worst case evaluation is provided by
- *   ZSTD_compressBound().
- *   ZSTD_compressContinue() doesn't guarantee recover after a failed
- *   compression.
- * - ZSTD_compressContinue() presumes prior input ***is still accessible and
- *   unmodified*** (up to maximum distance size, see WindowLog).
- *   It remembers all previous contiguous blocks, plus one separated memory
- *   segment (which can itself consists of multiple contiguous blocks)
- * - ZSTD_compressContinue() detects that prior input has been overwritten when
- *   `src` buffer overlaps. In which case, it will "discard" the relevant memory
- *   section from its history.
- *
- * Finish a frame with ZSTD_compressEnd(), which will write the last block(s)
- * and optional checksum. It's possible to use srcSize==0, in which case, it
- * will write a final empty block to end the frame. Without last block mark,
- * frames will be considered unfinished (corrupted) by decoders.
- *
- * `ZSTD_CCtx` object can be re-used (ZSTD_compressBegin()) to compress some new
- * frame.
- ******************************************************************************/
-
-/*=====   Buffer-less streaming compression functions  =====*/
-size_t ZSTD_compressBegin(ZSTD_CCtx *cctx, int compressionLevel);
-size_t ZSTD_compressBegin_usingDict(ZSTD_CCtx *cctx, const void *dict,
-	size_t dictSize, int compressionLevel);
-size_t ZSTD_compressBegin_advanced(ZSTD_CCtx *cctx, const void *dict,
-	size_t dictSize, ZSTD_parameters params,
-	unsigned long long pledgedSrcSize);
-size_t ZSTD_copyCCtx(ZSTD_CCtx *cctx, const ZSTD_CCtx *preparedCCtx,
-	unsigned long long pledgedSrcSize);
-size_t ZSTD_compressBegin_usingCDict(ZSTD_CCtx *cctx, const ZSTD_CDict *cdict,
-	unsigned long long pledgedSrcSize);
-size_t ZSTD_compressContinue(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize);
-size_t ZSTD_compressEnd(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize);
-
-
-
-/*-*****************************************************************************
- * Buffer-less streaming decompression (synchronous mode)
- *
- * A ZSTD_DCtx object is required to track streaming operations.
- * Use ZSTD_initDCtx() to initialize a context.
- * A ZSTD_DCtx object can be re-used multiple times.
- *
- * First typical operation is to retrieve frame parameters, using
- * ZSTD_getFrameParams(). It fills a ZSTD_frameParams structure which provide
- * important information to correctly decode the frame, such as the minimum
- * rolling buffer size to allocate to decompress data (`windowSize`), and the
- * dictionary ID used.
- * Note: content size is optional, it may not be present. 0 means unknown.
- * Note that these values could be wrong, either because of data malformation,
- * or because an attacker is spoofing deliberate false information. As a
- * consequence, check that values remain within valid application range,
- * especially `windowSize`, before allocation. Each application can set its own
- * limit, depending on local restrictions. For extended interoperability, it is
- * recommended to support at least 8 MB.
- * Frame parameters are extracted from the beginning of the compressed frame.
- * Data fragment must be large enough to ensure successful decoding, typically
- * `ZSTD_frameHeaderSize_max` bytes.
- * Result: 0: successful decoding, the `ZSTD_frameParams` structure is filled.
- *        >0: `srcSize` is too small, provide at least this many bytes.
- *        errorCode, which can be tested using ZSTD_isError().
- *
- * Start decompression, with ZSTD_decompressBegin() or
- * ZSTD_decompressBegin_usingDict(). Alternatively, you can copy a prepared
- * context, using ZSTD_copyDCtx().
- *
- * Then use ZSTD_nextSrcSizeToDecompress() and ZSTD_decompressContinue()
- * alternatively.
- * ZSTD_nextSrcSizeToDecompress() tells how many bytes to provide as 'srcSize'
- * to ZSTD_decompressContinue().
- * ZSTD_decompressContinue() requires this _exact_ amount of bytes, or it will
- * fail.
- *
- * The result of ZSTD_decompressContinue() is the number of bytes regenerated
- * within 'dst' (necessarily <= dstCapacity). It can be zero, which is not an
- * error; it just means ZSTD_decompressContinue() has decoded some metadata
- * item. It can also be an error code, which can be tested with ZSTD_isError().
- *
- * ZSTD_decompressContinue() needs previous data blocks during decompression, up
- * to `windowSize`. They should preferably be located contiguously, prior to
- * current block. Alternatively, a round buffer of sufficient size is also
- * possible. Sufficient size is determined by frame parameters.
- * ZSTD_decompressContinue() is very sensitive to contiguity, if 2 blocks don't
- * follow each other, make sure that either the compressor breaks contiguity at
- * the same place, or that previous contiguous segment is large enough to
- * properly handle maximum back-reference.
- *
- * A frame is fully decoded when ZSTD_nextSrcSizeToDecompress() returns zero.
- * Context can then be reset to start a new decompression.
- *
- * Note: it's possible to know if next input to present is a header or a block,
- * using ZSTD_nextInputType(). This information is not required to properly
- * decode a frame.
- *
- * == Special case: skippable frames ==
- *
- * Skippable frames allow integration of user-defined data into a flow of
- * concatenated frames. Skippable frames will be ignored (skipped) by a
- * decompressor. The format of skippable frames is as follows:
- * a) Skippable frame ID - 4 Bytes, Little endian format, any value from
- *    0x184D2A50 to 0x184D2A5F
- * b) Frame Size - 4 Bytes, Little endian format, unsigned 32-bits
- * c) Frame Content - any content (User Data) of length equal to Frame Size
- * For skippable frames ZSTD_decompressContinue() always returns 0.
- * For skippable frames ZSTD_getFrameParams() returns fparamsPtr->windowLog==0
- * what means that a frame is skippable.
- * Note: If fparamsPtr->frameContentSize==0, it is ambiguous: the frame might
- *       actually be a zstd encoded frame with no content. For purposes of
- *       decompression, it is valid in both cases to skip the frame using
- *       ZSTD_findFrameCompressedSize() to find its size in bytes.
- * It also returns frame size as fparamsPtr->frameContentSize.
- ******************************************************************************/
-
-/*=====   Buffer-less streaming decompression functions  =====*/
-size_t ZSTD_decompressBegin(ZSTD_DCtx *dctx);
-size_t ZSTD_decompressBegin_usingDict(ZSTD_DCtx *dctx, const void *dict,
-	size_t dictSize);
-void   ZSTD_copyDCtx(ZSTD_DCtx *dctx, const ZSTD_DCtx *preparedDCtx);
-size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx *dctx);
-size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize);
-typedef enum {
-	ZSTDnit_frameHeader,
-	ZSTDnit_blockHeader,
-	ZSTDnit_block,
-	ZSTDnit_lastBlock,
-	ZSTDnit_checksum,
-	ZSTDnit_skippableFrame
-} ZSTD_nextInputType_e;
-ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx *dctx);
-
-/*-*****************************************************************************
- * Block functions
- *
- * Block functions produce and decode raw zstd blocks, without frame metadata.
- * Frame metadata cost is typically ~18 bytes, which can be non-negligible for
- * very small blocks (< 100 bytes). User will have to take in charge required
- * information to regenerate data, such as compressed and content sizes.
- *
- * A few rules to respect:
- * - Compressing and decompressing require a context structure
- *   + Use ZSTD_initCCtx() and ZSTD_initDCtx()
- * - It is necessary to init context before starting
- *   + compression : ZSTD_compressBegin()
- *   + decompression : ZSTD_decompressBegin()
- *   + variants _usingDict() are also allowed
- *   + copyCCtx() and copyDCtx() work too
- * - Block size is limited, it must be <= ZSTD_getBlockSizeMax()
- *   + If you need to compress more, cut data into multiple blocks
- *   + Consider using the regular ZSTD_compress() instead, as frame metadata
- *     costs become negligible when source size is large.
- * - When a block is considered not compressible enough, ZSTD_compressBlock()
- *   result will be zero. In which case, nothing is produced into `dst`.
- *   + User must test for such outcome and deal directly with uncompressed data
- *   + ZSTD_decompressBlock() doesn't accept uncompressed data as input!!!
- *   + In case of multiple successive blocks, decoder must be informed of
- *     uncompressed block existence to follow proper history. Use
- *     ZSTD_insertBlock() in such a case.
- ******************************************************************************/
-
-/* Define for static allocation */
-#define ZSTD_BLOCKSIZE_ABSOLUTEMAX (128 * 1024)
-/*=====   Raw zstd block functions  =====*/
-size_t ZSTD_getBlockSizeMax(ZSTD_CCtx *cctx);
-size_t ZSTD_compressBlock(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize);
-size_t ZSTD_decompressBlock(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity,
-	const void *src, size_t srcSize);
-size_t ZSTD_insertBlock(ZSTD_DCtx *dctx, const void *blockStart,
-	size_t blockSize);
+size_t zstd_get_frame_header(zstd_frame_header *params, const void *src,
+	size_t src_size);
 
-#endif  /* ZSTD_H */
+#endif  /* LINUX_ZSTD_H */
diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
new file mode 100644
index 000000000000..13151c34f725
--- /dev/null
+++ b/include/linux/zstd_lib.h
@@ -0,0 +1,1157 @@
+/*
+ * Copyright (c) Yann Collet, Facebook, Inc.
+ * All rights reserved.
+ *
+ * This source code is licensed under the BSD-style license found in the
+ * LICENSE file in the root directory of https://github.com/facebook/zstd.
+ * An additional grant of patent rights can be found in the PATENTS file in the
+ * same directory.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation. This program is dual-licensed; you may select
+ * either version 2 of the GNU General Public License ("GPL") or BSD license
+ * ("BSD").
+ */
+
+#ifndef ZSTD_H
+#define ZSTD_H
+
+/* ======   Dependency   ======*/
+#include <linux/types.h>   /* size_t */
+
+
+/*-*****************************************************************************
+ * Introduction
+ *
+ * zstd, short for Zstandard, is a fast lossless compression algorithm,
+ * targeting real-time compression scenarios at zlib-level and better
+ * compression ratios. The zstd compression library provides in-memory
+ * compression and decompression functions. The library supports compression
+ * levels from 1 up to ZSTD_maxCLevel() which is 22. Levels >= 20, labeled
+ * ultra, should be used with caution, as they require more memory.
+ * Compression can be done in:
+ *  - a single step, reusing a context (described as Explicit memory management)
+ *  - unbounded multiple steps (described as Streaming compression)
+ * The compression ratio achievable on small data can be highly improved using
+ * compression with a dictionary in:
+ *  - a single step (described as Simple dictionary API)
+ *  - a single step, reusing a dictionary (described as Fast dictionary API)
+ ******************************************************************************/
+
+/*======  Helper functions  ======*/
+
+/**
+ * enum ZSTD_ErrorCode - zstd error codes
+ *
+ * Functions that return size_t can be checked for errors using ZSTD_isError()
+ * and the ZSTD_ErrorCode can be extracted using ZSTD_getErrorCode().
+ */
+typedef enum {
+	ZSTD_error_no_error,
+	ZSTD_error_GENERIC,
+	ZSTD_error_prefix_unknown,
+	ZSTD_error_version_unsupported,
+	ZSTD_error_parameter_unknown,
+	ZSTD_error_frameParameter_unsupported,
+	ZSTD_error_frameParameter_unsupportedBy32bits,
+	ZSTD_error_frameParameter_windowTooLarge,
+	ZSTD_error_compressionParameter_unsupported,
+	ZSTD_error_init_missing,
+	ZSTD_error_memory_allocation,
+	ZSTD_error_stage_wrong,
+	ZSTD_error_dstSize_tooSmall,
+	ZSTD_error_srcSize_wrong,
+	ZSTD_error_corruption_detected,
+	ZSTD_error_checksum_wrong,
+	ZSTD_error_tableLog_tooLarge,
+	ZSTD_error_maxSymbolValue_tooLarge,
+	ZSTD_error_maxSymbolValue_tooSmall,
+	ZSTD_error_dictionary_corrupted,
+	ZSTD_error_dictionary_wrong,
+	ZSTD_error_dictionaryCreation_failed,
+	ZSTD_error_maxCode
+} ZSTD_ErrorCode;
+
+/**
+ * ZSTD_maxCLevel() - maximum compression level available
+ *
+ * Return: Maximum compression level available.
+ */
+int ZSTD_maxCLevel(void);
+/**
+ * ZSTD_compressBound() - maximum compressed size in worst case scenario
+ * @srcSize: The size of the data to compress.
+ *
+ * Return:   The maximum compressed size in the worst case scenario.
+ */
+size_t ZSTD_compressBound(size_t srcSize);
+/**
+ * ZSTD_isError() - tells if a size_t function result is an error code
+ * @code:  The function result to check for error.
+ *
+ * Return: Non-zero iff the code is an error.
+ */
+static __attribute__((unused)) unsigned int ZSTD_isError(size_t code)
+{
+	return code > (size_t)-ZSTD_error_maxCode;
+}
+/**
+ * ZSTD_getErrorCode() - translates an error function result to a ZSTD_ErrorCode
+ * @functionResult: The result of a function for which ZSTD_isError() is true.
+ *
+ * Return:          The ZSTD_ErrorCode corresponding to the functionResult or 0
+ *                  if the functionResult isn't an error.
+ */
+static __attribute__((unused)) ZSTD_ErrorCode ZSTD_getErrorCode(
+	size_t functionResult)
+{
+	if (!ZSTD_isError(functionResult))
+		return (ZSTD_ErrorCode)0;
+	return (ZSTD_ErrorCode)(0 - functionResult);
+}
+
+/**
+ * enum ZSTD_strategy - zstd compression search strategy
+ *
+ * From faster to stronger.
+ */
+typedef enum {
+	ZSTD_fast,
+	ZSTD_dfast,
+	ZSTD_greedy,
+	ZSTD_lazy,
+	ZSTD_lazy2,
+	ZSTD_btlazy2,
+	ZSTD_btopt,
+	ZSTD_btopt2
+} ZSTD_strategy;
+
+/**
+ * struct ZSTD_compressionParameters - zstd compression parameters
+ * @windowLog:    Log of the largest match distance. Larger means more
+ *                compression, and more memory needed during decompression.
+ * @chainLog:     Fully searched segment. Larger means more compression, slower,
+ *                and more memory (useless for fast).
+ * @hashLog:      Dispatch table. Larger means more compression,
+ *                slower, and more memory.
+ * @searchLog:    Number of searches. Larger means more compression and slower.
+ * @searchLength: Match length searched. Larger means faster decompression,
+ *                sometimes less compression.
+ * @targetLength: Acceptable match size for optimal parser (only). Larger means
+ *                more compression, and slower.
+ * @strategy:     The zstd compression strategy.
+ */
+typedef struct {
+	unsigned int windowLog;
+	unsigned int chainLog;
+	unsigned int hashLog;
+	unsigned int searchLog;
+	unsigned int searchLength;
+	unsigned int targetLength;
+	ZSTD_strategy strategy;
+} ZSTD_compressionParameters;
+
+/**
+ * struct ZSTD_frameParameters - zstd frame parameters
+ * @contentSizeFlag: Controls whether content size will be present in the frame
+ *                   header (when known).
+ * @checksumFlag:    Controls whether a 32-bit checksum is generated at the end
+ *                   of the frame for error detection.
+ * @noDictIDFlag:    Controls whether dictID will be saved into the frame header
+ *                   when using dictionary compression.
+ *
+ * The default value is all fields set to 0.
+ */
+typedef struct {
+	unsigned int contentSizeFlag;
+	unsigned int checksumFlag;
+	unsigned int noDictIDFlag;
+} ZSTD_frameParameters;
+
+/**
+ * struct ZSTD_parameters - zstd parameters
+ * @cParams: The compression parameters.
+ * @fParams: The frame parameters.
+ */
+typedef struct {
+	ZSTD_compressionParameters cParams;
+	ZSTD_frameParameters fParams;
+} ZSTD_parameters;
+
+/**
+ * ZSTD_getCParams() - returns ZSTD_compressionParameters for selected level
+ * @compressionLevel: The compression level from 1 to ZSTD_maxCLevel().
+ * @estimatedSrcSize: The estimated source size to compress or 0 if unknown.
+ * @dictSize:         The dictionary size or 0 if a dictionary isn't being used.
+ *
+ * Return:            The selected ZSTD_compressionParameters.
+ */
+ZSTD_compressionParameters ZSTD_getCParams(int compressionLevel,
+	unsigned long long estimatedSrcSize, size_t dictSize);
+
+/**
+ * ZSTD_getParams() - returns ZSTD_parameters for selected level
+ * @compressionLevel: The compression level from 1 to ZSTD_maxCLevel().
+ * @estimatedSrcSize: The estimated source size to compress or 0 if unknown.
+ * @dictSize:         The dictionary size or 0 if a dictionary isn't being used.
+ *
+ * The same as ZSTD_getCParams() except also selects the default frame
+ * parameters (all zero).
+ *
+ * Return:            The selected ZSTD_parameters.
+ */
+ZSTD_parameters ZSTD_getParams(int compressionLevel,
+	unsigned long long estimatedSrcSize, size_t dictSize);
+
+/*-*************************************
+ * Explicit memory management
+ **************************************/
+
+/**
+ * ZSTD_CCtxWorkspaceBound() - amount of memory needed to initialize a ZSTD_CCtx
+ * @cParams: The compression parameters to be used for compression.
+ *
+ * If multiple compression parameters might be used, the caller must call
+ * ZSTD_CCtxWorkspaceBound() for each set of parameters and use the maximum
+ * size.
+ *
+ * Return:   A lower bound on the size of the workspace that is passed to
+ *           ZSTD_initCCtx().
+ */
+size_t ZSTD_CCtxWorkspaceBound(ZSTD_compressionParameters cParams);
+
+/**
+ * struct ZSTD_CCtx - the zstd compression context
+ *
+ * When compressing many times it is recommended to allocate a context just once
+ * and reuse it for each successive compression operation.
+ */
+typedef struct ZSTD_CCtx_s ZSTD_CCtx;
+/**
+ * ZSTD_initCCtx() - initialize a zstd compression context
+ * @workspace:     The workspace to emplace the context into. It must outlive
+ *                 the returned context.
+ * @workspaceSize: The size of workspace. Use ZSTD_CCtxWorkspaceBound() to
+ *                 determine how large the workspace must be.
+ *
+ * Return:         A compression context emplaced into workspace.
+ */
+ZSTD_CCtx *ZSTD_initCCtx(void *workspace, size_t workspaceSize);
+
+/**
+ * ZSTD_compressCCtx() - compress src into dst
+ * @ctx:         The context. Must have been initialized with a workspace at
+ *               least as large as ZSTD_CCtxWorkspaceBound(params.cParams).
+ * @dst:         The buffer to compress src into.
+ * @dstCapacity: The size of the destination buffer. May be any size, but
+ *               ZSTD_compressBound(srcSize) is guaranteed to be large enough.
+ * @src:         The data to compress.
+ * @srcSize:     The size of the data to compress.
+ * @params:      The parameters to use for compression. See ZSTD_getParams().
+ *
+ * Return:       The compressed size or an error, which can be checked using
+ *               ZSTD_isError().
+ */
+size_t ZSTD_compressCCtx(ZSTD_CCtx *ctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize, ZSTD_parameters params);
+
+/**
+ * ZSTD_DCtxWorkspaceBound() - amount of memory needed to initialize a ZSTD_DCtx
+ *
+ * Return: A lower bound on the size of the workspace that is passed to
+ *         ZSTD_initDCtx().
+ */
+size_t ZSTD_DCtxWorkspaceBound(void);
+
+/**
+ * struct ZSTD_DCtx - the zstd decompression context
+ *
+ * When decompressing many times it is recommended to allocate a context just
+ * once and reuse it for each successive decompression operation.
+ */
+typedef struct ZSTD_DCtx_s ZSTD_DCtx;
+/**
+ * ZSTD_initDCtx() - initialize a zstd decompression context
+ * @workspace:     The workspace to emplace the context into. It must outlive
+ *                 the returned context.
+ * @workspaceSize: The size of workspace. Use ZSTD_DCtxWorkspaceBound() to
+ *                 determine how large the workspace must be.
+ *
+ * Return:         A decompression context emplaced into workspace.
+ */
+ZSTD_DCtx *ZSTD_initDCtx(void *workspace, size_t workspaceSize);
+
+/**
+ * ZSTD_decompressDCtx() - decompress zstd compressed src into dst
+ * @ctx:         The decompression context.
+ * @dst:         The buffer to decompress src into.
+ * @dstCapacity: The size of the destination buffer. Must be at least as large
+ *               as the decompressed size. If the caller cannot upper bound the
+ *               decompressed size, then it's better to use the streaming API.
+ * @src:         The zstd compressed data to decompress. Multiple concatenated
+ *               frames and skippable frames are allowed.
+ * @srcSize:     The exact size of the data to decompress.
+ *
+ * Return:       The decompressed size or an error, which can be checked using
+ *               ZSTD_isError().
+ */
+size_t ZSTD_decompressDCtx(ZSTD_DCtx *ctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize);
+
+/*-************************
+ * Simple dictionary API
+ **************************/
+
+/**
+ * ZSTD_compress_usingDict() - compress src into dst using a dictionary
+ * @ctx:         The context. Must have been initialized with a workspace at
+ *               least as large as ZSTD_CCtxWorkspaceBound(params.cParams).
+ * @dst:         The buffer to compress src into.
+ * @dstCapacity: The size of the destination buffer. May be any size, but
+ *               ZSTD_compressBound(srcSize) is guaranteed to be large enough.
+ * @src:         The data to compress.
+ * @srcSize:     The size of the data to compress.
+ * @dict:        The dictionary to use for compression.
+ * @dictSize:    The size of the dictionary.
+ * @params:      The parameters to use for compression. See ZSTD_getParams().
+ *
+ * Compression using a predefined dictionary. The same dictionary must be used
+ * during decompression.
+ *
+ * Return:       The compressed size or an error, which can be checked using
+ *               ZSTD_isError().
+ */
+size_t ZSTD_compress_usingDict(ZSTD_CCtx *ctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize, const void *dict, size_t dictSize,
+	ZSTD_parameters params);
+
+/**
+ * ZSTD_decompress_usingDict() - decompress src into dst using a dictionary
+ * @ctx:         The decompression context.
+ * @dst:         The buffer to decompress src into.
+ * @dstCapacity: The size of the destination buffer. Must be at least as large
+ *               as the decompressed size. If the caller cannot upper bound the
+ *               decompressed size, then it's better to use the streaming API.
+ * @src:         The zstd compressed data to decompress. Multiple concatenated
+ *               frames and skippable frames are allowed.
+ * @srcSize:     The exact size of the data to decompress.
+ * @dict:        The dictionary to use for decompression. The same dictionary
+ *               must've been used to compress the data.
+ * @dictSize:    The size of the dictionary.
+ *
+ * Return:       The decompressed size or an error, which can be checked using
+ *               ZSTD_isError().
+ */
+size_t ZSTD_decompress_usingDict(ZSTD_DCtx *ctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize, const void *dict, size_t dictSize);
+
+/*-**************************
+ * Fast dictionary API
+ ***************************/
+
+/**
+ * ZSTD_CDictWorkspaceBound() - memory needed to initialize a ZSTD_CDict
+ * @cParams: The compression parameters to be used for compression.
+ *
+ * Return:   A lower bound on the size of the workspace that is passed to
+ *           ZSTD_initCDict().
+ */
+size_t ZSTD_CDictWorkspaceBound(ZSTD_compressionParameters cParams);
+
+/**
+ * struct ZSTD_CDict - a digested dictionary to be used for compression
+ */
+typedef struct ZSTD_CDict_s ZSTD_CDict;
+
+/**
+ * ZSTD_initCDict() - initialize a digested dictionary for compression
+ * @dictBuffer:    The dictionary to digest. The buffer is referenced by the
+ *                 ZSTD_CDict so it must outlive the returned ZSTD_CDict.
+ * @dictSize:      The size of the dictionary.
+ * @params:        The parameters to use for compression. See ZSTD_getParams().
+ * @workspace:     The workspace. It must outlive the returned ZSTD_CDict.
+ * @workspaceSize: The workspace size. Must be at least
+ *                 ZSTD_CDictWorkspaceBound(params.cParams).
+ *
+ * When compressing multiple messages / blocks with the same dictionary it is
+ * recommended to load it just once. The ZSTD_CDict merely references the
+ * dictBuffer, so it must outlive the returned ZSTD_CDict.
+ *
+ * Return:         The digested dictionary emplaced into workspace.
+ */
+ZSTD_CDict *ZSTD_initCDict(const void *dictBuffer, size_t dictSize,
+	ZSTD_parameters params, void *workspace, size_t workspaceSize);
+
+/**
+ * ZSTD_compress_usingCDict() - compress src into dst using a ZSTD_CDict
+ * @ctx:         The context. Must have been initialized with a workspace at
+ *               least as large as ZSTD_CCtxWorkspaceBound(cParams) where
+ *               cParams are the compression parameters used to initialize the
+ *               cdict.
+ * @dst:         The buffer to compress src into.
+ * @dstCapacity: The size of the destination buffer. May be any size, but
+ *               ZSTD_compressBound(srcSize) is guaranteed to be large enough.
+ * @src:         The data to compress.
+ * @srcSize:     The size of the data to compress.
+ * @cdict:       The digested dictionary to use for compression.
+ * @params:      The parameters to use for compression. See ZSTD_getParams().
+ *
+ * Compression using a digested dictionary. The same dictionary must be used
+ * during decompression.
+ *
+ * Return:       The compressed size or an error, which can be checked using
+ *               ZSTD_isError().
+ */
+size_t ZSTD_compress_usingCDict(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize, const ZSTD_CDict *cdict);
+
+
+/**
+ * ZSTD_DDictWorkspaceBound() - memory needed to initialize a ZSTD_DDict
+ *
+ * Return:  A lower bound on the size of the workspace that is passed to
+ *          ZSTD_initDDict().
+ */
+size_t ZSTD_DDictWorkspaceBound(void);
+
+/**
+ * struct ZSTD_DDict - a digested dictionary to be used for decompression
+ */
+typedef struct ZSTD_DDict_s ZSTD_DDict;
+
+/**
+ * ZSTD_initDDict() - initialize a digested dictionary for decompression
+ * @dictBuffer:    The dictionary to digest. The buffer is referenced by the
+ *                 ZSTD_DDict so it must outlive the returned ZSTD_DDict.
+ * @dictSize:      The size of the dictionary.
+ * @workspace:     The workspace. It must outlive the returned ZSTD_DDict.
+ * @workspaceSize: The workspace size. Must be at least
+ *                 ZSTD_DDictWorkspaceBound().
+ *
+ * When decompressing multiple messages / blocks with the same dictionary it is
+ * recommended to load it just once. The ZSTD_DDict merely references the
+ * dictBuffer, so it must outlive the returned ZSTD_DDict.
+ *
+ * Return:         The digested dictionary emplaced into workspace.
+ */
+ZSTD_DDict *ZSTD_initDDict(const void *dictBuffer, size_t dictSize,
+	void *workspace, size_t workspaceSize);
+
+/**
+ * ZSTD_decompress_usingDDict() - decompress src into dst using a ZSTD_DDict
+ * @ctx:         The decompression context.
+ * @dst:         The buffer to decompress src into.
+ * @dstCapacity: The size of the destination buffer. Must be at least as large
+ *               as the decompressed size. If the caller cannot upper bound the
+ *               decompressed size, then it's better to use the streaming API.
+ * @src:         The zstd compressed data to decompress. Multiple concatenated
+ *               frames and skippable frames are allowed.
+ * @srcSize:     The exact size of the data to decompress.
+ * @ddict:       The digested dictionary to use for decompression. The same
+ *               dictionary must've been used to compress the data.
+ *
+ * Return:       The decompressed size or an error, which can be checked using
+ *               ZSTD_isError().
+ */
+size_t ZSTD_decompress_usingDDict(ZSTD_DCtx *dctx, void *dst,
+	size_t dstCapacity, const void *src, size_t srcSize,
+	const ZSTD_DDict *ddict);
+
+
+/*-**************************
+ * Streaming
+ ***************************/
+
+/**
+ * struct ZSTD_inBuffer - input buffer for streaming
+ * @src:  Start of the input buffer.
+ * @size: Size of the input buffer.
+ * @pos:  Position where reading stopped. Will be updated.
+ *        Necessarily 0 <= pos <= size.
+ */
+typedef struct ZSTD_inBuffer_s {
+	const void *src;
+	size_t size;
+	size_t pos;
+} ZSTD_inBuffer;
+
+/**
+ * struct ZSTD_outBuffer - output buffer for streaming
+ * @dst:  Start of the output buffer.
+ * @size: Size of the output buffer.
+ * @pos:  Position where writing stopped. Will be updated.
+ *        Necessarily 0 <= pos <= size.
+ */
+typedef struct ZSTD_outBuffer_s {
+	void *dst;
+	size_t size;
+	size_t pos;
+} ZSTD_outBuffer;
+
+
+
+/*-*****************************************************************************
+ * Streaming compression - HowTo
+ *
+ * A ZSTD_CStream object is required to track streaming operation.
+ * Use ZSTD_initCStream() to initialize a ZSTD_CStream object.
+ * ZSTD_CStream objects can be reused multiple times on consecutive compression
+ * operations. It is recommended to re-use ZSTD_CStream in situations where many
+ * streaming operations will be achieved consecutively. Use one separate
+ * ZSTD_CStream per thread for parallel execution.
+ *
+ * Use ZSTD_compressStream() repetitively to consume input stream.
+ * The function will automatically update both `pos` fields.
+ * Note that it may not consume the entire input, in which case `pos < size`,
+ * and it's up to the caller to present again remaining data.
+ * It returns a hint for the preferred number of bytes to use as an input for
+ * the next function call.
+ *
+ * At any moment, it's possible to flush whatever data remains within internal
+ * buffer, using ZSTD_flushStream(). `output->pos` will be updated. There might
+ * still be some content left within the internal buffer if `output->size` is
+ * too small. It returns the number of bytes left in the internal buffer and
+ * must be called until it returns 0.
+ *
+ * ZSTD_endStream() instructs to finish a frame. It will perform a flush and
+ * write frame epilogue. The epilogue is required for decoders to consider a
+ * frame completed. Similar to ZSTD_flushStream(), it may not be able to flush
+ * the full content if `output->size` is too small. In which case, call again
+ * ZSTD_endStream() to complete the flush. It returns the number of bytes left
+ * in the internal buffer and must be called until it returns 0.
+ ******************************************************************************/
+
+/**
+ * ZSTD_CStreamWorkspaceBound() - memory needed to initialize a ZSTD_CStream
+ * @cParams: The compression parameters to be used for compression.
+ *
+ * Return:   A lower bound on the size of the workspace that is passed to
+ *           ZSTD_initCStream() and ZSTD_initCStream_usingCDict().
+ */
+size_t ZSTD_CStreamWorkspaceBound(ZSTD_compressionParameters cParams);
+
+/**
+ * struct ZSTD_CStream - the zstd streaming compression context
+ */
+typedef struct ZSTD_CStream_s ZSTD_CStream;
+
+/*===== ZSTD_CStream management functions =====*/
+/**
+ * ZSTD_initCStream() - initialize a zstd streaming compression context
+ * @params:         The zstd compression parameters.
+ * @pledgedSrcSize: If params.fParams.contentSizeFlag == 1 then the caller must
+ *                  pass the source size (zero means empty source). Otherwise,
+ *                  the caller may optionally pass the source size, or zero if
+ *                  unknown.
+ * @workspace:      The workspace to emplace the context into. It must outlive
+ *                  the returned context.
+ * @workspaceSize:  The size of workspace.
+ *                  Use ZSTD_CStreamWorkspaceBound(params.cParams) to determine
+ *                  how large the workspace must be.
+ *
+ * Return:          The zstd streaming compression context.
+ */
+ZSTD_CStream *ZSTD_initCStream(ZSTD_parameters params,
+	unsigned long long pledgedSrcSize, void *workspace,
+	size_t workspaceSize);
+
+/**
+ * ZSTD_initCStream_usingCDict() - initialize a streaming compression context
+ * @cdict:          The digested dictionary to use for compression.
+ * @pledgedSrcSize: Optionally the source size, or zero if unknown.
+ * @workspace:      The workspace to emplace the context into. It must outlive
+ *                  the returned context.
+ * @workspaceSize:  The size of workspace. Call ZSTD_CStreamWorkspaceBound()
+ *                  with the cParams used to initialize the cdict to determine
+ *                  how large the workspace must be.
+ *
+ * Return:          The zstd streaming compression context.
+ */
+ZSTD_CStream *ZSTD_initCStream_usingCDict(const ZSTD_CDict *cdict,
+	unsigned long long pledgedSrcSize, void *workspace,
+	size_t workspaceSize);
+
+/*===== Streaming compression functions =====*/
+/**
+ * ZSTD_resetCStream() - reset the context using parameters from creation
+ * @zcs:            The zstd streaming compression context to reset.
+ * @pledgedSrcSize: Optionally the source size, or zero if unknown.
+ *
+ * Resets the context using the parameters from creation. Skips dictionary
+ * loading, since it can be reused. If `pledgedSrcSize` is non-zero the frame
+ * content size is always written into the frame header.
+ *
+ * Return:          Zero or an error, which can be checked using ZSTD_isError().
+ */
+size_t ZSTD_resetCStream(ZSTD_CStream *zcs, unsigned long long pledgedSrcSize);
+/**
+ * ZSTD_compressStream() - streaming compress some of input into output
+ * @zcs:    The zstd streaming compression context.
+ * @output: Destination buffer. `output->pos` is updated to indicate how much
+ *          compressed data was written.
+ * @input:  Source buffer. `input->pos` is updated to indicate how much data was
+ *          read. Note that it may not consume the entire input, in which case
+ *          `input->pos < input->size`, and it's up to the caller to present
+ *          remaining data again.
+ *
+ * The `input` and `output` buffers may be any size. Guaranteed to make some
+ * forward progress if `input` and `output` are not empty.
+ *
+ * Return:  A hint for the number of bytes to use as the input for the next
+ *          function call or an error, which can be checked using
+ *          ZSTD_isError().
+ */
+size_t ZSTD_compressStream(ZSTD_CStream *zcs, ZSTD_outBuffer *output,
+	ZSTD_inBuffer *input);
+/**
+ * ZSTD_flushStream() - flush internal buffers into output
+ * @zcs:    The zstd streaming compression context.
+ * @output: Destination buffer. `output->pos` is updated to indicate how much
+ *          compressed data was written.
+ *
+ * ZSTD_flushStream() must be called until it returns 0, meaning all the data
+ * has been flushed. Since ZSTD_flushStream() causes a block to be ended,
+ * calling it too often will degrade the compression ratio.
+ *
+ * Return:  The number of bytes still present within internal buffers or an
+ *          error, which can be checked using ZSTD_isError().
+ */
+size_t ZSTD_flushStream(ZSTD_CStream *zcs, ZSTD_outBuffer *output);
+/**
+ * ZSTD_endStream() - flush internal buffers into output and end the frame
+ * @zcs:    The zstd streaming compression context.
+ * @output: Destination buffer. `output->pos` is updated to indicate how much
+ *          compressed data was written.
+ *
+ * ZSTD_endStream() must be called until it returns 0, meaning all the data has
+ * been flushed and the frame epilogue has been written.
+ *
+ * Return:  The number of bytes still present within internal buffers or an
+ *          error, which can be checked using ZSTD_isError().
+ */
+size_t ZSTD_endStream(ZSTD_CStream *zcs, ZSTD_outBuffer *output);
+
+/**
+ * ZSTD_CStreamInSize() - recommended size for the input buffer
+ *
+ * Return: The recommended size for the input buffer.
+ */
+size_t ZSTD_CStreamInSize(void);
+/**
+ * ZSTD_CStreamOutSize() - recommended size for the output buffer
+ *
+ * When the output buffer is at least this large, it is guaranteed to be large
+ * enough to flush at least one complete compressed block.
+ *
+ * Return: The recommended size for the output buffer.
+ */
+size_t ZSTD_CStreamOutSize(void);
+
+
+
+/*-*****************************************************************************
+ * Streaming decompression - HowTo
+ *
+ * A ZSTD_DStream object is required to track streaming operations.
+ * Use ZSTD_initDStream() to initialize a ZSTD_DStream object.
+ * ZSTD_DStream objects can be re-used multiple times.
+ *
+ * Use ZSTD_decompressStream() repetitively to consume your input.
+ * The function will update both `pos` fields.
+ * If `input->pos < input->size`, some input has not been consumed.
+ * It's up to the caller to present again remaining data.
+ * If `output->pos < output->size`, decoder has flushed everything it could.
+ * Returns 0 iff a frame is completely decoded and fully flushed.
+ * Otherwise it returns a suggested next input size that will never load more
+ * than the current frame.
+ ******************************************************************************/
+
+/**
+ * ZSTD_DStreamWorkspaceBound() - memory needed to initialize a ZSTD_DStream
+ * @maxWindowSize: The maximum window size allowed for compressed frames.
+ *
+ * Return:         A lower bound on the size of the workspace that is passed to
+ *                 ZSTD_initDStream() and ZSTD_initDStream_usingDDict().
+ */
+size_t ZSTD_DStreamWorkspaceBound(size_t maxWindowSize);
+
+/**
+ * struct ZSTD_DStream - the zstd streaming decompression context
+ */
+typedef struct ZSTD_DStream_s ZSTD_DStream;
+/*===== ZSTD_DStream management functions =====*/
+/**
+ * ZSTD_initDStream() - initialize a zstd streaming decompression context
+ * @maxWindowSize: The maximum window size allowed for compressed frames.
+ * @workspace:     The workspace to emplace the context into. It must outlive
+ *                 the returned context.
+ * @workspaceSize: The size of workspace.
+ *                 Use ZSTD_DStreamWorkspaceBound(maxWindowSize) to determine
+ *                 how large the workspace must be.
+ *
+ * Return:         The zstd streaming decompression context.
+ */
+ZSTD_DStream *ZSTD_initDStream(size_t maxWindowSize, void *workspace,
+	size_t workspaceSize);
+/**
+ * ZSTD_initDStream_usingDDict() - initialize streaming decompression context
+ * @maxWindowSize: The maximum window size allowed for compressed frames.
+ * @ddict:         The digested dictionary to use for decompression.
+ * @workspace:     The workspace to emplace the context into. It must outlive
+ *                 the returned context.
+ * @workspaceSize: The size of workspace.
+ *                 Use ZSTD_DStreamWorkspaceBound(maxWindowSize) to determine
+ *                 how large the workspace must be.
+ *
+ * Return:         The zstd streaming decompression context.
+ */
+ZSTD_DStream *ZSTD_initDStream_usingDDict(size_t maxWindowSize,
+	const ZSTD_DDict *ddict, void *workspace, size_t workspaceSize);
+
+/*===== Streaming decompression functions =====*/
+/**
+ * ZSTD_resetDStream() - reset the context using parameters from creation
+ * @zds:   The zstd streaming decompression context to reset.
+ *
+ * Resets the context using the parameters from creation. Skips dictionary
+ * loading, since it can be reused.
+ *
+ * Return: Zero or an error, which can be checked using ZSTD_isError().
+ */
+size_t ZSTD_resetDStream(ZSTD_DStream *zds);
+/**
+ * ZSTD_decompressStream() - streaming decompress some of input into output
+ * @zds:    The zstd streaming decompression context.
+ * @output: Destination buffer. `output.pos` is updated to indicate how much
+ *          decompressed data was written.
+ * @input:  Source buffer. `input.pos` is updated to indicate how much data was
+ *          read. Note that it may not consume the entire input, in which case
+ *          `input.pos < input.size`, and it's up to the caller to present
+ *          remaining data again.
+ *
+ * The `input` and `output` buffers may be any size. Guaranteed to make some
+ * forward progress if `input` and `output` are not empty.
+ * ZSTD_decompressStream() will not consume the last byte of the frame until
+ * the entire frame is flushed.
+ *
+ * Return:  Returns 0 iff a frame is completely decoded and fully flushed.
+ *          Otherwise returns a hint for the number of bytes to use as the input
+ *          for the next function call or an error, which can be checked using
+ *          ZSTD_isError(). The size hint will never load more than the frame.
+ */
+size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output,
+	ZSTD_inBuffer *input);
+
+/**
+ * ZSTD_DStreamInSize() - recommended size for the input buffer
+ *
+ * Return: The recommended size for the input buffer.
+ */
+size_t ZSTD_DStreamInSize(void);
+/**
+ * ZSTD_DStreamOutSize() - recommended size for the output buffer
+ *
+ * When the output buffer is at least this large, it is guaranteed to be large
+ * enough to flush at least one complete decompressed block.
+ *
+ * Return: The recommended size for the output buffer.
+ */
+size_t ZSTD_DStreamOutSize(void);
+
+
+/* --- Constants ---*/
+#define ZSTD_MAGICNUMBER            0xFD2FB528   /* >= v0.8.0 */
+#define ZSTD_MAGIC_SKIPPABLE_START  0x184D2A50U
+
+#define ZSTD_CONTENTSIZE_UNKNOWN (0ULL - 1)
+#define ZSTD_CONTENTSIZE_ERROR   (0ULL - 2)
+
+#define ZSTD_WINDOWLOG_MAX_32  27
+#define ZSTD_WINDOWLOG_MAX_64  27
+#define ZSTD_WINDOWLOG_MAX \
+	((unsigned int)(sizeof(size_t) == 4 \
+		? ZSTD_WINDOWLOG_MAX_32 \
+		: ZSTD_WINDOWLOG_MAX_64))
+#define ZSTD_WINDOWLOG_MIN 10
+#define ZSTD_HASHLOG_MAX ZSTD_WINDOWLOG_MAX
+#define ZSTD_HASHLOG_MIN        6
+#define ZSTD_CHAINLOG_MAX     (ZSTD_WINDOWLOG_MAX+1)
+#define ZSTD_CHAINLOG_MIN      ZSTD_HASHLOG_MIN
+#define ZSTD_HASHLOG3_MAX      17
+#define ZSTD_SEARCHLOG_MAX    (ZSTD_WINDOWLOG_MAX-1)
+#define ZSTD_SEARCHLOG_MIN      1
+/* only for ZSTD_fast, other strategies are limited to 6 */
+#define ZSTD_SEARCHLENGTH_MAX   7
+/* only for ZSTD_btopt, other strategies are limited to 4 */
+#define ZSTD_SEARCHLENGTH_MIN   3
+#define ZSTD_TARGETLENGTH_MIN   4
+#define ZSTD_TARGETLENGTH_MAX 999
+
+/* for static allocation */
+#define ZSTD_FRAMEHEADERSIZE_MAX 18
+#define ZSTD_FRAMEHEADERSIZE_MIN  6
+#define ZSTD_frameHeaderSize_prefix 5
+#define ZSTD_frameHeaderSize_min ZSTD_FRAMEHEADERSIZE_MIN
+#define ZSTD_frameHeaderSize_max ZSTD_FRAMEHEADERSIZE_MAX
+/* magic number + skippable frame length */
+#define ZSTD_skippableHeaderSize 8
+
+
+/*-*************************************
+ * Compressed size functions
+ **************************************/
+
+/**
+ * ZSTD_findFrameCompressedSize() - returns the size of a compressed frame
+ * @src:     Source buffer. It should point to the start of a zstd encoded frame
+ *           or a skippable frame.
+ * @srcSize: The size of the source buffer. It must be at least as large as the
+ *           size of the frame.
+ *
+ * Return:   The compressed size of the frame pointed to by `src` or an error,
+ *           which can be check with ZSTD_isError().
+ *           Suitable to pass to ZSTD_decompress() or similar functions.
+ */
+size_t ZSTD_findFrameCompressedSize(const void *src, size_t srcSize);
+
+/*-*************************************
+ * Decompressed size functions
+ **************************************/
+/**
+ * ZSTD_getFrameContentSize() - returns the content size in a zstd frame header
+ * @src:     It should point to the start of a zstd encoded frame.
+ * @srcSize: The size of the source buffer. It must be at least as large as the
+ *           frame header. `ZSTD_frameHeaderSize_max` is always large enough.
+ *
+ * Return:   The frame content size stored in the frame header if known.
+ *           `ZSTD_CONTENTSIZE_UNKNOWN` if the content size isn't stored in the
+ *           frame header. `ZSTD_CONTENTSIZE_ERROR` on invalid input.
+ */
+unsigned long long ZSTD_getFrameContentSize(const void *src, size_t srcSize);
+
+/**
+ * ZSTD_findDecompressedSize() - returns decompressed size of a series of frames
+ * @src:     It should point to the start of a series of zstd encoded and/or
+ *           skippable frames.
+ * @srcSize: The exact size of the series of frames.
+ *
+ * If any zstd encoded frame in the series doesn't have the frame content size
+ * set, `ZSTD_CONTENTSIZE_UNKNOWN` is returned. But frame content size is always
+ * set when using ZSTD_compress(). The decompressed size can be very large.
+ * If the source is untrusted, the decompressed size could be wrong or
+ * intentionally modified. Always ensure the result fits within the
+ * application's authorized limits. ZSTD_findDecompressedSize() handles multiple
+ * frames, and so it must traverse the input to read each frame header. This is
+ * efficient as most of the data is skipped, however it does mean that all frame
+ * data must be present and valid.
+ *
+ * Return:   Decompressed size of all the data contained in the frames if known.
+ *           `ZSTD_CONTENTSIZE_UNKNOWN` if the decompressed size is unknown.
+ *           `ZSTD_CONTENTSIZE_ERROR` if an error occurred.
+ */
+unsigned long long ZSTD_findDecompressedSize(const void *src, size_t srcSize);
+
+/*-*************************************
+ * Advanced compression functions
+ **************************************/
+/**
+ * ZSTD_checkCParams() - ensure parameter values remain within authorized range
+ * @cParams: The zstd compression parameters.
+ *
+ * Return:   Zero or an error, which can be checked using ZSTD_isError().
+ */
+size_t ZSTD_checkCParams(ZSTD_compressionParameters cParams);
+
+/**
+ * ZSTD_adjustCParams() - optimize parameters for a given srcSize and dictSize
+ * @srcSize:  Optionally the estimated source size, or zero if unknown.
+ * @dictSize: Optionally the estimated dictionary size, or zero if unknown.
+ *
+ * Return:    The optimized parameters.
+ */
+ZSTD_compressionParameters ZSTD_adjustCParams(
+	ZSTD_compressionParameters cParams, unsigned long long srcSize,
+	size_t dictSize);
+
+/*--- Advanced decompression functions ---*/
+
+/**
+ * ZSTD_isFrame() - returns true iff the buffer starts with a valid frame
+ * @buffer: The source buffer to check.
+ * @size:   The size of the source buffer, must be at least 4 bytes.
+ *
+ * Return: True iff the buffer starts with a zstd or skippable frame identifier.
+ */
+unsigned int ZSTD_isFrame(const void *buffer, size_t size);
+
+/**
+ * ZSTD_getDictID_fromDict() - returns the dictionary id stored in a dictionary
+ * @dict:     The dictionary buffer.
+ * @dictSize: The size of the dictionary buffer.
+ *
+ * Return:    The dictionary id stored within the dictionary or 0 if the
+ *            dictionary is not a zstd dictionary. If it returns 0 the
+ *            dictionary can still be loaded as a content-only dictionary.
+ */
+unsigned int ZSTD_getDictID_fromDict(const void *dict, size_t dictSize);
+
+/**
+ * ZSTD_getDictID_fromDDict() - returns the dictionary id stored in a ZSTD_DDict
+ * @ddict: The ddict to find the id of.
+ *
+ * Return: The dictionary id stored within `ddict` or 0 if the dictionary is not
+ *         a zstd dictionary. If it returns 0 `ddict` will be loaded as a
+ *         content-only dictionary.
+ */
+unsigned int ZSTD_getDictID_fromDDict(const ZSTD_DDict *ddict);
+
+/**
+ * ZSTD_getDictID_fromFrame() - returns the dictionary id stored in a zstd frame
+ * @src:     Source buffer. It must be a zstd encoded frame.
+ * @srcSize: The size of the source buffer. It must be at least as large as the
+ *           frame header. `ZSTD_frameHeaderSize_max` is always large enough.
+ *
+ * Return:   The dictionary id required to decompress the frame stored within
+ *           `src` or 0 if the dictionary id could not be decoded. It can return
+ *           0 if the frame does not require a dictionary, the dictionary id
+ *           wasn't stored in the frame, `src` is not a zstd frame, or `srcSize`
+ *           is too small.
+ */
+unsigned int ZSTD_getDictID_fromFrame(const void *src, size_t srcSize);
+
+/**
+ * struct ZSTD_frameParams - zstd frame parameters stored in the frame header
+ * @frameContentSize: The frame content size, or 0 if not present.
+ * @windowSize:       The window size, or 0 if the frame is a skippable frame.
+ * @dictID:           The dictionary id, or 0 if not present.
+ * @checksumFlag:     Whether a checksum was used.
+ */
+typedef struct {
+	unsigned long long frameContentSize;
+	unsigned int windowSize;
+	unsigned int dictID;
+	unsigned int checksumFlag;
+} ZSTD_frameParams;
+
+/**
+ * ZSTD_getFrameParams() - extracts parameters from a zstd or skippable frame
+ * @fparamsPtr: On success the frame parameters are written here.
+ * @src:        The source buffer. It must point to a zstd or skippable frame.
+ * @srcSize:    The size of the source buffer. `ZSTD_frameHeaderSize_max` is
+ *              always large enough to succeed.
+ *
+ * Return:      0 on success. If more data is required it returns how many bytes
+ *              must be provided to make forward progress. Otherwise it returns
+ *              an error, which can be checked using ZSTD_isError().
+ */
+size_t ZSTD_getFrameParams(ZSTD_frameParams *fparamsPtr, const void *src,
+	size_t srcSize);
+
+/*-*****************************************************************************
+ * Buffer-less and synchronous inner streaming functions
+ *
+ * This is an advanced API, giving full control over buffer management, for
+ * users which need direct control over memory.
+ * But it's also a complex one, with many restrictions (documented below).
+ * Prefer using normal streaming API for an easier experience
+ ******************************************************************************/
+
+/*-*****************************************************************************
+ * Buffer-less streaming compression (synchronous mode)
+ *
+ * A ZSTD_CCtx object is required to track streaming operations.
+ * Use ZSTD_initCCtx() to initialize a context.
+ * ZSTD_CCtx object can be re-used multiple times within successive compression
+ * operations.
+ *
+ * Start by initializing a context.
+ * Use ZSTD_compressBegin(), or ZSTD_compressBegin_usingDict() for dictionary
+ * compression,
+ * or ZSTD_compressBegin_advanced(), for finer parameter control.
+ * It's also possible to duplicate a reference context which has already been
+ * initialized, using ZSTD_copyCCtx()
+ *
+ * Then, consume your input using ZSTD_compressContinue().
+ * There are some important considerations to keep in mind when using this
+ * advanced function :
+ * - ZSTD_compressContinue() has no internal buffer. It uses externally provided
+ *   buffer only.
+ * - Interface is synchronous : input is consumed entirely and produce 1+
+ *   (or more) compressed blocks.
+ * - Caller must ensure there is enough space in `dst` to store compressed data
+ *   under worst case scenario. Worst case evaluation is provided by
+ *   ZSTD_compressBound().
+ *   ZSTD_compressContinue() doesn't guarantee recover after a failed
+ *   compression.
+ * - ZSTD_compressContinue() presumes prior input ***is still accessible and
+ *   unmodified*** (up to maximum distance size, see WindowLog).
+ *   It remembers all previous contiguous blocks, plus one separated memory
+ *   segment (which can itself consists of multiple contiguous blocks)
+ * - ZSTD_compressContinue() detects that prior input has been overwritten when
+ *   `src` buffer overlaps. In which case, it will "discard" the relevant memory
+ *   section from its history.
+ *
+ * Finish a frame with ZSTD_compressEnd(), which will write the last block(s)
+ * and optional checksum. It's possible to use srcSize==0, in which case, it
+ * will write a final empty block to end the frame. Without last block mark,
+ * frames will be considered unfinished (corrupted) by decoders.
+ *
+ * `ZSTD_CCtx` object can be re-used (ZSTD_compressBegin()) to compress some new
+ * frame.
+ ******************************************************************************/
+
+/*=====   Buffer-less streaming compression functions  =====*/
+size_t ZSTD_compressBegin(ZSTD_CCtx *cctx, int compressionLevel);
+size_t ZSTD_compressBegin_usingDict(ZSTD_CCtx *cctx, const void *dict,
+	size_t dictSize, int compressionLevel);
+size_t ZSTD_compressBegin_advanced(ZSTD_CCtx *cctx, const void *dict,
+	size_t dictSize, ZSTD_parameters params,
+	unsigned long long pledgedSrcSize);
+size_t ZSTD_copyCCtx(ZSTD_CCtx *cctx, const ZSTD_CCtx *preparedCCtx,
+	unsigned long long pledgedSrcSize);
+size_t ZSTD_compressBegin_usingCDict(ZSTD_CCtx *cctx, const ZSTD_CDict *cdict,
+	unsigned long long pledgedSrcSize);
+size_t ZSTD_compressContinue(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize);
+size_t ZSTD_compressEnd(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize);
+
+
+
+/*-*****************************************************************************
+ * Buffer-less streaming decompression (synchronous mode)
+ *
+ * A ZSTD_DCtx object is required to track streaming operations.
+ * Use ZSTD_initDCtx() to initialize a context.
+ * A ZSTD_DCtx object can be re-used multiple times.
+ *
+ * First typical operation is to retrieve frame parameters, using
+ * ZSTD_getFrameParams(). It fills a ZSTD_frameParams structure which provide
+ * important information to correctly decode the frame, such as the minimum
+ * rolling buffer size to allocate to decompress data (`windowSize`), and the
+ * dictionary ID used.
+ * Note: content size is optional, it may not be present. 0 means unknown.
+ * Note that these values could be wrong, either because of data malformation,
+ * or because an attacker is spoofing deliberate false information. As a
+ * consequence, check that values remain within valid application range,
+ * especially `windowSize`, before allocation. Each application can set its own
+ * limit, depending on local restrictions. For extended interoperability, it is
+ * recommended to support at least 8 MB.
+ * Frame parameters are extracted from the beginning of the compressed frame.
+ * Data fragment must be large enough to ensure successful decoding, typically
+ * `ZSTD_frameHeaderSize_max` bytes.
+ * Result: 0: successful decoding, the `ZSTD_frameParams` structure is filled.
+ *        >0: `srcSize` is too small, provide at least this many bytes.
+ *        errorCode, which can be tested using ZSTD_isError().
+ *
+ * Start decompression, with ZSTD_decompressBegin() or
+ * ZSTD_decompressBegin_usingDict(). Alternatively, you can copy a prepared
+ * context, using ZSTD_copyDCtx().
+ *
+ * Then use ZSTD_nextSrcSizeToDecompress() and ZSTD_decompressContinue()
+ * alternatively.
+ * ZSTD_nextSrcSizeToDecompress() tells how many bytes to provide as 'srcSize'
+ * to ZSTD_decompressContinue().
+ * ZSTD_decompressContinue() requires this _exact_ amount of bytes, or it will
+ * fail.
+ *
+ * The result of ZSTD_decompressContinue() is the number of bytes regenerated
+ * within 'dst' (necessarily <= dstCapacity). It can be zero, which is not an
+ * error; it just means ZSTD_decompressContinue() has decoded some metadata
+ * item. It can also be an error code, which can be tested with ZSTD_isError().
+ *
+ * ZSTD_decompressContinue() needs previous data blocks during decompression, up
+ * to `windowSize`. They should preferably be located contiguously, prior to
+ * current block. Alternatively, a round buffer of sufficient size is also
+ * possible. Sufficient size is determined by frame parameters.
+ * ZSTD_decompressContinue() is very sensitive to contiguity, if 2 blocks don't
+ * follow each other, make sure that either the compressor breaks contiguity at
+ * the same place, or that previous contiguous segment is large enough to
+ * properly handle maximum back-reference.
+ *
+ * A frame is fully decoded when ZSTD_nextSrcSizeToDecompress() returns zero.
+ * Context can then be reset to start a new decompression.
+ *
+ * Note: it's possible to know if next input to present is a header or a block,
+ * using ZSTD_nextInputType(). This information is not required to properly
+ * decode a frame.
+ *
+ * == Special case: skippable frames ==
+ *
+ * Skippable frames allow integration of user-defined data into a flow of
+ * concatenated frames. Skippable frames will be ignored (skipped) by a
+ * decompressor. The format of skippable frames is as follows:
+ * a) Skippable frame ID - 4 Bytes, Little endian format, any value from
+ *    0x184D2A50 to 0x184D2A5F
+ * b) Frame Size - 4 Bytes, Little endian format, unsigned 32-bits
+ * c) Frame Content - any content (User Data) of length equal to Frame Size
+ * For skippable frames ZSTD_decompressContinue() always returns 0.
+ * For skippable frames ZSTD_getFrameParams() returns fparamsPtr->windowLog==0
+ * what means that a frame is skippable.
+ * Note: If fparamsPtr->frameContentSize==0, it is ambiguous: the frame might
+ *       actually be a zstd encoded frame with no content. For purposes of
+ *       decompression, it is valid in both cases to skip the frame using
+ *       ZSTD_findFrameCompressedSize() to find its size in bytes.
+ * It also returns frame size as fparamsPtr->frameContentSize.
+ ******************************************************************************/
+
+/*=====   Buffer-less streaming decompression functions  =====*/
+size_t ZSTD_decompressBegin(ZSTD_DCtx *dctx);
+size_t ZSTD_decompressBegin_usingDict(ZSTD_DCtx *dctx, const void *dict,
+	size_t dictSize);
+void   ZSTD_copyDCtx(ZSTD_DCtx *dctx, const ZSTD_DCtx *preparedDCtx);
+size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx *dctx);
+size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize);
+typedef enum {
+	ZSTDnit_frameHeader,
+	ZSTDnit_blockHeader,
+	ZSTDnit_block,
+	ZSTDnit_lastBlock,
+	ZSTDnit_checksum,
+	ZSTDnit_skippableFrame
+} ZSTD_nextInputType_e;
+ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx *dctx);
+
+/*-*****************************************************************************
+ * Block functions
+ *
+ * Block functions produce and decode raw zstd blocks, without frame metadata.
+ * Frame metadata cost is typically ~18 bytes, which can be non-negligible for
+ * very small blocks (< 100 bytes). User will have to take in charge required
+ * information to regenerate data, such as compressed and content sizes.
+ *
+ * A few rules to respect:
+ * - Compressing and decompressing require a context structure
+ *   + Use ZSTD_initCCtx() and ZSTD_initDCtx()
+ * - It is necessary to init context before starting
+ *   + compression : ZSTD_compressBegin()
+ *   + decompression : ZSTD_decompressBegin()
+ *   + variants _usingDict() are also allowed
+ *   + copyCCtx() and copyDCtx() work too
+ * - Block size is limited, it must be <= ZSTD_getBlockSizeMax()
+ *   + If you need to compress more, cut data into multiple blocks
+ *   + Consider using the regular ZSTD_compress() instead, as frame metadata
+ *     costs become negligible when source size is large.
+ * - When a block is considered not compressible enough, ZSTD_compressBlock()
+ *   result will be zero. In which case, nothing is produced into `dst`.
+ *   + User must test for such outcome and deal directly with uncompressed data
+ *   + ZSTD_decompressBlock() doesn't accept uncompressed data as input!!!
+ *   + In case of multiple successive blocks, decoder must be informed of
+ *     uncompressed block existence to follow proper history. Use
+ *     ZSTD_insertBlock() in such a case.
+ ******************************************************************************/
+
+/* Define for static allocation */
+#define ZSTD_BLOCKSIZE_ABSOLUTEMAX (128 * 1024)
+/*=====   Raw zstd block functions  =====*/
+size_t ZSTD_getBlockSizeMax(ZSTD_CCtx *cctx);
+size_t ZSTD_compressBlock(ZSTD_CCtx *cctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize);
+size_t ZSTD_decompressBlock(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity,
+	const void *src, size_t srcSize);
+size_t ZSTD_insertBlock(ZSTD_DCtx *dctx, const void *blockStart,
+	size_t blockSize);
+
+#endif  /* ZSTD_H */
diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index 790abc472f5b..c88aad49e996 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -91,11 +91,15 @@
 
 static int INIT handle_zstd_error(size_t ret, void (*error)(char *x))
 {
-	const int err = ZSTD_getErrorCode(ret);
+	const zstd_error_code err = zstd_get_error_code(ret);
 
-	if (!ZSTD_isError(ret))
+	if (!zstd_is_error(ret))
 		return 0;
 
+	/*
+	 * zstd_get_error_name() cannot be used because error takes a char *
+	 * not a const char *
+	 */
 	switch (err) {
 	case ZSTD_error_memory_allocation:
 		error("ZSTD decompressor ran out of memory");
@@ -124,28 +128,28 @@ static int INIT decompress_single(const u8 *in_buf, long in_len, u8 *out_buf,
 				  long out_len, long *in_pos,
 				  void (*error)(char *x))
 {
-	const size_t wksp_size = ZSTD_DCtxWorkspaceBound();
+	const size_t wksp_size = zstd_dctx_workspace_bound();
 	void *wksp = large_malloc(wksp_size);
-	ZSTD_DCtx *dctx = ZSTD_initDCtx(wksp, wksp_size);
+	zstd_dctx *dctx = zstd_init_dctx(wksp, wksp_size);
 	int err;
 	size_t ret;
 
 	if (dctx == NULL) {
-		error("Out of memory while allocating ZSTD_DCtx");
+		error("Out of memory while allocating zstd_dctx");
 		err = -1;
 		goto out;
 	}
 	/*
 	 * Find out how large the frame actually is, there may be junk at
-	 * the end of the frame that ZSTD_decompressDCtx() can't handle.
+	 * the end of the frame that zstd_decompress_dctx() can't handle.
 	 */
-	ret = ZSTD_findFrameCompressedSize(in_buf, in_len);
+	ret = zstd_find_frame_compressed_size(in_buf, in_len);
 	err = handle_zstd_error(ret, error);
 	if (err)
 		goto out;
 	in_len = (long)ret;
 
-	ret = ZSTD_decompressDCtx(dctx, out_buf, out_len, in_buf, in_len);
+	ret = zstd_decompress_dctx(dctx, out_buf, out_len, in_buf, in_len);
 	err = handle_zstd_error(ret, error);
 	if (err)
 		goto out;
@@ -167,14 +171,14 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
 			 long *in_pos,
 			 void (*error)(char *x))
 {
-	ZSTD_inBuffer in;
-	ZSTD_outBuffer out;
-	ZSTD_frameParams params;
+	zstd_in_buffer in;
+	zstd_out_buffer out;
+	zstd_frame_header header;
 	void *in_allocated = NULL;
 	void *out_allocated = NULL;
 	void *wksp = NULL;
 	size_t wksp_size;
-	ZSTD_DStream *dstream;
+	zstd_dstream *dstream;
 	int err;
 	size_t ret;
 
@@ -238,13 +242,13 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
 	out.size = out_len;
 
 	/*
-	 * We need to know the window size to allocate the ZSTD_DStream.
+	 * We need to know the window size to allocate the zstd_dstream.
 	 * Since we are streaming, we need to allocate a buffer for the sliding
 	 * window. The window size varies from 1 KB to ZSTD_WINDOWSIZE_MAX
 	 * (8 MB), so it is important to use the actual value so as not to
 	 * waste memory when it is smaller.
 	 */
-	ret = ZSTD_getFrameParams(&params, in.src, in.size);
+	ret = zstd_get_frame_header(&header, in.src, in.size);
 	err = handle_zstd_error(ret, error);
 	if (err)
 		goto out;
@@ -253,19 +257,19 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
 		err = -1;
 		goto out;
 	}
-	if (params.windowSize > ZSTD_WINDOWSIZE_MAX) {
+	if (header.windowSize > ZSTD_WINDOWSIZE_MAX) {
 		error("ZSTD-compressed data has too large a window size");
 		err = -1;
 		goto out;
 	}
 
 	/*
-	 * Allocate the ZSTD_DStream now that we know how much memory is
+	 * Allocate the zstd_dstream now that we know how much memory is
 	 * required.
 	 */
-	wksp_size = ZSTD_DStreamWorkspaceBound(params.windowSize);
+	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
 	wksp = large_malloc(wksp_size);
-	dstream = ZSTD_initDStream(params.windowSize, wksp, wksp_size);
+	dstream = zstd_init_dstream(header.windowSize, wksp, wksp_size);
 	if (dstream == NULL) {
 		error("Out of memory while allocating ZSTD_DStream");
 		err = -1;
@@ -298,7 +302,7 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
 			in.size = in_len;
 		}
 		/* Returns zero when the frame is complete. */
-		ret = ZSTD_decompressStream(dstream, &out, &in);
+		ret = zstd_decompress_stream(dstream, &out, &in);
 		err = handle_zstd_error(ret, error);
 		if (err)
 			goto out;
diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index b080264ed3ad..57aaa64306a0 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -3443,43 +3443,92 @@ ZSTD_parameters ZSTD_getParams(int compressionLevel, unsigned long long srcSize,
 	return params;
 }
 
-EXPORT_SYMBOL(ZSTD_maxCLevel);
-EXPORT_SYMBOL(ZSTD_compressBound);
-
-EXPORT_SYMBOL(ZSTD_CCtxWorkspaceBound);
-EXPORT_SYMBOL(ZSTD_initCCtx);
-EXPORT_SYMBOL(ZSTD_compressCCtx);
-EXPORT_SYMBOL(ZSTD_compress_usingDict);
-
-EXPORT_SYMBOL(ZSTD_CDictWorkspaceBound);
-EXPORT_SYMBOL(ZSTD_initCDict);
-EXPORT_SYMBOL(ZSTD_compress_usingCDict);
-
-EXPORT_SYMBOL(ZSTD_CStreamWorkspaceBound);
-EXPORT_SYMBOL(ZSTD_initCStream);
-EXPORT_SYMBOL(ZSTD_initCStream_usingCDict);
-EXPORT_SYMBOL(ZSTD_resetCStream);
-EXPORT_SYMBOL(ZSTD_compressStream);
-EXPORT_SYMBOL(ZSTD_flushStream);
-EXPORT_SYMBOL(ZSTD_endStream);
-EXPORT_SYMBOL(ZSTD_CStreamInSize);
-EXPORT_SYMBOL(ZSTD_CStreamOutSize);
-
-EXPORT_SYMBOL(ZSTD_getCParams);
-EXPORT_SYMBOL(ZSTD_getParams);
-EXPORT_SYMBOL(ZSTD_checkCParams);
-EXPORT_SYMBOL(ZSTD_adjustCParams);
-
-EXPORT_SYMBOL(ZSTD_compressBegin);
-EXPORT_SYMBOL(ZSTD_compressBegin_usingDict);
-EXPORT_SYMBOL(ZSTD_compressBegin_advanced);
-EXPORT_SYMBOL(ZSTD_copyCCtx);
-EXPORT_SYMBOL(ZSTD_compressBegin_usingCDict);
-EXPORT_SYMBOL(ZSTD_compressContinue);
-EXPORT_SYMBOL(ZSTD_compressEnd);
-
-EXPORT_SYMBOL(ZSTD_getBlockSizeMax);
-EXPORT_SYMBOL(ZSTD_compressBlock);
+size_t zstd_compress_bound(size_t src_size)
+{
+	return ZSTD_compressBound(src_size);
+}
+EXPORT_SYMBOL(zstd_compress_bound);
+
+int zstd_min_clevel(void)
+{
+	/*
+	 * zstd-1.3.1 doesn't implement ZSTD_minCLevel().
+	 * Return 0 (default level).
+	 */
+	return 0;
+}
+EXPORT_SYMBOL(zstd_min_clevel);
+
+int zstd_max_clevel(void)
+{
+	return ZSTD_maxCLevel();
+}
+EXPORT_SYMBOL(zstd_max_clevel);
+
+zstd_parameters zstd_get_params(int level,
+	unsigned long long estimated_src_size)
+{
+	return ZSTD_getParams(level, estimated_src_size, 0);
+}
+EXPORT_SYMBOL(zstd_get_params);
+
+size_t zstd_cctx_workspace_bound(const zstd_compression_parameters *cparams)
+{
+	return ZSTD_CCtxWorkspaceBound(*cparams);
+}
+EXPORT_SYMBOL(zstd_cctx_workspace_bound);
+
+zstd_cctx *zstd_init_cctx(void *workspace, size_t workspace_size)
+{
+	return ZSTD_initCCtx(workspace, workspace_size);
+}
+EXPORT_SYMBOL(zstd_init_cctx);
+
+size_t zstd_compress_cctx(zstd_cctx *cctx, void *dst, size_t dst_capacity,
+	const void *src, size_t src_size, const zstd_parameters *parameters)
+{
+	return ZSTD_compressCCtx(cctx, dst, dst_capacity, src, src_size, *parameters);
+}
+EXPORT_SYMBOL(zstd_compress_cctx);
+
+size_t zstd_cstream_workspace_bound(const zstd_compression_parameters *cparams)
+{
+	return ZSTD_CStreamWorkspaceBound(*cparams);
+}
+EXPORT_SYMBOL(zstd_cstream_workspace_bound);
+
+zstd_cstream *zstd_init_cstream(const zstd_parameters *parameters,
+	unsigned long long pledged_src_size, void *workspace, size_t workspace_size)
+{
+	return ZSTD_initCStream(*parameters, pledged_src_size, workspace, workspace_size);
+}
+EXPORT_SYMBOL(zstd_init_cstream);
+
+size_t zstd_reset_cstream(zstd_cstream *cstream,
+	unsigned long long pledged_src_size)
+{
+	return ZSTD_resetCStream(cstream, pledged_src_size);
+}
+EXPORT_SYMBOL(zstd_reset_cstream);
+
+size_t zstd_compress_stream(zstd_cstream *cstream, zstd_out_buffer *output,
+	zstd_in_buffer *input)
+{
+	return ZSTD_compressStream(cstream, output, input);
+}
+EXPORT_SYMBOL(zstd_compress_stream);
+
+size_t zstd_flush_stream(zstd_cstream *cstream, zstd_out_buffer *output)
+{
+	return ZSTD_flushStream(cstream, output);
+}
+EXPORT_SYMBOL(zstd_flush_stream);
+
+size_t zstd_end_stream(zstd_cstream *cstream, zstd_out_buffer *output)
+{
+	return ZSTD_endStream(cstream, output);
+}
+EXPORT_SYMBOL(zstd_end_stream);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Zstd Compressor");
diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
index 66cd487a326a..02e92c2cbf4f 100644
--- a/lib/zstd/decompress.c
+++ b/lib/zstd/decompress.c
@@ -2490,42 +2490,82 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 	}
 }
 
-EXPORT_SYMBOL(ZSTD_DCtxWorkspaceBound);
-EXPORT_SYMBOL(ZSTD_initDCtx);
-EXPORT_SYMBOL(ZSTD_decompressDCtx);
-EXPORT_SYMBOL(ZSTD_decompress_usingDict);
-
-EXPORT_SYMBOL(ZSTD_DDictWorkspaceBound);
-EXPORT_SYMBOL(ZSTD_initDDict);
-EXPORT_SYMBOL(ZSTD_decompress_usingDDict);
-
-EXPORT_SYMBOL(ZSTD_DStreamWorkspaceBound);
-EXPORT_SYMBOL(ZSTD_initDStream);
-EXPORT_SYMBOL(ZSTD_initDStream_usingDDict);
-EXPORT_SYMBOL(ZSTD_resetDStream);
-EXPORT_SYMBOL(ZSTD_decompressStream);
-EXPORT_SYMBOL(ZSTD_DStreamInSize);
-EXPORT_SYMBOL(ZSTD_DStreamOutSize);
-
-EXPORT_SYMBOL(ZSTD_findFrameCompressedSize);
-EXPORT_SYMBOL(ZSTD_getFrameContentSize);
-EXPORT_SYMBOL(ZSTD_findDecompressedSize);
-
-EXPORT_SYMBOL(ZSTD_isFrame);
-EXPORT_SYMBOL(ZSTD_getDictID_fromDict);
-EXPORT_SYMBOL(ZSTD_getDictID_fromDDict);
-EXPORT_SYMBOL(ZSTD_getDictID_fromFrame);
-
-EXPORT_SYMBOL(ZSTD_getFrameParams);
-EXPORT_SYMBOL(ZSTD_decompressBegin);
-EXPORT_SYMBOL(ZSTD_decompressBegin_usingDict);
-EXPORT_SYMBOL(ZSTD_copyDCtx);
-EXPORT_SYMBOL(ZSTD_nextSrcSizeToDecompress);
-EXPORT_SYMBOL(ZSTD_decompressContinue);
-EXPORT_SYMBOL(ZSTD_nextInputType);
-
-EXPORT_SYMBOL(ZSTD_decompressBlock);
-EXPORT_SYMBOL(ZSTD_insertBlock);
+unsigned int zstd_is_error(size_t code)
+{
+	return ZSTD_isError(code);
+}
+EXPORT_SYMBOL(zstd_is_error);
+
+zstd_error_code zstd_get_error_code(size_t code)
+{
+	return ZSTD_getErrorCode(code);
+}
+EXPORT_SYMBOL(zstd_get_error_code);
+
+const char *zstd_get_error_name(size_t code)
+{
+	/* Real implementation in zstd-1.4.6. */
+	return "GENERIC";
+}
+EXPORT_SYMBOL(zstd_get_error_name);
+
+size_t zstd_dctx_workspace_bound(void)
+{
+	return ZSTD_DCtxWorkspaceBound();
+}
+EXPORT_SYMBOL(zstd_dctx_workspace_bound);
+
+zstd_dctx *zstd_init_dctx(void *workspace, size_t workspace_size)
+{
+	return ZSTD_initDCtx(workspace, workspace_size);
+}
+EXPORT_SYMBOL(zstd_init_dctx);
+
+size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, size_t dst_capacity,
+	const void *src, size_t src_size)
+{
+	return ZSTD_decompressDCtx(dctx, dst, dst_capacity, src, src_size);
+}
+EXPORT_SYMBOL(zstd_decompress_dctx);
+
+size_t zstd_dstream_workspace_bound(size_t max_window_size)
+{
+	return ZSTD_DStreamWorkspaceBound(max_window_size);
+}
+EXPORT_SYMBOL(zstd_dstream_workspace_bound);
+
+zstd_dstream *zstd_init_dstream(size_t max_window_size, void *workspace,
+	size_t workspace_size)
+{
+	return ZSTD_initDStream(max_window_size, workspace, workspace_size);
+}
+EXPORT_SYMBOL(zstd_init_dstream);
+
+size_t zstd_reset_dstream(zstd_dstream *dstream)
+{
+	return ZSTD_resetDStream(dstream);
+}
+EXPORT_SYMBOL(zstd_reset_dstream);
+
+size_t zstd_decompress_stream(zstd_dstream *dstream, zstd_out_buffer *output,
+	zstd_in_buffer *input)
+{
+	return ZSTD_decompressStream(dstream, output, input);
+}
+EXPORT_SYMBOL(zstd_decompress_stream);
+
+size_t zstd_find_frame_compressed_size(const void *src, size_t src_size)
+{
+	return ZSTD_findFrameCompressedSize(src, src_size);
+}
+EXPORT_SYMBOL(zstd_find_frame_compressed_size);
+
+size_t zstd_get_frame_header(zstd_frame_header *header, const void *src,
+	size_t src_size)
+{
+	return ZSTD_getFrameParams(header, src, src_size);
+}
+EXPORT_SYMBOL(zstd_get_frame_header);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Zstd Decompressor");
-- 
2.31.1

