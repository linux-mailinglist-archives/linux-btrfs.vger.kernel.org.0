Return-Path: <linux-btrfs+bounces-19407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF60C92477
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B514E4E9002
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB424A078;
	Fri, 28 Nov 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8pojJ0S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E31523A;
	Fri, 28 Nov 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339317; cv=none; b=deVGx8G34Vd5jfBiIw5+51H2UIy7uJtzsSob3btpFxv+elztfFMcs/iKfw2gfUSCD3Fe1unTsGD9R+ZPjhDiruxWYtWwr5nQyQCsQOjwlRpE2qhXD/umfSagw4IKCXkLTWt4p1hqa5FG2Fl+5Apw7CVPi/0svRkUa4pGv9M1AO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339317; c=relaxed/simple;
	bh=P9sShO2SJ+J12w2qf8NfcC3WRBmt0j00rkH0httD118=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW8nLlX9w11Dg22KCiuN5TghNRyvrqjLsyEpT0YwM3Pc86oDhzych/Pm8+HDwpC5mC6xyvptn+6ur96uYkErqC4pRxQ8Ku9B7eYw8Mxsov4Y1omJzdSpMZCGG7Qn90Mh1CgEa85J36uX0515wuVg2ANYbi7RRKp8unaIsMX4HzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8pojJ0S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339315; x=1795875315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9sShO2SJ+J12w2qf8NfcC3WRBmt0j00rkH0httD118=;
  b=c8pojJ0SXZTDbWS5jfeVnHH0yxbB6y339JfoZIrysfODASjcwOfbU5zo
   eMfiF6KfRGLdcHh5YlDtSYu0TAXhGAEJc8O+CKjzdQX1KLYGZg3PrWpTb
   W2KhEWb9cp4/DSGLTZNK2pWexINI5xOmA+SDNAOfDmCt1C2JQuf2wmboC
   8aXZcH88uN4WWSZuma+vTPXPumrmjUI7ymG80guy7F+MZr5Bh96W49xFR
   /uK95/CaY+emRJdFCiNBewsnL4+t3e4gotE3AW+41VTam1TuQoohKV2/O
   13H33m/JttSiCqFla3mw+BuCXmpyS+jIexpqetikPR0teF9ong3z4k6pX
   g==;
X-CSE-ConnectionGUID: CdzGHxx+R4mqZt+n9TgoYw==
X-CSE-MsgGUID: X2qd05KcQgW1H2Mr+fBaOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409557"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409557"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:15 -0800
X-CSE-ConnectionGUID: NJQoLWCoTpW2RqrQ8pzKcw==
X-CSE-MsgGUID: iyKNyd6yTLCgu49Q9GuSqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823131"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:15:12 -0800
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
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Subject: [RFC PATCH 14/16] crypto: qat - add support for zstd
Date: Fri, 28 Nov 2025 19:05:02 +0000
Message-ID: <20251128191531.1703018-15-giovanni.cabiddu@intel.com>
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

Add support for the ZSTD algorithm for both QAT GEN4 and QAT GEN6 via
the acomp API.

For GEN4, data is compressed in hardware using the LZ4s algorithm (a
QAT-specific variant of LZ4). The output is then parsed to generate ZSTD
sequences, and the ZSTD library is invoked to produce the final ZSTD
stream using the zstd_compress_sequences_and_literals() API. The maximum
compressed size is limited to 512 KB due to the use of per-CPU scratch
buffers. On GEN4, only compression is supported in hardware;
decompression falls back to software.

For GEN6, both compression and decompression are offloaded to the
accelerator, which natively supports the ZSTD algorithm. However, since
GEN6 is limited to a history size of 64 KB, decompression of frames
compressed with a larger history falls back to software.

Since GEN2 devices do not support ZSTD or LZ4s, add a mechanism that
prevents selecting GEN2 compression instances for ZSTD or LZ4s when a
GEN2 plug-in card is present on a system with an embedded GEN4 or GEN6
device.

In addition, modified the algorithm registration logic to allow
registering the correct implementation, i.e. LZ4s based for GEN4 or
native ZSTD for GEN6.

Co-developed-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/Kconfig              |   1 +
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |   1 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   1 +
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     |   7 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   6 +
 .../intel/qat/qat_common/adf_common_drv.h     |   6 +-
 .../intel/qat/qat_common/adf_gen4_hw_data.c   |  19 +-
 .../crypto/intel/qat/qat_common/adf_init.c    |   6 +-
 .../crypto/intel/qat/qat_common/icp_qat_fw.h  |   7 +
 .../intel/qat/qat_common/icp_qat_fw_comp.h    |   2 +
 .../crypto/intel/qat/qat_common/icp_qat_hw.h  |   3 +-
 .../intel/qat/qat_common/qat_comp_algs.c      | 516 +++++++++++++++++-
 .../intel/qat/qat_common/qat_comp_req.h       |  11 +
 .../qat/qat_common/qat_comp_zstd_utils.c      | 120 ++++
 .../qat/qat_common/qat_comp_zstd_utils.h      |  13 +
 .../intel/qat/qat_common/qat_compression.c    |  23 +-
 17 files changed, 705 insertions(+), 38 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.h

diff --git a/drivers/crypto/intel/qat/Kconfig b/drivers/crypto/intel/qat/Kconfig
index 4b4861460dd4..9a48bc7c3118 100644
--- a/drivers/crypto/intel/qat/Kconfig
+++ b/drivers/crypto/intel/qat/Kconfig
@@ -11,6 +11,7 @@ config CRYPTO_DEV_QAT
 	select CRYPTO_LIB_SHA1
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
+	select CRYPTO_ZSTD
 	select FW_LOADER
 	select CRC8
 
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 53fa91d577ed..37a282bdb2e2 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -469,6 +469,7 @@ void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->clock_frequency = ADF_420XX_AE_FREQ;
 	hw_data->services_supported = adf_gen4_services_supported;
 	hw_data->get_svc_slice_cnt = adf_gen4_get_svc_slice_cnt;
