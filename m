Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F547B0F1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 00:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjI0WvJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0WvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 18:51:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64485FB
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 15:51:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 199311F385;
        Wed, 27 Sep 2023 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695855064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y64KSbvlHW4e8O3w0859LF+m3l3yA7Ff72VfHHp3Jos=;
        b=cwAqJHboW6rE2YkO2gjrET2s5dK/x1Sku2+Y6tljtoyTtne1E0vQ9kh3Wq1wdpUAE0YSyX
        ngd+oyhJMZFGa3QB2LqtoCV8NZnhyv4qK28vskcfCz+Qjjip29a5vJPo7HU0SCc3s5PLvJ
        75YF0zvj44q9iYqO9q2M0sNryA+Jy+k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1325313479;
        Wed, 27 Sep 2023 22:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6ahNMdaxFGUUPwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 27 Sep 2023 22:51:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Konstantinos Skarlatos <k.skarlatos@gmail.com>
Subject: [PATCH] btrfs-progs: fix failed resume due to bad search
Date:   Thu, 28 Sep 2023 08:20:45 +0930
Message-ID: <840a9a762a3a0b8365d79dd7c23d812d95761dcf.1695855009.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that when converting to bg tree crashed, the
resulted fs is unable to be resumed.

This problems comes with the following error messages:

  ./btrfstune --convert-to-block-group-tree /dev/sda
  ERROR: Corrupted fs, no valid METADATA block group found
  ERROR: failed to delete block group item from the old root: -117
  ERROR: failed to convert the filesystem to block group tree feature
  ERROR: btrfstune failed
  extent buffer leak: start 17825576632320 len 16384

[CAUSE]
When resuming a interrupted conversion, we go through
read_converting_block_groups() to handle block group items in both
extent and block group trees.

However for the block group items in the extent tree, there are several
problems involved:

- Uninitialized @key inside read_old_block_groups_from_root()
  Here we only set @key.type, not setting @key.objectid for the initial
  search.

  Thus if we're unlukcy, we can got (u64)-1 as key.objectid, and exit
  the search immediately.

- Wrong search direction
  The conversion is converting block groups in descending order, but the
  block groups read is in ascending order.
  Meaning if we start from the last converted block group, we would at
  most read one block group.

[FIX]
To fix the problems, this patch would just remove
read_old_block_groups_from_root() function completely.

As for the conversion, we ensured the block group item is either in the
old extent or the new block group tree.
Thus there is no special handling needed reading block groups.

We only need to read all block groups from both trees, using the same
read_old_block_groups_from_root() function.

Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
To Konstantinos:

The bug I fixed here can explain all the failures you hit (the initial
one and the one after the quick diff).

Please verify if this helps and report back (without the quick diff in
the original thread).

We may have other corner cases to go, but I believe the patch itself is
necessary no matter what, as the deleted code is really
over-engineered and buggy.
---
 kernel-shared/extent-tree.c | 79 +------------------------------------
 1 file changed, 1 insertion(+), 78 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 7022643a9843..4d6bf2b228e9 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2852,83 +2852,6 @@ out:
 	return ret;
 }
 
-/*
- * Helper to read old block groups items from specified root.
- *
- * The difference between this and read_block_groups_from_root() is,
- * we will exit if we have already read the last bg in the old root.
- *
- * This is to avoid wasting time finding bg items which should be in the
- * new root.
- */
-static int read_old_block_groups_from_root(struct btrfs_fs_info *fs_info,
-					   struct btrfs_root *root)
-{
-	struct btrfs_path path = {0};
-	struct btrfs_key key;
-	struct cache_extent *ce;
-	/* The last block group bytenr in the old root. */
-	u64 last_bg_in_old_root;
-	int ret;
-
-	if (fs_info->last_converted_bg_bytenr != (u64)-1) {
-		/*
-		 * We know the last converted bg in the other tree, load the chunk
-		 * before that last converted as our last bg in the tree.
-		 */
-		ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
-			         fs_info->last_converted_bg_bytenr);
-		if (!ce || ce->start != fs_info->last_converted_bg_bytenr) {
-			error("no chunk found for bytenr %llu",
-			      fs_info->last_converted_bg_bytenr);
-			return -ENOENT;
-		}
-		ce = prev_cache_extent(ce);
-		/*
-		 * We should have previous unconverted chunk, or we have
-		 * already finished the convert.
-		 */
-		ASSERT(ce);
-
-		last_bg_in_old_root = ce->start;
-	} else {
-		last_bg_in_old_root = (u64)-1;
-	}
-
-	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-
-	while (true) {
-		ret = find_first_block_group(root, &path, &key);
-		if (ret > 0) {
-			ret = 0;
-			goto out;
-		}
-		if (ret != 0) {
-			goto out;
-		}
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-
-		ret = read_one_block_group(fs_info, &path);
-		if (ret < 0 && ret != -ENOENT)
-			goto out;
-
-		/* We have reached last bg in the old root, no need to continue */
-		if (key.objectid >= last_bg_in_old_root)
-			break;
-
-		if (key.offset == 0)
-			key.objectid++;
-		else
-			key.objectid = key.objectid + key.offset;
-		key.offset = 0;
-		btrfs_release_path(&path);
-	}
-	ret = 0;
-out:
-	btrfs_release_path(&path);
-	return ret;
-}
-
 /* Helper to read all block groups items from specified root. */
 static int read_block_groups_from_root(struct btrfs_fs_info *fs_info,
 					   struct btrfs_root *root)
@@ -2989,7 +2912,7 @@ static int read_converting_block_groups(struct btrfs_fs_info *fs_info)
 		return ret;
 	}
 
-	ret = read_old_block_groups_from_root(fs_info, old_root);
+	ret = read_block_groups_from_root(fs_info, old_root);
 	if (ret < 0) {
 		error("failed to load block groups from the old root: %d", ret);
 		return ret;
-- 
2.42.0

