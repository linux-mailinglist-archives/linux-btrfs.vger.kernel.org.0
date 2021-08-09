Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768F33E4506
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhHILlr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 07:41:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51722 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhHILlq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 07:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628509286; x=1660045286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YddtKie6XBP0nacTnXCib0TD7qFRU8Uaz5JBb9mlwB8=;
  b=MRk5vc7uvUoXb1Mvd6kJp/no1Ald9CrNTphFjGdCJYDP9hsEJ2teW0hZ
   6aAeYC0FVi3t/4tJ3CnrGncADUGGXZi8+E2osRlaUBGP1pCmDCIWw6uQ2
   5kt3MUz0PjR2uH5xrEol66c19sa/C1/dDFBWFayE588ZvHD6Yd1ail55L
   Jo2mxCzR93lLZexzzVcHgKh00vbzxOaVl9hHj9QWAt18TvwUxs7nksjqM
   lwruDkbmyvpyATEYds4L6ZUlz2IuvRVJgIjSZfT1OcW+RuS48M3AvPcJz
   QH2IYV/Md9TpQdgEksPSdgz9TqQBKLI/pw/R6y8ayuknChw+pc9yt0Ueu
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="175886448"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 19:41:26 +0800
IronPort-SDR: 2L54iQ/4eFCEC/W2+xiZUVNpMuZ/PrPFRcatCGA2GmM9dmwsJcdgUnujumfLzSFUkoL26S5hUf
 VeHgU9s+XWa/t/P7ouuqZTXTCcLLM3mfx+h4enrXCR2datH6VOb8SnoAPVlzZldLwxYAWFc7Wl
 325QgR3WbSx0wgFCQ8deZWmh3MWbRxq5Z+Tvt+eiKPnXVjxOjK16oGBLmcoJu1/VNvfefD4rr/
 fhWhEh984Wj+KuaDcu6k0q/6UzDLsJC/+zHk/b/R7K6om0aXkDRUMAz9GKkVC4bmYlPNZd3z4B
 q0uMjgKYPSXF+fr1wdk9TZsZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 04:18:49 -0700
IronPort-SDR: iKSL4zOjBvpQDXA6JNuX5of/TDuhvZXmHxXYFufFt3WuDaxl91NsueVKIZdyenGKQAqmkHBd8G
 IqLhEgh/wPthu7CQKjcZ8pBtx0kI2gg7CEsESZC5D7iRsTynYFtAdfMiwSQzmIeX7AoUgdh2vm
 lUFRYN3srOYwpFRZK9fpZIFqraLRuR5fXnGX3lKbq4uLJfafnriFIgC6cxriQT6/p0UZnWlduk
 OmmACiQY62Coms5hUd7qfae67hWuKB/YC0tbc+l4XS2Lyhq87V9UnmA+1gxBIaugSgOfhsOfe0
 5DA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 04:41:25 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: allow disabling of zone auto relcaim
Date:   Mon,  9 Aug 2021 20:41:17 +0900
Message-Id: <56979ba90a8e850da85d2a246d6c10d8c45e8fa5.1628509211.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Automatically reclaiming dirty zones might not always be desired for all
workloads, especially as there are currently still some rough edges with
the relocation code on zoned filesystems.

Allow disabling zone auto reclaim on a per filesystem basis.

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
 - Use READ_ONCE/WRITE_ONCE
---
 fs/btrfs/free-space-cache.c |  7 ++++---
 fs/btrfs/sysfs.c            | 10 +++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8eeb65278ac0..05336630cb9f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2538,6 +2538,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
+	int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
 
 	spin_lock(&ctl->tree_lock);
 	if (!used)
@@ -2567,9 +2568,9 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	/* All the region is now unusable. Mark it as unused and reclaim */
 	if (block_group->zone_unusable == block_group->length) {
 		btrfs_mark_bg_unused(block_group);
-	} else if (block_group->zone_unusable >=
-		   div_factor_fine(block_group->length,
-				   fs_info->bg_reclaim_threshold)) {
+	} else if (bg_reclaim_threshold &&
+		   block_group->zone_unusable >=
+		   div_factor_fine(block_group->length, bg_reclaim_threshold)) {
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bfe5e27617b0..7ba09991aa23 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -984,7 +984,8 @@ static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	ssize_t ret;
 
-	ret = scnprintf(buf, PAGE_SIZE, "%d\n", fs_info->bg_reclaim_threshold);
+	ret = scnprintf(buf, PAGE_SIZE, "%d\n",
+			READ_ONCE(fs_info->bg_reclaim_threshold));
 
 	return ret;
 }
@@ -1001,10 +1002,13 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	if (thresh <= 50 || thresh > 100)
+	if (thresh != 0 && (thresh <= 50 || thresh > 100))
 		return -EINVAL;
 
-	fs_info->bg_reclaim_threshold = thresh;
+	WRITE_ONCE(fs_info->bg_reclaim_threshold, thresh);
+
+	if (thresh == 0)
+		btrfs_info(fs_info, "disabling auto reclaim");
 
 	return len;
 }
-- 
2.32.0

