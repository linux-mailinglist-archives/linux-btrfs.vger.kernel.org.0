Return-Path: <linux-btrfs+bounces-7271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF9954CE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D223B25137
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC68F5464E;
	Fri, 16 Aug 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkJWXGqe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5AD2BB1C;
	Fri, 16 Aug 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819512; cv=none; b=rKsH6pvL4JEZ5X8gRU5mTQPPkLuyoyK4Meqm9nJ2NPhjsL6EmT5fQKPbjlDutVeCSfTFqAud5d6Qxh93bgFuUd68L8fMHdNHDoHLYxv3XGKGNgBsiNyDmz8wrMThC0Gh5DuGAFWmL1wSjxA+8T9Ycub1tKkaAUmEcS+m+xidA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819512; c=relaxed/simple;
	bh=CHaiWuhlK2oilB02S0vAQGpbVxQJYSALMGWJkD3RrYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JftsfOaFuaMjJe3i9Gtv4tngVymVgSOiWqzp545WKsHg5PMx4nul3/xZkcloUEhNeUQNJSwNgsSic1LqHMAsq81fIdmsGdmz60mTuiPMPglrStaMIGvoeKiqmqqhOhXAUZmBk9esPHgg4BUcM6Kot9FFXnMiJ4RThZegt/RiOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkJWXGqe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819509; x=1755355509;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CHaiWuhlK2oilB02S0vAQGpbVxQJYSALMGWJkD3RrYQ=;
  b=BkJWXGqegWp/8KjwBV4f/KJuFOJba7J85R3vsN2vTkwjxpld+wU3Ux9F
   aE1HbtR5alE218Fyh9vnPet4Fc4sgBLJfbofavWfRNcHCGtUQ4JWPhccs
   cxn/Y0wVjuNC1FgI0jv9lflzU+HAeEKETbfAgH9EOJSeQ4qQs/BWiUyDg
   FNgXbiwwfee/l1/1FXO1dOkBUDYhiU71u6Ht6EKFAaCTtyPVJ/MQ/zLQD
   S9wlDAHIi7eNopmbTrEN0WWaiD2n+yc7UD6brjbm/HxMvsC4kEKMg0KHM
   VCIJikeNciE0CZ0e75BtYR3j2r94tM17tY8xGvaXBuFMJ2j1tt75lWbm9
   w==;
X-CSE-ConnectionGUID: ZzE3ErBwSbuq3DKRz5sEgQ==
X-CSE-MsgGUID: dXsh72irQdGRw2KlIkrj0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21972970"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="21972970"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:57 -0700
X-CSE-ConnectionGUID: xvqtfWF5T4yVq811cN2dFA==
X-CSE-MsgGUID: 7YJZHnIcTp69lN7VOHBLsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="97205542"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:44:20 -0500
Subject: [PATCH v3 12/25] cxl/region: Refactor common create region code
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-12-7c9b96cba6d7@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819456; l=2376;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=CHaiWuhlK2oilB02S0vAQGpbVxQJYSALMGWJkD3RrYQ=;
 b=t80r3e+q4zsiVPP6LuC5XHt548hYyktBtBdttdKdRn1dqocwMyHcNc0p7oI9TXkpeun997XPT
 YRq2/SvZPZqCATldNOszWTlBDQkCrJdWECJtX4xN4ULZXHjEhpM39yB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

create_pmem_region_store() and create_ram_region_store() are identical
with the exception of the region mode.  With the addition of DC region
mode this would end up being 3 copies of the same code.

Refactor create_pmem_region_store() and create_ram_region_store() to use
a single common function to be used in subsequent DC code.

Suggested-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/region.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 650fe33f2ed4..f85b26b39b2f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2553,9 +2553,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
 }
 
-static ssize_t create_pmem_region_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t create_region_store(struct device *dev, const char *buf,
+				   size_t len, enum cxl_region_mode mode)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_region *cxlr;
@@ -2565,31 +2564,26 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
+	cxlr = __create_region(cxlrd, mode, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
 	return len;
 }
+
+static ssize_t create_pmem_region_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	return create_region_store(dev, buf, len, CXL_REGION_PMEM);
+}
 DEVICE_ATTR_RW(create_pmem_region);
 
 static ssize_t create_ram_region_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-	struct cxl_region *cxlr;
-	int rc, id;
-
-	rc = sscanf(buf, "region%d\n", &id);
-	if (rc != 1)
-		return -EINVAL;
-
-	cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
-	if (IS_ERR(cxlr))
-		return PTR_ERR(cxlr);
-
-	return len;
+	return create_region_store(dev, buf, len, CXL_REGION_RAM);
 }
 DEVICE_ATTR_RW(create_ram_region);
 

-- 
2.45.2


