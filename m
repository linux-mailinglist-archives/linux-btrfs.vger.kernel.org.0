Return-Path: <linux-btrfs+bounces-19408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F9BC92435
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7D26351304
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C552676DE;
	Fri, 28 Nov 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJvfJBX5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DA1F4262;
	Fri, 28 Nov 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339319; cv=none; b=ECm867HkhuRQK0fcWF54mC9RCF6+U0BjHWvbM3GttFHNN5ojbTdmHQqGDI0DOCm6YvOyFzc7CbIgOxNlySKRpfGNIFXJAoJcnk/TVcHgf2JfeMsqDjuCBhRYOTQSu5X66w8trRP/sxm2fEyX2HapvLCmaQs/Bn6seSQYKrCMyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339319; c=relaxed/simple;
	bh=B2OkQoPd7PN3e+30L9to24M48gAA+HrFg/osArbbW0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO6ME+cmQWbWKyV0oavMBHFMRw9aEhhmaEvvovK477bPpxltJUdnRg10NbP1UlV/EGfPPSkiTUANq4dRxJzUEsAygvn/S+zVrDA6evN/hjc89krNNyGu9OauS47A3GAeO0kNbCyAmsBWRVVe0weRXQYrbjm7sgOX8TrBMp647qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJvfJBX5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339318; x=1795875318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B2OkQoPd7PN3e+30L9to24M48gAA+HrFg/osArbbW0Y=;
  b=FJvfJBX55nbddR4DVx2ebBzwHzuttud0KtSYK8XQ0QS9PL/8v3evvw0n
   fRGhXRDiDVPtouXL8OWWmvcp/2kxACjH01nPqU5cQtOmvb1/TW88BOjNe
   ky3UMnKdH5YW5W+dRlltbvxtLilXgR3fWjJU3tbrqwyexxYNLRnK0JTd1
   LpLVZjGvvbvJoIFdMPQorfF4X8frQDTysdnxalET9DWQZb6SFWAyuWbdv
   LBwrvlmLhiI2sMSn79w6fYLRCG2BR6G6zk2vfELMxRxLx012vzPIdqQYI
   Mr6cpBQV4NJNcNnolbK+a/V9cNhGxTB3MBs4+zU42nWfJfhludWfdxl3f
   A==;
X-CSE-ConnectionGUID: DsDo1cIpRkq/kHxAL6gNdA==
X-CSE-MsgGUID: am+h1lvLRx2sfIBvMsREHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409568"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409568"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:17 -0800
X-CSE-ConnectionGUID: U32IbJP8T+28WA5fRAAPsA==
X-CSE-MsgGUID: DdxkVqhXRzWqLK+GOV4zKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823142"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:15:14 -0800
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
Subject: [RFC PATCH 15/16] crypto: qat - add support for compression levels
Date: Fri, 28 Nov 2025 19:05:03 +0000
Message-ID: <20251128191531.1703018-16-giovanni.cabiddu@intel.com>
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

Add support for compression levels for all compression implementations
in the QAT driver by implementing the setparam() API.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     | 12 ++-
 .../intel/qat/qat_common/adf_accel_devices.h  |  2 +-
 drivers/crypto/intel/qat/qat_common/adf_dc.c  |  5 +-
 drivers/crypto/intel/qat/qat_common/adf_dc.h  |  3 +-
 .../intel/qat/qat_common/adf_gen2_hw_data.c   | 16 +++-
 .../intel/qat/qat_common/adf_gen4_hw_data.c   | 10 ++-
 .../intel/qat/qat_common/qat_comp_algs.c      | 85 ++++++++++++++++++-
 7 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
index b04d6b947da2..07582ea35182 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
@@ -459,7 +459,7 @@ static int ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number)
 	return ret;
 }
 
-static int build_comp_block(void *ctx, enum adf_dc_algo algo)
+static int build_comp_block(void *ctx, enum adf_dc_algo algo, unsigned int level)
 {
 	struct icp_qat_fw_comp_req *req_tmpl = ctx;
 	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
@@ -478,8 +478,16 @@ static int build_comp_block(void *ctx, enum adf_dc_algo algo)
 		return -EINVAL;
 	}
 
