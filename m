Return-Path: <linux-btrfs+bounces-19399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC44C9242C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8EC3AF126
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21013331230;
	Fri, 28 Nov 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUNTNYGD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F6331232;
	Fri, 28 Nov 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339295; cv=none; b=Bu8lLBZ6DxAalQEYC21P0azU3IHxbMg4R8E7QCkk/tp1tJ02EWx3CCIeDKnzV0VjxsNgX2hvIoN63+hLrqzc89OWRc8bvUnN+NTpiFotNBEoOQMbN/e4bYWfmIWRQ4h4iV3SWpaYYeovNL4qlNY6bkJ2xi0TK01dDPiSqU+tkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339295; c=relaxed/simple;
	bh=ZvqmPw4T6Gz2H3QQj/9UnAx9YD3LsI8N8HhCpw+JSNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM04f5oewfRjRAF3KMPtOWRiw1s6BpLwfe392Po3elI3x6kBIAVr+YTbj4wgdM3h3fHCiDumau9ubfcbGjPWfL0YCBcLuDSZHRR9sgT6gmY01gyaRf6jk0PI/0bOwM+AwdWywClqWmwzaM2Ja01lOZnRQShb1OdGmbxErU47RrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUNTNYGD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339294; x=1795875294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZvqmPw4T6Gz2H3QQj/9UnAx9YD3LsI8N8HhCpw+JSNA=;
  b=CUNTNYGDYKahJk2UuBuy/0cfbjLFmXYM2lBG/5T0hF4aBk9WEkvKtrwF
   ERuoNjC06Q8GDIKQluqKOqelJdUft3/YbXM8R2ZqNyMNQ17+c+mq1HOHB
   sC2uvUd8hBRa5NXQK6j+QjcyFfygK2ittIDRsipAUHvOdZY/qJoWb12Yv
   jpXh6yH/3F+snYRjHbQLS2PH1rQ719OPrWVlWzx7Uig4FPU/slzirqTxQ
   BLP7fQ69T+uSknvNSfonaRhrOEd76s0nM3/N3fvN5lFp5ErRKqje/T1Zu
   W5yQ4FTiaj/eKuR7PUfcQxc6ADrzYtNShncfVXsoSvJ9m6zchbeQwRe+k
   w==;
X-CSE-ConnectionGUID: 28vmeiPfQvWs/fgSKZmxvA==
X-CSE-MsgGUID: ZfTMn0EHTPOTmYIKchamZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409465"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409465"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:54 -0800
X-CSE-ConnectionGUID: 07AYphcUQHqkriIaFNQvYw==
X-CSE-MsgGUID: xepMrwxoS7ONCJUXcrYvfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823031"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:51 -0800
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
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [RFC PATCH 06/16] crypto: deflate - add support for deflate rfc1950 (zlib)
Date: Fri, 28 Nov 2025 19:04:54 +0000
Message-ID: <20251128191531.1703018-7-giovanni.cabiddu@intel.com>
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

Add acomp backend for zlib-deflate compression algorithm.

