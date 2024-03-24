Return-Path: <linux-btrfs+bounces-3525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1455888B61
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FE01F27B31
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806792A5BC8;
	Sun, 24 Mar 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kr8tq9fQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BA14E2E3;
	Sun, 24 Mar 2024 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322294; cv=none; b=Pyjok5KIcPPrDX9QcShEVVI3BM8w0eQYdfFjylbTFx8l2oRSTOTiVzxcR5bJxXLybtfWFq1646RbiqZy35G3FFTWutLnNM/SlxSJ7TRtkIXo2QSD5FsdEcKRXw7laHE7FHtxtZQd0w1z+l5frHlLPlioriilbl8ZtnrXgexFms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322294; c=relaxed/simple;
	bh=ExbqMkEoopRff3LKVChNomfBbb1n44Pk8l4uAHbwlE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiWZX7aRD9iwWKyC3wiw0wBxp/zdDMJgU5sKedcba37IFd77kOvSSVI+OG0rEbnivflCLMJEXcufGftZdG+l2hCH2S3A8/wO1XZbfSD0zf6MnNQm0we0jIbxLAtGO4bcbk64+5BiIK/HRzvNcbyZ/IAWEVbAg0wduJ/o/6e3+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kr8tq9fQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322291; x=1742858291;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ExbqMkEoopRff3LKVChNomfBbb1n44Pk8l4uAHbwlE0=;
  b=Kr8tq9fQ8iW6/0KUyTT8fNJZz91A1xLZVvEaKVdX1KmVW1SJ9s2TgCon
   bQdPpkxhRd/Uucxe+7fawdWFA8ZALkJCWCrzUevAc3UBN2GQwPp+nR0qU
   ZXSQOVmOlwzDqvoIFDzRtQ+ol7nGBKUcgt9Gfwpc7sDY9Cx3uAXbRiXaU
   9L/DHTekKxGn7tTv5atjldF6jkCr0i5QuUeDqsAxu4fGQQnLfwYkI+QGu
   p4broHBpdpLOCUr5xcw0QvDZD8BNTtEIbhIuPn3DkbFSs0C6+LHVCbFqk
   ZPSgNjei70gUMLOpvrjLIhlBBBgsHyMXYm8oXBhhL399RjjHdvpcO2CQz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9260885"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9260885"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15842194"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:07 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:04 -0700
Subject: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity Devices
 (DCD)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=4137;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=L0YFDCEsjv8HWC653cNW+kOC3bCUS327QGxxY4JOQM8=;
 b=biXfqR5QP6sUOlha0l3wJRnbYHnl4W23vQSOFjYBoz+1E/TIkRQR07lHRJdcwgPCgOikrU1Xg
 MksnR9HVghHAqUmllg5MShxurUIlSvsHrQ+V8apS4uEt7M+M+ujjY1w
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Per the CXL 3.1 specification software must check the Command Effects
Log (CEL) to know if a device supports dynamic capacity (DC).  If the
device does support DC the specifics of the DC Regions (0-7) are read
through the mailbox.

Flag DC Device (DCD) commands in a device if they are supported.
Subsequent patches will key off these bits to configure DCD.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes for v1
[iweiny: update to latest master]
[iweiny: update commit message]
[iweiny: Based on the fix:
	https://lore.kernel.org/all/20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com/
[jonathan: remove unneeded format change]
[jonathan: don't split security code in mbox.c]
---
 drivers/cxl/core/mbox.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 15 +++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..ed4131c6f50b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -161,6 +161,34 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
 	}
 }
 
+static bool cxl_is_dcd_command(u16 opcode)
+{
+#define CXL_MBOX_OP_DCD_CMDS 0x48
+
+	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
+}
+
+static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
+					u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_DC_CONFIG:
+		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
+		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
+		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_RELEASE_DC:
+		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
+		break;
+	default:
+		break;
+	}
+}
+
 static bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
@@ -733,6 +761,11 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 			enabled++;
 		}
 
+		if (cxl_is_dcd_command(opcode)) {
+			cxl_set_dcd_cmd_enabled(mds, opcode);
+			enabled++;
+		}
+
 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
 			enabled ? "enabled" : "unsupported by driver");
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 20fb3b35e89e..79a67cff9143 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -238,6 +238,15 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/* Device enabled DCD commands */
+enum dcd_cmd_enabled_bits {
+	CXL_DCD_ENABLED_GET_CONFIG,
+	CXL_DCD_ENABLED_GET_EXTENT_LIST,
+	CXL_DCD_ENABLED_ADD_RESPONSE,
+	CXL_DCD_ENABLED_RELEASE,
+	CXL_DCD_ENABLED_MAX
+};
+
 /* Device enabled poison commands */
 enum poison_cmd_enabled_bits {
 	CXL_POISON_ENABLED_LIST,
@@ -454,6 +463,7 @@ struct cxl_dev_state {
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
+ * @dcd_cmds: List of DCD commands implemented by memory device
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
  * @total_bytes: sum of all possible capacities
@@ -481,6 +491,7 @@ struct cxl_memdev_state {
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	u64 total_bytes;
@@ -551,6 +562,10 @@ enum cxl_opcode {
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
+	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
+	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
+	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 

-- 
2.44.0