+	if (level < 6)
+		hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_51_SEARCH_DEPTH_LEVEL_1;
+	else if (level < 9)
+		hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_51_SEARCH_DEPTH_LEVEL_6;
+	else if (level < 10)
+		hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_51_SEARCH_DEPTH_LEVEL_9;
+	else
+		hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_51_SEARCH_DEPTH_LEVEL_10;
+
 	hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_51_LLLBD_CTRL_LLLBD_DISABLED;
-	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_51_SEARCH_DEPTH_LEVEL_1;
 	lower_val = ICP_QAT_FW_COMP_51_BUILD_CONFIG_LOWER(hw_comp_lower_csr);
 	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
 	cd_pars->u.sl.comp_slice_cfg_word[1] = 0;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index aea24173efe4..bc6951aa36a0 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -245,7 +245,7 @@ struct adf_pfvf_ops {
 };
 
 struct adf_dc_ops {
-	int (*build_comp_block)(void *ctx, enum adf_dc_algo algo);
+	int (*build_comp_block)(void *ctx, enum adf_dc_algo algo, unsigned int level);
 	int (*build_decomp_block)(void *ctx, enum adf_dc_algo algo);
 };
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dc.c b/drivers/crypto/intel/qat/qat_common/adf_dc.c
index 3e8fb4e3ed97..c6aeda2258af 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dc.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_dc.c
@@ -4,7 +4,8 @@
 #include "adf_dc.h"
 #include "icp_qat_fw_comp.h"
 