This backend outputs data in the format defined by rfc1950: raw deflate
data wrapped with a zlib header and footer.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/deflate.c | 74 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index a3e1fff55661..26b4617f6196 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -36,7 +36,7 @@ static DEFINE_MUTEX(deflate_stream_lock);
 static void *deflate_alloc_stream(void)
 {
 	size_t size = max(zlib_inflate_workspacesize(),
-			  zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS,
+			  zlib_deflate_workspacesize(MAX_WBITS,
 						     DEFLATE_DEF_MEMLEVEL));
 	struct deflate_stream *ctx;
 
@@ -113,17 +113,34 @@ static int deflate_compress_one(struct acomp_req *req,
 	return 0;
 }
 
-static int deflate_compress(struct acomp_req *req)
+enum algo {
+	ALGO_DEFLATE,
+	ALGO_ZLIB_DEFLATE,
+};
+
+static int _deflate_compress(struct acomp_req *req, enum algo algo)
 {
 	struct crypto_acomp_stream *s;
 	struct deflate_stream *ds;
+	int window_bits;
 	int err;
 
+	switch (algo) {
+	case ALGO_DEFLATE:
+		window_bits = -DEFLATE_DEF_WINBITS;
+		break;
+	case ALGO_ZLIB_DEFLATE:
+		window_bits = DEFLATE_DEF_WINBITS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	s = crypto_acomp_lock_stream_bh(&deflate_streams);
 	ds = s->ctx;
 
 	err = zlib_deflateInit2(&ds->stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
-				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
+				window_bits, DEFLATE_DEF_MEMLEVEL,
 				Z_DEFAULT_STRATEGY);
 	if (err != Z_OK) {
 		err = -EINVAL;
@@ -138,6 +155,16 @@ static int deflate_compress(struct acomp_req *req)
 	return err;
 }
 
+static int deflate_compress(struct acomp_req *req)
+{
+	return _deflate_compress(req, ALGO_DEFLATE);
+}
+
+static int zlib_deflate_compress(struct acomp_req *req)
+{
+	return _deflate_compress(req, ALGO_ZLIB_DEFLATE);
+}
+
 static int deflate_decompress_one(struct acomp_req *req,
 				  struct deflate_stream *ds)
 {
@@ -194,7 +221,7 @@ static int deflate_decompress_one(struct acomp_req *req,
 	return 0;
 }
 
-static int deflate_decompress(struct acomp_req *req)
+static int _deflate_decompress(struct acomp_req *req, enum algo algo)
 {
 	struct crypto_acomp_stream *s;
 	struct deflate_stream *ds;
@@ -203,7 +230,18 @@ static int deflate_decompress(struct acomp_req *req)
 	s = crypto_acomp_lock_stream_bh(&deflate_streams);
 	ds = s->ctx;
 
-	err = zlib_inflateInit2(&ds->stream, -DEFLATE_DEF_WINBITS);
+	switch (algo) {
+	case ALGO_DEFLATE:
+		err = zlib_inflateInit2(&ds->stream, -DEFLATE_DEF_WINBITS);
+		break;
+	case ALGO_ZLIB_DEFLATE:
+		err = zlib_inflateInit(&ds->stream);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
 	if (err != Z_OK) {
 		err = -EINVAL;
 		goto out;
@@ -217,6 +255,16 @@ static int deflate_decompress(struct acomp_req *req)
 	return err;
 }
 
+static int deflate_decompress(struct acomp_req *req)
+{
+	return _deflate_decompress(req, ALGO_DEFLATE);
+}
+
+static int zlib_deflate_decompress(struct acomp_req *req)
+{
+	return _deflate_decompress(req, ALGO_ZLIB_DEFLATE);
+}
+
 static int deflate_init(struct crypto_acomp *tfm)
 {
 	int ret;
@@ -228,7 +276,7 @@ static int deflate_init(struct crypto_acomp *tfm)
 	return ret;
 }
 
-static struct acomp_alg acomp = {
+static struct acomp_alg acomps[] = { {
 	.compress		= deflate_compress,
 	.decompress		= deflate_decompress,
 	.init			= deflate_init,
@@ -236,16 +284,24 @@ static struct acomp_alg acomp = {
 	.base.cra_driver_name	= "deflate-generic",
 	.base.cra_flags		= CRYPTO_ALG_REQ_VIRT,
 	.base.cra_module	= THIS_MODULE,
-};
+}, {
+	.compress		= zlib_deflate_compress,
+	.decompress		= zlib_deflate_decompress,
+	.init			= deflate_init,
+	.base.cra_name		= "zlib-deflate",
+	.base.cra_driver_name	= "zlib-deflate-generic",
+	.base.cra_flags		= CRYPTO_ALG_REQ_VIRT,
+	.base.cra_module	= THIS_MODULE,
+} };
 
 static int __init deflate_mod_init(void)
 {
-	return crypto_register_acomp(&acomp);
+	return crypto_register_acomps(acomps, ARRAY_SIZE(acomps));
 }
 
 static void __exit deflate_mod_fini(void)
 {
-	crypto_unregister_acomp(&acomp);
+	crypto_unregister_acomps(acomps, ARRAY_SIZE(acomps));
 	crypto_acomp_free_streams(&deflate_streams);
 }
 
-- 
2.51.1


