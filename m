Return-Path: <linux-btrfs+bounces-19401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C9C9245C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11204E681D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6D032F77C;
	Fri, 28 Nov 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlIB1Rw6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0D3314AB;
	Fri, 28 Nov 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339300; cv=none; b=JkWKXifWi87FnzDX35eH93pczAd5XK3Ydakl37e2eR6xNryzYWnGdP6DPc0fdboPi9T93KFQofJzJr9dihc6mJfnoDXR0O8shBw8KGQJegBGbrCseNs6x+6mHktVLkj5qRKqnMYJjSWlVbjUuVOLe8a0V7H7uo6pO9erKwsZlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339300; c=relaxed/simple;
	bh=p31Dfj9nEPwokqsjCSCb/7DgmeErXmQXCYeGslmMVa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNrBhcHQRtgCYHpIvZkuyMisReJFV9aoeohqo+7NUQ5np10AlTOj/Mb95SReRiodrClaDa1oPHDPZl72Cv1WNTeO3yCfKGUguwWFHeR0Fvr23kmU/lzlohKRR3RNeKJN/iKu3N7axZ6c5tBUiTxmmFbHDGhS5sVXygPwEzRxi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlIB1Rw6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339299; x=1795875299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p31Dfj9nEPwokqsjCSCb/7DgmeErXmQXCYeGslmMVa4=;
  b=jlIB1Rw64npCf2eTxz0GYjmRmMKTWknhXuMBSsvTzp7BqxsjLXtvK+sB
   PrBWxhwUVu76Tqscxxi4mpjXIbqf20ss2amopJjfaZj5W1v5RgR4YoqdF
   rObEf7Hjyr+YWg9Bm0MPOE4w5S1MFgpXn5Uo2cxctZYqhylB+7+XwGNG/
   TK/4QhVRMN6OpI7Yq+rIEePyGjXL2MN/cBZDm9xtdO4myoBDtFRpXObsh
   oGQUgCy1frckRGUvYw9yUhQ8plSKX1LNC/RrAtQifsPizzx+EDUf1cKPB
   R+34woydLwZobYVrYuo7Emc7V+FXXewN43Lvh9I+ZXOkCSWhNeW3AgW9N
   w==;
X-CSE-ConnectionGUID: z5+/TTpTS8+TOfVbdEuuHw==
X-CSE-MsgGUID: THLi8fwvSGWRhIItD6n3eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409488"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409488"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:59 -0800
X-CSE-ConnectionGUID: QS/DFuEnQV2DejZkN3TXhg==
X-CSE-MsgGUID: ZaNPbOpORKesQj44aJns+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823052"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:56 -0800
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
Subject: [RFC PATCH 08/16] crypto: acomp - Add setparam interface
Date: Fri, 28 Nov 2025 19:04:56 +0000
Message-ID: <20251128191531.1703018-9-giovanni.cabiddu@intel.com>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

Add the acompress plubming for setparam.  This is modelled after
setkey for ahash.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/acompress.c                  | 73 +++++++++++++++++++++++++++--
 crypto/compress.h                   |  9 +++-
 crypto/scompress.c                  |  9 +---
 include/crypto/acompress.h          | 18 +++++++
 include/crypto/internal/acompress.h |  3 ++
 5 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index be28cbfd22e3..12bae6ee5925 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -48,6 +48,56 @@ static inline struct acomp_alg *crypto_acomp_alg(struct crypto_acomp *tfm)
 	return __crypto_acomp_alg(crypto_acomp_tfm(tfm)->__crt_alg);
 }
 
