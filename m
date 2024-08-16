Return-Path: <linux-btrfs+bounces-7251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3B954BBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92389281B84
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78E1C57A0;
	Fri, 16 Aug 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxSfHOOC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA01C461F;
	Fri, 16 Aug 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816826; cv=none; b=onJKN2VWf2ValZwJAn7TSC2qt9nF2mxR9BTx5ZC2AeOertltPE+zewGgeFe5NXSjF2UJmrmgZK5KQU7kU+aMYJCByDCjDFKvC3e6/BRs35j2U87zu90M+LWi9V/hJuPR759hudtT2vZcBbd/taiKmvvKJESiNBwquDIMCr495Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816826; c=relaxed/simple;
	bh=SWMZ4XkcT3C6EuI3kX3FJrjCNYC9aTWVw08nTrQrMOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EimuGLmI1ZQ4ZXfmRqoWyUvZBDm6csZ+diZNNZk7MIxxqtMsNe5iFC5OuD8nV6PSVkpcG8YjspBVNnJHeAKItmSR85iUtHcrr1151IdVNKqyoQnTjc9J4/8KiKzQZNMXjzBtjKV2NntW7luN/j1d6BiYE6qXxXLOyW5jJWsvU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxSfHOOC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816825; x=1755352825;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SWMZ4XkcT3C6EuI3kX3FJrjCNYC9aTWVw08nTrQrMOo=;
  b=XxSfHOOCD2oypT1JVme4nOG4bwGbo97RvYdKPtFUj4EtBjHP6zUZQvPx
   JNPyfv5jxjfP0r7wbTgX6kR0ga0GBrQoJvxFv2d7HzCO5uSJ2RWGS2u2t
   Nk/p3zuaRDUAAsxoKD491HwZMzDl/WCZmhXusnFmXNTkGJHWfZPPJ11Gy
   LEp2Jb/+tOfkY34di99vOUE1IskdNOobwewFlglSXJ1qnrv7X9Mw57KM2
   jSoc9NrJtWHNtUYjbNxqqj8WM8sO1v6PiIGn4QF30lBoIUooUMlkhgu++
   nAWH2dPOs97g8l9CSos7cmN1Rl/q7OVEC3KgMZrNLD5L7rtQiUsToRL+u
   A==;
X-CSE-ConnectionGUID: 0uXnd/zhT9SFPi8KrYrCqw==
X-CSE-MsgGUID: z8orii1UTu6uPyuM9GEDPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272829"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:24 -0700
X-CSE-ConnectionGUID: CTGrDG75QR+cnBREnAjHRg==
X-CSE-MsgGUID: xndzYq6qTPGDEDxRmSzSLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411433"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:00:03 -0500
Subject: [PATCH v2 15/25] cxl/pci: Factor out interrupt policy check
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-15-20189a10ad7d@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=2095;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=SWMZ4XkcT3C6EuI3kX3FJrjCNYC9aTWVw08nTrQrMOo=;
 b=Kfin4DeWXtl8gIorYmbqtqpLlqJ10XLdn9MKQb/mel/Q1r0quJ2PbIK818m9Oc8+y4spEAuhh
 +GfYwz6cP/zC5BndOVsHqp53JgzSWyPK9V3QZLzCrpKGJARZ62f5F3D
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


