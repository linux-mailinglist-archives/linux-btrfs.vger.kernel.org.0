Return-Path: <linux-btrfs+bounces-3531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9765D888B81
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815711C2959D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B172AA9CC;
	Sun, 24 Mar 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfPqms57"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26822365B2;
	Sun, 24 Mar 2024 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322305; cv=none; b=gpRq0VqV5qcUa6CCFOlQ8m/W4XIo+mzOw+RQauSbE+gAg8VxPYP+THojz7L61nLSIBfiFbG7cnSMAkfqK5AHPCoUbNcGO/vZcfq3d6nwZ3BSHV74+x58LtSKzX5ep3igPL67HNLZOGOfAJn5X8JKxKxaoia76eZjXjgYYv1nOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322305; c=relaxed/simple;
	bh=jVPxGR5BgM9vA0s1brpDXZj2La8xlSIyBw8kpmZZV6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reiAtqHXICb9XUL9tvIOLpZ8MEruM0oR/o+nmMmMDZv4qkdhpYyiJwrFQgqas7wq3jZtFeyDcg2hmKbMhT0NJTZ3I2COqcEZaRWsye3lkFnjnvFQK11o6VJROpwUwUpH14fUaW1gho4Fjf2foHyuo5dCOgkeIG5bBT9Q2J9z7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfPqms57; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322304; x=1742858304;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jVPxGR5BgM9vA0s1brpDXZj2La8xlSIyBw8kpmZZV6w=;
  b=MfPqms57nDAHyOU65vEHcPUe3gnrGc8xmcSUPBLWtp2V2Rrhu8BaN9gr
   2THhUKHilOo7JfNAa7A8upBU8fPrgewYYe1ou7WE3BEca6zPruznM0oMb
   86WNDZiseQxtt3P7eXTEQzU/hz/dENdQeC2RFu/JsQL39OKIDo3vl8imU
   paWUQfbPGHDlRsuzuQuhkTswt0X6sEkTv5N5pOdvVAQ+Zo35R8oz9nvYi
   OgvebLsLSJRYH0AeZ1vYzFr6QUDzt1Ra3Xk0LVnCBEQN0/FkbSTT0RqGx
   KvEWzLwpq1lC9V40Zz1rwcXQAT+3YUrehmdcPybARkFTlXcXDYCbbeZbe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431733"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431733"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464701"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:19 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:18 -0700
Subject: [PATCH 15/26] range: Add range_overlaps()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
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
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=3117;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=jVPxGR5BgM9vA0s1brpDXZj2La8xlSIyBw8kpmZZV6w=;
 b=53iCHLJ/xWLPJlIgzSANBdAyM7tqEPc2zNiSaLKJv/ddYCJwR6n/w4cTZhkxgLdxBdAy9OS1f
 AobHeXQ6eQTD+GzTSt916xd9MiMVrNMwMNBn+yOb85x9/HEwj20voeQ
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
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

[1] https://lore.kernel.org/all/65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch/
---
 fs/btrfs/ordered-data.c | 10 +++++-----
 include/linux/range.h   |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 59850dc17b22..032d30a49edc 100644
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
@@ -914,7 +914,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 
 	while (1) {
 		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-		if (range_overlaps(entry, file_offset, len))
+		if (btrfs_range_overlaps(entry, file_offset, len))
 			break;
 
 		if (entry->file_offset >= file_offset + len) {
@@ -1043,12 +1043,12 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
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
index 6ad0b73cb7ad..9a46f3212965 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -13,11 +13,18 @@ static inline u64 range_len(const struct range *range)
 	return range->end - range->start + 1;
 }
 
+/* True if r1 completely contains r2 */
 static inline bool range_contains(struct range *r1, struct range *r2)
 {
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
+/* True if any part of r1 overlaps r2 */
+static inline bool range_overlaps(struct range *r1, struct range *r2)
+{
+	return r1->start <= r2->end && r1->end >= r2->start;
+}
+
 int add_range(struct range *range, int az, int nr_range,
 		u64 start, u64 end);
 

-- 
2.44.0


