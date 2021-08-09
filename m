Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A8B3E3D54
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 02:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhHIAaC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Aug 2021 20:30:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31977 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhHIAaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Aug 2021 20:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628468981; x=1660004981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9MfgdTU+OuJF9DJCe0UQvJ3Kcx9XBdCcw+YjW85Lp5o=;
  b=Rb5NzTbFjBUOYY7KsY1qfuTsvsy4nXt7sc7gNprrE55gJydxZjfw7bjI
   f3ggrSbBzxdWdlgTNVm7ABMlWMr3aKCtBvYC0BqMkF3+eX0U9ooriQKBW
   ibxj/YZwlusxE4um44unT5x0G2rqZ3JQnWY61XDYREDAEehZAOug42sBk
   Kk0xMwI3wqX5i9l60W/wailC02VCZy8rsTIzJcmyAxAue1me1N0rMXP6L
   1f9D8uhdkHrGKxjBAxy0VK/IDDJNrY9ObQU7LnoN8iG6fE8uyGQVHcn/k
   2TofX6e8G7yzY6hW17qdHHY1Wo+JnUb7mhVhrLqpgh32PvZIkcZPtyEee
   A==;
X-IronPort-AV: E=Sophos;i="5.84,305,1620662400"; 
   d="scan'208";a="176633342"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 08:29:41 +0800
IronPort-SDR: XWkD3FAjOHLiVM9WWnulRnWrCorEFhUi9cx16x+fnua8ftIovJ9fS2bDwiJMySz75zQc1qE+ir
 xLNKg3tfR7ph+90mWj8sVDnR5gwVRN23fXvmLMCuWgP5hoattgtZ5jkXfJauMGyMrCk6e1GsKT
 R1F6OI0VU7c4suHz1CmhB3R9lFs/qhykfjlfsKlo1lBV99paHnZd8dUmpssT/5XdL3fTUlaGgG
 X0ZcCIZIK39xj7oYUFT5Wpmpw2MktijSBZlj/d/PA1jMtTruhSgrJ8ShwlJys3lMr9hvPSGUyx
 P1wk9aW3P8PdHnPY5gzf/B3h
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2021 17:05:15 -0700
IronPort-SDR: b/34ndMxNroQHe2mAqPhMx12Hd+U6tH8buC8jVxrO8xu1viLhTAzFpv/gU/ALQiHdriZHrGyDh
 aFRWKFKJoQflA5nu9xd702Lg7XTBHzOji/K8A5gAJYadFpHzzvnwURfLUjxHwSsQt0tdwvXCgz
 SSXwWi9o1IO6j1mQfS8EP+O5/uG6bYU6w4ZjiR8R/Ie9ijtA5b0UXLgG+0ozSBhruKEP/kgNpy
 mFB9ENd1Up+Br++Wyx64khfyHNqwHYbnRQcDiqtoh6AQJnyjkb8Lnr6ZmE1k8cM6BMEQSzy4Po
 dnU=
WDCIronportException: Internal
Received: from gczpn73.ad.shared (HELO naota-xeon.wdc.com) ([10.225.57.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2021 17:29:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: zoned: add ASSERTs on splitting extent_map
Date:   Mon,  9 Aug 2021 09:29:18 +0900
Message-Id: <20210809002918.2686884-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call split_zoned_em() on an extent_map on submitting a bio for it. Thus,
we can assume the extent_map is PINNED, not LOGGING, and in the modified
list. Add ASSERT()s to ensure the  extent_maps after the split also has the
proper flags set and are in the modified list.

Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Suggested-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0c40dfaf6c0d..7d3882e9ef10 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2303,7 +2303,6 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	struct extent_map *split_mid = NULL;
 	struct extent_map *split_post = NULL;
 	int ret = 0;
-	int modified;
 	unsigned long flags;
 
 	/* Sanity check */
@@ -2333,11 +2332,12 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	ASSERT(em->len == len);
 	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
 	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
+	ASSERT(test_bit(EXTENT_FLAG_PINNED, &em->flags));
+	ASSERT(!test_bit(EXTENT_FLAG_LOGGING, &em->flags));
+	ASSERT(!list_empty(&em->list));
 
 	flags = em->flags;
 	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
-	clear_bit(EXTENT_FLAG_LOGGING, &flags);
-	modified = !list_empty(&em->list);
 
 	/* First, replace the em with a new extent_map starting from * em->start */
 	split_pre->start = em->start;
@@ -2351,7 +2351,7 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	split_pre->compress_type = em->compress_type;
 	split_pre->generation = em->generation;
 
-	replace_extent_mapping(em_tree, em, split_pre, modified);
+	replace_extent_mapping(em_tree, em, split_pre, 1);
 
 	/*
 	 * Now we only have an extent_map at:
@@ -2371,7 +2371,7 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 		split_mid->flags = flags;
 		split_mid->compress_type = em->compress_type;
 		split_mid->generation = em->generation;
-		add_extent_mapping(em_tree, split_mid, modified);
+		add_extent_mapping(em_tree, split_mid, 1);
 	}
 
 	if (post) {
@@ -2385,7 +2385,7 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 		split_post->flags = flags;
 		split_post->compress_type = em->compress_type;
 		split_post->generation = em->generation;
-		add_extent_mapping(em_tree, split_post, modified);
+		add_extent_mapping(em_tree, split_post, 1);
 	}
 
 	/* Once for us */
-- 
2.32.0