+static int acomp_no_setparam(struct crypto_acomp *tfm, const u8 *param,
+			    unsigned int len)
+{
+	return -ENOSYS;
+}
+
+static int acomp_set_need_param(struct crypto_acomp *tfm,
+				struct acomp_alg *alg)
+{
+	if (alg->calg.base.cra_type != &crypto_acomp_type) {
+		struct crypto_scomp **ctx = acomp_tfm_ctx(tfm);
+		struct crypto_scomp *scomp = *ctx;
+
+		if (!crypto_scomp_alg_has_setparam(crypto_scomp_alg(scomp)))
+			return 0;
+	} else if (alg->setparam == acomp_no_setparam) {
+		return 0;
+	}
+
+	if ((alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
+		crypto_acomp_set_flags(tfm, CRYPTO_TFM_NEED_KEY);
+
+	return 0;
+}
+
+int crypto_acomp_setparam(struct crypto_acomp *tfm, const u8 *param,
+			  unsigned int len)
+{
+	struct acomp_alg *alg = crypto_acomp_alg(tfm);
+	int err;
+
+	if (alg->calg.base.cra_type == &crypto_acomp_type) {
+		err = alg->setparam(tfm, param, len);
+	} else {
+		struct crypto_scomp **ctx = acomp_tfm_ctx(tfm);
+		struct crypto_scomp *scomp = *ctx;
+
+		err = crypto_scomp_setparam(scomp, param, len);
+	}
+
+	if (unlikely(err)) {
+		acomp_set_need_param(tfm, alg);
+		return err;
+	}
+
+	crypto_acomp_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(crypto_acomp_setparam);
+
 static int __maybe_unused crypto_acomp_report(
 	struct sk_buff *skb, struct crypto_alg *alg)
 {
@@ -87,8 +137,9 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 	struct crypto_acomp *fb = NULL;
 	int err;
 
-	if (tfm->__crt_alg->cra_type != &crypto_acomp_type)
-		return crypto_init_scomp_ops_async(tfm);
+	if (alg->calg.base.cra_type != &crypto_acomp_type)
+		return crypto_init_scomp_ops_async(tfm) ?:
+		       acomp_set_need_param(acomp, alg);
 
 	if (acomp_is_async(acomp)) {
 		fb = crypto_alloc_acomp(crypto_acomp_alg_name(acomp), 0,
@@ -116,6 +167,10 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 	if (err)
 		goto out_free_fb;
 
+	err = acomp_set_need_param(acomp, alg);
+	if (err)
+		goto out_free_fb;
+
 	return 0;
 
 out_free_fb:
@@ -285,6 +340,8 @@ int crypto_acomp_compress(struct acomp_req *req)
 {
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
 
+	if (crypto_acomp_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
 	if (acomp_req_on_stack(req) && acomp_is_async(tfm))
 		return -EAGAIN;
 	if (crypto_acomp_req_virt(tfm) || acomp_request_issg(req))
@@ -297,6 +354,8 @@ int crypto_acomp_decompress(struct acomp_req *req)
 {
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
 
+	if (crypto_acomp_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
 	if (acomp_req_on_stack(req) && acomp_is_async(tfm))
 		return -EAGAIN;
 	if (crypto_acomp_req_virt(tfm) || acomp_request_issg(req))
@@ -312,11 +371,19 @@ void comp_prepare_alg(struct comp_alg_common *alg)
 	base->cra_flags &= ~CRYPTO_ALG_TYPE_MASK;
 }
 
+static void acomp_prepare_alg(struct acomp_alg *alg)
+{
+	comp_prepare_alg(&alg->calg);
+
+	if (!alg->setparam)
+		alg->setparam = acomp_no_setparam;
+}
+
 int crypto_register_acomp(struct acomp_alg *alg)
 {
 	struct crypto_alg *base = &alg->calg.base;
 
-	comp_prepare_alg(&alg->calg);
+	acomp_prepare_alg(alg);
 
 	base->cra_type = &crypto_acomp_type;
 	base->cra_flags |= CRYPTO_ALG_TYPE_ACOMPRESS;
diff --git a/crypto/compress.h b/crypto/compress.h
index f7737a1fcbbd..55f6bd137bdc 100644
--- a/crypto/compress.h
+++ b/crypto/compress.h
@@ -9,13 +9,20 @@
 #ifndef _LOCAL_CRYPTO_COMPRESS_H
 #define _LOCAL_CRYPTO_COMPRESS_H
 
+#include <crypto/internal/scompress.h>
 #include "internal.h"
 
 struct acomp_req;
-struct comp_alg_common;
 
 int crypto_init_scomp_ops_async(struct crypto_tfm *tfm);
+int scomp_no_setparam(struct crypto_scomp *tfm, const u8 *param,
+		      unsigned int len);
 
 void comp_prepare_alg(struct comp_alg_common *alg);
 
+static inline bool crypto_scomp_alg_has_setparam(struct scomp_alg *alg)
+{
+	return alg->setparam != scomp_no_setparam;
+}
+
 #endif	/* _LOCAL_CRYPTO_COMPRESS_H */
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 900796f3035a..67da9ef9b9cc 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -45,17 +45,12 @@ static cpumask_t scomp_scratch_want;
 static void scomp_scratch_workfn(struct work_struct *work);
 static DECLARE_WORK(scomp_scratch_work, scomp_scratch_workfn);
 
-static int scomp_no_setparam(struct crypto_scomp *tfm, const u8 *param,
-			     unsigned int len)
+int scomp_no_setparam(struct crypto_scomp *tfm, const u8 *param,
+		      unsigned int len)
 {
 	return -ENOSYS;
 }
 
-static bool crypto_scomp_alg_has_setparam(struct scomp_alg *alg)
-{
-	return alg->setparam != scomp_no_setparam;
-}
-
 static bool crypto_scomp_alg_needs_param(struct scomp_alg *alg)
 {
 	return crypto_scomp_alg_has_setparam(alg) &&
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 9eacb9fa375d..3e735171271e 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -186,6 +186,21 @@ static inline struct comp_alg_common *crypto_comp_alg_common(
 	return __crypto_comp_alg_common(crypto_acomp_tfm(tfm)->__crt_alg);
 }
 
+static inline u32 crypto_acomp_get_flags(struct crypto_acomp *tfm)
+{
+	return crypto_tfm_get_flags(crypto_acomp_tfm(tfm));
+}
+
+static inline void crypto_acomp_set_flags(struct crypto_acomp *tfm, u32 flags)
+{
+	crypto_tfm_set_flags(crypto_acomp_tfm(tfm), flags);
+}
+
+static inline void crypto_acomp_clear_flags(struct crypto_acomp *tfm, u32 flags)
+{
+	crypto_tfm_clear_flags(crypto_acomp_tfm(tfm), flags);
+}
+
 static inline unsigned int crypto_acomp_reqsize(struct crypto_acomp *tfm)
 {
 	return tfm->reqsize;
@@ -554,4 +569,7 @@ static inline struct acomp_req *acomp_request_on_stack_init(
 struct acomp_req *acomp_request_clone(struct acomp_req *req,
 				      size_t total, gfp_t gfp);
 
+int crypto_acomp_setparam(struct crypto_acomp *tfm,
+			  const u8 *param, unsigned int len);
+
 #endif
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index 2d97440028ff..4cdc98a64418 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -28,6 +28,7 @@
  *
  * @compress:	Function performs a compress operation
  * @decompress:	Function performs a de-compress operation
+ * @setparam:	Set parameters of the algorithm (e.g., compression level)
  * @init:	Initialize the cryptographic transformation object.
  *		This function is used to initialize the cryptographic
  *		transformation object. This function is called only once at
@@ -46,6 +47,8 @@
 struct acomp_alg {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	int (*setparam)(struct crypto_acomp *tfm, const u8 *param,
+			unsigned int len);
 	int (*init)(struct crypto_acomp *tfm);
 	void (*exit)(struct crypto_acomp *tfm);
 
-- 
2.51.1


