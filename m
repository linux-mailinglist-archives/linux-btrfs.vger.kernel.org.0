Return-Path: <linux-btrfs+bounces-7273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89455954CEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2568FB254D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75E1C823A;
	Fri, 16 Aug 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVU8O3TI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67431BDABD;
	Fri, 16 Aug 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819514; cv=none; b=SP9gldK7vAsOEZzErZXGLXVdS5blylkCoxv7F9S0aQrdPyutvlhRoIaaqTihf4KOzciI/W5o2VsrPATdBwcOZd5X4ZNCI8UbmGzTXoAlhvQZBUEPkBbx2egKJJ10ooLwuhIBUX4ltuUfWk9YlIaNwFxH7VZZ3ycleSpBZfhTgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819514; c=relaxed/simple;
	bh=SWMZ4XkcT3C6EuI3kX3FJrjCNYC9aTWVw08nTrQrMOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Teoi5Zwx6z27rVzqLobeHCGkQAWwZ0MH5nlPTqkPEMkFZAM62nj/B2l45i9wQLs2svBCcp12kE+UNp5cOGJbLYYKnccU+A2kwKZncCgOYxZ+OjyppX8VgW7TuaZqhlVVnNbpAgAAriaa7NpKGhXFlCW7nxM/c/nI5mUW+qx34gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVU8O3TI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819513; x=1755355513;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SWMZ4XkcT3C6EuI3kX3FJrjCNYC9aTWVw08nTrQrMOo=;
  b=WVU8O3TIroRY+vbM41SAiXx6JNJvFuF2A22G8OECzmAXduW6UkSOG7Dd
   6EdT8mTntNfpxFsXFPO0Vj1C1hZO/VFoWtkK9zfKKqkRGj/lut8UvzXgL
   Fx6H7vyZFQapaXEf+Fmp8VFMVEWdFw4XPyBCx+KBydP+aIH5F0nfvpjtO
   x/7zjTwkKunlsyQFvAHnnVRn1pbHYcaoZF6ilXGFzezL9gs35M2ZXMitW
   wfnzVFnhsCTlrxhpOpSKbcuBdP24lY8L0ddaGvIvJC+BPa38sqnRSu5v3
   DyzEkXhVFqwvbB+gPcscUcw1ti3kquSuToOA292YNwSHvyKxAAMI0a8Ba
   A==;
X-CSE-ConnectionGUID: 68F33uIwS7SjhABYUDku+w==
X-CSE-MsgGUID: fiCsOc5ITz+TKSfOv3UF5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21973017"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="21973017"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:05 -0700
X-CSE-ConnectionGUID: fbao3WifRXK0hojIqpLWFA==
X-CSE-MsgGUID: BSfHaqHHSve2kdmmWP6ihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="97205562"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:44:23 -0500
Subject: [PATCH v3 15/25] cxl/pci: Factor out interrupt policy check
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-15-7c9b96cba6d7@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819456; l=2095;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=SWMZ4XkcT3C6EuI3kX3FJrjCNYC9aTWVw08nTrQrMOo=;
 b=P13uGvYyKMQtyAlbewEolO4y1HgS6Mvunxmuo7nrGKYr5Ygihty+uGTw4sJzIWtmpISrwqD/S
 GZjzTsOQRyQCMDguvPVdQec32njRR1XEwYFWnypvDlm6AWUUoWpWv66
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Factor out event interrupt setting validation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: reword commit message]
[iweiny: keep review tags on simple patch]
---
 drivers/cxl/pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 17bea49bbf4d..370c74eae323 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -738,6 +738,21 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
+					  struct cxl_event_interrupt_policy *policy)
+{
+	if (cxl_event_int_is_fw(policy->info_settings) ||
+	    cxl_event_int_is_fw(policy->warn_settings) ||
+	    cxl_event_int_is_fw(policy->failure_settings) ||
+	    cxl_event_int_is_fw(policy->fatal_settings)) {
+		dev_err(mds->cxlds.dev,
+			"FW still in control of Event Logs despite _OSC settings\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
@@ -760,14 +775,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (cxl_event_int_is_fw(policy.info_settings) ||
-	    cxl_event_int_is_fw(policy.warn_settings) ||
-	    cxl_event_int_is_fw(policy.failure_settings) ||
-	    cxl_event_int_is_fw(policy.fatal_settings)) {
-		dev_err(mds->cxlds.dev,
-			"FW still in control of Event Logs despite _OSC settings\n");
+	if (!cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
-	}
 
 	rc = cxl_event_config_msgnums(mds, &policy);
 	if (rc)

-- 
2.45.2


