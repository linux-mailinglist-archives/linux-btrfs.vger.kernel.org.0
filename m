Return-Path: <linux-btrfs+bounces-15089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747EAED895
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2BE3A511D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB424467D;
	Mon, 30 Jun 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G70340SG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B81FDA8C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275434; cv=none; b=FDASQpfK4ZISqKa4mhpMe5E4CFMIUoGb+9kQdytA4JNhHgydEyUKOyK4m3EnDQQXXUszhA5FWJlZ0k5RjKBwxPNSu+rSuNV9dH4mssmBAhd+dwdgR1doJvJFSXpTkI/VAVVOx2/ICH900yc1xhXKGcTYS+tuL0RqB8+UKDwXBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275434; c=relaxed/simple;
	bh=KvXu0DR2muW6kt8wKdceB7v+yaCLPWjDNgxYGScyc48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D96UzhbGUxpz+pcdCr3BU8/oayTzmTPNKMUM0hzVtEFg3OH8+AyILbVNnf+ZvfAoflz9nyJmYK2YmSsG5XQwuchjf7WNNnyUPGyXTpgf1RBj8capf7K0vsY5jO7lFSgCzBssceJ20VB4bwCm1T4kQQIotVCNRHeycY+II+r3t9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G70340SG; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751275433; x=1782811433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvXu0DR2muW6kt8wKdceB7v+yaCLPWjDNgxYGScyc48=;
  b=G70340SGfOFAI1YCYKfQ64QmOKVPPTdSm/eIL3kbVce9L3S9uEor62D1
   GQlwfwAhiVJdtT38h2Bp40k2pbsKhxm1RbjqCy8DF+FIDYPRN0kRtlTk1
   fjuKufPAN+M53Nrv6YC88LwGH3/ZYYqJzjAt1AAgwWQCFBqt3lcGCkXGc
   lZ3kfw09RBTpRZ4sEm13lcuV2zJPDLoSolkJU9zJg17a6q83D3wK5XYvt
   srZa8YJpSK+sDSQILgjvIF/aS9AD6C93bJbtoDhbon3N9mFdW0tBxMC48
   XiujDKwTr3K8G3tVNwRfCTBT8RfjRi3+KZ8WcOCfUl01cjwhEUMha/AMe
   g==;
X-CSE-ConnectionGUID: HgxYKDBjRKWWMoZ7EcVArA==
X-CSE-MsgGUID: BxcbwW2NQSGEu65Hd+Z0Jg==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="84975632"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 17:23:52 +0800
IronPort-SDR: 68624920_daSgsgG5KdQ67uVWhh46rYnCVvRVJs/O19nqFhQeij+cB7H
 EY0LcxB3YE0y/8Lgwkj3dSaei5zDSgk8VHEoUmw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 01:21:53 -0700
WDCIronportException: Internal
Received: from 5cg2174243.ad.shared (HELO naota-xeon) ([10.224.163.146])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2025 02:23:50 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs: zoned: do not remove unwritten non-data block group
Date: Mon, 30 Jun 2025 18:23:30 +0900
Message-ID: <b3d5079b7ac23898b5af224b6ce577dbd6ab2f5c.1751273376.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751273376.git.naohiro.aota@wdc.com>
References: <cover.1751273376.git.naohiro.aota@wdc.com>
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

When a metadata tree node is cleaned on the zoned setup, we keep that
node still dirty and write it out not to create a write hole. However,
this can make a block group's used bytes == 0 while there is dirty
region left.

Such unused block group is moved into the unused_bg list and processed
for the removal. When the removal succeeds, the block group is removed
from the transaction->dirty_bgs list, so the unused dirty nodes in the
block group are not sent at the transaction commit time. It will be
written at some later time e.g, sync or umount, and causes the "unable
to find chunk map" errors.

This can happen relatively easier on SMR whose zone size is 256MB. However,
calling do_zone_finish() on such block group returns -EAGAIN and keep that
block group intact, which is why the issue is hidden until now.

Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 00e567a4cd16..d9afaddeeab0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -34,6 +34,14 @@ int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group
 }
 #endif
 
+static inline bool has_unwritten_metadata(struct btrfs_block_group *block_group)
+{
+	return btrfs_is_zoned(block_group->fs_info) &&
+		(block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) &&
+		block_group->start + block_group->alloc_offset >
+			block_group->meta_write_pointer;
+}
+
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
  * is not in progress
@@ -1244,6 +1252,12 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		goto out;
 
 	spin_lock(&block_group->lock);
+	/*
+	 * Hitting this WARN means we removed a block group with an unwritten
+	 * region. It will cause "unable to find chunk map for logical" errors.
+	 */
+	WARN_ON(has_unwritten_metadata(block_group));
+
 	set_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags);
 
 	/*
@@ -1586,8 +1600,9 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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


