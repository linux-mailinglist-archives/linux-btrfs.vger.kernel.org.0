Return-Path: <linux-btrfs+bounces-20683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4262FD39F8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 08:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4468301F026
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A62DC346;
	Mon, 19 Jan 2026 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T1u4N0cF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4A283C89
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807082; cv=none; b=DSS0VM6UAfW5p2o9urBG6dBdVz+mcXDXpXWQ9sIVcWjLCqdgxwldNlDNlXJW1RJAAaOws/GytdDXoQmetn6xs3CgJ1ho31mzRDl2AFzzoJGens4V7Dnjk7otHmYVJDmYu51nFerzNV34egKd1ZQaU2VSocQMqCcmhQAEJoCSTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807082; c=relaxed/simple;
	bh=sB/s/S3oaEyHZBaMAG5gA10cNuK5a5FGg/WuIPUwExo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZ5g6cqfrzrT0MumN+bYMPv7IeqsmzdA+0PFzeTo/9BgH5qoX24xF22WkYnEjO9k7WrtzDRavcKhm1QvaQm8mGv5LGlvYqpza9+sYZmv2pF5tWvrcAnIrT06cyXKYaczkj1sNqWJQbh1dFd/wO4bXXG7lVN5aDZ8oj4k+sTUth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T1u4N0cF; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768807080; x=1800343080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sB/s/S3oaEyHZBaMAG5gA10cNuK5a5FGg/WuIPUwExo=;
  b=T1u4N0cFvn1mNGzHcqe21f4Oyr1ONByfh1DqxQI/V6SLqD8BhtmvVIsd
   dpLRBPtAnawWfPcroLHIUw4+1S9FUR1/HBXmxs4o7B+sR2zjHUee6UtW7
   osYFJOnUDAp6B3BH2B8xqYJwejraTg2pXCX4K0dpGZV8/8LhJxs3CPl/N
   rtgOBiGDn4gr21/dwiyIdg1TKYrpLFgw8efc9oRXQVtHGf4p2/AaEzU2n
   JK/UO3dHaI7vOCWm8YX0W3i1K/HfG+XcK8BvM1ot/mzcFmXYi6L7EO7Qx
   1w5Q9rb76OS2eOPK4ys14hA8vZWmpAcAYUmIdHPv0Csdgz8GdibLiH3gO
   A==;
X-CSE-ConnectionGUID: 2MZP4RTnTdCOUDBuAv5FKA==
X-CSE-MsgGUID: 2dPJRFbkTkS/X+WKJgbiJw==
X-IronPort-AV: E=Sophos;i="6.21,237,1763395200"; 
   d="scan'208";a="139736384"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2026 15:17:54 +0800
IronPort-SDR: 696ddaa2_8W9eN6kcbe7Ke1ZEXSINGynp9HNURvI6iHmT5haEpelLmBL
 FlFAk1k3mrV98Zn0KTMPLim5pAtDBb9rxxyxSKg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2026 23:17:55 -0800
WDCIronportException: Internal
Received: from 5cg1443ryj.ad.shared (HELO neo.wdc.com) ([10.224.28.37])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Jan 2026 23:17:53 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] btrfs: remove bogus NULL checks in __btrfs_write_out_cache
Date: Mon, 19 Jan 2026 08:17:50 +0100
Message-ID: <20260119071750.43226-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan reported a new smatch warning in free-space-cache.c:

New smatch warnings:
fs/btrfs/free-space-cache.c:1207 write_pinned_extent_entries() warn: variable dereferenced before check 'block_group' (see line 1203)

But the check if the block_group pointer is NULL is bogus, because to
get to this point block_group::io_ctl has already been dereferenced
further up the call-chain when calling __btrfs_write_out_cache() from
btrfs_write_out_cache().

Remove the bogus checks for block_group == NULL in
__btrfs_write_out_cache() and it's siblings.

Cc: Filipe Manana <fdmanana@suse.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202601170636.WsePMV5H-lkp@intel.com/
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Note: a full fstests run is still running at the time of submission. 

 fs/btrfs/free-space-cache.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f0f72850fab2..20aa9ebe8a6c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1079,7 +1079,7 @@ int write_cache_extent_entries(struct btrfs_io_ctl *io_ctl,
 	struct btrfs_trim_range *trim_entry;
 
 	/* Get the cluster for this block_group if it exists */
-	if (block_group && !list_empty(&block_group->cluster_list)) {
+	if (!list_empty(&block_group->cluster_list)) {
 		cluster = list_first_entry(&block_group->cluster_list,
 					   struct btrfs_free_cluster, block_group_list);
 	}
@@ -1203,9 +1203,6 @@ static noinline_for_stack int write_pinned_extent_entries(
 	struct extent_io_tree *unpin = NULL;
 	int ret;
 
-	if (!block_group)
-		return 0;
-
 	/*
 	 * We want to add any pinned extents to our free space cache
 	 * so we don't leak the space
@@ -1393,7 +1390,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	if (ret)
 		return ret;
 
-	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA)) {
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA) {
 		down_write(&block_group->data_rwsem);
 		spin_lock(&block_group->lock);
 		if (block_group->delalloc_bytes) {
@@ -1465,7 +1462,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 			goto out_nospc;
 	}
 
-	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
 		up_write(&block_group->data_rwsem);
 	/*
 	 * Release the pages and unlock the extent, we will flush
@@ -1500,7 +1497,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	cleanup_write_cache_enospc(inode, io_ctl, &cached_state);
 
 out_unlock:
-	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
 		up_write(&block_group->data_rwsem);
 
 out:
-- 
2.52.0


