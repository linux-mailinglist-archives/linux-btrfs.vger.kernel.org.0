Return-Path: <linux-btrfs+bounces-9210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C049B53CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 21:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F111F23E4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B5207A2F;
	Tue, 29 Oct 2024 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrtaK8yp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417491DDA31;
	Tue, 29 Oct 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234112; cv=none; b=ZjJMVtKnv+y8u3FRhu+HwTp3Lu5zaYr8xslLzIEDjm/BBtMFiwsBii3fl00B7wQV9arNW4gerg85GT9SQ2kAvTK7nuDSRmCOIBUNrcRxAJnJwhl7vVdVMILTA5VtyjC7HzvIlsJAkAAmKu+0tak1BIvuKBJDFHik/la/hJNqA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234112; c=relaxed/simple;
	bh=Sjbi8PEbxyGAWEWf49Rc8jCY43wCQ/1nCbnscjm+SYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLAbYhCmQj37CS5nMECLM1x9zCDFl/pV0csOyMayMNX504t06Z+fznSPbk//9u3p4DDpo1wFu7B30C/tMEWUTQGM8AbmetQ8jNk1FvrE9zE0BhWSdE9HN/Ve/xLuNqA5GlM8gYnJsW14zsowZwXqeeJr5YGmSR8DymRiZkE0hOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrtaK8yp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730234110; x=1761770110;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Sjbi8PEbxyGAWEWf49Rc8jCY43wCQ/1nCbnscjm+SYI=;
  b=QrtaK8ypPl/8t9w+/tqEgDBDygdzyd2vk3kxRKHvDcGj0Nufc0Q8+Zaq
   F56bB95Av9/bFNm8PVOSIPcTE6Jmja2N8/9UrmHYpUEJzRihIoGo4+88n
   wO8+UED0pp7WrhrjiJml2rbe11C37ezc6V8pIIv644BMAF7tmE1v+KqpV
   KsnpxnZcOihk2uWX0G8XwhgGTYJI4f7zaaSWPJAbcWv0zxcFzs5bbaxhw
   Q/+CwLCYi+brF4n05dr7IbTg2HJmeRAjYPomBgHQB5BouZObutvAAxsXW
   jBiiiYgp2sKADSDsbfjzGTCJAqHIR3htfRUZFEpmC7IA5qlPsjXK2Gt4G
   g==;
X-CSE-ConnectionGUID: CPj1g8qhSHq5c5uU2M7g1A==
X-CSE-MsgGUID: o+HQMyV+RnuS/WrZQ9Ir1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29865453"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29865453"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:09 -0700
X-CSE-ConnectionGUID: u+OFs3aiSN+77JgDCBiXtg==
X-CSE-MsgGUID: nYjNqNCCTn+zANVaVeOecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="81712077"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.108.77])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:07 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 29 Oct 2024 15:34:36 -0500
Subject: [PATCH v5 01/27] range: Add range_overlaps()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-dcd-type2-upstream-v5-1-8739cb67c374@intel.com>
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
In-Reply-To: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730234086; l=3607;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Sjbi8PEbxyGAWEWf49Rc8jCY43wCQ/1nCbnscjm+SYI=;
 b=W4UVYywSz5/8EH9S+fg/68G4NopwHqkmmOgzff6WEKaHLXREF24MTGRPYtJSTPEsecgAO8Rb/
 mEmZTPknZXaDoG3VpyfDv+2jylWb78OHUBL6w9KHr+Eo2x85gFxfqhL
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
Changes:
[David: constify parameters]
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


