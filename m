Return-Path: <linux-btrfs+bounces-7260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA387954CB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D71F221B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B51BDAA6;
	Fri, 16 Aug 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELGuRhD9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA31BD02A;
	Fri, 16 Aug 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819465; cv=none; b=IJh4VlKzpcAJmuTZpfKkvtUbk7JhWQvhQ/GgQyEvSEcnV5j0pXP2JA+vW1wxEMFt0bZWi63ipY3c8e6h4tCNUwI30+OS2xJJ7PoC5jmVaVHZdkT++EnuYwgDhurzITzqVwGsRHdKRt+D0v/6zcUkMChtnvz8QOkoCrMvicTxyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819465; c=relaxed/simple;
	bh=iuwoKFBy90JgvWLAvMU7CdNYTV/UBM55Pi1kkx/Ytv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JST8auTXhYiFIUpFAYZrL11+zLsgZS/FcRS7RQ6iQkFeTtF4n5HigreKYgy+XuxDvDKjphgG6LIcdoxeQ9uZDCb8PZU50NjCGo2u8WtTerGwNTkVoY+gdM6dcpxkLV+ryxoBXZrV2BsVsHqnEFk08qmWWs2Gz235xrUS9hKZxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELGuRhD9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819462; x=1755355462;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iuwoKFBy90JgvWLAvMU7CdNYTV/UBM55Pi1kkx/Ytv0=;
  b=ELGuRhD9hKMz5St2NED4g3dMYECe8MVQ4JJ8nsUT82A7pBY6XgmPHNZY
   i6OcluZwaBMuuUr3BmyinEztgAJP3icOaTN6N5YQ0Hxbdb7QULdHyfGFj
   SEVnx0ofDq/R93178Y9Q5SdHQFht8F4zqb2MY9S7bYldlS+LIgEjiIBCT
   /MJ5kK6c02526KVsbGRBKdsetuHuH5wq3jiBjAv1KeL5yzuIJfYWNPcYl
   iaLWizig9k0r569zMGZbMIF7R7oWcRJ/Khk1ar8Ve+d8K5ruo4M+A3JEB
   iodyZzYvpORPVw9H9yTOlHXA7prd+gu5drXe/WXby6973ENC2rkIoMAd4
   Q==;
X-CSE-ConnectionGUID: cqyzJ1DRSZCVysbOWNQy5w==
X-CSE-MsgGUID: Uh0WnH4wSXqusVFOGxJtsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32752997"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32752997"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:21 -0700
X-CSE-ConnectionGUID: uDw5gF45T3mpk7TemIjCbQ==
X-CSE-MsgGUID: jZuxvUnxTuiGiwroXPxLrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59532429"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:20 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:44:09 -0500
Subject: [PATCH v3 01/25] range: Add range_overlaps()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-1-7c9b96cba6d7@intel.com>
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
 nvdimm@lists.linux.dev, Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819455; l=3425;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=iuwoKFBy90JgvWLAvMU7CdNYTV/UBM55Pi1kkx/Ytv0=;
 b=zBG6AJxvt1C81AmrC3CZTbYdDcM/Qu95vAwWbmi4ZLvjaiFuaIHd1a9fDX/vUMS1WVW3ZOPpb
 s/Ay7PnptCDDDTABZnczy8InAgpUFvd+CyzLjVBvIZDPMxNjDWt8OmY
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

Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

[1] https://lore.kernel.org/all/65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch/
---
 fs/btrfs/ordered-data.c | 10 +++++-----
 include/linux/range.h   |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 82a68394a89c..37164cc44a25 100644
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
2.45.2


