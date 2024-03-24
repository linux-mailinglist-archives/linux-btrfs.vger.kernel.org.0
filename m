Return-Path: <linux-btrfs+bounces-3538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BC888B8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DF128DEAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F12AD45D;
	Sun, 24 Mar 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh5n5TSr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37252236581;
	Sun, 24 Mar 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322302; cv=none; b=b+AxuGmwa8zZ+PcPAOyNQo70r3/eJOWzJYSwg2XY52fw/wLVrc0lajh1c7X2QLC9V7z1Z7kRdOsNtZyr/qhtKtjC4xvL9Ztz+J7SM5BpO4z6N6D6lO5s0yGHtynpVhve/8CynyP3IBby8oEUeuL8HZUQQbDN2XCVhE2Zs0c/3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322302; c=relaxed/simple;
	bh=CiHiKsG4LEsFUzhFG3rWxV2fGxiw05tzfl9X4v0Ed0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J0trhuvHAQCLJPbJHy7FsteC9ZgIU21TM3bNnT8y96/g5wTBV8+aIJJBp8RnPVXBeavQJ7qPmyCZdksbzIwuNdOZ65IHlZtgWfm5uvSoWaU0GzdmsAaksIqWJ2WJDgZjrjUh9mqdkD5Tc++Q5RxuntG+O0+R2DLAZt0mul9heU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh5n5TSr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322301; x=1742858301;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CiHiKsG4LEsFUzhFG3rWxV2fGxiw05tzfl9X4v0Ed0o=;
  b=Nh5n5TSrWs9nBntAAKceTzUORFOssIcAGzMEAKr5iZg7JAjTs3iSGad5
   7krxjTsWfy7i2T3lZLmz+SvGewX1S2ytM4KzUqh8Y7Qos2zA4Pljzmcyj
   h6jjcad9aL1E4269VGnqrKeJJkK6ZSXIhZ6FVQf6TGH49Cr98lkx/HoFs
   goOXZ3725tC90iPqVKz5zWRm62tox7AKt+kpJgR0ZRQYjIdH4Z/msx21g
   GZI64hdcPlzQ01lqtKU++FyjMfU8XFgQy7ZiurOMCdK+YjABTa/f0roV3
   xMWA1Kbo3d6uoGyzonwyqtv8zygyZXE4YE4uL6RaBD9jlLycrvy37LEXz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431720"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431720"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464692"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:17 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:15 -0700
Subject: [PATCH 12/26] cxl/pci: Factor out interrupt policy check
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-12-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=1959;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=CiHiKsG4LEsFUzhFG3rWxV2fGxiw05tzfl9X4v0Ed0o=;
 b=o2G89A/C/ro+KexNY+8PtmPRkeuPhN2vLmc6wqo19fSzntp8uudLilGvrNqhq2329sh3Ci0Ax
 LWMISYLWW/rCCZtl2abE1KLgfKtgSQBNTtFFRBN3xqGiilF3oKEe2Yt
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic capacity devices (DCD) require interrupts to notify the host of
events in the DCD log.  The interrupts for DCD may be supported despite
FW control of memory event logs.

Prepare to support DCD event interrupts separate from other event
interrupts by factoring out the check for event interrupt settings.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V3:
[iweiny: new patch]
---
 drivers/cxl/pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ccaf4ad26a4f..12cd5d399230 100644
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
2.44.0


