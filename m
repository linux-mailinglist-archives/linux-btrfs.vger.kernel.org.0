Return-Path: <linux-btrfs+bounces-4555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6868B3659
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670132844F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1481448DF;
	Fri, 26 Apr 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTLRs/l+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7A14532D;
	Fri, 26 Apr 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129810; cv=none; b=aJb+U4VRYDOx8q3O945UoccSJm33MfjeQ3zh3axddiIgO4MuORiPbooKeZqMYYOAGn1DkuMHZyi/h9odokCQyNMkfy435OOKQZ9eNBqWJOFHS8cLGj+u72z9NX+UqyC9M6Q54MvtG5Y3Abu/0Vw0nywcuXCOqRvQ2hMS+eECsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129810; c=relaxed/simple;
	bh=JQTIe8JMxkNxe5JfmeBIbVWz9NGiNeER2iB56mvI2JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opw2G6/Z+UF4801N9w99cw2SgmR3KHiea4w8QgC4Oj/nO74/Hb835FDTF1jeVTKVibl5iL/jgptlW7htnqzLs/X9u9nVHycmux+qHM2SAPhm2EplonSDvIjW3uOA+mL5gvJbiG3/zhtYOJHVm1+lIgF1I/0bDq/vOiBFUsCxn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTLRs/l+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129809; x=1745665809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQTIe8JMxkNxe5JfmeBIbVWz9NGiNeER2iB56mvI2JA=;
  b=RTLRs/l+llQEEVP7LHg3394BRU+g7KPkJtpuWPQ7O7KyifOLzNhlPru7
   Gj0MTjyKmIY+aB/7ayUD94meKWO/c6Ce2Kv34MvUsmcQfPQ0gNVZGsMZ1
   5szTkxH5A/FkyftSmoQU3oThx/2s0zpo78OAhUTMXV0xI19tQzktDtLym
   6dh/T3qL6bj2nm2Ryp/tJNTvw1BMPrtuUJdtkXwYN7E4y8DxRqb66DKkJ
   hWJ32k1DVuSvukq4WbTl5OqfR6PkN3ayoOgjj/8EgcpFnNN/9ZEGJ94F3
   02lJRWXIOuWZTxwqAnY9It4gqTDvwh5/49Dshh6z4H5FZIbFaEHeoMng6
   Q==;
X-CSE-ConnectionGUID: NyKx0v9vSemB51EDXFg4FA==
X-CSE-MsgGUID: q8fXYOY2SDaxUlACQYtLbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20474068"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20474068"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:10:08 -0700
X-CSE-ConnectionGUID: dNgowoCqTdqrrUIRnOLusw==
X-CSE-MsgGUID: fhK8fq9ASAyJ8H6m2n3snA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30030901"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 04:10:04 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	embg@meta.com,
	cyan@meta.com,
	brian.will@intel.com,
	weigang.li@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [RFC PATCH 2/6] Revert "crypto: deflate - Remove zlib-deflate"
Date: Fri, 26 Apr 2024 11:54:25 +0100
Message-ID: <20240426110941.5456-3-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

This reverts commit 62a465c25e99b9a98259a6b7f5bb759f5296d501.
---
 crypto/deflate.c | 61 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index 6e31e0db0e86..b2a46f6dc961 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -39,20 +39,24 @@ struct deflate_ctx {
 	struct z_stream_s decomp_stream;
 };
 
-static int deflate_comp_init(struct deflate_ctx *ctx)
+static int deflate_comp_init(struct deflate_ctx *ctx, int format)
 {
 	int ret = 0;
 	struct z_stream_s *stream = &ctx->comp_stream;
 
 	stream->workspace = vzalloc(zlib_deflate_workspacesize(
-				    -DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL));
+				    MAX_WBITS, MAX_MEM_LEVEL));
 	if (!stream->workspace) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = zlib_deflateInit2(stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
-				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
-				Z_DEFAULT_STRATEGY);
+	if (format)
+		ret = zlib_deflateInit(stream, 3);
+	else
+		ret = zlib_deflateInit2(stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
+					-DEFLATE_DEF_WINBITS,
+					DEFLATE_DEF_MEMLEVEL,
+					Z_DEFAULT_STRATEGY);
 	if (ret != Z_OK) {
 		ret = -EINVAL;
 		goto out_free;
@@ -64,7 +68,7 @@ static int deflate_comp_init(struct deflate_ctx *ctx)
 	goto out;
 }
 
