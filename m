Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30076010
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfGZHr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 03:47:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8944 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGZHr0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 03:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564127247; x=1595663247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mk5kSLQStMoPCc9aun5tnr8NyiXoRCK9IzcsRVv8jVc=;
  b=HB2wwLBZyDbszmXEGH6DkESkBCAwKBg/6xiz2jBM5JZrjiZXm9jix5Pz
   UjwkBHHWfoeX7bTafAfDTIrPzRs3m+7POYt3rZbEg/MepvwfhjKRvy10j
   /DwDGwvnPL2kluq4g05rSLKccJ55fKqbFJ9Ky/Km+iJno28jXxqqlaRcl
   1pliNCG9nG1UwyNX1NbI69gzAlXYfvlHTHGq20nAi4wm/FFxvrOnktfXy
   FXpX64DOTpqnePgIzYnL4b1bLBxvSnocQ3/5IMnh2mSjKHZTIUajAc5XE
   pE+PI1XOu619Wh+WhQQbdNIn8wZGq2PVqqglq3mLxkOp3i+GGZs2+Dww3
   A==;
IronPort-SDR: 5md4WM+QhVHkThp2Y3IgMdqLmgbM17aicxLJDg2tilw4kWOBxX7sw0rhf/v5wR3EWnLPRpM9JB
 BDwuwlP1y73EJ72DUa/yUezaKAjM9PIJiBQsHai5N5S7jfpLzBUG10NE3k03NYBNlJFSU3oE+n
 oAhMJrpl84Gs25SEozXAEPj+NjcKKPlriqIXUmthc/e0NT3E7Ao07tPtToKCxEEEqhbr9veROc
 wIb3TF7X1eVHUNtxMw9fQwyXTJ+1Qo7IyQQ9ysGNR/KvP1GuOLOnutaIOxGqhOG748Bzt0Lsik
 wkg=
X-IronPort-AV: E=Sophos;i="5.64,310,1559491200"; 
   d="scan'208";a="118887351"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 15:47:26 +0800
IronPort-SDR: L2RifZdd1CSELDxpQ/NwqVP5K3+cBkXgy6yqgjDyFUC3VlYL7S/jbXwZoT4Rr9RnfjDfwCAFMC
 V0t4zH1lcdf/6z+phES+//AjAwDjxzTSbKUWU7fjJYbJQhDFU64mESpRAgk+DUcc7XeEpaPoXQ
 UpbHeGycbyJO5alctt3NQYevLNWS+EVpaCnCpG6hN/dw9caRP8GCe5LOT6eu6l5eaL/1u0sm4W
 Z3+hb97GBZTlEs3pmxe32tDCNUqUITWBWkWUzcRauFIQx6S5D6CwUspvIZdF/XuXwIpleNCskG
 rQ4owC4y5sEYVVpOaSWy60ww
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jul 2019 00:45:35 -0700
IronPort-SDR: Tb6uNtzw+n2RcFQnRjqFt0QtKTcZBTCarHnV4lUUcGoPbeeaquZWRn4nDbmngfPgmvfrHLtWdc
 1Cdz1IamuFo/OZ7KmCphgdYfO5kIYPHlASLL+8kyXAnIGENZsK+VaTCzoMaxMhYD/p5QMlfneZ
 MrTanDLmeYGCgK329IWb4tvbsXygTg4nBY0armidGg2fMWi9UZ+9GMDRadkHLaJhpmD1RAkctH
 TRT+bHqHwN4XzhhMrSah3GjJoB4u4SEyLfs1WAjSqBI+/G7RM6isv6PhhsPm7vaJT8qkFeY9+O
 yOw=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 00:47:26 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix extent_state leak in btrfs_lock_and_flush_ordered_range
Date:   Fri, 26 Jul 2019 16:47:05 +0900
Message-Id: <20190726074705.27513-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_lock_and_flush_ordered_range() loads given "*cached_state" into
cachedp, which, in general, is NULL. Then, lock_extent_bits() updates
"cachedp", but it never goes backs to the caller. Thus the caller still
see its "cached_state" to be NULL and never free the state allocated
under btrfs_lock_and_flush_ordered_range(). As a result, we will
see massive state leak with e.g. fstests btrfs/005. Fix this bug by
properly handling the pointers.

Fixes: bd80d94efb83 ("btrfs: Always use a cached extent_state in btrfs_lock_and_flush_ordered_range")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ordered-data.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index df02ed25b7db..ab31b1a1b624 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -982,13 +982,14 @@ void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
 					struct extent_state **cached_state)
 {
 	struct btrfs_ordered_extent *ordered;
-	struct extent_state *cachedp = NULL;
+	struct extent_state *cache = NULL;
+	struct extent_state **cachedp = &cache;
 
 	if (cached_state)
-		cachedp = *cached_state;
+		cachedp = cached_state;
 
 	while (1) {
-		lock_extent_bits(tree, start, end, &cachedp);
+		lock_extent_bits(tree, start, end, cachedp);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     end - start + 1);
 		if (!ordered) {
@@ -998,10 +999,10 @@ void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
 			 * aren't exposing it outside of this function
 			 */
 			if (!cached_state)
-				refcount_dec(&cachedp->refs);
+				refcount_dec(&cache->refs);
 			break;
 		}
-		unlock_extent_cached(tree, start, end, &cachedp);
+		unlock_extent_cached(tree, start, end, cachedp);
 		btrfs_start_ordered_extent(&inode->vfs_inode, ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 	}
-- 
2.22.0

