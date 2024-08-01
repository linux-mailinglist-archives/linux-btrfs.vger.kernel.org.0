Return-Path: <linux-btrfs+bounces-6947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558169445CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC6D1F24414
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AB0156F54;
	Thu,  1 Aug 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YodZEASz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196711EB4A2
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498484; cv=none; b=tcWzmT95GdSLRsj7FxJwK1MK6iyLymQ578WMsVhluqKddwTKQvxSpYBSvvo/B1G2t6DmMBNUIrMwwlCmUlm8fpxmMf3WbB5obXtdbMsYRsl4tJ6kcNJpo0PFsu4e2oRE+yOb1F81NUpPLPm43+73GMouE4rpkbRUXzOH6wE9bd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498484; c=relaxed/simple;
	bh=S17FxprZzhF8N0kTbH9KjGn+kmdwtKgM122AJzBVjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoYBwInYhR6QKExeXEODSJ1Upo5/Okpi1PTmK0OzXV1/+tS4Fu8p6EkqNR7FCw6OhoII+wsKChM9AW+Q8jyGM2hOJknHtPgNEd+0ELnUXZPpQi8GvS2jIAoDEVxpL73owLUE8zcvXyw+HAjJufUME34tOg2A9kL2vywxhwTkcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YodZEASz; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722498482; x=1754034482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S17FxprZzhF8N0kTbH9KjGn+kmdwtKgM122AJzBVjEw=;
  b=YodZEASziLK2mh5S2+YB2tS91eYAMWLOzUHdmSlIeqqIR66TZpGmBifx
   f0NvYQE09RUgp2fqf3U8ePUgwbgllJITPCjBtSjl3l0dZJKAE28nXJlmI
   s1M75FJ4fuHG0Aixt7s4Hk+FgoyD4JV+nGgjmjLsXRb1K3VSmA6DXcSU6
   Y/p+lYbtx1X35UUFrsoHvpV9Y18nvzuxh3fMIKCen0Jrn5TAp4xcXDfbx
   58vqZ9U61DNuAN7vxsDxvKn+pvNfsOVwaExwyWZpFza1vhswOqse6DyfJ
   0Y9mWSfffhckQKLK4aWbaJncfaeFibltMr6wR5jcVClo/jpmHElfF3dMF
   Q==;
X-CSE-ConnectionGUID: vcEoBF/RR+6pzP7Rd/39DQ==
X-CSE-MsgGUID: J6GpT043TNSfunslD/26KQ==
X-IronPort-AV: E=Sophos;i="6.09,253,1716220800"; 
   d="scan'208";a="24229860"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2024 15:48:00 +0800
IronPort-SDR: 66ab2fbd_iauQvzhFkoCgFF819oYsUVgqVvRdwYZqe7IEhxGPdJegyaR
 gkxdHCv/pCdsyIsjj2Tx02nsnQNHi/ARsUtuiCw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2024 23:48:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2024 00:48:00 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: properly take lock to read/update BG's zoned variables
Date: Thu,  1 Aug 2024 16:47:52 +0900
Message-ID: <a3bc8f26a7c7ffff883c319464cf9b07edb10548.1722480197.git.naohiro.aota@wdc.com>
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
v2:
  - Use plain spin_lock()s instead of guard()s
  - Drop unnecessary empty line
---
 fs/btrfs/free-space-cache.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f5996a43db24..eaa1dbd31352 100644
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
+	spin_lock(&block_group->lock);
 
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
 
+	spin_lock(&ctl->tree_lock);
 	ctl->free_space += to_free;
+	spin_unlock(&ctl->tree_lock);
 	/*
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
@@ -2727,11 +2730,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
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
@@ -2745,6 +2745,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
+	spin_unlock(&block_group->lock);
+
 	return 0;
 }
 
-- 
2.45.2


