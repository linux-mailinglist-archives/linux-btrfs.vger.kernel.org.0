Return-Path: <linux-btrfs+bounces-7250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD8954BBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461811F2554C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3298D1C461A;
	Fri, 16 Aug 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPD63FOE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B51C3F3E;
	Fri, 16 Aug 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816824; cv=none; b=SXpZm1M/tCHN5ARBoaE30o6+rwm2fg/liJsGf+PneOJUXw4924aafJGVtt+T1wIIfnDajts6b/izPy8fZlrXsdDp6XQbusiZYgf+uDj6uwFFK5IqKbIa4uuK9cjRusbsnPd5yPjPbD8lTINjFsSdokNvrfRjqfwH0U8kMv4iUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816824; c=relaxed/simple;
	bh=1C0H7UERFiFZZ/FOaknhjU0DGvDsdbFkKV5LYyGmeyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAnqnIldXRnGPvzg8GjEeKgg8nQAheyO0mLlDJwTNgK3XcQNisdcji8dNjfDsiXeBPLY6TY5ISFm5s+7B9GiwdMksBMKDpAWWvG4UAjMQnGvyh/HR83wEK4DhrvLhZru1hxyNHeB8lZIVK2fY+p4Mi6jlwsXUtZYtfeaHr3fM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPD63FOE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816823; x=1755352823;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1C0H7UERFiFZZ/FOaknhjU0DGvDsdbFkKV5LYyGmeyU=;
  b=bPD63FOEbSTWA3LoIqpLk26LMHCUg/BpIH3TZ2wfij1HrM3BrCIZWXip
   IbdftEr9KgzqHp2s/ActBSUH0iiAH/f4vFU84JnMyJYwh9WxSEaQEi/Hg
   VBqO/QVda4uGG4hHQ0G7k+qHnPbCClJ390ztumfDb90tiEpHqcSEL7g1V
   g83fsGu9j8uYs66YcoVfkIGjyAOCTQ+bkiiqeWvRgl/X+iuBXRziOTaNw
   OBz8rGsuuDpNJeyfuRHcuDqCQKz5PXb+owKi3Y06HPsIm1L0VQKatefJ8
   xh1Qkw4/gIYjycCcpJ6l3dHP3lADrhrjmIQoY8dP3WDVxPAy6E/0/BuJj
   g==;
X-CSE-ConnectionGUID: c/NUEGWXRzWRRBEUUTQTtQ==
X-CSE-MsgGUID: XvcFqhznQfmKakZx0Nbm9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272821"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272821"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:22 -0700
X-CSE-ConnectionGUID: /R+f22TKQsSFmHuaLKi0eg==
X-CSE-MsgGUID: Eij69b/HQmiNrkin28pnRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411401"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:21 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:00:02 -0500
Subject: [PATCH v2 14/25] cxl/events: Split event msgnum configuration from
 irq setup
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-14-20189a10ad7d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=2746;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=1C0H7UERFiFZZ/FOaknhjU0DGvDsdbFkKV5LYyGmeyU=;
 b=aHOePV1Xoc/fsKfdOT5Xf1woYSfx+Lq9vclxX+U8PD0AsRQ3lURv0kQMJ8iBHeX4GRcOPI9s9
 ZhNsQdhg541ChVDnMdxN2jYMvOhr4e2FKyLJ6xGx/g+vqy+k3Ff/wBc
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Split cxl_event_config_msgnums() from irq setup in preparation for
separate DCD interrupts configuration.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f7f03599bc83..17bea49bbf4d 100644
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
@@ -773,11 +769,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return -EBUSY;
 	}
 
+	rc = cxl_event_config_msgnums(mds, &policy);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds);
+	rc = cxl_event_irqsetup(mds, &policy);
 	if (rc)
 		return rc;
 

-- 
2.45.2


