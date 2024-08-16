Return-Path: <linux-btrfs+bounces-7239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDC954BA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A11F254B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230D1BDAA6;
	Fri, 16 Aug 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djO90WMC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341211BD02A;
	Fri, 16 Aug 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816802; cv=none; b=O3D4KKMGF2m10Teia87+vtu5iRtLhRCuVi2xVkjqql7h+NZKDzYo3TI+Y9GWWQ9vzyBgWUO0JJOuFQ2dXd2+jviLMq0cDJwEUoHdhjP/CVdOPDDstJPqm8g8Kj4Q/usy2fo5H8vESES4SWjvFuGwJ/8V8NNEAfwBn5WtuCaXSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816802; c=relaxed/simple;
	bh=5VkggrFXyoRX+xFMFtPbi/ymdAmy5/e3QrX+vM16NIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcFlwdYctN02N+Kte/4DkW39QqUZqP7wIbjAppAlyeb/0OsmLuT7VY6GxGu70C2WIXO1Lm34incXnxZ+8ObZGe21Mh/5FTWKxNZS9m8ROtt5EzvAijY/jChrUL6btQEwcdRnY8mCm5gcOH/xgt1535SMyAZtwrmZkw7oNYWj8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djO90WMC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816800; x=1755352800;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5VkggrFXyoRX+xFMFtPbi/ymdAmy5/e3QrX+vM16NIA=;
  b=djO90WMCwZDnFu63cg4oJhQroBAuNe7WxRzbhEpGRJCzKPZR5A8Vi5iO
   nQHFBheb97fNm8TaEmENJ4SjATKDfhJQQBa6/uPLMfYOgLwHp1C3FTtaM
   ZQoiJGWL947K+r9/E1WRf9WtDCTvxNqHJ+UMBooWUX6kD3TefzgBIbIPt
   aq0BTljnbOvB25nPmmBCqGzSoY5kxnPCEkw+6s0TXSQTIryjeajfWgRE0
   8l8HQ04hxbEmusEbmQH+4Ot9rZ4wLBHLv7veIRWl6BPGcipUAC+Cc9eVr
   cR+07mheEa4XY4a/uuM6PH98vKGqzGbIT4s1WYsdlEkPGE+4sm9BSYSdI
   g==;
X-CSE-ConnectionGUID: fDsUwqglRR+R0u+D+LJpNg==
X-CSE-MsgGUID: E/mis/0sS0+Ud16B8cZCCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272743"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:59:59 -0700
X-CSE-ConnectionGUID: NBDIqoKNSIaWCBUqKWDG1A==
X-CSE-MsgGUID: PP4BSPWuR0Wg/+QDvnDlUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411049"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:59:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 08:59:51 -0500
Subject: [PATCH v2 03/25] dax: Document dax dev range tuple
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-3-20189a10ad7d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=1068;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=5VkggrFXyoRX+xFMFtPbi/ymdAmy5/e3QrX+vM16NIA=;
 b=dkW/0VO1hCLBbRJkyg2McAXvf0uF3ddKfBVVLec1uHI5zCf8xQBbxAIhx+K2xf7JU8E6T0lqW
 9GVerPg5S4aBaLp1e0DaCFAfzxAesm+EfnGQ5nn57l66Xsns7fcKz3a
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The device DAX structure is being enhanced to track additional DCD
information.

The current range tuple was not fully documented.  Document it prior to
adding information for DC.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: move to start of series]
---
 drivers/dax/dax-private.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 446617b73aea..ccde98c3d4e2 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -58,7 +58,10 @@ struct dax_mapping {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
- * @ranges: resource-span + pgoff tuples for the instance
+ * @ranges: range tuples of memory used
+ * @pgoff: page offset
+ * @range: resource-span
+ * @mapping: device to assist in interrogating the range layout
  */
 struct dev_dax {
 	struct dax_region *region;

-- 
2.45.2