+	hw_data->accel_capabilities_ext_mask = ADF_ACCEL_CAPABILITIES_EXT_ZSTD_LZ4S;
 
 	adf_gen4_set_err_mask(&hw_data->dev_err_mask);
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 740f68a36ac5..9b36520812ba 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -463,6 +463,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->clock_frequency = ADF_4XXX_AE_FREQ;
 	hw_data->services_supported = adf_gen4_services_supported;
 	hw_data->get_svc_slice_cnt = adf_gen4_get_svc_slice_cnt;
+	hw_data->accel_capabilities_ext_mask = ADF_ACCEL_CAPABILITIES_EXT_ZSTD_LZ4S;
 
 	adf_gen4_set_err_mask(&hw_data->dev_err_mask);
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
index bed88d3ce8ca..b04d6b947da2 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
@@ -471,6 +471,9 @@ static int build_comp_block(void *ctx, enum adf_dc_algo algo)
 	case QAT_DEFLATE:
 		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DYNAMIC;
 	break;
+	case QAT_ZSTD:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_ZSTD_COMPRESS;
+	break;
 	default:
 		return -EINVAL;
 	}
@@ -494,6 +497,9 @@ static int build_decomp_block(void *ctx, enum adf_dc_algo algo)
 	case QAT_DEFLATE:
 		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
 	break;
+	case QAT_ZSTD:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_ZSTD_DECOMPRESS;
+	break;
 	default:
 		return -EINVAL;
 	}
@@ -933,6 +939,7 @@ void adf_init_hw_data_6xxx(struct adf_hw_device_data *hw_data)
 	hw_data->num_rps = ADF_GEN6_ETR_MAX_BANKS;
 	hw_data->clock_frequency = ADF_6XXX_AE_FREQ;
 	hw_data->get_svc_slice_cnt = adf_gen6_get_svc_slice_cnt;
