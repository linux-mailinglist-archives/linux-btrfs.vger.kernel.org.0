Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261003E9383
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhHKOVT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35964 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhHKOVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691647; x=1660227647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=083VbVpuPIiBHeyUyg4bbSl1cDJieON3B5IrJ/WVDS4=;
  b=h8QLECeHC9KHM6mOCXw+9zt9DoTnEYO/ioGtTx6J6rwWzb1IbdGA9Sqt
   UEYx2u2krWz6RRP9y3edvnw9jl9h1mdarwLw1SVscz+S81KjiUv+KqN2w
   Hv+YNfnS4axjHtLsjOPevLzad445E4oxgZ2SrVkQcL8GJC9bqMO60GrTX
   f/KYpUDps/4Vsg2EzxOhN2YoFBFsWa/ppD+mMJIJu6hj9wjpMzsFRy9Ks
   1Hw83jBDK91T76kJ/hHx7MB37xHCLoMfVWO+DBi2qONeQHHENaF+1IsRh
   dXIKu2mgUYfJxz9evgqrBamSi0yOcrhR4+iuCkjuys1uHkAqTM7yT516E
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937869"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:47 +0800
IronPort-SDR: 34B/gGkRhwC5NcKimpjOE1XBeBuroCNax3A9N5VnLmaERXTIoVhGVkhuoBkC/FYbm8jZkg6ZVz
 +2XyGk9Lzs/Bx2/DkcIwoXIqtAa7DuxKGigy2xEliUIl2GAOa2G7g6FZDWO3hv1G6ZviKk/36e
 Qst+5QgRqJ8BuRmXzSuCDW3iUKUfe9gYK+ygja0Br1zup29OSKKSSpW0PskvV/z2xnMrrjDkOD
 cTQob3FS5ul3ZHXwWp98R+j5l4r3SR9wGbmR1VhZizxchuD4fKbSbw8vyVaoBeC6MG+CtMSnXV
 3Y2tbwdiMnrpFbL7UUDwLsxu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:17 -0700
IronPort-SDR: t1LUSO0W+GMXWyfudliju14PZE3VapRtHvOQJQYSe2yFbpVSUmggWk+3b0ylTRLE23yWuN8lQL
 ZIO3os4zR34G/Z8hnsLrh268qHhP1mTJyZQNh8yb0xMmLBKEoLEIZdhA0hlz6A9dd0uUVoZTyQ
 EeG+LkKZwoXUYis9ga3m3hHbeOQ2q3WZC1xu7ZveAFUWe/r5Mz1P6MyNN3ZsOikCzxKSGgPsoK
 G2vaH5FGW3CEw8JtkfEsDs8ogSx1AeLxCtC2bstFXEr+v2I5jHYk6VRX27eFb6hgUpCONOIHt2
 ibg=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:47 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/17] btrfs: zoned: move btrfs_free_excluded_extents out from btrfs_calc_zone_unusable
Date:   Wed, 11 Aug 2021 23:16:26 +0900
Message-Id: <09e4304e298cd1a2691eeebb59759103aa9e5409.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_free_excluded_extents() is not nccessary for
btrfs_calc_zone_unusable() and it makes btrfs_calc_zone_unusable()
difficult to reuse. Move it out and call btrfs_free_excluded_extents() in
the proper context.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 5 +++++
 fs/btrfs/zoned.c       | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9e833d74e8dc..db368518d42c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2037,6 +2037,11 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	 */
 	if (btrfs_is_zoned(info)) {
 		btrfs_calc_zone_unusable(cache);
+		/*
+		 * Should not have any excluded extents. Just in case,
+		 * though
+		 */
+		btrfs_free_excluded_extents(cache);
 	} else if (cache->length == cache->used) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 32f444c7ec76..579fb03ba937 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1273,9 +1273,6 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 	cache->cached = BTRFS_CACHE_FINISHED;
 	cache->free_space_ctl->free_space = free;
 	cache->zone_unusable = unusable;
-
-	/* Should not have any excluded extents. Just in case, though */
-	btrfs_free_excluded_extents(cache);
 }
 
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
-- 
2.32.0

