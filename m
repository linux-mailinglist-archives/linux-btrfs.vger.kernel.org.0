Return-Path: <linux-btrfs+bounces-6818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E293EFF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 10:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97691C2161D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0D13C3CF;
	Mon, 29 Jul 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BFEG3y2f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1D5E091
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241984; cv=none; b=m8L1hyBoNYZ/IZ/lYP6PIKnMChzbXtn14Nek2qqUdgdA7lHq/8QHr3yo6aAy9if0rCyK9TFPkr05Fob2qsFPpC+KiX99WbCSPuuHsMR0AkS9ulkWhhBNsPcxrsQyMTgwzVLHyu8ng9Umy9koGQ4atobEMKo6e8VgQ5GenWXu+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241984; c=relaxed/simple;
	bh=6b3OZ6j0++ShY5SDPCRgYUocP+zQc/HIwlTyBiPuvSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAGOhFgQ8COcEmBPoBCpKHxd5lVxUHym4XjejBm9w6zHIPlj+s7w3fx90HeRzNS9C6Ig4/ikNWZVfcQjcb4AArnxivVBPA6hRGWSTEM4JoGNv4jT/awBcnLuM0kiB08mBdc9WhrHaxaWpsdSJfPxO0eWddbxGHQWmfOY5afH2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BFEG3y2f; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722241982; x=1753777982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6b3OZ6j0++ShY5SDPCRgYUocP+zQc/HIwlTyBiPuvSg=;
  b=BFEG3y2fvZHal/uKZyHmzk86Lz+1MZJVWFKxlL+Qvh0n6ZT+4nT54PDI
   rO+zjchW5+fwJqXUEba4m4uIlJICEy6q3GJpulz9GJCHutkyYSnHU4Rmr
   hWxKITsrj4CZKItOP7aC/ZqvEr+H7qZrGjHK+HEWCTZr0Vzvl+h+WymX8
   2FI0EMr0VWhkrkIgw1iO1H+zR0ZYH3Kng36jH16A1obtpUR+Gyg4qShk4
   7MaTZQSlTcma8XJgvoOYD7lcwZkgbjOqQ88efN3WXdtvJL1TGNDpHCqWs
   CLT70LiYBT6xojpFXq+xNTpbWw1bypbwK6aE4+UbTyixDWKBPOi1OVLa9
   Q==;
X-CSE-ConnectionGUID: GKWW/uUhR/uiCbcGGn5VTQ==
X-CSE-MsgGUID: W5ISasHcRLm2sSo0/XcCjw==
X-IronPort-AV: E=Sophos;i="6.09,245,1716220800"; 
   d="scan'208";a="23932440"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2024 16:32:56 +0800
IronPort-SDR: 66a745c8_L8yZt+Fzfh2JK0AkG6lcCxF3ohl+RfcNWA0DtoXF9BO800L
 q6mQW739JctZh+14j4hqanFRIEveFwAHAO7Flvg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:33:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.112])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jul 2024 01:32:55 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: properly take lock to read/update BG's zoned variables
Date: Mon, 29 Jul 2024 17:32:50 +0900
Message-ID: <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__btrfs_add_free_space_zoned() references and modifies BG's alloc_offset,
ro, and zone_unusable, but without taking the lock. It is mostly safe
because they monotonically increase (at least for now) and this function is
mostly called by a transaction commit, which is serialized by itself.

Still, taking the lock is a safer and correct option and I'm going to add a
change to reset zone_unusable while a block group is still alive. So, add
locking around the operations.

Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f5996a43db24..51263d6dac36 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2697,15 +2697,16 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
 	int bg_reclaim_threshold = 0;
-	bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
+	bool initial;
 	u64 reclaimable_unusable;
 
-	WARN_ON(!initial && offset + size > block_group->zone_capacity);
+	guard(spinlock)(&block_group->lock);
 
+	initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
+	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 	if (!initial)
 		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 
-	spin_lock(&ctl->tree_lock);
 	if (!used)
 		to_free = size;
 	else if (initial)
@@ -2718,7 +2719,9 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		to_free = offset + size - block_group->alloc_offset;
 	to_unusable = size - to_free;
 
-	ctl->free_space += to_free;
+	scoped_guard(spinlock, &ctl->tree_lock) {
+		ctl->free_space += to_free;
+	}
 	/*
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
@@ -2727,15 +2730,13 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		block_group->zone_unusable += to_unusable;
 		WARN_ON(block_group->zone_unusable > block_group->length);
 	}
-	spin_unlock(&ctl->tree_lock);
 	if (!used) {
-		spin_lock(&block_group->lock);
 		block_group->alloc_offset -= size;
-		spin_unlock(&block_group->lock);
 	}
 
 	reclaimable_unusable = block_group->zone_unusable -
 			       (block_group->length - block_group->zone_capacity);
+
 	/* All the region is now unusable. Mark it as unused and reclaim */
 	if (block_group->zone_unusable == block_group->length) {
 		btrfs_mark_bg_unused(block_group);
-- 
2.45.2


