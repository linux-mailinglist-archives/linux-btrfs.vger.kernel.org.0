Return-Path: <linux-btrfs+bounces-7264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60A954CC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39885B21BDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DA1C37A8;
	Fri, 16 Aug 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfJ3WNtc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3421C3788;
	Fri, 16 Aug 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819477; cv=none; b=D/4alJBsq11vJ6ndkrwrj5IUfN1UnP/XQbK98lNcnZzJ3VSttDeJOXp1+kQddVg8jFSW7yEWWWRScylz2xVS6QlL1hlXd9IJMKBpVKMP9js4Ix4v6sETcV6YMTUFsEl8c8IKFg26YR36WmTil5aUBEB3x7BjnmhsJEbX9RHbTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819477; c=relaxed/simple;
	bh=zE/2HTJOxpSE4o8R1dogrP65OdaBlasLFG61eovlfjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgbXo7YV+dficApt9jgezxv95YIaj/bgED/ue/J/R1mARudnwqD9cESLkR9e5bh+NxJTs2i7hEP/jWVpDc5+qOa8XZ6RtRiZDDLeHzFQlU0ET6MezejgwF+JMgee9NVk6seSfpg1+DXJHcmo655yA7g6x/wPPgytbCdCtmReuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfJ3WNtc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819475; x=1755355475;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zE/2HTJOxpSE4o8R1dogrP65OdaBlasLFG61eovlfjA=;
  b=UfJ3WNtcLxuLq+WipjfV7H3f0Ya2D0ePMng74tlPPpWqRGHFq+lFFwE7
   /27J5U0eTr/q0ipIMzgnWR63h14AKWxbBSGfgV6cNv87Y9L1k3pw6a6Vl
   5yzvMz6qgzsSTRcR21WzWM2TS3XDmU275liOoBxFWXemRvjYybN3b/zT5
   0ad3kqkovoIBC5SkZdhzESoAIGJflE2XyydkZig2Qfl75fhjx/L6fPGaE
   eOogd6xp8I1eb7H16+TLMbSoxLZ7eNkjL4IltLk9GiC9LRvd/fRbHbCuk
   9wIyr6CpCKglhH25fWIr7xXhTHnSW2XjHTaDePumm5DsC+dbDxB4bd/2I
   Q==;
X-CSE-ConnectionGUID: SOlSvnUbQIy0t/wd9j+JPg==
X-CSE-MsgGUID: CHnRlVA8Sg2ijd5cepewxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32753058"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32753058"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:34 -0700
X-CSE-ConnectionGUID: BSANjG0uRuykTdSzs7BnqQ==
X-CSE-MsgGUID: /zMZam4GTECQX33T+6STZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64086951"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:33 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:44:13 -0500
Subject: [PATCH v3 05/25] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-5-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819455; l=4080;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=WtZcODhnUribhyPmAiHIARMX/qet7opXXZrojTnpIjM=;
 b=ocXHitRs+ZUChNxnLOtdua06Ysqrd60c9IQTmmaOdoH0AlPJ0cggQP+KG42gg0gHTDT6iG2w4
 Rm5fR2eh8gpDB/JRWu1CX3wF2nRGJ96+Onvh9IrVsxY54lIBkgc4Ct2
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Per the CXL 3.1 specification software must check the Command Effects
Log (CEL) for dynamic capacity command support.

Detect support for the DCD commands while reading the CEL, including:

	Get DC Config
	Get DC Extent List
	Add DC Response
	Release DC

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: Keep tags for this early simple patch]
[Davidlohr: update commit message]
[djiang: Fix misalignment]
---
 drivers/cxl/core/mbox.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 15 +++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e5cdeafdf76e..8eb196858abe 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -164,6 +164,34 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
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
+				    u16 opcode)
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
@@ -745,6 +773,11 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
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
index afb53d058d62..f2f8b567e0e7 100644
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
@@ -482,6 +492,7 @@ struct cxl_memdev_state {
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	u64 total_bytes;
@@ -555,6 +566,10 @@ enum cxl_opcode {
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
2.45.2


