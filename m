Return-Path: <linux-btrfs+bounces-19400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C34C9240D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6920B3509F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBB3314A9;
	Fri, 28 Nov 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDI9BYqq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EE33123D;
	Fri, 28 Nov 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339298; cv=none; b=cTecwxG6l6HaeWpMMBF14Q8WNihUzY9FmR/fKRyXO6ElcNPxYXsxpm8b0ktvF3EV2VDDEKDk5fkxi0ZyV6QaiaqnKBNT8H85r5kf+P2s26tAfi0T9iKOnjU/mSHp8JG8ntsFowCofUJfS3K+UVwW4RUiM1Dag/9C9O5tA8PgOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339298; c=relaxed/simple;
	bh=y3ErzXKc3FPuya5jOZqBcRVODuHT2ckpbDssR0XNHKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk9dJbLKowy3TpBLfWKenAfV1HXYXrFHhjpfZWX4uHZSkrBFkFMLGU1Omij35xJUkxL5i5JFClPW2uuE3t1cb7o4YozfceZ9fVhBUGa5QR6ti4kTGUu+Id99s0zqGNwrNcH8GFxAqos2He+yIeDKlzaPOr3M1t4tjo+EwfZo/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDI9BYqq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339297; x=1795875297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y3ErzXKc3FPuya5jOZqBcRVODuHT2ckpbDssR0XNHKc=;
  b=jDI9BYqqtCnrh574tA5KOsjwt3FuPflb+kig5Ci57weoqFOUJFLPwzbv
   BPgPBYFZYcOg5N9UeSK6bygWNgSFNAqsvSphhPYU9U+yCZbY0tymAUT6V
   uzuHA4zGY64jdO18gCCHXwpoKnnbjqaHDPXh5b7XxyW7fbRVaZzsjQhgg
   PHYuhgls2EgH5ErKqI7/0xTjLbkILcp4VxAr03OnkRALSz1H3Y5yeTiEr
   2utnrOwx3biOC9rKN7W7jGoVx4iJYVvPuwuu36o+sERGf+EkqfRqjTtsd
   taAZUs17NCvPu5h6C8uaCoUrVrfW0L7mSmb9pMtxdulo99ZpHfMF+O+Mq
   A==;
X-CSE-ConnectionGUID: ced5sbxbReeeWK73MUlmpA==
X-CSE-MsgGUID: 8fVB1xqgS7CIpLvI0KjnPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409477"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409477"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:56 -0800
X-CSE-ConnectionGUID: Kg9RyktLTDKBKeryJ8YyEA==
X-CSE-MsgGUID: gJheXkDPRYqQwaLkE/OZ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823040"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:53 -0800
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
Subject: [RFC PATCH 07/16] crypto: scomp - Add setparam interface
Date: Fri, 28 Nov 2025 19:04:55 +0000
Message-ID: <20251128191531.1703018-8-giovanni.cabiddu@intel.com>
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

Add the scompress plumbing for setparam.  This is modelled after
setkey for shash.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/scompress.c                  | 48 ++++++++++++++++++++++++++++-
 include/crypto/internal/scompress.h | 27 ++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 1a7ed8ae65b0..900796f3035a 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -45,6 +45,46 @@ static cpumask_t scomp_scratch_want;
 static void scomp_scratch_workfn(struct work_struct *work);
 static DECLARE_WORK(scomp_scratch_work, scomp_scratch_workfn);
 
