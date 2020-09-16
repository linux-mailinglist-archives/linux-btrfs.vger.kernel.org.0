Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3257326BAC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIPDnb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPDmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:42:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D46C06178C;
        Tue, 15 Sep 2020 20:42:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so2440292plt.9;
        Tue, 15 Sep 2020 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=;
        b=G2tIH0hJDw6zI92LS/tcNNlHDcmmoUZfw6SbHD2guhCP/EguIR999y1+FxTCyDDkfe
         tjeVfQvqKsrNK+fL1PW2rN3SgLNUzKQsjOhtyUluz64Nn26tecg/JoV7tGaQbJxl2vWC
         ETAOh8fJeuYCih2snpvYiVesT2gc+G6V7nEltdTnwaYh0ZeDREqR3uD+pz1yufF4yIBg
         0/wVV0fh2VO7OjDuDeB4y44DBhTYavxu5IiHz/qajUNFVQJONemtgDf11ZSNd033wB4h
         r71tBBSO9GLay1+LZWnGZtTCmWLiGdzfXQDojF6LjzIvnRJrsr6fabApBnQblS6G6s2/
         L7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=;
        b=jC7mWyz02lmVfjyIiSyy7s+J2xqCjfz3fhvfoObAUsHZhF/iVLyasxUcRxiutCH2Qu
         2iW05ZBsBY7fenfDufVh4kzW00AP24LkgAPeFV8bppGBcbRrb/jslrr8BoDCIujfhqTu
         JDvymnr2Hznfxyr1Pq9uxtw7YpGjAnO0BUAch37zCtzDRwesbi5TsKA7gDAfehH41Dwm
         4tjoG0KoSUo0u35bWgZE3LLuwP83maYX8GOV2he26JAybE7X2czQMJNka43AJeHVIwB5
         JZjtYf+4bEPGoIbwqAhyQqis/EUui+3usz3KZjYbl+/umRgNTXTu1GA4yIdZ60FwlmH+
         5pxg==
X-Gm-Message-State: AOAM533joAmOaBo8FkDo5IYtn2ekhWHpLE99VkRxtuDT/0czRNj2Dd3q
        0mEywFAKOvZzNVWjWq2NH8KGE8ii5sskjA==
X-Google-Smtp-Source: ABdhPJwIdN9jdHWNUgbnk9X/e5/fIUkyDrTm/Ylx6HjufZ434p5aOCgnmfBhcKOD3fa2jkVsQXis+A==
X-Received: by 2002:a17:902:20b:b029:d1:9bc8:37f5 with SMTP id 11-20020a170902020bb02900d19bc837f5mr21043614plc.41.1600227771832;
        Tue, 15 Sep 2020 20:42:51 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:42:51 -0700 (PDT)
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
Subject: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Date:   Tue, 15 Sep 2020 20:42:59 -0700
Message-Id: <20200916034307.2092020-7-nickrterrell@gmail.com>
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
 fs/btrfs/zstd.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index a7367ff573d4..6b466e090cd7 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -16,7 +16,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/zstd_compat.h>
+#include <linux/zstd.h>
 #include "misc.h"
 #include "compression.h"
 #include "ctree.h"
@@ -159,8 +159,8 @@ static void zstd_calc_ws_mem_sizes(void)
 			zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
 		size_t level_size =
 			max_t(size_t,
-			      ZSTD_CStreamWorkspaceBound(params.cParams),
-			      ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT));
+			      ZSTD_estimateCStreamSize_usingCParams(params.cParams),
+			      ZSTD_estimateDStreamSize(ZSTD_BTRFS_MAX_INPUT));
 
 		max_size = max_t(size_t, max_size, level_size);
 		zstd_ws_mem_sizes[level - 1] = max_size;
@@ -389,13 +389,23 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = 0;
 
 	/* Initialize the stream */
-	stream = ZSTD_initCStream(params, len, workspace->mem,
-			workspace->size);
+	stream = ZSTD_initStaticCStream(workspace->mem, workspace->size);
 	if (!stream) {
-		pr_warn("BTRFS: ZSTD_initCStream failed\n");
+		pr_warn("BTRFS: ZSTD_initStaticCStream failed\n");
 		ret = -EIO;
 		goto out;
 	}
+	{
+		size_t ret2;
+
+		ret2 = ZSTD_initCStream_advanced(stream, NULL, 0, params, len);
+		if (ZSTD_isError(ret2)) {
+			pr_warn("BTRFS: ZSTD_initCStream_advanced returned %s\n",
+					ZSTD_getErrorName(ret2));
+			ret = -EIO;
+			goto out;
+		}
+	}
 
 	/* map in the first page of input data */
 	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
@@ -421,8 +431,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret2 = ZSTD_compressStream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_compressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_compressStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto out;
 		}
@@ -489,8 +499,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		ret2 = ZSTD_endStream(stream, &workspace->out_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_endStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_endStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto out;
 		}
@@ -557,10 +567,9 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	unsigned long total_out = 0;
 
-	stream = ZSTD_initDStream(
-			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
+	stream = ZSTD_initStaticDStream(workspace->mem, workspace->size);
 	if (!stream) {
-		pr_debug("BTRFS: ZSTD_initDStream failed\n");
+		pr_debug("BTRFS: ZSTD_initStaticDStream failed\n");
 		ret = -EIO;
 		goto done;
 	}
@@ -579,8 +588,8 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		ret2 = ZSTD_decompressStream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_decompressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_decompressStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto done;
 		}
@@ -633,10 +642,9 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 	unsigned long pg_offset = 0;
 	char *kaddr;
 
-	stream = ZSTD_initDStream(
-			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
+	stream = ZSTD_initStaticDStream(workspace->mem, workspace->size);
 	if (!stream) {
-		pr_warn("BTRFS: ZSTD_initDStream failed\n");
+		pr_warn("BTRFS: ZSTD_initStaticDStream failed\n");
 		ret = -EIO;
 		goto finish;
 	}
@@ -667,8 +675,8 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 		ret2 = ZSTD_decompressStream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_decompressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_decompressStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto finish;
 		}
-- 
2.28.0

