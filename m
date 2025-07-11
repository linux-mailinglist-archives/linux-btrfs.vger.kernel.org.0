Return-Path: <linux-btrfs+bounces-15437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D4B0141E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2537B97F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1C1E521E;
	Fri, 11 Jul 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h5/acnCO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567401E376C
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217911; cv=none; b=ZQlZb9nUiMAobWtZzI4IWFSXecJ4lj3x2FEqe4IhtZ8Uqv04cMQms+C4gVw3mttk/FFv4sOyUe+M3QUw2tJxoJ6TyOmTgKMNxhaPzSeAlEynDIqgchXdOTDwUEMvLBtfl5WfssZEDQSpaTHtNCukxbdW8UlNWGvnkqi9iM5KWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217911; c=relaxed/simple;
	bh=jaxykcY2pHgBTXymyttT0eQQOogHdB4AnOcMEPOY0U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ikm9b1U+A9M7k4xwLHNF6v1HQfp7JsPbZtmAiwZwig79zuQic+qvApEjNExh+FcWDFqFypcqSNvtCvnD5wBCW2WDS+ZGzPgEu1VUroKU0WM5fRcWmRD9enE9LzQlkKNCobnzN62mbGX3+F7Z/eDKNLE0QT9Pyr5vVsuw86cAUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h5/acnCO; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752217910; x=1783753910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jaxykcY2pHgBTXymyttT0eQQOogHdB4AnOcMEPOY0U4=;
  b=h5/acnCOvIPKd5ZCAq2zr6oMzrFNKU3y1rOeGqcl5stM45wEwcG08k2h
   xmrOruzBei+SORnGOiDrzOP83mfgRerrxutSKztzKJ80/7WZ7YooEo2L8
   9ikmSHI9CHILI9envHrPFg5F7nWQrIt8bUPPCuQNKqUe8us6WUOGNYgGc
   Mfz9xfdFQ2C9Yrb8xgckeRjZ5gc4bon5Tza8Zx1Ow8hCG0oN4VEvMTOoo
   sw3pqdhLGgJ0a+aFvmiU1iubECcqilS2EcTyu89v/xSywwyiBCytBGjwO
   vyp7rGmNg1XUqYRuHXGP3lGvEcbDMlCs13V+WGnZMLziKRIZ+gZJ7AKhg
   Q==;
X-CSE-ConnectionGUID: S3RWANTXTQWyx0GpA6Q+GQ==
X-CSE-MsgGUID: 6Fg+LB88RZiSWQvUsbQoiQ==
X-IronPort-AV: E=Sophos;i="6.16,302,1744041600"; 
   d="scan'208";a="87606671"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:11:43 +0800
IronPort-SDR: 6870aa95_jDPJVfr5Aqn/1Uejq/wt3TKs6ET/uatCzB1BpoyBLnzH3NX
 pvXPm6aphWDA44ElGG39uHjFaAnIsnXKPe9eDaQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 23:09:25 -0700
WDCIronportException: Internal
Received: from 5cg2012qjk.ad.shared (HELO naota-xeon) ([10.224.163.136])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2025 00:11:42 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] btrfs: zoned: do not remove unwritten non-data block group
Date: Fri, 11 Jul 2025 16:11:19 +0900
Message-ID: <5fd0a65f2192fc73069f00804317e68cdb6d06d9.1752217584.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752217584.git.naohiro.aota@wdc.com>
References: <cover.1752217584.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some reports of "unable to find chunk map for logical 2147483648
length 16384" error message appears in the dmesg. This means some IOs are
occurring after a block group is removed.

When a metadata tree node is cleaned on the zoned setup, we keep that node
still dirty and write it out not to create a write hole. However, this can
make a block group's used bytes == 0 while there is dirty region left.

Such unused block group is moved into the unused_bg list and processed for
the removal. When the removal succeeds, the block group is removed from the
transaction->dirty_bgs list, so the unused dirty nodes in the block group
are not sent at the transaction commit time. It will be written at some
later time e.g, sync or umount, and causes the "unable to find chunk map"
errors.

This can happen relatively easier on SMR whose zone size is 256MB. However,
calling do_zone_finish() on such block group returns -EAGAIN and keep that
block group intact, which is why the issue is hidden until now.

Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3e895427c773..d93982aac5b6 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -34,6 +34,19 @@ int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group
 }
 #endif
 
+static inline bool has_unwritten_metadata(struct btrfs_block_group *block_group)
+{
+	/* The meta_write_pointer is available only on the zoned setup. */
+	if (!btrfs_is_zoned(block_group->fs_info))
+		return false;
+
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
+		return false;
+
+	return block_group->start + block_group->alloc_offset >
+		block_group->meta_write_pointer;
+}
+
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
  * is not in progress
@@ -1244,6 +1257,15 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		goto out;
 
 	spin_lock(&block_group->lock);
+	/*
+	 * Hitting this WARN means we removed a block group with an unwritten
+	 * region. It will cause "unable to find chunk map for logical" errors.
+	 */
+	if (WARN_ON(has_unwritten_metadata(block_group)))
+		btrfs_warn(fs_info,
+			   "block group %llu is removed before metadata write out",
+			   block_group->start);
+
 	set_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags);
 
 	/*
@@ -1586,8 +1608,9 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * needing to allocate extents from the block group.
 		 */
 		used = btrfs_space_info_used(space_info, true);
-		if (space_info->total_bytes - block_group->length < used &&
-		    block_group->zone_unusable < block_group->length) {
+		if ((space_info->total_bytes - block_group->length < used &&
+		     block_group->zone_unusable < block_group->length) ||
+		    has_unwritten_metadata(block_group)) {
 			/*
 			 * Add a reference for the list, compensate for the ref
 			 * drop under the "next" label for the
-- 
2.50.0


