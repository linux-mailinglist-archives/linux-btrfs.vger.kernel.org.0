Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B012526BADC
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIPDr4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgIPDry (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:47:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689BC06174A;
        Tue, 15 Sep 2020 20:40:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so822306pjd.4;
        Tue, 15 Sep 2020 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fKNeZSsXX3F75uWAvoclig0FCLwLLfStaZMUpC2Nwo=;
        b=MBMW6QMq9lCxZUAmvXVtcBYONHEPOCnbWNuKiZJWW65LC9wyrofhoWFzZBC+Y3HhOT
         G2pHeFDFBdqb3XeOD8673GkG54+crAqrHtMGfC5utUo7pGK0gwqJYwghKeqPJ7Fouqg9
         a1EW2ZbmQ9UtrHQoYRclmzQQgmQLxWA0humcihwtRQ0n+ad/2DwL/kuWTrC6Nea//9NG
         aeemwFijt+vriQZye/oGtrhD1P91DO8uUR/F8z93hCnSk8VWI+zujWiEUzstQQS4eknN
         TNO1ZT3oZk2XH5Nrr2r2YHgtTcth54B2w+48DKMsM50qMyTGtTKbwdXs07G4MauJuaw5
         cVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fKNeZSsXX3F75uWAvoclig0FCLwLLfStaZMUpC2Nwo=;
        b=cSzIoHD4b7tcnjZBHgb2hcePf3OyY0dLofN6VdcBrzXiUegOgfaGl38Wx5lmopJJ1b
         HcK86isTc8LANR58D0REy1utr42gpbleyQxeeljHQCr1X2hnHUW1PnNqNjRjm1fKQLF4
         +bDVuapZLRJswPXqmDOGWVcthsW2TsyhZRBrIePXgR++C6odRoCRtY+HtvT+yWzjbTM2
         b+o5FE9c/YGA3vBAD2o4xGdmYsilM0MAst0I4V5Nb+/z8dik1gwl7D850V7+Qif/vD1y
         NUC0C9L/k6HY9zlBHrbJxZYbLjcy2RZ78PNZjSdAkNsscapn2FwDSdZj/ievVVzNabFz
         F5uw==
X-Gm-Message-State: AOAM533VcGpErlEQY1s1OoJHWdjurlSo9MQD+P7mzmNVBATI9hYZ+q2x
        DubZmicGYGJW5s3rtcULU/s=
X-Google-Smtp-Source: ABdhPJz2ijRe9DqZppb7/1KZROPtSsQuUb5Q6+cvVGIVbzAk2adBQ/IF8nSGzwaq7W3PsSJSEg2qxw==
X-Received: by 2002:a17:902:309:b029:d1:e5e7:ca3f with SMTP id 9-20020a1709020309b02900d1e5e7ca3fmr4663933pld.43.1600227655314;
        Tue, 15 Sep 2020 20:40:55 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:40:54 -0700 (PDT)
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
Subject: [PATCH 4/9] crypto: zstd: Switch to zstd-1.4.6 API
Date:   Tue, 15 Sep 2020 20:42:57 -0700
Message-Id: <20200916034307.2092020-5-nickrterrell@gmail.com>
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

