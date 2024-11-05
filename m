Return-Path: <linux-btrfs+bounces-9340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572A9BD4D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 19:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A16D1C22746
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230891EBA1B;
	Tue,  5 Nov 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ope8d/M+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2B1E907E;
	Tue,  5 Nov 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831914; cv=none; b=dIv1vgXgWuORgMmGW4FesR4W/qK2mEBTi6pFCvc8EJ5FVPsDWwVeJByuXQbycGmY2DizQf2Kzo+RaVgk+OC1Mxuu8lp6yraSacB8MGYq8c98vaGnRag2amqxxdJOyIRgqRcqHrOXtBAKesj2D6XzZjNomzQKWJ63fJK394zqyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831914; c=relaxed/simple;
	bh=94mNaBSKBGKU/oxXHv0KQQ3HrmkwrIQ1mGVq1crl7PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3W16/4FTCRh4M/OmvuaD2EfXzZL9UsdqCRK6zMQAXFvdF6umNdbkn9c+5PDpVHX3FOVWe6hP5It6djcb1vRfJV+O3oMI29yqpZUvS5q7oG5fRjEK156BqJzSaqVlgmFrDbDDLawd9okI0o8Q2BiArBg1rVHKy1NFCftMgMj4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ope8d/M+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831911; x=1762367911;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=94mNaBSKBGKU/oxXHv0KQQ3HrmkwrIQ1mGVq1crl7PM=;
  b=Ope8d/M++BEfrJfB9/b6OY+UyP4VMr7hmsejzQXu/Rs1+ccqEcLmOvmj
   9/K6tbdIgWW5/xK6Xf+45VBuYiF8faavLy++YID7hWVBiMivxLhdc9LaJ
   fWXLd9fiqRxF+LQI4W5r9CLKclCjuv5ppgIh9PQv/bJ3VpTpJ5jBV1oPn
   tfwu2EDCRF6K0Zuqw8+gsBibCB0zsEUJgM0TX046mll1acvrrfKvY63I/
   sk8mvbyPvvK74LF5gRyEmdcGDsonZn/Ot0k7IfBaXRL23Eli1HRCMn1Ew
   YuvEnLQUCN6TmhaYKKFnAo3mjjEDL41cWi/XIX0z3QSO2ZrkcBxd4Wa3H
   w==;
X-CSE-ConnectionGUID: jxCoXyCsS3OwAGFN5JNrEA==
X-CSE-MsgGUID: bNKqS9aKQ5Ko+ym3sI6kVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30708359"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30708359"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:31 -0800
X-CSE-ConnectionGUID: 8YNCvpn6RKaWza8E3Gl/Mw==
X-CSE-MsgGUID: UTC8DIHeSPSGlunJQZ6uZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84948634"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO localhost) ([10.125.109.247])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:30 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 05 Nov 2024 12:38:23 -0600
Subject: [PATCH v6 01/27] range: Add range_overlaps()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dcd-type2-upstream-v6-1-85c7fa2140fe@intel.com>
References: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
In-Reply-To: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730831904; l=3560;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=94mNaBSKBGKU/oxXHv0KQQ3HrmkwrIQ1mGVq1crl7PM=;
 b=hME8ciUyjqEZnMsxFxb54/oj16NvxM9Il0dsRBM+nb1Jbrl/MJKVrqbmFVPOAZRVNkoL8XKOz
 l8XDqu1poxgBQMFsWS+DxVCby7dxhiR32yLRTMJ2wQcE57ScVYPuUSL
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Code to support CXL Dynamic Capacity devices will have extent ranges
which need to be compared for intersection not a subset as is being
checked in range_contains().

range_overlaps() is defined in btrfs with a different meaning from what
is required in the standard range code.  Dan Williams pointed this out
in [1].  Adjust the btrfs call according to his suggestion there.

Then add a generic range_overlaps().

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Link: https://lore.kernel.org/all/65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/btrfs/ordered-data.c | 10 +++++-----
 include/linux/range.h   |  8 ++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2104d60c216166d577ef81750c63167248f33b6a..744c3375ee6a88e0fc01ef7664e923a48cbe6dca 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -111,8 +111,8 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 file_offset,
 	return NULL;
 }
 
-static int range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
-			  u64 len)
+static int btrfs_range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
+				u64 len)
 {
 	if (file_offset + len <= entry->file_offset ||
 	    entry->file_offset + entry->num_bytes <= file_offset)
@@ -985,7 +985,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 
 	while (1) {
 		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-		if (range_overlaps(entry, file_offset, len))
+		if (btrfs_range_overlaps(entry, file_offset, len))
 			break;
 
 		if (entry->file_offset >= file_offset + len) {
@@ -1114,12 +1114,12 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	}
 	if (prev) {
 		entry = rb_entry(prev, struct btrfs_ordered_extent, rb_node);
-		if (range_overlaps(entry, file_offset, len))
+		if (btrfs_range_overlaps(entry, file_offset, len))
 			goto out;
 	}
 	if (next) {
 		entry = rb_entry(next, struct btrfs_ordered_extent, rb_node);
-		if (range_overlaps(entry, file_offset, len))
+		if (btrfs_range_overlaps(entry, file_offset, len))
 			goto out;
 	}
 	/* No ordered extent in the range */
diff --git a/include/linux/range.h b/include/linux/range.h
index 6ad0b73cb7adc0ee53451b8fed0a70772adc98fa..876cd5355158eff267a42991ba17fa35a1d31600 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -13,11 +13,19 @@ static inline u64 range_len(const struct range *range)
 	return range->end - range->start + 1;
 }
 
+/* True if r1 completely contains r2 */
 static inline bool range_contains(struct range *r1, struct range *r2)
 {
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
+/* True if any part of r1 overlaps r2 */
+static inline bool range_overlaps(const struct range *r1,
+				  const struct range *r2)
+{
+	return r1->start <= r2->end && r1->end >= r2->start;
+}
+
 int add_range(struct range *range, int az, int nr_range,
 		u64 start, u64 end);
 

-- 
2.47.0


