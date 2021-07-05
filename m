Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E23BC1B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGEQfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 12:35:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43971 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGEQfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 12:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625502768; x=1657038768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YxOfd4bU7IgVkoaDVpvC5rgfS2uTwQKrEA0Gg8WrbFY=;
  b=nE/InPcR/fvJQjydgGkuEytPRY3T7I+PzzXp+CFi4suVcOph+deCOa1w
   w5SDy6l2hHtanRcnXPhw6iqB3cuOERpaP7csi/d23pmkyZddzcOaTRZ9R
   R9tinRz+9GJYB4hR4IQSWO7gufIzYlOK0Edek79/Ah5pdejrY1QGZw72G
   6Vq/fCfOkvdLrA+1ANeKEli19+OfWTHopxDHPfxNyOvkEYk0nmGgaqHv5
   Ae0fZfpi5bplEZjID7jjuPw/J6Iv2WOZd1HDrz492dDLiDIroQysabKar
   ejRd8utRtHdXuDZ6/JCnynANo8PFMUFdP7yHekPz/Za7iSs+5rvWm/0ww
   w==;
IronPort-SDR: ANgzsEU3CDKfu1nJwM76Gok5FVaDRiWpKkNOfhS78NCDPI9HaWo63NNdrPIgLvYuOQhQCOiGb3
 Lr08aFT1JmJsKX4G/9WkZNz4vvgkcZSf09Qb1ENf9mML3qH62yJhVIxsg0AaUbIBmSGxZBkwWT
 zG43CGDvV7EY8XqdoYQiq2Mz5ITcQd5GaxFL0cXVFTLqNUVaw1CrLQmZdNty8Lw81G1ecMtZUw
 dmURIrYxj83zx72qXYMdEqrgzz4tUDV36IuwMxxPnq7mUBmeN/+SaAZQ1Z+TcvKvkKz+4D+i/i
 iYw=
X-IronPort-AV: E=Sophos;i="5.83,325,1616428800"; 
   d="scan'208";a="285260926"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2021 00:32:48 +0800
IronPort-SDR: r5cQXSvBVchB9eyVqVs14bS0noKbdrFNlxc4BH3CzqRoLi8rWHM3cWZASG9sWkIVkV7myoM6M8
 pnQuZqnHKaW5r1lA4P7u25QDb87C0mtVk7Cui7nBd/QIi9c4x2ij7Qu09/NJZKCYo0saIwvggx
 iXaBNMSvazCcmc2nMcyopLpAtL3XquST/1FyF4mBOASAR7rMHvUhb76sMP7W/1sFNhxpH1LGGV
 k/QZDDptnG2p4O+A1TnadG0DG8O6Ft+iQKWnGIMqxUFMtj2YdPo/ZAi4CRPZg8z3/AQarOIbjE
 U1PBHfUuCI3Bj+v0aZk8541Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 09:09:50 -0700
IronPort-SDR: dYdeQf6UOcS5dBeb2nPlDbEa9rZY7KvNlp838CH4qvaUrjB1BgDtxOj89bDlq6Iepz7kCksKpx
 FvWhw2TaJQsRxtK1V4+Utp3KB2XG/hfA6YBoj818YufJ4ogize9LJtu+4wW16LbS4g+Ygab1G0
 34IX4feP8aTBVdUJWjBwCzf6KJsAbUEET5Pzuvmn9ZLa6AnljQy2M2WepTJ+uv4cVHg6QvZnfm
 kdz6rqkIyJ+N8S4538bge6ASoZijDkSNKGVle9x+0FCPcw4i3oQscSewJNEPaNZkopkTQ4KK7K
 5X8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Jul 2021 09:32:47 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't block if we can't acquire the reclaim lock
Date:   Tue,  6 Jul 2021 01:32:38 +0900
Message-Id: <8fc77aa7ffbc61e7e55d57e8cfc7423642558b17.1625500974.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we can acquire the reclaim_bgs_lock in on block group reclaim, we block
until it is free. This can potentially stall for a long time.

While reclaim of block groups is necessary for a good user experience on a
zoned file system, there still is no need to block as it is best effort
only, just like when we're deleting unused block groups.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c557327b4545..9e7d9d0c763d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1498,7 +1498,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
 		return;
 
-	mutex_lock(&fs_info->reclaim_bgs_lock);
+	/*
+	 * Long running balances can keep us blocked here for eternity, so
+	 * simply skip reclaim if we're unable to get the mutex.
+	 */
+	if (!mutex_trylock(&fs_info->reclaim_bgs_lock)) {
+		btrfs_exclop_finish(fs_info);
+		return;
+	}
+
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 zone_unusable;
-- 
2.31.1