+static int scomp_no_setparam(struct crypto_scomp *tfm, const u8 *param,
+			     unsigned int len)
+{
+	return -ENOSYS;
+}
+
+static bool crypto_scomp_alg_has_setparam(struct scomp_alg *alg)
+{
+	return alg->setparam != scomp_no_setparam;
+}
+
+static bool crypto_scomp_alg_needs_param(struct scomp_alg *alg)
+{
+	return crypto_scomp_alg_has_setparam(alg) &&
+	       !(alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY);
+}
+
+static void scomp_set_need_param(struct crypto_scomp *tfm,
+				 struct scomp_alg *alg)
+{
+	if (crypto_scomp_alg_needs_param(alg))
+		crypto_scomp_set_flags(tfm, CRYPTO_TFM_NEED_KEY);
+}
+
+int crypto_scomp_setparam(struct crypto_scomp *tfm, const u8 *param,
+			  unsigned int len)
+{
+	struct scomp_alg *scomp = crypto_scomp_alg(tfm);
+	int err;
+
+	err = scomp->setparam(tfm, param, len);
+	if (unlikely(err)) {
+		scomp_set_need_param(tfm, scomp);
+		return err;
+	}
+
+	crypto_scomp_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
+	return 0;
+}
+
 static int __maybe_unused crypto_scomp_report(
 	struct sk_buff *skb, struct crypto_alg *alg)
 {
@@ -121,9 +161,12 @@ static int crypto_scomp_alloc_scratches(void)
 
 static int crypto_scomp_init_tfm(struct crypto_tfm *tfm)
 {
-	struct scomp_alg *alg = crypto_scomp_alg(__crypto_scomp_tfm(tfm));
+	struct crypto_scomp *comp = __crypto_scomp_tfm(tfm);
+	struct scomp_alg *alg = crypto_scomp_alg(comp);
 	int ret = 0;
 
+	scomp_set_need_param(comp, alg);
+
 	mutex_lock(&scomp_lock);
 	ret = crypto_acomp_alloc_streams(&alg->streams);
 	if (ret)
@@ -356,6 +399,9 @@ static void scomp_prepare_alg(struct scomp_alg *alg)
 	comp_prepare_alg(&alg->calg);
 
 	base->cra_flags |= CRYPTO_ALG_REQ_VIRT;
+
+	if (!alg->setparam)
+		alg->setparam = scomp_no_setparam;
 }
 
 int crypto_register_scomp(struct scomp_alg *alg)
diff --git a/include/crypto/internal/scompress.h b/include/crypto/internal/scompress.h
index 6a2c5f2e90f9..cfeff1009e2f 100644
--- a/include/crypto/internal/scompress.h
+++ b/include/crypto/internal/scompress.h
@@ -20,6 +20,7 @@ struct crypto_scomp {
  *
  * @compress:	Function performs a compress operation
  * @decompress:	Function performs a de-compress operation
+ * @setparam:	Set parameters of the algorithm (e.g., compression level)
  * @streams:	Per-cpu memory for algorithm
  * @calg:	Cmonn algorithm data structure shared with acomp
  */
@@ -30,6 +31,8 @@ struct scomp_alg {
 	int (*decompress)(struct crypto_scomp *tfm, const u8 *src,
 			  unsigned int slen, u8 *dst, unsigned int *dlen,
 			  void *ctx);
+	int (*setparam)(struct crypto_scomp *tfm, const u8 *param,
+			unsigned int len);
 
 	struct crypto_acomp_streams streams;
 
@@ -64,10 +67,31 @@ static inline struct scomp_alg *crypto_scomp_alg(struct crypto_scomp *tfm)
 	return __crypto_scomp_alg(crypto_scomp_tfm(tfm)->__crt_alg);
 }
 
+static inline u32 crypto_scomp_get_flags(struct crypto_scomp *tfm)
+{
+	return crypto_tfm_get_flags(crypto_scomp_tfm(tfm));
+}
+
+static inline void crypto_scomp_set_flags(struct crypto_scomp *tfm, u32 flags)
+{
+	crypto_tfm_set_flags(crypto_scomp_tfm(tfm), flags);
+}
+
+static inline void crypto_scomp_clear_flags(struct crypto_scomp *tfm, u32 flags)
+{
+	crypto_tfm_clear_flags(crypto_scomp_tfm(tfm), flags);
+}
+
+int crypto_scomp_setparam(struct crypto_scomp *tfm, const u8 *param,
+			  unsigned int len);
+
 static inline int crypto_scomp_compress(struct crypto_scomp *tfm,
 					const u8 *src, unsigned int slen,
 					u8 *dst, unsigned int *dlen, void *ctx)
 {
+	if (crypto_scomp_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
 	return crypto_scomp_alg(tfm)->compress(tfm, src, slen, dst, dlen, ctx);
 }
 
@@ -76,6 +100,9 @@ static inline int crypto_scomp_decompress(struct crypto_scomp *tfm,
 					  u8 *dst, unsigned int *dlen,
 					  void *ctx)
 {
+	if (crypto_scomp_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
 	return crypto_scomp_alg(tfm)->decompress(tfm, src, slen, dst, dlen,
 						 ctx);
 }
-- 
2.51.1