-int qat_comp_build_ctx(struct adf_accel_dev *accel_dev, void *ctx, enum adf_dc_algo algo)
+int qat_comp_build_ctx(struct adf_accel_dev *accel_dev, void *ctx,
+		       enum adf_dc_algo algo, unsigned int level)
 {
 	struct icp_qat_fw_comp_req *req_tmpl = ctx;
 	struct icp_qat_fw_comp_cd_hdr *comp_cd_ctrl = &req_tmpl->comp_cd_ctrl;
@@ -27,7 +28,7 @@ int qat_comp_build_ctx(struct adf_accel_dev *accel_dev, void *ctx, enum adf_dc_a
 					    ICP_QAT_FW_COMP_ENABLE_SECURE_RAM_USED_AS_INTMD_BUF);
 
 	/* Build HW config block for compression */
-	ret = GET_DC_OPS(accel_dev)->build_comp_block(ctx, algo);
+	ret = GET_DC_OPS(accel_dev)->build_comp_block(ctx, algo, level);
 	if (ret) {
 		dev_err(&GET_DEV(accel_dev), "Failed to build compression block\n");
 		return ret;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dc.h b/drivers/crypto/intel/qat/qat_common/adf_dc.h
index 6cb5e09054a6..eca5a63d85ab 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dc.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_dc.h
@@ -12,6 +12,7 @@ enum adf_dc_algo {
 	QAT_ZSTD,
 };
 
-int qat_comp_build_ctx(struct adf_accel_dev *accel_dev, void *ctx, enum adf_dc_algo algo);
+int qat_comp_build_ctx(struct adf_accel_dev *accel_dev, void *ctx, enum adf_dc_algo algo,
+		       unsigned int level);
 
 #endif /* ADF_DC_H */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
index 6a505e9a5cf9..8dea916ecc45 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
@@ -172,11 +172,12 @@ void adf_gen2_set_ssm_wdtimer(struct adf_accel_dev *accel_dev)
 }
 EXPORT_SYMBOL_GPL(adf_gen2_set_ssm_wdtimer);
 
-static int adf_gen2_build_comp_block(void *ctx, enum adf_dc_algo algo)
+static int adf_gen2_build_comp_block(void *ctx, enum adf_dc_algo algo, unsigned int level)
 {
 	struct icp_qat_fw_comp_req *req_tmpl = ctx;
 	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
 	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+	u32 l;
 
 	switch (algo) {
 	case QAT_DEFLATE:
@@ -186,11 +187,22 @@ static int adf_gen2_build_comp_block(void *ctx, enum adf_dc_algo algo)
 		return -EINVAL;
 	}
 
+	if (level < 2)
+		l = ICP_QAT_HW_COMPRESSION_DEPTH_1;
+	else if (level < 4)
+		l = ICP_QAT_HW_COMPRESSION_DEPTH_4;
+	else if (level < 6)
+		l = ICP_QAT_HW_COMPRESSION_DEPTH_8;
+	else if (level < 8)
+		l = ICP_QAT_HW_COMPRESSION_DEPTH_16;
+	else
+		l = ICP_QAT_HW_COMPRESSION_DEPTH_128;
+
 	cd_pars->u.sl.comp_slice_cfg_word[0] =
 		ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(ICP_QAT_HW_COMPRESSION_DIR_COMPRESS,
 						    ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED,
 						    ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE,
-						    ICP_QAT_HW_COMPRESSION_DEPTH_1,
+						    l,
 						    ICP_QAT_HW_COMPRESSION_FILE_TYPE_0);
 
 	return 0;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index faeffe941591..d949ed5400d0 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -491,7 +491,7 @@ int adf_gen4_bank_drain_start(struct adf_accel_dev *accel_dev,
 	return ret;
 }
 
-static int adf_gen4_build_comp_block(void *ctx, enum adf_dc_algo algo)
+static int adf_gen4_build_comp_block(void *ctx, enum adf_dc_algo algo, unsigned int level)
 {
 	struct icp_qat_fw_comp_req *req_tmpl = ctx;
 	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
@@ -519,7 +519,13 @@ static int adf_gen4_build_comp_block(void *ctx, enum adf_dc_algo algo)
 		return -EINVAL;
 	}
 
-	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1;
+	if (level < 4)
+		hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1;
+	else if (level < 7)
+		hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_6;
+	else
+		hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_9;
+
 	hw_comp_lower_csr.hash_update = ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_DONT_ALLOW;
 	hw_comp_lower_csr.edmm = ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_ENABLED;
 	hw_comp_upper_csr.nice = ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_DEFAULT_VAL;
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 0e237c2d7966..d549c5a315d8 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -6,6 +6,7 @@
 #include <crypto/scatterwalk.h>
 #include <linux/dma-mapping.h>
 #include <linux/workqueue.h>
+#include <linux/zlib.h>
 #include <linux/zstd.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
@@ -28,6 +29,7 @@
 #define QAT_ZSTD_MAX_BLOCK_SIZE			65536
 #define QAT_MAX_SEQUENCES			(128 * 1024)
 #define QAT_ZSTD_MAX_CONTENT_SIZE		4096
+#define QAT_DEFAULT_COMP_LEVEL			1
 
 static DEFINE_MUTEX(algs_lock);
 static unsigned int active_devs_deflate;
@@ -132,6 +134,7 @@ struct qat_compression_ctx {
 	int (*qat_comp_callback)(struct qat_compression_req *qat_req, void *resp,
 				 struct qat_callback_params *params);
 	struct crypto_acomp *ftfm;
+	struct crypto_acomp_params params;
 };
 
 struct qat_compression_req {
@@ -327,7 +330,7 @@ static int qat_comp_alg_init_tfm(struct crypto_acomp *acomp_tfm, int alg)
 		return -EINVAL;
 	ctx->inst = inst;
 
-	return qat_comp_build_ctx(inst->accel_dev, ctx->comp_ctx, alg);
+	return qat_comp_build_ctx(inst->accel_dev, ctx->comp_ctx, alg, QAT_DEFAULT_COMP_LEVEL);
 }
 
 static int qat_comp_alg_deflate_init_tfm(struct crypto_acomp *acomp_tfm)
@@ -340,6 +343,8 @@ static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
 	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 
+	crypto_acomp_putparams(&ctx->params);
+
 	qat_compression_put_instance(ctx->inst);
 	memset(ctx, 0, sizeof(*ctx));
 }
@@ -691,6 +696,80 @@ static int qat_comp_alg_sw_decompress(struct acomp_req *req)
 	return ret;
 }
 
