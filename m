Return-Path: <linux-btrfs+bounces-8603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6C993AC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0430284F1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EFA1C1AB8;
	Mon,  7 Oct 2024 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhtPOX8m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273801BFE18;
	Mon,  7 Oct 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342984; cv=none; b=pxiPha5V/GHHsurLDc05HO8XaagFlclbOY69qdRrmCSoL1f7ufqQOeJ5tmZoHk5wzq8z8HGs65J2NMo9dyhNGh8cEhXOo0G6SkRaqN/4srrk4NOVJ242nJdSD5Ha0753z/5+MkgCsD48zQ5G7T0C0BjwgwCjGmBh1ECyUT7z2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342984; c=relaxed/simple;
	bh=xKwxMnn7zPMYaMgu3lh8wgm8BtmFwz0lKdAy/W2nB5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ninL4zMSHRuQBMLM9mlredP+/PykE42FZQ5glGVhBqi3duiq6DZtVMNCyP/M2XSO+nY87to5RB9p1JG0pKWwAyW6hVvWI5cEPbx0PMFpTU7Wa8kKvxdjpdsTosBM3OufdAJ7HF3uBI3qfT03saa4LNQ9b8Bv2yxGgCKKHYEcs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhtPOX8m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728342983; x=1759878983;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xKwxMnn7zPMYaMgu3lh8wgm8BtmFwz0lKdAy/W2nB5g=;
  b=IhtPOX8mE3gQ7CD0kV8AW2Aj0JSIkjNSHSW/hTT06CHkQ2j4QE7ZUR5r
   SMtscLXNXrYk60pVtvONaceKXrDZyHXrs48dXJ6p0TtyG84sfrkLOmL5N
   AH4UfNRmSe7WPpbpQEWp0Jc4iMAA2OjfvLSbUEbgVZv55hLWuWJg2dJet
   Lb5GVIRVyJcN5F9xvFkNul2PQaZfS6gA7SPkbiSUDiENWCPleosvaAwaE
   Cy2rdFHiswqqZinE2POqglJXEoGRMiUzhSD8GhyjmMSr3W3P3hMUeBwBr
   ySo99WADWe8IXBaqZfI0a5FS04XhPFD5xrO8R4fth/nzx0opw1zuMSa1G
   A==;
X-CSE-ConnectionGUID: vxSoPZ0bSgySLi7SanX/Ag==
X-CSE-MsgGUID: aEy2w4tEQZq7rKXzazCJ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38078887"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38078887"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:23 -0700
X-CSE-ConnectionGUID: PZsAkQO2Qc+ZTi/RjK1Sdg==
X-CSE-MsgGUID: voVZvvsLRGWD//ne2Q9Y0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75634572"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:20 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 07 Oct 2024 18:16:09 -0500
Subject: [PATCH v4 03/28] cxl/cdat: Use %pra for dpa range outputs
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-dcd-type2-upstream-v4-3-c261ee6eeded@intel.com>
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
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=1802;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=xKwxMnn7zPMYaMgu3lh8wgm8BtmFwz0lKdAy/W2nB5g=;
 b=uStKn2bXJUPwz+TjjqwS3eFb9+g7YZh1JqkpPq06GqCXVJ2hNlCQiIN626PqSqYJ6NLCixI+K
 co37C7GxLGnBTR3niZ2B7U4Cugk98+EtfBb+rERlcXhoC6uwSV8ArYS
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Now that there is a printk specifier for struct range use it in
debug output of CDAT data.

To: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/cdat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index ef1621d40f05..438869df241a 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -247,8 +247,8 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 	dpa_perf->dpa_range = dent->dpa_range;
 	dpa_perf->qos_class = dent->qos_class;
 	dev_dbg(dev,
-		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
-		dent->dpa_range.start, dpa_perf->qos_class,
+		"DSMAS: dpa: %pra qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
+		&dent->dpa_range, dpa_perf->qos_class,
 		dent->coord[ACCESS_COORDINATE_CPU].read_bandwidth,
 		dent->coord[ACCESS_COORDINATE_CPU].write_bandwidth,
 		dent->coord[ACCESS_COORDINATE_CPU].read_latency,
@@ -279,8 +279,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 			 range_contains(&pmem_range, &dent->dpa_range))
 			update_perf_entry(dev, dent, &mds->pmem_perf);
 		else
-			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
-				dent->dpa_range.start);
+			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
+				&dent->dpa_range);
 	}
 }
 

-- 
2.46.0


