Return-Path: <linux-btrfs+bounces-7240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF80954BA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680B1283918
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49C1BE235;
	Fri, 16 Aug 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntwaOafp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4F1BDA85;
	Fri, 16 Aug 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816803; cv=none; b=A/3kumCgpJXCcAKBZmwbSPQP0YvisSrTdHLzh3Rl+Cj7VPFN8dscgjfNFmNAVDP4I7MwtwTVIZ2pPfqspRoQ3hODTa5NF4VW1FGY81k4cQ7h/vgDU/fxMjsa9WFPa/4QPweTQuoFlLbYcWCAbW9bdIGI9bsy2I26O0L5O8ks1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816803; c=relaxed/simple;
	bh=Zo1dZh5pzHpeeydz3y04EF5edS3G2yB/CM8mLx26TMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1qRzdviKdHgNd96heCOE4a4Uedi1PwssdJnt1GxbOr0hYMWCb9ebKoswUkiptZKcxO3vWpsnUUnZNW3XJdDGP6ZhFcU3o/sAfs3pRRL3cZlgNOrhoRS4pWnvWa41syzBBSasUKr7MB9NtZxvU2rmv6Y38CLtZRT5PhNkrioVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntwaOafp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816802; x=1755352802;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Zo1dZh5pzHpeeydz3y04EF5edS3G2yB/CM8mLx26TMA=;
  b=ntwaOafp97QJiJD605xijmWVVeomguRIRXVjXm6J62J7OydsyP9HFWP2
   tdopYHjAuJooWW6Z2JJaaHWpF/NIZQUorl4J8q5YgloSHGFWqa4j0wOP4
   L9nn52sa97rtCkP75thjrs5w9nZcw+30HX1y2X12RywmZ1F0zpwXkMywE
   AWMPDC+CvGVU+pChkExwmW2Q661I4fpciFEoufcs1Gx0ktLBm/LVc/gWQ
   C08TgBkRBEZ/vv6A1TAW29OmdewgR9H0ibK4Ic74GQ+IWUY72yGWy0slw
   Lu/i4j8AJDkFpLUa470mcBzbZ+oPZxzHYemlE5pJ6WcOYk6+ioBHlCjol
   Q==;
X-CSE-ConnectionGUID: ZJTwEX79RjCxKa7zgk+d/A==
X-CSE-MsgGUID: yuyKeXoEQKiA6qnIZv9t9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272749"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272749"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:01 -0700
X-CSE-ConnectionGUID: xyrRTVkkSl+0LhBrzebYXw==
X-CSE-MsgGUID: IIqi6/ZQQ7Sj/Zm+FOLXNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411076"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:01 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 08:59:52 -0500
Subject: [PATCH v2 04/25] cxl/pci: Delay event buffer allocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-4-20189a10ad7d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=1342;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Zo1dZh5pzHpeeydz3y04EF5edS3G2yB/CM8mLx26TMA=;
 b=m0c9vfIqai24h7En9QehZLv94Qt2R152vZHbIToQei9Y4kC8nA8VtHdJ34aJ3sStcS4QnYCnS
 yihWHrLKsLQAIGHMn8es4Fmk/P4mP7D0sL1nzTy0dRQmDl+s4oPeV1t
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The event buffer does not need to be allocated if something has failed in
setting up event irq's.

In prep for adjusting event configuration for DCD events move the buffer
allocation to the end of the event configuration.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: keep tags for early simple patch]
[Davidlohr, Jonathan, djiang: move to beginning of series]
	[Dave feel free to pick this up if you like]
---
 drivers/cxl/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4be35dc22202..3a60cd66263e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -760,10 +760,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
 		return -EBUSY;
 	}
 
+	rc = cxl_mem_alloc_event_buf(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_event_irqsetup(mds);
 	if (rc)
 		return rc;

-- 
2.45.2


