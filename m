Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA946499A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiLLHiA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiLLHh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46B634F
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6Hw97FMPWKL8rzjA62fiZ1qEb2PWDJS525Y51FrAy4I=; b=4tbHZl4/a4en4HudXxDDM8RW6w
        9YcDmOgKXn88f7oqU8XDkDdjf5uRO2doyhSonx31a46o6EbIyO51+ujVIBmWpk+CUomz+Dtv2MzYS
        NM/4a8ro0o4qg9JkdgTGmDFeJbA8BrIVl8HSAg4PUra7zjFH/qkK5j3I+JhTCPKp2vfeALVbmJVzE
        ThmgK5iGg73SX1W4mHgNlXmzW1p2GmjqZCZR7WKSZCXpdzA8fc1z3UeRS0AufK1GneLwZekXJum/t
        M+5IQqNKAnP7DXPO2MqWaXcIO3RchQ59MxEbX/axAPNulwHtOGXN5VuKCWdjpiOC6axm0rBJoTWYl
        11fRGfag==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNp-009WZZ-1R; Mon, 12 Dec 2022 07:37:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: remove the bdev argument to btrfs_rmap_block
Date:   Mon, 12 Dec 2022 08:37:24 +0100
Message-Id: <20221212073724.12637-8-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212073724.12637-1-hch@lst.de>
References: <20221212073724.12637-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only user in the zoned remap code is gone now, so remove the argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/block-group.c            | 9 ++-------
 fs/btrfs/block-group.h            | 3 +--
 fs/btrfs/tests/extent-map-tests.c | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 708d843daa72de..72688a4f38af99 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1816,7 +1816,6 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  *
  * @fs_info:       the filesystem
  * @chunk_start:   logical address of block group
- * @bdev:	   physical device to resolve, can be NULL to indicate any device
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
  * @naddrs:	   length of @logical
@@ -1827,8 +1826,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  * block copies.
  */
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     struct block_device *bdev, u64 physical, u64 **logical,
-		     int *naddrs, int *stripe_len)
+		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -1868,9 +1866,6 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 			      data_stripe_length))
 			continue;
 
-		if (bdev && map->stripes[i].dev->bdev != bdev)
-			continue;
-
 		stripe_nr = physical - map->stripes[i].physical;
 		stripe_nr = div64_u64_rem(stripe_nr, map->stripe_len, &offset);
 
@@ -1927,7 +1922,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info, cache->start, NULL,
+		ret = btrfs_rmap_block(fs_info, cache->start,
 				       bytenr, &logical, &nr, &stripe_len);
 		if (ret)
 			return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a02ea76fd6cffe..0462f9b5cedf95 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -315,8 +315,7 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		       struct block_device *bdev, u64 physical, u64 **logical,
-		       int *naddrs, int *stripe_len);
+		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index c5b3a631bf4fb4..f2f2e11dac4c02 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -509,7 +509,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 		goto out_free;
 	}
 
-	ret = btrfs_rmap_block(fs_info, em->start, NULL, btrfs_sb_offset(1),
+	ret = btrfs_rmap_block(fs_info, em->start, btrfs_sb_offset(1),
 			       &logical, &out_ndaddrs, &out_stripe_len);
 	if (ret || (out_ndaddrs == 0 && test->expected_mapped_addr)) {
 		test_err("didn't rmap anything but expected %d",
-- 
2.35.1

