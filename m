Return-Path: <linux-btrfs+bounces-4558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB59F8B365F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8746B2849BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346F145343;
	Fri, 26 Apr 2024 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv3Z/e9W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C8145321;
	Fri, 26 Apr 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129821; cv=none; b=YHv1KXK46KKUHUluFWgNwK2/8AA2bL+2j7hA3SmT1kcmDitqNUa8Fv0LFhoMDssHSLdXQCcRrvOi5KcG5cvgipbkSVynu3v7cyHW8SgAikej0BDIluIF5zoJ/iec0m0/cGGjPllp+TuYjLicSELMGZTLxS4z9YIIRy/l5VxuYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129821; c=relaxed/simple;
	bh=Tqra8/1ha5Kv33pjuHHw6inu+5h3ytJKKpKbhL4wab0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1zAjAtzdD4HPEE63AmnSI+7iEMYW6Wp/d1WGOtHZB0PsTC7DIVWyama61K/GjFTJfJzIGOEr5DKjAXGQXv4B68EyLWXEaPLYeONRM3mGPTyQ6DDvRuaQOtt3u3KzWrx/jLLNNXHZVgnebG95We825xcaYFGk63ECbz8ZpymggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv3Z/e9W; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129820; x=1745665820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tqra8/1ha5Kv33pjuHHw6inu+5h3ytJKKpKbhL4wab0=;
  b=Mv3Z/e9WXVYRjq20ernWPpUF83sRR0Lz6w9icKVycHhqvDCi3IDxnOBG
   KcAV+zFgfSQlFYGhz04+jdoqwFeawImjnrmfDFYGlPIR4D6tdQVVFLPBB
   F96W6uaiXboxO7tFL3Kh8lnZKMODFEFVKr73KiJ7mP93FKUOP4FBhULLp
   l3kftlMvbEXmcTOhiyPCdA04Gm/Ko1kdl9SIqoy1eZMfqPp7IT7c29pU0
   ldmwukD2f8twmx+YtfgHO2vfdj6UK0hrAFkS+eqtATpLpX4cqGt83WgIU
   TIWq9tOa00uROlPvx6Kd3S6gue3dOfQK3T68faTPsoHS5K0vRBQGdaH6s
   g==;
X-CSE-ConnectionGUID: v3eN1JPuQ7aVbb3RH8lscg==
X-CSE-MsgGUID: kvmD0tO6TTe6R7VmlWr1+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20474097"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20474097"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:10:19 -0700
X-CSE-ConnectionGUID: mSzro9B9Tk+ws7rfLtpUng==
X-CSE-MsgGUID: swgjxfjcSImSwmOo8mjnYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30030955"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 04:10:15 -0700
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
Subject: [RFC PATCH 5/6] crypto: qat - change compressor settings for QAT GEN4
Date: Fri, 26 Apr 2024 11:54:28 +0100
Message-ID: <20240426110941.5456-6-giovanni.cabiddu@intel.com>
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

Enable dynamic compression by default for QAT GEN4 and change
compression level to 9.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
index 5859238e37de..34f418b88738 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
@@ -22,7 +22,7 @@ static void qat_comp_build_deflate(void *ctx)
 	header->hdr_flags =
 		ICP_QAT_FW_COMN_HDR_FLAGS_BUILD(ICP_QAT_FW_COMN_REQ_FLAG_SET);
 	header->service_type = ICP_QAT_FW_COMN_REQ_CPM_FW_COMP;
-	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_STATIC;
+	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DYNAMIC;
 	header->comn_req_flags =
 		ICP_QAT_FW_COMN_FLAGS_BUILD(QAT_COMN_CD_FLD_TYPE_16BYTE_DATA,
 					    QAT_COMN_PTR_TYPE_SGL);
@@ -35,7 +35,7 @@ static void qat_comp_build_deflate(void *ctx)
 	hw_comp_lower_csr.skip_ctrl = ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_LITERAL;
 	hw_comp_lower_csr.algo = ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_ILZ77;
 	hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_ENABLED;
-	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1;
+	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_9;
 	hw_comp_lower_csr.hash_update = ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_DONT_ALLOW;
 	hw_comp_lower_csr.edmm = ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_ENABLED;
 	hw_comp_upper_csr.nice = ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_DEFAULT_VAL;
-- 
2.44.0


