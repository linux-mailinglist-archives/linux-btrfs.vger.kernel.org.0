Return-Path: <linux-btrfs+bounces-8606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D7993ACF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD83B24241
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E641D07BA;
	Mon,  7 Oct 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPs2WPLk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DBE1CF2AD;
	Mon,  7 Oct 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342993; cv=none; b=o2PXt7YNMBeZMQdFU0W6+e5ESEpOZA2//wozUT1beRqLbsED7VdGCnpS7adZcUQhI+x3oWd9u2dBfvQ2QcwetWEIM9VjjegVtX7fSmNq9Qcxn0gHD7T+pO1Lxw18XLaBFHS1uwEpbh2d9+2A+Xe3L2GYbZ5q4eu+A0F8nmss83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342993; c=relaxed/simple;
	bh=385I7+Y0VzN5L43OObnKX7IOjsMcQVkhxQQqH4ktdoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSk6FIcUGyWb2FcVTfWB8PQWJfRZOKGW/XvCbvMBVdRgcgSyJJ/SChjON2ikvhDuNXxRWzraYzN6YUpTvb6+42NE9iq/e6CAl9/qxBB4JYy19gkY1L5zOaVwmyxzMqJ3dVN6H0KqEwyMz1Wrh5SUNLFGncidQPF+hOTbRRPpzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPs2WPLk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728342992; x=1759878992;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=385I7+Y0VzN5L43OObnKX7IOjsMcQVkhxQQqH4ktdoI=;
  b=TPs2WPLklpHIEBR9nplifen1+OFuNH4zVlVVCrio1gM6lzv7/3svg1hG
   IzIZAg9l6+0CUg5KDBMdm4rhOCXyt4RguyzdRpadxPr8fMeyKnwrnIN2U
   4GN+lCHYkPZlL014HvzR/Ce52t2U/eUw+yJpykQ6Lk6DEbzjn0qBF9lRD
   PUGnenjWh1GCg4CnDY4y2EEYiFKFNJUih379yB0jrBvpmGB3njTo5VENd
   J/Gnz1/5QX3eu3ASpkUFhIdbqA0qTM6n4JG4rikTlF5z1Tsvgtnuj+yET
   Qw4pHhqjaA7P/cp6mS6kVFQHK9HsdqiF3rjCK6um3xuMmAtIGx2776i90
   g==;
X-CSE-ConnectionGUID: jgojzz1/S+axNqA3NzTp9w==
X-CSE-MsgGUID: qqKOOv5sSgmfUHZoEB5YFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38078914"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38078914"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:32 -0700
X-CSE-ConnectionGUID: 4E4Jgdy8QNC19vrb+futNQ==
X-CSE-MsgGUID: ldgdRJATQcSC01R7RogHVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75634582"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:30 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 07 Oct 2024 18:16:12 -0500
Subject: [PATCH v4 06/28] cxl/pci: Delay event buffer allocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-dcd-type2-upstream-v4-6-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=1342;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=385I7+Y0VzN5L43OObnKX7IOjsMcQVkhxQQqH4ktdoI=;
 b=CN+pHNJ4yuXddnutJgvb6PuhUXw8rcAL6YbMbS1paDl/r3xIwGUXEdsCb/hVXN59XpqvF7tvE
 aBN7tWFRFXyCIZT7Hfken8/clWbmLTmV4Wv0JV5ZfGMlDa/rCK5Iz8z
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
index 37164174b5fb..0ccd6fd98b9d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -764,10 +764,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return 0;
 	}
 
-	rc = cxl_mem_alloc_event_buf(mds);
-	if (rc)
-		return rc;
-
 	rc = cxl_event_get_int_policy(mds, &policy);
 	if (rc)
 		return rc;
@@ -781,6 +777,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
2.46.0


