Return-Path: <linux-btrfs+bounces-7253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F2954BC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238FB28160D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E221C68A7;
	Fri, 16 Aug 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fY89KNgH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C221C57AD;
	Fri, 16 Aug 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816830; cv=none; b=M1vX04NEBuS7/2nDvPyiXpzAJ/5nBobeAAMO1CzuEhcfy4+8dW2G3i8L+ScM39pnH53GuC1dI3KRnhxYszZjDF4EbeUMruU8orEtIPz4PcnaVJogKBsBGlo8+0ka709KkL5Z8AiD9/2ZY1MVMF7TcNmMuH5ew5C8GGFw1GVzlLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816830; c=relaxed/simple;
	bh=pqRNyjGqOVpA4g/Gj6bYGTLfCk09oM9Oq8+UwkaTqOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HL2uSC3jzZ9NDLCWxkDixqsQNIOsVfS3onwei9NTfRDdqrNQyHxQWcaUh4gPhNRBJAcMYbmmnOzzBGlh4v6IMW/vpR6ESQwWoPzsyJAF3DAynfrL35W5X7IOkhGYFDE8NPG2TbDgDFc1z/0e1nUO+UiaWbijY5yqkTpMu8zoFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fY89KNgH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816828; x=1755352828;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pqRNyjGqOVpA4g/Gj6bYGTLfCk09oM9Oq8+UwkaTqOc=;
  b=fY89KNgHKokwN4kwBKitp1KA8CmldjdIeCZfvUY5xlhKJfV/gEYBYVhO
   raYfbR4CIUiMT0pJToSY8hgY3CfzHbhT7yVbJiaXH33jz7R7VjMpJL8Qv
   RP0iZa1+PrvUaHFvWQIF5Zvl+2nqnABgNBT5m5UgICJC9ERqkx7t+zvkK
   psTrDobrHfVZjlrlOV3DZsYLJ4i4mNYzUw50jCrIUlz/zjBGqrH6UjnRC
   YmgxkwPoBVaSrk4D/Qzq3B/ofUDFQxbnBejaISg6RnjIreNgdlK5MuK7x
   VCIRqmHUGQUcY91kkOyO5S8DtXlFgjg32vXdESiMO1uQQPGUVSjEWbQiv
   Q==;
X-CSE-ConnectionGUID: RIcCYUyDSCqzNqAv3Nm8gA==
X-CSE-MsgGUID: 0o+v7z8QSjq6EHeY4liPfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272846"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272846"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:28 -0700
X-CSE-ConnectionGUID: C1gU//79Q2+pHmssQrxcDQ==
X-CSE-MsgGUID: I+xYOfkuSvu1F2Fz9NWmSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411500"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:28 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:00:05 -0500
Subject: [PATCH v2 17/25] cxl/core: Return endpoint decoder information
 from region search
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-17-20189a10ad7d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=4183;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=pqRNyjGqOVpA4g/Gj6bYGTLfCk09oM9Oq8+UwkaTqOc=;
 b=5MduwxG5h+xCFT7Kz1niQDIzqRUK2ebRDWJcd1aUkUTq500L4J6exSyAHWBj1pHPNmr+6T2/5
 pvvDjYy5mhNAUtCiNsjl0ZJ+nK52c5hOLo16ttD8LzLRKgiwuJKtmQ6
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

cxl_dpa_to_region() finds the region from a <DPA, device> tuple.
The search involves finding the device endpoint decoder as well.

Dyanmic capacity extent processing uses the endpoint decoder HPA
information to calculate the HPA offset.  In addition, well behaved
extents should be contained within an endpoint decoder.

Return the endpoint decoder found to be used in subsequent DCD code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/core.h   | 6 ++++--
 drivers/cxl/core/mbox.c   | 2 +-
 drivers/cxl/core/memdev.c | 4 ++--
 drivers/cxl/core/region.c | 8 +++++++-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 15b6cf1c19ef..76c4153a9b2c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -39,7 +39,8 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 
@@ -50,7 +51,8 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 	return ULLONG_MAX;
 }
 static inline
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled)
 {
 	return NULL;
 }
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 68c26c4be91a..01a447aaa1b1 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -909,7 +909,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		guard(rwsem_read)(&cxl_dpa_rwsem);
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
-		cxlr = cxl_dpa_to_region(cxlmd, dpa);
+		cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 		if (cxlr)
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7da1f0f5711a..12fb07fb89a6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -323,7 +323,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (rc)
 		goto out;
 
-	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 	if (cxlr)
 		dev_warn_once(mds->cxlds.dev,
 			      "poison inject dpa:%#llx region: %s\n", dpa,
@@ -387,7 +387,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (rc)
 		goto out;
 
-	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 	if (cxlr)
 		dev_warn_once(mds->cxlds.dev,
 			      "poison clear dpa:%#llx region: %s\n", dpa,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 35c4a1f4f9bd..8e0884b52f84 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2828,6 +2828,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 struct cxl_dpa_to_region_context {
 	struct cxl_region *cxlr;
 	u64 dpa;
+	struct cxl_endpoint_decoder *cxled;
 };
 
 static int __cxl_dpa_to_region(struct device *dev, void *arg)
@@ -2861,11 +2862,13 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 			dev_name(dev));
 
 	ctx->cxlr = cxlr;
+	ctx->cxled = cxled;
 
 	return 1;
 }
 
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled)
 {
 	struct cxl_dpa_to_region_context ctx;
 	struct cxl_port *port;
@@ -2877,6 +2880,9 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
+	if (cxled)
+		*cxled = ctx.cxled;
+
 	return ctx.cxlr;
 }
 

-- 
2.45.2