-static int deflate_decomp_init(struct deflate_ctx *ctx)
+static int deflate_decomp_init(struct deflate_ctx *ctx, int format)
 {
 	int ret = 0;
 	struct z_stream_s *stream = &ctx->decomp_stream;
@@ -74,7 +78,10 @@ static int deflate_decomp_init(struct deflate_ctx *ctx)
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = zlib_inflateInit2(stream, -DEFLATE_DEF_WINBITS);
+	if (format)
+		ret = zlib_inflateInit(stream);
+	else
+		ret = zlib_inflateInit2(stream, -DEFLATE_DEF_WINBITS);
 	if (ret != Z_OK) {
 		ret = -EINVAL;
 		goto out_free;
@@ -98,21 +105,21 @@ static void deflate_decomp_exit(struct deflate_ctx *ctx)
 	vfree(ctx->decomp_stream.workspace);
 }
 
-static int __deflate_init(void *ctx)
+static int __deflate_init(void *ctx, int format)
 {
 	int ret;
 
-	ret = deflate_comp_init(ctx);
+	ret = deflate_comp_init(ctx, format);
 	if (ret)
 		goto out;
-	ret = deflate_decomp_init(ctx);
+	ret = deflate_decomp_init(ctx, format);
 	if (ret)
 		deflate_comp_exit(ctx);
 out:
 	return ret;
 }
 
-static void *deflate_alloc_ctx(struct crypto_scomp *tfm)
+static void *gen_deflate_alloc_ctx(struct crypto_scomp *tfm, int format)
 {
 	struct deflate_ctx *ctx;
 	int ret;
@@ -121,7 +128,7 @@ static void *deflate_alloc_ctx(struct crypto_scomp *tfm)
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	ret = __deflate_init(ctx);
+	ret = __deflate_init(ctx, format);
 	if (ret) {
 		kfree(ctx);
 		return ERR_PTR(ret);
@@ -130,11 +137,21 @@ static void *deflate_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
+static void *deflate_alloc_ctx(struct crypto_scomp *tfm)
+{
+	return gen_deflate_alloc_ctx(tfm, 0);
+}
+
+static void *zlib_deflate_alloc_ctx(struct crypto_scomp *tfm)
+{
+	return gen_deflate_alloc_ctx(tfm, 1);
+}
+
 static int deflate_init(struct crypto_tfm *tfm)
 {
 	struct deflate_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	return __deflate_init(ctx);
+	return __deflate_init(ctx, 0);
 }
 
 static void __deflate_exit(void *ctx)
@@ -269,7 +286,7 @@ static struct crypto_alg alg = {
 	.coa_decompress  	= deflate_decompress } }
 };
 
-static struct scomp_alg scomp = {
+static struct scomp_alg scomp[] = { {
 	.alloc_ctx		= deflate_alloc_ctx,
 	.free_ctx		= deflate_free_ctx,
 	.compress		= deflate_scompress,
@@ -279,7 +296,17 @@ static struct scomp_alg scomp = {
 		.cra_driver_name = "deflate-scomp",
 		.cra_module	 = THIS_MODULE,
 	}
-};
+}, {
+	.alloc_ctx		= zlib_deflate_alloc_ctx,
+	.free_ctx		= deflate_free_ctx,
+	.compress		= deflate_scompress,
+	.decompress		= deflate_sdecompress,
+	.base			= {
+		.cra_name	= "zlib-deflate",
+		.cra_driver_name = "zlib-deflate-scomp",
+		.cra_module	 = THIS_MODULE,
+	}
+} };
 
 static int __init deflate_mod_init(void)
 {
@@ -289,7 +316,7 @@ static int __init deflate_mod_init(void)
 	if (ret)
 		return ret;
 
-	ret = crypto_register_scomp(&scomp);
+	ret = crypto_register_scomps(scomp, ARRAY_SIZE(scomp));
 	if (ret) {
 		crypto_unregister_alg(&alg);
 		return ret;
@@ -301,7 +328,7 @@ static int __init deflate_mod_init(void)
 static void __exit deflate_mod_fini(void)
 {
 	crypto_unregister_alg(&alg);
-	crypto_unregister_scomp(&scomp);
+	crypto_unregister_scomps(scomp, ARRAY_SIZE(scomp));
 }
 
 subsys_initcall(deflate_mod_init);
-- 
2.44.0


