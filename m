Return-Path: <linux-btrfs+bounces-3537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F6888B89
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD521C291FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F372ACB50;
	Sun, 24 Mar 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS4GmB83"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670351FEC63;
	Sun, 24 Mar 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322302; cv=none; b=hOILEM8xXyCuuxWDID7PDjeksNMcLX80QMo6onI6+a6yKZ5ncR0bxDy/GtMOeM+p4Z35WCmX65ffD+fhTkCCJ6AvzCUhkqjd3CDdvvCzn8ld2fcMES0wcjhlVVI0n8lOAW6zAPcH122qGmd70PZ3xmLU28AQ6ySIm3V2SC2+tpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322302; c=relaxed/simple;
	bh=aOa7tSKdrtNNgJakY80BLsxWTWX10CPFdKyFwZ4Ph/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlf0asXA/WTkowp3xH2FQPvXh3uBP4EZDdVaV0klcc3KXnNTcLCczRAwNo/VV0YnTHWiJ8Cb4TWTrAbSyo8GssQOIejVg8gaGHUOE/PjjpsKFMmCdanVNKR6vx/clx/tTqDphxnTMANhQ10C2al8EG4SFS3oisV4QBu5Gzdu/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS4GmB83; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322301; x=1742858301;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aOa7tSKdrtNNgJakY80BLsxWTWX10CPFdKyFwZ4Ph/I=;
  b=LS4GmB83aH99kr9QIMO3UK2GFZTZb+O/N+UOGDdjOGpFaHc3FS+MpnKX
   u08R5PszEAXdahVu7RVXKUqLOCIXX7HuKnJtl82G8dIL0ntr+U2nZAMYo
   a7muO6WeXVaHeHWNZMgvDIe7j9h3+shKsN1QIlTGu0XzPEg6qh6kf/zdC
   GnahHw1LRNk8j5Yi1Xx2/G1MdWHafUDlR/qZ2sYF2MU/eCLitiDDvzn7J
   owU58oDzItmxVCYTD+tVPVgYp/YDggstvrcCCcbZ7uxn4tlnFwItA0kk4
   ur7M+FxURgUfNmqTWv8tXjUSrcudcRv6bhApwLzLGU/5hUb485FckQ3Vi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431715"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431715"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464689"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:17 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:14 -0700
Subject: [PATCH 11/26] cxl/pci: Delay event buffer allocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-11-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=1026;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=aOa7tSKdrtNNgJakY80BLsxWTWX10CPFdKyFwZ4Ph/I=;
 b=RVAKA90DnUdbxQtuGUIzs3pcIWux1IflAmZNWbu+KeOiQP5vCfQyAxYhTvQnW3tCgDa5G705n
 N4dJSVSlGUKCLvxaXUC+QZvVQ/VUxMOFTzbwYYNXV9DAiMSGT2n2fz4
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The event buffer does not need to be allocated if something has failed
in setting up event irq's.

In prep for adjusting event configuration for DCD events move the buffer
allocation to the end of the event configuration.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index cedd9b05f129..ccaf4ad26a4f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -756,10 +756,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return 0;
 	}
 
-	rc = cxl_mem_alloc_event_buf(mds);
-	if (rc)
-		return rc;
-
 	rc = cxl_event_get_int_policy(mds, &policy);
 	if (rc)
 		return rc;
@@ -777,6 +773,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
+	rc = cxl_mem_alloc_event_buf(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_event_irqsetup(mds, &policy);
 	if (rc)
 		return rc;

-- 
2.44.0


