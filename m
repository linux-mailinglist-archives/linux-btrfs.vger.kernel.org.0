Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D8527E1BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 08:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgI3GuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgI3GuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 02:50:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89529C061755;
        Tue, 29 Sep 2020 23:50:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so501318pff.6;
        Tue, 29 Sep 2020 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fKNeZSsXX3F75uWAvoclig0FCLwLLfStaZMUpC2Nwo=;
        b=VxTo6zF2fu49RsmnYgmpKorcmYpqhYfxCs9DGycyfzzCy4r9Q0EROtwrw52m0lEZtI
         Q2fnlRz+iD4eabk1O+A7K1LY/NKIC/HD+atXxRHukStTStxRg44QUL8omwHsDVY3XAMI
         O0Pe5arLJpYedWmsDLBpFsXU5gooUm9USrNMsjvO6KM1dOIQSk0eFyCe5X+HGAJzntOz
         gKsZyHNhLrytVKF2rA0ipBadNOSVnQxiWIYt4FRFfq7S5FRKJQOIRuswiqZTYHfpc6fI
         UiDeaAZTiq5cZt+QNCr7y4YDBxnLKMF2tdZonPB7AqgqhkFk4G44lA+5y78k8Y0gT6dh
         +K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fKNeZSsXX3F75uWAvoclig0FCLwLLfStaZMUpC2Nwo=;
        b=f9HgkUp0EQsr3DCVkQZxzKoMEi4K3s8m3RGgOpjkfUs/1rPbAr9FgobbPzWYKF+4T1
         bwat2RqCBS5LfF+bzfl1ceT522OhQ3y0pg1wi4MY07JSt1kxPt3wwAyqU3sb/qEWlziM
         qx+jHj1KWc7DjJnmlZ6qNjjT3GCgJ5g3IGYhZHfvQ1xB54aE7zDyFCq5ZoplmRVAsbok
         UcVMxNMqOogix7r9N/00GT5Y4GLZoeM16bm0kuePH/mLikAoSDDCMoWc/0xFsFfqeX8t
         CA+tIPqRzsUkcIcy5pHkcwcNnE142imXBrgXnc+FUCHsp8DlvOkab1/zq2JFz3xL15SN
         tVxw==
X-Gm-Message-State: AOAM5327imZukXhjtMvoo3sFkRnerogZBChP3LSRhZ12zkqVQL1q5RZJ
        S/+xwaXWluNvvhI0Aj4oBpc3uzBpQ3M=
X-Google-Smtp-Source: ABdhPJyRQKWxXuxGl6KTzKn3DRvgoJHqNKyv/wjJz4eoPYtaSRBHmcq9jH112mZN+5bU9oexmLPawg==
X-Received: by 2002:a62:7b94:0:b029:142:2501:35e4 with SMTP id w142-20020a627b940000b0290142250135e4mr1387276pfc.68.1601448602040;
        Tue, 29 Sep 2020 23:50:02 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id 190sm1100865pfy.22.2020.09.29.23.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:50:01 -0700 (PDT)
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
Subject: [PATCH v4 4/9] crypto: zstd: Switch to zstd-1.4.6 API
Date:   Tue, 29 Sep 2020 23:53:13 -0700
Message-Id: <20200930065318.3326526-5-nickrterrell@gmail.com>
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
 crypto/zstd.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index dcda3cad3b5c..767fe2fbe009 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/vmalloc.h>
-#include <linux/zstd_compat.h>
+#include <linux/zstd.h>
 #include <crypto/internal/scompress.h>
 
 
@@ -24,16 +24,15 @@ struct zstd_ctx {
 	void *dwksp;
 };
 
-static ZSTD_parameters zstd_params(void)
-{
-	return ZSTD_getParams(ZSTD_DEF_LEVEL, 0, 0);
-}
-
 static int zstd_comp_init(struct zstd_ctx *ctx)
 {
 	int ret = 0;
-	const ZSTD_parameters params = zstd_params();
-	const size_t wksp_size = ZSTD_CCtxWorkspaceBound(params.cParams);
+	const size_t wksp_size = ZSTD_estimateCCtxSize(ZSTD_DEF_LEVEL);
+
+	if (ZSTD_isError(wksp_size)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
 
 	ctx->cwksp = vzalloc(wksp_size);
 	if (!ctx->cwksp) {
@@ -41,7 +40,7 @@ static int zstd_comp_init(struct zstd_ctx *ctx)
 		goto out;
 	}
 
-	ctx->cctx = ZSTD_initCCtx(ctx->cwksp, wksp_size);
+	ctx->cctx = ZSTD_initStaticCCtx(ctx->cwksp, wksp_size);
 	if (!ctx->cctx) {
 		ret = -EINVAL;
 		goto out_free;
@@ -56,7 +55,7 @@ static int zstd_comp_init(struct zstd_ctx *ctx)
 static int zstd_decomp_init(struct zstd_ctx *ctx)
 {
 	int ret = 0;
-	const size_t wksp_size = ZSTD_DCtxWorkspaceBound();
+	const size_t wksp_size = ZSTD_estimateDCtxSize();
 
 	ctx->dwksp = vzalloc(wksp_size);
 	if (!ctx->dwksp) {
@@ -64,7 +63,7 @@ static int zstd_decomp_init(struct zstd_ctx *ctx)
 		goto out;
 	}
 
-	ctx->dctx = ZSTD_initDCtx(ctx->dwksp, wksp_size);
+	ctx->dctx = ZSTD_initStaticDCtx(ctx->dwksp, wksp_size);
 	if (!ctx->dctx) {
 		ret = -EINVAL;
 		goto out_free;
@@ -152,9 +151,8 @@ static int __zstd_compress(const u8 *src, unsigned int slen,
 {
 	size_t out_len;
 	struct zstd_ctx *zctx = ctx;
-	const ZSTD_parameters params = zstd_params();
 
-	out_len = ZSTD_compressCCtx(zctx->cctx, dst, *dlen, src, slen, params);
+	out_len = ZSTD_compressCCtx(zctx->cctx, dst, *dlen, src, slen, ZSTD_DEF_LEVEL);
 	if (ZSTD_isError(out_len))
 		return -EINVAL;
 	*dlen = out_len;
-- 
2.28.0

