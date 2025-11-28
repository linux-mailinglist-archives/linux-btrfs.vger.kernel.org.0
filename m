Return-Path: <linux-btrfs+bounces-19404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D49C9244A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5083ACB63
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BDE23C512;
	Fri, 28 Nov 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCcW1Clo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60A32FA2F;
	Fri, 28 Nov 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339308; cv=none; b=QBpO53fLeGDL1jizgPF4GClfVXuqunPtS+SmQUvkvnn2eI+/W0Dajg1VEkl3MtN+9MCebJv5eXbtl4D88vG+uHLPh9ZbLmjHlDQl+Lm8vIBm2/H555awccUFNSWeQldgs7saLldwgJl1MRaayellpmOaPghBlN9giXhCQbVRk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339308; c=relaxed/simple;
	bh=T2jiKLCKK+/+zm00sguEXt/0ksPcgDvfx3hY4uOTUVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKV26Ba2NdkgaADggF/u43NiRTNx4dJErzVUesE2KyplbUKR877ZCZA1kUc+GLVbO3Yl0/E4iqPabvmKv4XPu4iAh/O3L0Z5aLo/D1rVkjM99P6xwdW8/7X/uwByYRO5kvZFRPQ8jC63dZ3wuYTYY3Uf/9dW8+/C/doETyRZEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCcW1Clo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339307; x=1795875307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T2jiKLCKK+/+zm00sguEXt/0ksPcgDvfx3hY4uOTUVE=;
  b=hCcW1CloX6SMaqaT40DigbWyx0ZvEN2hcnesj4EDt6NWL6ifjL1wWd8I
   9y47usWPTJ+WMGjji/MBu+oufvhnd/lakMtoOtJYebghYOoJmBjRER3wu
   xUtzpL0vo1wSgu7b07TeaiGU1vXM8yBb3fN54U0OcnrFiByDy80Iu1iRP
   7Xa+7ZbF55xStIAk/JCF44ItaJFV8kwP0gqIJJMjLevokW2PBbe7ppNh4
   36jlk/T+iu2pDCnOQgGKmll2tzOhAT8x3xN4lqyuJZ0PBrkRvPPURAvb4
   ih8753evqzbWQehxEsMxmwgz6r0cQAYJ7FLXUq8j30OArC1a2iCWQH7uu
   g==;
X-CSE-ConnectionGUID: uM5vI/LEQJOSDvxXqj0skg==
X-CSE-MsgGUID: LWUm0XN4Tf+alFmTSBbwhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409528"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409528"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:07 -0800
X-CSE-ConnectionGUID: 6NCVp1d6TSiHurD6WjJzUQ==
X-CSE-MsgGUID: UkqR51G1RX6I6PebWvtIbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823092"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:15:04 -0800
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
Subject: [RFC PATCH 11/16] crypto: deflate - add support for compression levels
Date: Fri, 28 Nov 2025 19:04:59 +0000
Message-ID: <20251128191531.1703018-12-giovanni.cabiddu@intel.com>
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

Add support for configurable compression levels in the deflate and
zlib-deflate algorithms by implementing the setparam() API. This API
allows the acomp interface to adjust compression parameters, providing
users with finer control over compression behavior.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/deflate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index d75c2951dfa9..114bd1caddf6 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -120,6 +120,7 @@ enum algo {
 
 static int _deflate_compress(struct acomp_req *req, enum algo algo)
 {
+	struct crypto_acomp_params *p = acomp_tfm_ctx(crypto_acomp_reqtfm(req));
 	struct crypto_acomp_stream *s;
 	struct deflate_stream *ds;
 	int window_bits;
@@ -139,7 +140,7 @@ static int _deflate_compress(struct acomp_req *req, enum algo algo)
 	s = crypto_acomp_lock_stream_bh(&deflate_streams);
 	ds = s->ctx;
 
-	err = zlib_deflateInit2(&ds->stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
+	err = zlib_deflateInit2(&ds->stream, p->level, Z_DEFLATED,
 				window_bits, DEFLATE_DEF_MEMLEVEL,
 				Z_DEFAULT_STRATEGY);
 	if (err != Z_OK) {
@@ -267,8 +268,11 @@ static int zlib_deflate_decompress(struct acomp_req *req)
 
 static int deflate_init(struct crypto_acomp *tfm)
 {
+	struct crypto_acomp_params *p = acomp_tfm_ctx(tfm);
 	int ret;
 
+	p->level = DEFLATE_DEF_LEVEL;
+
 	mutex_lock(&deflate_stream_lock);
 	ret = crypto_acomp_alloc_streams(&deflate_streams);
 	mutex_unlock(&deflate_stream_lock);
@@ -276,21 +280,55 @@ static int deflate_init(struct crypto_acomp *tfm)
 	return ret;
 }
 
+static int deflate_setparam(struct crypto_acomp *tfm, const u8 *param,
+			    unsigned int len)
+{
+	struct crypto_acomp_params *p = acomp_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_acomp_getparams(p, param, len);
+	if (ret)
+		return ret;
+
+	if (p->level > Z_BEST_COMPRESSION || p->level < Z_DEFAULT_COMPRESSION) {
+		p->level = DEFLATE_DEF_LEVEL;
+		return -EINVAL;
+	}
+
+	if (p->level == CRYPTO_COMP_NO_LEVEL)
+		p->level = DEFLATE_DEF_LEVEL;
+
+	return 0;
+}
+
+static void deflate_exit(struct crypto_acomp *tfm)
+{
+	struct crypto_acomp_params *p = acomp_tfm_ctx(tfm);
+
+	crypto_acomp_putparams(p);
+}
+
 static struct acomp_alg acomps[] = { {
 	.compress		= deflate_compress,
 	.decompress		= deflate_decompress,
+	.setparam		= deflate_setparam,
 	.init			= deflate_init,
+	.exit			= deflate_exit,
 	.base.cra_name		= "deflate",
 	.base.cra_driver_name	= "deflate-generic",
 	.base.cra_flags		= CRYPTO_ALG_REQ_VIRT,
+	.base.cra_ctxsize	= sizeof(struct crypto_acomp_params),
 	.base.cra_module	= THIS_MODULE,
 }, {
 	.compress		= zlib_deflate_compress,
 	.decompress		= zlib_deflate_decompress,
+	.setparam		= deflate_setparam,
 	.init			= deflate_init,
+	.exit			= deflate_exit,
 	.base.cra_name		= "zlib-deflate",
 	.base.cra_driver_name	= "zlib-deflate-generic",
 	.base.cra_flags		= CRYPTO_ALG_REQ_VIRT,
+	.base.cra_ctxsize	= sizeof(struct crypto_acomp_params),
 	.base.cra_module	= THIS_MODULE,
 } };
 
-- 
2.51.1


