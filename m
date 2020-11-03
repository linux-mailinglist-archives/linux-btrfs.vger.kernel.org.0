Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90F2A3C87
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 07:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgKCGCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 01:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgKCGCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 01:02:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB323C0617A6;
        Mon,  2 Nov 2020 22:02:17 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id j18so13279423pfa.0;
        Mon, 02 Nov 2020 22:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=;
        b=iEqbPFcmoBVXXCzrGQK2134vW+8Xz0YWFUGJNPGE6qJxp0tCM0nsNFXXC4h+P1xzAD
         RbBL+COQhh47jkqv5/sjqYoTs+bvTCVUYiVeJLSPeBykfty17A15g1dGz5KLHAwrnbnL
         jfvTqAeL/w3PsoiBSs4kOok9tzIiJPLdAgMdtRc3w3MZXnhWixUYI51c+QjDl8YrX7cE
         CUswOLRvdyxH4x/EqRZKpCMOjGikIZ3SgigzOwqhm3i9s0EVg6BbA8tpVlRSCnVYCyEt
         XCfTdYqaZXUBPJE+5ku4PMi6En22dNHhdVv82IsiWGYbeSNF2ra1lj/e0zSsQN/sNBy8
         N/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=;
        b=K6ZFOjsOW/rR9Atxp04ih9lAosCe6LKjJaOkhtMbCIV09LelmCsJ/991TZuw5OzwaO
         0QlY976DmbzPj1yaqSiRGCnBVMsOmK/dVScwUrM07NDXfRoCWxFw+sxxj1+pnxQMT0TR
         l9KCmEILMjlySPf8siqqssS0r9aEAJNBicjvCcKNovLzpzUPEvm49d0gaQevkG7FYD+S
         vOn7KSbRBKDL7TyzN4qTkeggNPUnv5L2Xlc2gSFWzGlhOssSu7mbvHg7hChKRxw9Orqk
         6exL3q2xy51th2phdzU2+E5NIGuMj6qHvguqEQAVJSPY8UzgV694XD6aH/RzBluhwmkP
         JdWA==
X-Gm-Message-State: AOAM5339836i1oUHfFj+la899Js4mlDNdR6rYeaLNPIfjzdt1Xd+cb67
        YcTgSOsR8UfGIUenxqEwMHw=
X-Google-Smtp-Source: ABdhPJyGVtb0kQhKxDOQ3rgCyFM7CMKxKblu6sRqk+tIeYGAbfG3LCMa/grSJQZbBh9QW8E7X+cIbQ==
X-Received: by 2002:a63:c64:: with SMTP id 36mr5263358pgm.255.1604383337287;
        Mon, 02 Nov 2020 22:02:17 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b16sm15647269pfp.195.2020.11.02.22.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:02:16 -0800 (PST)
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
Subject: [PATCH v5 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Date:   Mon,  2 Nov 2020 22:05:31 -0800
Message-Id: <20201103060535.8460-6-nickrterrell@gmail.com>
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

