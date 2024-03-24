Return-Path: <linux-btrfs+bounces-3535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C6888B88
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFAB1C2954B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766262ABE94;
	Sun, 24 Mar 2024 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK3WrLdc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E412002F4;
	Sun, 24 Mar 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322300; cv=none; b=RmorVpHmh9MK1orf1li2TqSFLTz7QD6MYh0b6LBEy/OElBmbvKVz4yUWPHxigaQcTjlo+05cCeexLuASWY22ko7NSK/JmC4d6NLcnXyzIx2JMDebK55Ln+iwAJrkjBW/VJ2uiICK1K++j6sZS5ps2m1nCzHkH9/VP1Ks2nHLer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322300; c=relaxed/simple;
	bh=sHOHAAgo36BLciM/K7n2mRo2mKuGuaXUBGhyzlTFcnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbl+lvodsjIrHNRyTghKQE3uqhMs/pKzM3Ms1yx1AGx8DPdcgUQ50961beBkEONa52DP9gePRa4m4Gh8HQL6ymp2QWZysFFsSlpS6JgMc6csoo2jcxE17xXNgTXiI+GoKwz+fYbz47XBe6gnuVRkt4fltaVsNT+VrEjgNnTSEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK3WrLdc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322299; x=1742858299;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sHOHAAgo36BLciM/K7n2mRo2mKuGuaXUBGhyzlTFcnU=;
  b=kK3WrLdclJBucFHlfv03QDJaU7CST7/H608cRd8t00XSzM5YZpGJy9mG
   uPRjsRJRRqTVCggiBO1tKkRkLnAFxszMKxP4o4ByhpTH70kT/kHeUoMS0
   Gro0ngCHGc+81SYMmRBgzCVTW5agKTMR4Iq+6VDEBOCmEmVHGHFn/4HtL
   3gkAQfJhBDKopYene+nv59jsc4BsgCdBqO2OuaWVW/6Ys1otmMmOVFPBR
   vsfmmgtcCH8NB8IDzVESKDVH4CD3AsFChhI4u24iMPQlhz45hF8s6+9So
   Kcw7vt/n06kEG4fUGarH+BtFRTEykq65kQKkzagyyeIGkx9PW7ETs+L+s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431712"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464685"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:16 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:13 -0700
Subject: [PATCH 10/26] cxl/events: Factor out event msgnum configuration
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-10-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=2584;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=sHOHAAgo36BLciM/K7n2mRo2mKuGuaXUBGhyzlTFcnU=;
 b=mOpBBOsOLZaK3hFPvkaJoSljLE6XhFjBl9gLKSZ5STCIrET6lhWbgu36Xtiyq0Ma+PV7zpKbY
 95epuu3rURaCGVXEZPqCj74bQDnUUZEUwB7drjn3Mu+bcK2WpQcfZqN
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic Capacity Devices (DCD) require events to process extent addition
or removal.  BIOS may have control over memory event processing.

Factor out cxl_event_config_msgnums() in preparation for setting up DCD
event interrupts separate from memory events.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 216881455364..cedd9b05f129 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -698,35 +698,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 	return cxl_event_get_int_policy(mds, policy);
 }
 
-static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
+static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
+			      struct cxl_event_interrupt_policy *policy)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct cxl_event_interrupt_policy policy;
 	int rc;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
-	if (rc)
-		return rc;
-
-	rc = cxl_event_req_irq(cxlds, policy.info_settings);
+	rc = cxl_event_req_irq(cxlds, policy->info_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
+	rc = cxl_event_req_irq(cxlds, policy->warn_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
+	rc = cxl_event_req_irq(cxlds, policy->failure_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
+	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
 		return rc;
@@ -745,7 +741,7 @@ static bool cxl_event_int_is_fw(u8 setting)
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
-	struct cxl_event_interrupt_policy policy;
+	struct cxl_event_interrupt_policy policy = { 0 };
 	int rc;
 
 	/*
@@ -777,7 +773,11 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return -EBUSY;
 	}
 
-	rc = cxl_event_irqsetup(mds);
+	rc = cxl_event_config_msgnums(mds, &policy);
+	if (rc)
+		return rc;
+
+	rc = cxl_event_irqsetup(mds, &policy);
 	if (rc)
 		return rc;
 

-- 
2.44.0