+static int qat_comp_setparam_deflate(struct crypto_acomp *tfm, const u8 *param,
+				     unsigned int len)
+{
+	struct qat_compression_ctx *ctx = acomp_tfm_ctx(tfm);
+	struct crypto_acomp_params *p = &ctx->params;
+	struct adf_accel_dev *accel_dev;
+	int ret;
+
+	if (!ctx->inst || !ctx->inst->accel_dev)
+		return -EINVAL;
+
+	accel_dev = ctx->inst->accel_dev;
+
+	ret = crypto_acomp_getparams(p, param, len);
+	if (ret)
+		return ret;
+
+	if (p->level > Z_BEST_COMPRESSION || p->level < Z_DEFAULT_COMPRESSION) {
+		dev_warn(&GET_DEV(accel_dev),
+			 "[%s]: invalid level %d\n", __func__, p->level);
+		p->level = QAT_DEFAULT_COMP_LEVEL;
+		return -EINVAL;
+	}
+
+	if (p->level == CRYPTO_COMP_NO_LEVEL)
+		p->level = QAT_DEFAULT_COMP_LEVEL;
+
+	return qat_comp_build_ctx(ctx->inst->accel_dev, ctx->comp_ctx,
+				  QAT_DEFLATE, p->level);
+}
+
+static int qat_comp_setparam_zstd(struct crypto_acomp *tfm, const u8 *param,
+				  unsigned int len, enum adf_dc_algo algo)
+{
+	struct qat_compression_ctx *ctx = acomp_tfm_ctx(tfm);
+	struct crypto_acomp_params *p = &ctx->params;
+	struct adf_accel_dev *accel_dev;
+	int ret;
+
+	if (!ctx->inst || !ctx->inst->accel_dev)
+		return -EINVAL;
+
+	accel_dev = ctx->inst->accel_dev;
+
+	ret = crypto_acomp_getparams(p, param, len);
+	if (ret)
+		return ret;
+
+	if (p->level > zstd_max_clevel() || p->level < zstd_min_clevel()) {
+		dev_warn(&GET_DEV(accel_dev),
+			 "[%s]: invalid level %d\n", __func__, p->level);
+		p->level = QAT_DEFAULT_COMP_LEVEL;
+		return -EINVAL;
+	}
+
+	if (p->level == CRYPTO_COMP_NO_LEVEL || p->level <= 0)
+		p->level = QAT_DEFAULT_COMP_LEVEL;
+
+	return qat_comp_build_ctx(ctx->inst->accel_dev, ctx->comp_ctx, algo,
+				  p->level);
+}
+
+static int qat_comp_setparam_zstd_native(struct crypto_acomp *tfm, const u8 *param,
+					 unsigned int len)
+{
+	return qat_comp_setparam_zstd(tfm, param, len, QAT_ZSTD);
+}
+
+static int qat_comp_setparam_zstd_lz4s(struct crypto_acomp *tfm, const u8 *param,
+				       unsigned int len)
+{
+	return qat_comp_setparam_zstd(tfm, param, len, QAT_LZ4S);
+}
+
 static struct acomp_alg qat_acomp_deflate[] = { {
 	.base = {
 		.cra_name = "deflate",
@@ -705,6 +784,7 @@ static struct acomp_alg qat_acomp_deflate[] = { {
 	.exit = qat_comp_alg_exit_tfm,
 	.compress = qat_comp_alg_compress,
 	.decompress = qat_comp_alg_decompress,
+	.setparam = qat_comp_setparam_deflate,
 }, {
 	.base = {
 		.cra_name = "zlib-deflate",
@@ -719,6 +799,7 @@ static struct acomp_alg qat_acomp_deflate[] = { {
 	.exit = qat_comp_alg_exit_tfm,
 	.compress = qat_comp_alg_rfc1950_compress,
 	.decompress = qat_comp_alg_rfc1950_decompress,
+	.setparam = qat_comp_setparam_deflate,
 }};
 
 static struct acomp_alg qat_acomp_zstd_lz4s = {
@@ -736,6 +817,7 @@ static struct acomp_alg qat_acomp_zstd_lz4s = {
 	.exit = qat_comp_alg_zstd_exit_tfm,
 	.compress = qat_comp_alg_lz4s_zstd_compress,
 	.decompress = qat_comp_alg_sw_decompress,
+	.setparam = qat_comp_setparam_zstd_lz4s,
 };
 
 static struct acomp_alg qat_acomp_zstd_native = {
@@ -753,6 +835,7 @@ static struct acomp_alg qat_acomp_zstd_native = {
 	.exit = qat_comp_alg_zstd_exit_tfm,
 	.compress = qat_comp_alg_compress,
 	.decompress = qat_comp_alg_zstd_decompress,
+	.setparam = qat_comp_setparam_zstd_native,
 };
 
 static int qat_comp_algs_register_deflate(void)
-- 
2.51.1


