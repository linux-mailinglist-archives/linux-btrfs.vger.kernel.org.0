Return-Path: <linux-btrfs+bounces-7066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5514C94CBCB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D701F24136
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63018C90C;
	Fri,  9 Aug 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kaOCNLP/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35C166F21
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190368; cv=none; b=aHvLrVmcg4gT3gJbazbjSVuctcogvD1dBxCZRcDS8gnGUn5BbJ1liQXkHe1UJQ5Tp0XpEv21ngvK/Td2aZZnEJCc74rilPUxbuZHQB0FEEfzzQehOKUaQXCu1yFiCzJiUSWgzEbKFBRhofVqKMy/XvESF/ROYG4MLPeCbFxQmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190368; c=relaxed/simple;
	bh=pupQQAw+x/583hdebCk5JsfeZCSxW5XmKPZu+296uY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbnezRZWdHwCUFuhhF8Fz5smT72G8NdGdWAbUUiChNm1Fwch1GmRRw2AcWQf5AV3q/mY2Lv60ttsDlUu/6oB6VbfUxMtgOQMVD+Vs7tf6v1WxEHJpdCO2JT/s5/m0wko764ZiXoThZX1zmzNMVjUu0gsFBlXTvQma5IL5qSfrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kaOCNLP/; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723190366; x=1754726366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pupQQAw+x/583hdebCk5JsfeZCSxW5XmKPZu+296uY0=;
  b=kaOCNLP/8lURFPrwcRdrZM4y0vB160SdvZDdEwy+SyCj/xg5mg6eBGTI
   8dskfV+0TfWOYZsJKev5sm+WI+KF7VKbOA5W6+/gzm3mjF74/LlozxybU
   FO9Fb1dezERwTYOwkgV1SUZtQs60mpLta0cNDths/Tg8+FFk76MiVdbOG
   laS63w/uPu3Zg72eUlb3//O+X9leQ+eemQs4nZwc5rKKeEHXOin1mFU83
   oC8wpWZ4JgEuwOiytcVFvZwc9Ck96ILJKW86eUu9lWvvGe0GzJaOl87MA
   WcTsQim9wW1ztmzEivyHXJIwm8k8ZKmNiJG3dtTMyojph7EHmWhtmp+Cn
   w==;
X-CSE-ConnectionGUID: MKO/e+mRSdS7iW7r+LYMqA==
X-CSE-MsgGUID: qV4FpockSHi/l6EDI2E79w==
X-IronPort-AV: E=Sophos;i="6.09,275,1716220800"; 
   d="scan'208";a="24884831"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2024 15:59:25 +0800
IronPort-SDR: 66b5be61_JvDOdGWbXZI/aGGteprJjKVVF3gkCtN08uLGtR5WDSymady
 nxK9R5PX2qpsPOwQrjkXPmyScDeVI6bvZeOAdXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 23:59:45 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.116])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2024 00:59:26 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3] btrfs: zoned: properly take lock to read/update BG's zoned variables
Date: Fri,  9 Aug 2024 16:59:22 +0900
Message-ID: <a7453cfe31daeb0e7ba0950b611ded4640ecbca1.1723190260.git.naohiro.aota@wdc.com>
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
v3:
  - Rewrite the initial freeing detection with "if"
v2:
  - Use plain spin_lock()s instead of guard()s
  - Drop unnecessary empty line
---
 fs/btrfs/free-space-cache.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f5996a43db24..6b302707fee5 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2697,15 +2697,17 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
 	int bg_reclaim_threshold = 0;
-	bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
+	bool initial = false;
 	u64 reclaimable_unusable;
 
-	WARN_ON(!initial && offset + size > block_group->zone_capacity);
+	spin_lock(&block_group->lock);
 
+	if (size == block_group->length && block_group->alloc_offset == 0)
+		initial = true;
+	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 	if (!initial)
 		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 
-	spin_lock(&ctl->tree_lock);
 	if (!used)
 		to_free = size;
 	else if (initial)
@@ -2718,7 +2720,9 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		to_free = offset + size - block_group->alloc_offset;
 	to_unusable = size - to_free;
 
+	spin_lock(&ctl->tree_lock);
 	ctl->free_space += to_free;
+	spin_unlock(&ctl->tree_lock);
 	/*
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
@@ -2727,11 +2731,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
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
@@ -2745,6 +2746,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
+	spin_unlock(&block_group->lock);
+
 	return 0;
 }
 
-- 
2.45.2


