Return-Path: <linux-btrfs+bounces-19405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC8C92429
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82EDD34F063
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D132FA08;
	Fri, 28 Nov 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awUbVpik"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E832A3F0;
	Fri, 28 Nov 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339311; cv=none; b=lu7xaed9dXGbZwH1/lYbQdoX1+m+FavZrJeBVymXlE2d3yUx/KWNErs6bWZ+Yhrxb+vfyk741JR/AWWbpE6sonnewyvp7vddzQCUPXAUh+DrZW5vRe9mCWj8N3Yr+Y5jcucHuwyl3cx2c1X6aCZ/PDDe9JFrJs6raMMZGB97efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339311; c=relaxed/simple;
	bh=k0U1ebIYv9VITVKHPtneMklpxBVCg7Ib3Vqdksodq04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcmNNZvtKC/d8XGudgwIVqMry07oWkZjXqhhoF9xQxAKT936hVxqr5W5cv68nFg2/4JeUrkuH4zWAXSZD5x1u0pGmphPBbiLtIg8reOb2GFpw5dZsZwbHpJmcq3Z4BAKkAgI0tO8Rm/xcYSCbfHRDfudjla/b83vI9gC3QxliWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awUbVpik; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339310; x=1795875310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k0U1ebIYv9VITVKHPtneMklpxBVCg7Ib3Vqdksodq04=;
  b=awUbVpikGrugYFbwpjXYIa/Krmt9YRV0Xa3ssVjh+VEVl7x8pxyvlYtm
   THsbRvnI8qKlq2v/BUGlXiLwdWKfX3nqRKGX6wuhMRi4azwdynGDXnLbT
   CG0qUaGiRrzl0PeYUSGb5qimGyai7WUybPzzmZkpBRIu9Xbdc+TwxVyaV
   AuIBOSqtrQ2zuThdlzHv/UMdKOwiXQPOKKT+gqj7Bv3iFD4iOZpJizqHI
   lzQuMcShcztjYC64q0/apsoPRwsmtCUn3koIm/yVXu87MdWwsRujRz1y0
   lV79wnepC4TUxAJs2XZ0Dr3irhfUv2wv7xY0nhj3Qad2O+iH3kgBnAGVu
   Q==;
X-CSE-ConnectionGUID: wYVfXzHUTl+wOYhTVl8h/A==
X-CSE-MsgGUID: BlRp5p+WR/qkKiWv1sBjWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409536"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409536"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:09 -0800
X-CSE-ConnectionGUID: 6EQk/Ly0SCCPJjQ0YIMIeg==
X-CSE-MsgGUID: AVunbErqS9me/goJIh+MMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823103"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:15:07 -0800
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: clm@fb.comi,
	dsterba@suse.com,
	terrelln@fb.com,
	herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	cyan@meta.com,
	brian.will@intel.com,
	weigang.li@intel.com,
	senozhatsky@chromium.org,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Subject: [RFC PATCH 12/16] crypto: zstd - add support for compression levels
Date: Fri, 28 Nov 2025 19:05:00 +0000
Message-ID: <20251128191531.1703018-13-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>

Add support for configurable compression levels in the zstd algorithms
by implementing the setparam() API. This API allows the acomp interface
to adjust compression parameters, providing users with finer control
over compression behavior.

The context size has been increased to support the maximum level.

Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
---
 crypto/zstd.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index fd240130ad4c..ed59a3ce25ba 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -37,7 +37,7 @@ static void *zstd_alloc_stream(int node)
 	struct zstd_ctx *ctx;
 	size_t wksp_size;
 
-	params = zstd_get_params(ZSTD_DEF_LEVEL, ZSTD_MAX_SIZE);
+	params = zstd_get_params(zstd_max_clevel(), ZSTD_MAX_SIZE);
 
 	wksp_size = max(zstd_cstream_workspace_bound(&params.cParams),
 			zstd_dstream_workspace_bound(ZSTD_MAX_SIZE));
@@ -66,8 +66,11 @@ static struct crypto_acomp_streams zstd_streams = {
 
 static int zstd_init(struct crypto_acomp *acomp_tfm)
 {
+	struct crypto_acomp_params *p = acomp_tfm_ctx(acomp_tfm);
 	int ret = 0;
 
+	p->level = ZSTD_DEF_LEVEL;
+
 	mutex_lock(&zstd_stream_lock);
 	ret = crypto_acomp_alloc_streams(&zstd_streams);
 	mutex_unlock(&zstd_stream_lock);
@@ -96,6 +99,7 @@ static int zstd_compress_one(struct acomp_req *req, struct zstd_ctx *ctx,
 
 static int zstd_compress(struct acomp_req *req)
 {
+	struct crypto_acomp_params *p = acomp_tfm_ctx(crypto_acomp_reqtfm(req));
 	struct crypto_acomp_stream *s;
 	unsigned int pos, scur, dcur;
 	unsigned int total_out = 0;
@@ -111,6 +115,8 @@ static int zstd_compress(struct acomp_req *req)
 	s = crypto_acomp_lock_stream_bh(&zstd_streams);
 	ctx = s->ctx;
 
+	ctx->params = zstd_get_params(p->level, ZSTD_MAX_SIZE);
+
 	ret = acomp_walk_virt(&walk, req, true);
 	if (ret)
 		goto out;
@@ -284,14 +290,45 @@ static int zstd_decompress(struct acomp_req *req)
 	return ret;
 }
 
+static int zstd_setparam(struct crypto_acomp *tfm, const u8 *param,
+			 unsigned int len)
+{
+	struct crypto_acomp_params *p = acomp_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_acomp_getparams(p, param, len);
+	if (ret)
+		return ret;
+
+	if (p->level > zstd_max_clevel() || p->level < zstd_min_clevel()) {
+		p->level = ZSTD_DEF_LEVEL;
+		return -EINVAL;
+	}
+
+	if (p->level == CRYPTO_COMP_NO_LEVEL)
+		p->level = ZSTD_DEF_LEVEL;
+
+	return 0;
+}
+
+static void zstd_exit(struct crypto_acomp *tfm)
+{
+	struct crypto_acomp_params *p = acomp_tfm_ctx(tfm);
+
+	crypto_acomp_putparams(p);
+}
+
 static struct acomp_alg zstd_acomp = {
 	.base = {
 		.cra_name = "zstd",
 		.cra_driver_name = "zstd-generic",
 		.cra_flags = CRYPTO_ALG_REQ_VIRT,
+		.cra_ctxsize = sizeof(struct crypto_acomp_params),
 		.cra_module = THIS_MODULE,
 	},
 	.init = zstd_init,
+	.exit = zstd_exit,
+	.setparam = zstd_setparam,
 	.compress = zstd_compress,
 	.decompress = zstd_decompress,
 };
-- 
2.51.1


