Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC17274AB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 23:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIVVGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgIVVG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:06:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EAC061755;
        Tue, 22 Sep 2020 14:06:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so2079626pjd.3;
        Tue, 22 Sep 2020 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fKNeZSsXX3F75uWAvoclig0FCLwLLfStaZMUpC2Nwo=;
        b=VRnjbhaR7u9Ns94IhEs7xpF9rCvZP/sm8ZtuC2hiGWNyBU5tXf+QSFQ8I0G4DjB5xC
         qDtgHGeKqCSWhFG8djLjeMnW8cFhirccyxDMwJPsX2vr67u5OpinvTkMg6Wn/4VIXevz
         ldZxz0mKv7SZ8al4MvEsKIljAGH3E5rDJZGVIq9N4zU8crSgNWLENnGFwRL2LWXdTO9k
         EMvSnwUANSC7UZmHeMmeYSG0VxtlBve0n7AxG2+VqfcPILKrEbRPAwmtydEdYKb+29Ck
         hJuLuR4rd6WG/q2Qh36hB4UYMfRaW/6hmC5NwoL2Yzw8/zCSFOeVPdK6YZ+S9y/s+czm
         JnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fKNeZSsXX3F75uWAvoclig0FCLwLLfStaZMUpC2Nwo=;
        b=n/zbsezrTzoPAjpakAvXafhMxPK/xiA2JQgBzJb56pgYrTIutLazYd1c5/xA+UQxZ6
         oEk+eXoxQf5GllRkOTi5h8nvnfdFMk43FGEPuICuCTajLVX5HWd6PRT/+aGVcelHZpQV
         nQ7K2lIkaUXWRQznu2vpBACkkTvdKD7cjzBZG1aTxvMiuD7MupCv9OXZBfPRxh76sxLS
         DKPfwsfwUGCDKiEsKiKMM38njw/a7vQe5zKtg3Q2uHG/7eW7r85E/X9utsd5bfs+eLNK
         SbgcR5Q3RnXtEYT15vUzf9GJkWV1m13NHNIBjFZhkY9O+uxCcmvNrkMb3ur9cgqzMcay
         4Dmw==
X-Gm-Message-State: AOAM532jXlq4QSlORvsgyF4ZjGIyjSQlVdCoxldhlB59d2YPKARV1smb
        /Q/3IassYsZfriB/uGDTk3I=
X-Google-Smtp-Source: ABdhPJxHNlmwtyEyY3QaIV8vUtWmW8GG7n0PfB1SNTU3deVbHxrNSzwE43B7Y8Qf8j7SkAAUpzLrkQ==
X-Received: by 2002:a17:90a:d812:: with SMTP id a18mr5422822pjv.228.1600808789298;
        Tue, 22 Sep 2020 14:06:29 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i15sm16118945pfk.145.2020.09.22.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:06:28 -0700 (PDT)
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
Subject: [PATCH v2 4/9] crypto: zstd: Switch to zstd-1.4.6 API
Date:   Tue, 22 Sep 2020 14:09:19 -0700
Message-Id: <20200922210924.1725-5-nickrterrell@gmail.com>
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