+	hw_data->accel_capabilities_ext_mask = ADF_ACCEL_CAPABILITIES_EXT_ZSTD;
 
 	adf_gen6_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen6_init_pf_pfvf_ops(&hw_data->pfvf_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 89845754841b..b56781c6a764 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -39,6 +39,7 @@ intel_qat-y := adf_accel_engine.o \
 	qat_bl.o \
 	qat_comp_algs.o \
 	qat_compression.o \
+	qat_comp_zstd_utils.o \
 	qat_crypto.o \
 	qat_hal.o \
 	qat_mig_dev.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 9fe3239f0114..aea24173efe4 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -58,6 +58,11 @@ enum adf_accel_capabilities {
 	ADF_ACCEL_CAPABILITIES_RANDOM_NUMBER = 128
 };
 
+enum adf_accel_capabilities_ext {
+	ADF_ACCEL_CAPABILITIES_EXT_ZSTD_LZ4S = BIT(0),
+	ADF_ACCEL_CAPABILITIES_EXT_ZSTD = BIT(1),
+};
+
 enum adf_fuses {
 	ADF_FUSECTL0,
 	ADF_FUSECTL1,
@@ -334,6 +339,7 @@ struct adf_hw_device_data {
 	u32 fuses[ADF_MAX_FUSES];
 	u32 straps;
 	u32 accel_capabilities_mask;
+	u32 accel_capabilities_ext_mask;
 	u32 extended_dc_capabilities;
 	u16 fw_capabilities;
 	u32 clock_frequency;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 6cf3a95489e8..7b8b295ac459 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -111,12 +111,12 @@ void qat_algs_unregister(void);
 int qat_asym_algs_register(void);
 void qat_asym_algs_unregister(void);
 
-struct qat_compression_instance *qat_compression_get_instance_node(int node);
+struct qat_compression_instance *qat_compression_get_instance_node(int node, int alg);
 void qat_compression_put_instance(struct qat_compression_instance *inst);
 int qat_compression_register(void);
 int qat_compression_unregister(void);
-int qat_comp_algs_register(void);
-void qat_comp_algs_unregister(void);
+int qat_comp_algs_register(u32 caps);
+void qat_comp_algs_unregister(u32 caps);
 void qat_comp_alg_callback(void *resp);
 
 int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 349fdb323763..faeffe941591 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -504,14 +504,21 @@ static int adf_gen4_build_comp_block(void *ctx, enum adf_dc_algo algo)
 	switch (algo) {
 	case QAT_DEFLATE:
 		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DYNAMIC;
+		hw_comp_lower_csr.algo = ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_ILZ77;
+		hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_ENABLED;
+		hw_comp_lower_csr.skip_ctrl = ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_LITERAL;
+		break;
+	case QAT_LZ4S:
+		header->service_cmd_id = ICP_QAT_FW_COMP_20_CMD_LZ4S_COMPRESS;
+		hw_comp_lower_csr.algo = ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_LZ4S;
+		hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_DISABLED;
+		hw_comp_lower_csr.skip_ctrl = ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_TOKEN;
+		hw_comp_lower_csr.abd = ICP_QAT_HW_COMP_20_ABD_ABD_DISABLED;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	hw_comp_lower_csr.skip_ctrl = ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_LITERAL;
-	hw_comp_lower_csr.algo = ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_ILZ77;
-	hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_ENABLED;
 	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1;
 	hw_comp_lower_csr.hash_update = ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_DONT_ALLOW;
 	hw_comp_lower_csr.edmm = ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_ENABLED;
@@ -538,12 +545,16 @@ static int adf_gen4_build_decomp_block(void *ctx, enum adf_dc_algo algo)
 	switch (algo) {
 	case QAT_DEFLATE:
 		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
+		hw_decomp_lower_csr.algo = ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_DEFLATE;
+		break;
+	case QAT_LZ4S:
+		header->service_cmd_id = ICP_QAT_FW_COMP_20_CMD_LZ4S_DECOMPRESS;
+		hw_decomp_lower_csr.algo = ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_LZ4S;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	hw_decomp_lower_csr.algo = ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_DEFLATE;
 	lower_val = ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_LOWER(hw_decomp_lower_csr);
 
 	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index 46491048e0bb..8da96ab4f62e 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -179,6 +179,7 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	struct service_hndl *service;
+	u32 caps;
 	int ret;
 
 	set_bit(ADF_STATUS_STARTING, &accel_dev->status);
@@ -252,7 +253,8 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 	}
 	set_bit(ADF_STATUS_CRYPTO_ALGS_REGISTERED, &accel_dev->status);
 
-	if (!list_empty(&accel_dev->compression_list) && qat_comp_algs_register()) {
+	caps = hw_data->accel_capabilities_ext_mask;
+	if (!list_empty(&accel_dev->compression_list) && qat_comp_algs_register(caps)) {
 		dev_err(&GET_DEV(accel_dev),
 			"Failed to register compression algs\n");
 		set_bit(ADF_STATUS_STARTING, &accel_dev->status);
@@ -305,7 +307,7 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 
 	if (!list_empty(&accel_dev->compression_list) &&
 	    test_bit(ADF_STATUS_COMP_ALGS_REGISTERED, &accel_dev->status))
-		qat_comp_algs_unregister();
+		qat_comp_algs_unregister(hw_data->accel_capabilities_ext_mask);
 	clear_bit(ADF_STATUS_COMP_ALGS_REGISTERED, &accel_dev->status);
 
 	list_for_each_entry(service, &service_table, list) {
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw.h
index c141160421e1..2fea30a78340 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw.h
@@ -151,6 +151,13 @@ struct icp_qat_fw_comn_resp {
 	ICP_QAT_FW_COMN_CNV_FLAG_BITPOS, \
 	ICP_QAT_FW_COMN_CNV_FLAG_MASK)
 
+#define ICP_QAT_FW_COMN_ST_BLK_FLAG_BITPOS 4
+#define ICP_QAT_FW_COMN_ST_BLK_FLAG_MASK 0x1
+#define ICP_QAT_FW_COMN_HDR_ST_BLK_FLAG_GET(hdr_flags) \
+	QAT_FIELD_GET(hdr_flags, \
+	ICP_QAT_FW_COMN_ST_BLK_FLAG_BITPOS, \
+	ICP_QAT_FW_COMN_ST_BLK_FLAG_MASK)
+
 #define ICP_QAT_FW_COMN_HDR_CNV_FLAG_SET(hdr_t, val) \
 	QAT_FIELD_SET((hdr_t.hdr_flags), (val), \
 	ICP_QAT_FW_COMN_CNV_FLAG_BITPOS, \
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_comp.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_comp.h
index 81969c515a17..2526053ee630 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_comp.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_comp.h
@@ -8,6 +8,8 @@ enum icp_qat_fw_comp_cmd_id {
 	ICP_QAT_FW_COMP_CMD_STATIC = 0,
 	ICP_QAT_FW_COMP_CMD_DYNAMIC = 1,
 	ICP_QAT_FW_COMP_CMD_DECOMPRESS = 2,
+	ICP_QAT_FW_COMP_CMD_ZSTD_COMPRESS = 10,
+	ICP_QAT_FW_COMP_CMD_ZSTD_DECOMPRESS = 11,
 	ICP_QAT_FW_COMP_CMD_DELIMITER
 };
 
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
index b8f1c4ffb8b5..bbb8edcd09e8 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
@@ -335,7 +335,8 @@ enum icp_qat_hw_compression_delayed_match {
 enum icp_qat_hw_compression_algo {
 	ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE = 0,
 	ICP_QAT_HW_COMPRESSION_ALGO_LZS = 1,
-	ICP_QAT_HW_COMPRESSION_ALGO_DELIMITER = 2
+	ICP_QAT_HW_COMPRESSION_ALGO_ZSTD = 2,
+	ICP_QAT_HW_COMPRESSION_ALGO_DELIMITER
 };
 
 enum icp_qat_hw_compression_depth {
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 23a1ed4f6b40..0e237c2d7966 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -6,6 +6,7 @@
 #include <crypto/scatterwalk.h>
 #include <linux/dma-mapping.h>
 #include <linux/workqueue.h>
+#include <linux/zstd.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "adf_dc.h"
@@ -13,18 +14,104 @@
 #include "qat_comp_req.h"
 #include "qat_compression.h"
 #include "qat_algs_send.h"
+#include "qat_comp_zstd_utils.h"
 
-#define QAT_RFC_1950_HDR_SIZE 2
-#define QAT_RFC_1950_FOOTER_SIZE 4
-#define QAT_RFC_1950_CM_DEFLATE 8
-#define QAT_RFC_1950_CM_DEFLATE_CINFO_32K 7
-#define QAT_RFC_1950_CM_MASK 0x0f
-#define QAT_RFC_1950_CM_OFFSET 4
-#define QAT_RFC_1950_DICT_MASK 0x20
-#define QAT_RFC_1950_COMP_HDR 0x785e
+#define QAT_RFC_1950_HDR_SIZE			2
+#define QAT_RFC_1950_FOOTER_SIZE		4
+#define QAT_RFC_1950_CM_DEFLATE			8
+#define QAT_RFC_1950_CM_DEFLATE_CINFO_32K	7
+#define QAT_RFC_1950_CM_MASK			0x0f
+#define QAT_RFC_1950_CM_OFFSET			4
+#define QAT_RFC_1950_DICT_MASK			0x20
+#define QAT_RFC_1950_COMP_HDR			0x785e
+#define QAT_ZSTD_SCRATCH_SIZE			524288
+#define QAT_ZSTD_MAX_BLOCK_SIZE			65536
+#define QAT_MAX_SEQUENCES			(128 * 1024)
+#define QAT_ZSTD_MAX_CONTENT_SIZE		4096
 
 static DEFINE_MUTEX(algs_lock);
-static unsigned int active_devs;
+static unsigned int active_devs_deflate;
+static unsigned int active_devs_lz4s;
+static unsigned int active_devs_zstd;
+
+struct qat_zstd_scratch {
+	size_t		cctx_buffer_size;
+	void		*lz4s;
+	void		*input_data;
+	void		*out_seqs;
+	void		*workspace;
+	ZSTD_CCtx	*ctx;
+};
+
+static void *qat_zstd_alloc_scratch(int node)
+{
+	struct qat_zstd_scratch *scratch;
+	ZSTD_parameters params;
+	size_t cctx_size;
+	ZSTD_CCtx *ctx;
+
+	scratch = kzalloc_node(sizeof(*scratch), GFP_KERNEL, node);
+	if (!scratch)
+		return ERR_PTR(-ENOMEM);
+
+	scratch->lz4s = kvmalloc_node(QAT_ZSTD_SCRATCH_SIZE, GFP_KERNEL, node);
+	if (!scratch->lz4s)
+		goto error;
+
+	scratch->input_data = kvmalloc_node(QAT_ZSTD_SCRATCH_SIZE, GFP_KERNEL, node);
+	if (!scratch->input_data)
+		goto error;
+
+	scratch->out_seqs = kvcalloc_node(QAT_MAX_SEQUENCES, sizeof(ZSTD_Sequence),
+					  GFP_KERNEL, node);
+	if (!scratch->out_seqs)
+		goto error;
+
+	params = zstd_get_params(zstd_max_clevel(), QAT_ZSTD_SCRATCH_SIZE);
+	cctx_size = zstd_cctx_workspace_bound(&params.cParams);
+
+	scratch->workspace = kvmalloc_node(cctx_size, GFP_KERNEL | __GFP_ZERO, node);
+	if (!scratch->workspace)
+		goto error;
+
+	ctx = zstd_init_cctx(scratch->workspace, cctx_size);
+	if (!ctx)
+		goto error;
+
+	scratch->ctx = ctx;
+	scratch->cctx_buffer_size = cctx_size;
+
+	zstd_cctx_set_param(ctx, ZSTD_c_blockDelimiters, ZSTD_sf_explicitBlockDelimiters);
+
+	return scratch;
+
+error:
+	kvfree(scratch->lz4s);
+	kvfree(scratch->input_data);
+	kvfree(scratch->out_seqs);
+	kvfree(scratch->workspace);
+	kfree(scratch);
+	return ERR_PTR(-ENOMEM);
+}
+
+static void qat_zstd_free_scratch(void *ctx)
+{
+	struct qat_zstd_scratch *scratch = ctx;
+
+	if (!scratch)
+		return;
+
+	kvfree(scratch->lz4s);
+	kvfree(scratch->input_data);
+	kvfree(scratch->out_seqs);
+	kvfree(scratch->workspace);
+	kfree(scratch);
+}
+
+static struct crypto_acomp_streams qat_zstd_streams = {
+	.alloc_ctx = qat_zstd_alloc_scratch,
+	.free_ctx = qat_zstd_free_scratch,
+};
 
 enum direction {
 	DECOMPRESSION = 0,
@@ -33,10 +120,18 @@ enum direction {
 
 struct qat_compression_req;
 
+struct qat_callback_params {
+	unsigned int produced;
+	unsigned int dlen;
+	bool plain;
+};
+
 struct qat_compression_ctx {
 	u8 comp_ctx[QAT_COMP_CTX_SIZE];
 	struct qat_compression_instance *inst;
-	int (*qat_comp_callback)(struct qat_compression_req *qat_req, void *resp);
+	int (*qat_comp_callback)(struct qat_compression_req *qat_req, void *resp,
+				 struct qat_callback_params *params);
+	struct crypto_acomp *ftfm;
 };
 
 struct qat_compression_req {
@@ -89,7 +184,7 @@ static int parse_zlib_header(u16 zlib_h)
 }
 
 static int qat_comp_rfc1950_callback(struct qat_compression_req *qat_req,
-				     void *resp)
+				     void *resp, struct qat_callback_params *params)
 {
 	struct acomp_req *areq = qat_req->acompress_req;
 	enum direction dir = qat_req->dir;
@@ -134,6 +229,7 @@ static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(areq);
 	struct qat_compression_instance *inst = ctx->inst;
+	struct qat_callback_params params = { };
 	int consumed, produced;
 	s8 cmp_err, xlt_err;
 	int res = -EBADMSG;
@@ -148,6 +244,10 @@ static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 	consumed = qat_comp_get_consumed_ctr(resp);
 	produced = qat_comp_get_produced_ctr(resp);
 
+	/* Cache parameters for algorithm specific callback */
+	params.produced = produced;
+	params.dlen = areq->dlen;
+
 	dev_dbg(&GET_DEV(accel_dev),
 		"[%s][%s][%s] slen = %8d dlen = %8d consumed = %8d produced = %8d cmp_err = %3d xlt_err = %3d",
 		crypto_tfm_alg_driver_name(crypto_acomp_tfm(tfm)),
@@ -155,16 +255,20 @@ static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 		status ? "ERR" : "OK ",
 		areq->slen, areq->dlen, consumed, produced, cmp_err, xlt_err);
 
-	areq->dlen = 0;
+	if (unlikely(status != ICP_QAT_FW_COMN_STATUS_FLAG_OK)) {
+		if (cmp_err == ERR_CODE_OVERFLOW_ERROR || xlt_err == ERR_CODE_OVERFLOW_ERROR)
+			res = -E2BIG;
 
-	if (unlikely(status != ICP_QAT_FW_COMN_STATUS_FLAG_OK))
+		areq->dlen = 0;
 		goto end;
+	}
 
 	if (qat_req->dir == COMPRESSION) {
 		cnv = qat_comp_get_cmp_cnv_flag(resp);
 		if (unlikely(!cnv)) {
 			dev_err(&GET_DEV(accel_dev),
 				"Verified compression not supported\n");
+			areq->dlen = 0;
 			goto end;
 		}
 
@@ -174,15 +278,20 @@ static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 			dev_dbg(&GET_DEV(accel_dev),
 				"Actual buffer overflow: produced=%d, dlen=%d\n",
 				produced, qat_req->actual_dlen);
+
+			res = -E2BIG;
+			areq->dlen = 0;
 			goto end;
 		}
+
+		params.plain = !!qat_comp_get_cmp_uncomp_flag(resp);
 	}
 
 	res = 0;
 	areq->dlen = produced;
 
 	if (ctx->qat_comp_callback)
-		res = ctx->qat_comp_callback(qat_req, resp);
+		res = ctx->qat_comp_callback(qat_req, resp, &params);
 
 end:
 	qat_bl_free_bufl(accel_dev, &qat_req->buf);
@@ -200,7 +309,7 @@ void qat_comp_alg_callback(void *resp)
 	qat_alg_send_backlog(backlog);
 }
 
-static int qat_comp_alg_init_tfm(struct crypto_acomp *acomp_tfm)
+static int qat_comp_alg_init_tfm(struct crypto_acomp *acomp_tfm, int alg)
 {
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
 	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -213,12 +322,17 @@ static int qat_comp_alg_init_tfm(struct crypto_acomp *acomp_tfm)
 		node = tfm->node;
 
 	memset(ctx, 0, sizeof(*ctx));
-	inst = qat_compression_get_instance_node(node);
+	inst = qat_compression_get_instance_node(node, alg);
 	if (!inst)
 		return -EINVAL;
 	ctx->inst = inst;
 
-	return qat_comp_build_ctx(inst->accel_dev, ctx->comp_ctx, QAT_DEFLATE);
+	return qat_comp_build_ctx(inst->accel_dev, ctx->comp_ctx, alg);
+}
+
+static int qat_comp_alg_deflate_init_tfm(struct crypto_acomp *acomp_tfm)
+{
+	return qat_comp_alg_init_tfm(acomp_tfm, QAT_DEFLATE);
 }
 
 static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
@@ -236,7 +350,7 @@ static int qat_comp_alg_rfc1950_init_tfm(struct crypto_acomp *acomp_tfm)
 	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	int ret;
 
-	ret = qat_comp_alg_init_tfm(acomp_tfm);
+	ret = qat_comp_alg_init_tfm(acomp_tfm, QAT_DEFLATE);
 	ctx->qat_comp_callback = &qat_comp_rfc1950_callback;
 
 	return ret;
@@ -317,6 +431,43 @@ static int qat_comp_alg_decompress(struct acomp_req *req)
 	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, 0, 0, 0, 0);
 }
 
+static int qat_comp_alg_zstd_decompress(struct acomp_req *req)
+{
+	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct acomp_req *nreq = acomp_request_ctx(req);
+	zstd_frame_header header;
+	void *buffer;
+	int ret;
+
+	buffer = kmap_local_page(sg_page(req->src)) + req->src->offset;
+	ret = zstd_get_frame_header(&header, buffer, req->src->length);
+	kunmap_local(buffer);
+
+	if (ret) {
+		dev_err(&GET_DEV(ctx->inst->accel_dev),
+			"ZSTD-compressed data has an incomplete frame header\n");
+		return ret;
+	}
+
+	if (header.windowSize > QAT_ZSTD_MAX_BLOCK_SIZE ||
+	    header.frameContentSize >= QAT_ZSTD_MAX_CONTENT_SIZE) {
+		dev_dbg(&GET_DEV(ctx->inst->accel_dev),
+			"Window size=0x%llx\n", header.windowSize);
+
+		memcpy(nreq, req, sizeof(*req));
+		acomp_request_set_tfm(nreq, ctx->ftfm);
+
+		ret = crypto_acomp_decompress(nreq);
+		req->dlen = nreq->dlen;
+
+		return ret;
+	}
+
+	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, 0, 0, 0, 0);
+}
+
 static int qat_comp_alg_rfc1950_compress(struct acomp_req *req)
 {
 	if (!req->dst && req->dlen != 0)
@@ -354,7 +505,193 @@ static int qat_comp_alg_rfc1950_decompress(struct acomp_req *req)
 						QAT_RFC_1950_FOOTER_SIZE, 0, 0);
 }
 
-static struct acomp_alg qat_acomp[] = { {
+static int qat_comp_lz4s_zstd_callback(struct qat_compression_req *qat_req, void *resp,
+				       struct qat_callback_params *params)
+{
+	struct acomp_req *areq = qat_req->acompress_req;
+	struct qat_zstd_scratch *scratch;
+	struct crypto_acomp_stream *s;
+	unsigned int lit_len = 0;
+	ZSTD_Sequence *out_seqs;
+	void *lz4s, *zstd;
+	size_t comp_size;
+	size_t seq_count;
+	void *input_data;
+	ZSTD_CCtx *ctx;
+	int ret = 0;
+
+	if (params->produced + QAT_ZSTD_LIT_COPY_LEN > QAT_ZSTD_SCRATCH_SIZE) {
+		pr_debug("[%s]: produced size (%u) + COPY_SIZE > QAT_ZSTD_SCRATCH_SIZE (%u)\n",
+			 __func__, params->produced, QAT_ZSTD_SCRATCH_SIZE);
+		areq->dlen = 0;
+		return -E2BIG;
+	}
+
+	s = crypto_acomp_lock_stream_bh(&qat_zstd_streams);
+	scratch = s->ctx;
+
+	lz4s = scratch->lz4s;
+	zstd = lz4s;  /* Output buffer is same as lz4s */
+	out_seqs = scratch->out_seqs;
+	ctx = scratch->ctx;
+	input_data = scratch->input_data;
+
+	if (likely(!params->plain)) {
+		if (likely(sg_nents(areq->dst) == 1)) {
+			zstd = sg_virt(areq->dst);
+			lz4s = zstd;
+		} else {
+			memcpy_from_sglist(lz4s, areq->dst, 0, params->produced);
+		}
+
+		seq_count = qat_alg_dec_lz4s(out_seqs, QAT_MAX_SEQUENCES, lz4s,
+					     params->produced, input_data, &lit_len);
+	} else {
+		out_seqs[0].litLength = areq->slen;
+		out_seqs[0].offset = 0;
+		out_seqs[0].matchLength = 0;
+
+		seq_count = 1;
+	}
+
+	comp_size = zstd_compress_sequences_and_literals(ctx, zstd, params->dlen,
+							 out_seqs, seq_count,
+							 input_data, lit_len,
+							 QAT_ZSTD_SCRATCH_SIZE,
+							 areq->slen);
+	if (zstd_is_error(comp_size)) {
+		if (comp_size == ZSTD_error_cannotProduce_uncompressedBlock)
+			ret = -E2BIG;
+		else
+			ret = -EINVAL;
+
+		comp_size = 0;
+		goto out;
+	}
+
+	if (comp_size > params->dlen) {
+		pr_debug("[%s]: compressed_size (%u) > output buffer size (%u)\n",
+			 __func__, (unsigned int)comp_size, params->dlen);
+		ret = -EOVERFLOW;
+		goto out;
+	}
+
+	if (unlikely(sg_nents(areq->dst) != 1))
+		memcpy_to_sglist(areq->dst, 0, zstd, comp_size);
+
+out:
+	areq->dlen = comp_size;
+	crypto_acomp_unlock_stream_bh(s);
+
+	return ret;
+}
+
+static int qat_comp_alg_lz4s_zstd_init_tfm(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	int reqsize;
+	int ret;
+
+	/* qat_comp_alg_init_tfm() wipes out the ctx */
+	ret = qat_comp_alg_init_tfm(acomp_tfm, QAT_LZ4S);
+	if (ret)
+		return ret;
+
+	ctx->ftfm = crypto_alloc_acomp_node("zstd", 0, CRYPTO_ALG_NEED_FALLBACK,
+					    tfm->node);
+	if (IS_ERR(ctx->ftfm))
+		return PTR_ERR(ctx->ftfm);
+
+	reqsize = max(sizeof(struct qat_compression_req),
+		      sizeof(struct acomp_req) + crypto_acomp_reqsize(ctx->ftfm));
+
+	acomp_tfm->reqsize = reqsize;
+
+	ctx->qat_comp_callback = &qat_comp_lz4s_zstd_callback;
+
+	return 0;
+}
+
+static int qat_comp_alg_zstd_init_tfm(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	int reqsize;
+	int ret;
+
+	/* qat_comp_alg_init_tfm() wipes out the ctx */
+	ret = qat_comp_alg_init_tfm(acomp_tfm, QAT_ZSTD);
+	if (ret)
+		return ret;
+
+	ctx->ftfm = crypto_alloc_acomp_node("zstd", 0, CRYPTO_ALG_NEED_FALLBACK,
+					    tfm->node);
+	if (IS_ERR(ctx->ftfm)) {
+		qat_comp_alg_exit_tfm(acomp_tfm);
+		return PTR_ERR(ctx->ftfm);
+	}
+
+	reqsize = max(sizeof(struct qat_compression_req),
+		      sizeof(struct acomp_req) + crypto_acomp_reqsize(ctx->ftfm));
+
+	acomp_tfm->reqsize = reqsize;
+
+	return 0;
+}
+
+static void qat_comp_alg_zstd_exit_tfm(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (!ctx)
+		return;
+
+	if (ctx->ftfm)
+		crypto_free_acomp(ctx->ftfm);
+
+	qat_comp_alg_exit_tfm(acomp_tfm);
+}
+
+static int qat_comp_alg_lz4s_zstd_compress(struct acomp_req *req)
+{
+	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct acomp_req *nreq = acomp_request_ctx(req);
+	int ret;
+
+	if (req->slen <= QAT_ZSTD_SCRATCH_SIZE && req->dlen <= QAT_ZSTD_SCRATCH_SIZE)
+		return qat_comp_alg_compress(req);
+
+	memcpy(nreq, req, sizeof(*req));
+	acomp_request_set_tfm(nreq, ctx->ftfm);
+
+	ret = crypto_acomp_compress(nreq);
+	req->dlen = nreq->dlen;
+
+	return ret;
+}
+
+static int qat_comp_alg_sw_decompress(struct acomp_req *req)
+{
+	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct acomp_req *nreq = acomp_request_ctx(req);
+	int ret;
+
+	memcpy(nreq, req, sizeof(*req));
+	acomp_request_set_tfm(nreq, ctx->ftfm);
+
+	ret = crypto_acomp_decompress(nreq);
+	req->dlen = nreq->dlen;
+
+	return ret;
+}
+
+static struct acomp_alg qat_acomp_deflate[] = { {
 	.base = {
 		.cra_name = "deflate",
 		.cra_driver_name = "qat_deflate",
@@ -364,7 +701,7 @@ static struct acomp_alg qat_acomp[] = { {
 		.cra_reqsize = sizeof(struct qat_compression_req),
 		.cra_module = THIS_MODULE,
 	},
-	.init = qat_comp_alg_init_tfm,
+	.init = qat_comp_alg_deflate_init_tfm,
 	.exit = qat_comp_alg_exit_tfm,
 	.compress = qat_comp_alg_compress,
 	.decompress = qat_comp_alg_decompress,
@@ -382,23 +719,148 @@ static struct acomp_alg qat_acomp[] = { {
 	.exit = qat_comp_alg_exit_tfm,
 	.compress = qat_comp_alg_rfc1950_compress,
 	.decompress = qat_comp_alg_rfc1950_decompress,
-} };
+}};
 
-int qat_comp_algs_register(void)
+static struct acomp_alg qat_acomp_zstd_lz4s = {
+	.base = {
+		.cra_name = "zstd",
+		.cra_driver_name = "qat_zstd",
+		.cra_priority = 4001,
+		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+			     CRYPTO_ALG_NEED_FALLBACK,
+		.cra_reqsize = sizeof(struct qat_compression_req),
+		.cra_ctxsize = sizeof(struct qat_compression_ctx),
+		.cra_module = THIS_MODULE,
+	},
+	.init = qat_comp_alg_lz4s_zstd_init_tfm,
+	.exit = qat_comp_alg_zstd_exit_tfm,
+	.compress = qat_comp_alg_lz4s_zstd_compress,
+	.decompress = qat_comp_alg_sw_decompress,
+};
+
+static struct acomp_alg qat_acomp_zstd_native = {
+	.base = {
+		.cra_name = "zstd",
+		.cra_driver_name = "qat_zstd",
+		.cra_priority = 4001,
+		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+			     CRYPTO_ALG_NEED_FALLBACK,
+		.cra_reqsize = sizeof(struct qat_compression_req),
+		.cra_ctxsize = sizeof(struct qat_compression_ctx),
+		.cra_module = THIS_MODULE,
+	},
+	.init = qat_comp_alg_zstd_init_tfm,
+	.exit = qat_comp_alg_zstd_exit_tfm,
+	.compress = qat_comp_alg_compress,
+	.decompress = qat_comp_alg_zstd_decompress,
+};
+
+static int qat_comp_algs_register_deflate(void)
 {
 	int ret = 0;
 
 	mutex_lock(&algs_lock);
-	if (++active_devs == 1)
-		ret = crypto_register_acomps(qat_acomp, ARRAY_SIZE(qat_acomp));
+	if (++active_devs_deflate == 1) {
+		ret = crypto_register_acomps(qat_acomp_deflate,
+					     ARRAY_SIZE(qat_acomp_deflate));
+	}
 	mutex_unlock(&algs_lock);
+
 	return ret;
 }
 
-void qat_comp_algs_unregister(void)
+static void qat_comp_algs_unregister_deflate(void)
 {
 	mutex_lock(&algs_lock);
-	if (--active_devs == 0)
-		crypto_unregister_acomps(qat_acomp, ARRAY_SIZE(qat_acomp));
+	if (--active_devs_deflate == 0)
+		crypto_unregister_acomps(qat_acomp_deflate, ARRAY_SIZE(qat_acomp_deflate));
 	mutex_unlock(&algs_lock);
 }
+
+static int qat_comp_algs_register_lz4s(void)
+{
+	int ret = 0;
+
+	mutex_lock(&algs_lock);
+	if (++active_devs_lz4s == 1) {
+		ret = crypto_acomp_alloc_streams(&qat_zstd_streams);
+		if (ret) {
+			active_devs_lz4s--;
+			goto unlock;
+		}
+
+		ret = crypto_register_acomp(&qat_acomp_zstd_lz4s);
+		if (ret) {
+			crypto_acomp_free_streams(&qat_zstd_streams);
+			active_devs_lz4s--;
+		}
+	}
+unlock:
+	mutex_unlock(&algs_lock);
+
+	return ret;
+}
+
+static void qat_comp_algs_unregister_lz4s(void)
+{
+	mutex_lock(&algs_lock);
+	if (--active_devs_lz4s == 0) {
+		crypto_unregister_acomp(&qat_acomp_zstd_lz4s);
+		crypto_acomp_free_streams(&qat_zstd_streams);
+	}
+	mutex_unlock(&algs_lock);
+}
+
+static int qat_comp_algs_register_zstd(void)
+{
+	int ret = 0;
+
+	mutex_lock(&algs_lock);
+	if (++active_devs_zstd == 1)
+		ret = crypto_register_acomp(&qat_acomp_zstd_native);
+	mutex_unlock(&algs_lock);
+
+	return ret;
+}
+
+static void qat_comp_algs_unregister_zstd(void)
+{
+	mutex_lock(&algs_lock);
+	if (--active_devs_zstd == 0)
+		crypto_unregister_acomp(&qat_acomp_zstd_native);
+	mutex_unlock(&algs_lock);
+}
+
+int qat_comp_algs_register(u32 caps)
+{
+	int ret = 0;
+
+	ret = qat_comp_algs_register_deflate();
+	if (ret)
+		return ret;
+
+	if (caps & ADF_ACCEL_CAPABILITIES_EXT_ZSTD_LZ4S) {
+		ret = qat_comp_algs_register_lz4s();
+		if (ret)
+			return ret;
+	}
+
+	if (caps & ADF_ACCEL_CAPABILITIES_EXT_ZSTD) {
+		ret = qat_comp_algs_register_zstd();
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+void qat_comp_algs_unregister(u32 caps)
+{
+	qat_comp_algs_unregister_deflate();
+
+	if (caps & ADF_ACCEL_CAPABILITIES_EXT_ZSTD_LZ4S)
+		qat_comp_algs_unregister_lz4s();
+
+	if (caps & ADF_ACCEL_CAPABILITIES_EXT_ZSTD)
+		qat_comp_algs_unregister_zstd();
+}
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_req.h b/drivers/crypto/intel/qat/qat_common/qat_comp_req.h
index 18a1f33a6db9..a3e5cd3c72c6 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_req.h
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_req.h
@@ -7,6 +7,8 @@
 
 #define QAT_COMP_REQ_SIZE (sizeof(struct icp_qat_fw_comp_req))
 #define QAT_COMP_CTX_SIZE (QAT_COMP_REQ_SIZE * 2)
+#define QAT_ASB_RATIO_MODE_VAL 8
+#define QAT_ASB_VALUE(slen) (((slen) >> 4) * (QAT_ASB_RATIO_MODE_VAL + 1))
 
 static inline void qat_comp_create_req(void *ctx, void *req, u64 src, u32 slen,
 				       u64 dst, u32 dlen, u64 opaque)
@@ -23,6 +25,7 @@ static inline void qat_comp_create_req(void *ctx, void *req, u64 src, u32 slen,
 	fw_req->comn_mid.opaque_data = opaque;
 	req_pars->comp_len = slen;
 	req_pars->out_buffer_sz = dlen;
+	fw_req->u3.asb_threshold.asb_value = QAT_ASB_VALUE(slen);
 }
 
 static inline void qat_comp_create_compression_req(void *ctx, void *req,
@@ -110,4 +113,12 @@ static inline u8 qat_comp_get_cmp_cnv_flag(void *resp)
 	return ICP_QAT_FW_COMN_HDR_CNV_FLAG_GET(flags);
 }
 
+static inline u8 qat_comp_get_cmp_uncomp_flag(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+	u8 flags = qat_resp->comn_resp.hdr_flags;
+
+	return ICP_QAT_FW_COMN_HDR_ST_BLK_FLAG_GET(flags);
+}
+
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.c b/drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.c
new file mode 100644
index 000000000000..3cf4c3034d5d
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 Intel Corporation */
+#include <linux/module.h>
+#include <linux/byteorder/generic.h>
+#include <linux/zstd_lib.h>
+
+#include "qat_comp_zstd_utils.h"
+
+#define ML_BITS		4
+#define ML_MASK		((1U << ML_BITS) - 1)
+#define RUN_BITS	(8 - ML_BITS)
+#define RUN_MASK	((1U << RUN_BITS) - 1)
+#define LZ4MINMATCH	2
+
+/*
+ * Implement the same algorithm as the QAT ZSTD sequence producer plugin,
+ * to decode LZ4s formatted data into ZSTD_Sequence format.
+ */
+size_t qat_alg_dec_lz4s(ZSTD_Sequence *out_seqs, size_t out_seqs_capacity,
+			unsigned char *lz4s_buff, unsigned int lz4s_buff_size,
+			unsigned char *literals, unsigned int *lit_len)
+{
+	unsigned char *end_ip = lz4s_buff + lz4s_buff_size;
+	unsigned int hist_literal_len = 0;
+	unsigned char *ip = lz4s_buff;
+	size_t seqs_idx = 0;
+
+	*lit_len = 0;
+
+	if (!lz4s_buff_size)
+		return 0;
+
+	while (ip < end_ip) {
+		size_t length = 0;
+		size_t offset = 0;
+		size_t literal_len = 0, match_len = 0;
+
+		/* get literal length */
+		unsigned const token = *ip++;
+
+		length = token >> ML_BITS;
+		if (length == RUN_MASK) {
+			unsigned int s;
+
+			do {
+				s = *ip++;
+				length += s;
+			} while (s == 255);
+		}
+
+		literal_len = length;
+
+		{
+			u8 *start = ip;
+			u8 *dest = literals;
+			u8 *dest_end = literals + length;
+
+			do {
+				__builtin_memcpy(dest, start, QAT_ZSTD_LIT_COPY_LEN);
+				dest += QAT_ZSTD_LIT_COPY_LEN;
+				start += QAT_ZSTD_LIT_COPY_LEN;
+			} while (dest < dest_end);
+		}
+
+		literals += length;
+		*lit_len += length;
+
+		ip += length;
+		if (ip == end_ip) { /* Meet the end of the LZ4 sequence */
+			literal_len += hist_literal_len;
+			out_seqs[seqs_idx].litLength = literal_len;
+			out_seqs[seqs_idx].offset = offset;
+			out_seqs[seqs_idx].matchLength = match_len;
+			break;
+		}
+
+		/* get matchPos */
+		offset = le16_to_cpu(*(__le16 *)ip);
+		ip += 2;
+
+		/* get match length */
+		length = token & ML_MASK;
+		if (length == ML_MASK) {
+			unsigned int s;
+
+			do {
+				s = *ip++;
+				length += s;
+			} while (s == 255);
+		}
+		if (length != 0) {
+			length += LZ4MINMATCH;
+			match_len = (unsigned short)length;
+			literal_len += hist_literal_len;
+
+			/* update ZSTD_Sequence */
+			out_seqs[seqs_idx].offset = offset;
+			out_seqs[seqs_idx].litLength = literal_len;
+			out_seqs[seqs_idx].matchLength = match_len;
+			hist_literal_len = 0;
+			++seqs_idx;
+			if (seqs_idx >= (out_seqs_capacity - 1)) {
+				pr_debug("[%s]: qat zstd sequence overflow (seqs_idx:%lu, out_seqs_capacity:%lu, lz4s_buff_size:%u)\n",
+					 __func__, seqs_idx, out_seqs_capacity, lz4s_buff_size);
+				return -1;
+			}
+		} else {
+			if (literal_len > 0) {
+				/*
+				 * When match length is 0, the literalLen needs to be
+				 * temporarily stored and processed together with the next data
+				 * block.
+				 */
+				hist_literal_len += literal_len;
+			}
+		}
+	}
+
+	return ++seqs_idx;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.h b/drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.h
new file mode 100644
index 000000000000..89fc8c8dceea
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef QAT_COMP_ZSTD_UTILS_H_
+#define QAT_COMP_ZSTD_UTILS_H_
+#include <linux/zstd_lib.h>
+
+#define QAT_ZSTD_LIT_COPY_LEN	8
+
+size_t qat_alg_dec_lz4s(ZSTD_Sequence *out_seqs, size_t out_seqs_capacity,
+			unsigned char *lz4s_buff, unsigned int lz4s_buff_size,
+			unsigned char *literals, unsigned int *lit_len);
+
+#endif
diff --git a/drivers/crypto/intel/qat/qat_common/qat_compression.c b/drivers/crypto/intel/qat/qat_common/qat_compression.c
index 53a4db5507ec..1424d7a9bcd3 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_compression.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_compression.c
@@ -46,12 +46,14 @@ static int qat_compression_free_instances(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 
-struct qat_compression_instance *qat_compression_get_instance_node(int node)
+struct qat_compression_instance *qat_compression_get_instance_node(int node, int alg)
 {
 	struct qat_compression_instance *inst = NULL;
+	struct adf_hw_device_data *hw_data = NULL;
 	struct adf_accel_dev *accel_dev = NULL;
 	unsigned long best = ~0;
 	struct list_head *itr;
+	u32 caps, mask;
 
 	list_for_each(itr, adf_devmgr_get_head()) {
 		struct adf_accel_dev *tmp_dev;
@@ -61,6 +63,15 @@ struct qat_compression_instance *qat_compression_get_instance_node(int node)
 		tmp_dev = list_entry(itr, struct adf_accel_dev, list);
 		tmp_dev_node = dev_to_node(&GET_DEV(tmp_dev));
 
+		if (alg == QAT_ZSTD || alg == QAT_LZ4S) {
+			hw_data = tmp_dev->hw_device;
+			caps = hw_data->accel_capabilities_ext_mask;
+			mask = ADF_ACCEL_CAPABILITIES_EXT_ZSTD |
+			       ADF_ACCEL_CAPABILITIES_EXT_ZSTD_LZ4S;
+			if (!(caps & mask))
+				continue;
+		}
+
 		if ((node == tmp_dev_node || tmp_dev_node < 0) &&
 		    adf_dev_started(tmp_dev) && !list_empty(&tmp_dev->compression_list)) {
 			ctr = atomic_read(&tmp_dev->ref_count);
@@ -78,6 +89,16 @@ struct qat_compression_instance *qat_compression_get_instance_node(int node)
 			struct adf_accel_dev *tmp_dev;
 
 			tmp_dev = list_entry(itr, struct adf_accel_dev, list);
+
+			if (alg == QAT_ZSTD || alg == QAT_LZ4S) {
+				hw_data = tmp_dev->hw_device;
+				caps = hw_data->accel_capabilities_ext_mask;
+				mask = ADF_ACCEL_CAPABILITIES_EXT_ZSTD |
+				       ADF_ACCEL_CAPABILITIES_EXT_ZSTD_LZ4S;
+				if (!(caps & mask))
+					continue;
+			}
+
 			if (adf_dev_started(tmp_dev) &&
 			    !list_empty(&tmp_dev->compression_list)) {
 				accel_dev = tmp_dev;
-- 
2.51.1


