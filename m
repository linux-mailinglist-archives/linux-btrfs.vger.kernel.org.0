Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B284D60B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 12:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348298AbiCKLgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348296AbiCKLgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 06:36:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363691BFDDB
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 03:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0D14B82881
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CE8C340EC
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646998540;
        bh=BFBeVh+lWx3n7AjVCy6Ny2Q/fOz8Og70sVplC5ynLwM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R+YugpRE2Dg1KWSlrtESDFhS3s2+vWVkC/ZQzBnMBawMUg0NI/M8NTlWvdDzojLJv
         ZQ69wS0vXs3vHtDs4hgBql8C2231xitC2FESXo8vatDNEe9GklON4guI0VJHSQry5W
         xC1IhOfH5KP38QMToXoDuYmaBqVge/2NZOQU9KdyXA4XEgj6WvgkyjBLvuo0e0ath6
         gG0RCKkzYDh68XRpencaJdvKvqXWDQlc7EvEXXedkfVD2wc3jMqrs2bHbJ4wNlZMnS
         HVmAklH+EJf3pKau5ZXDIKChtAj7trPSs1r1cRvQAorMvzVsuk1Cj1UibUI+fflM1D
         cqHcm9tX2eIsw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: release upper nodes when reading stale btree node from disk
Date:   Fri, 11 Mar 2022 11:35:32 +0000
Message-Id: <ee93177c2376cc42ad55de7ffd2c666b39035ac0.1646998177.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646998177.git.fdmanana@suse.com>
References: <cover.1646998177.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When reading a btree node (or leaf), at read_block_for_search(), if we
can't find its extent buffer in the cache (the fs_info->buffer_radix
radix tree), then we unlock all upper level nodes before reading the
btree node/leaf from disk, to prevent blocking other tasks for too long.

However if we find that the extent buffer is in the cache but it is not
up to date, we don't unlock upper level nodes before reading it from disk,
potentially blocking other tasks on upper level nodes for too long.

Fix this inconsistent behaviour by unlocking upper level nodes if we need
to read a node/leaf from disk because its in-memory extent buffer is not
up to date. If we unlocked upper level nodes then we must return -EAGAIN
to the caller, just like the case where the extent buffer is not cached in
memory. And like that case, we determine if upper level nodes are locked
by checking only if the parent node is locked - if it isn't, then no other
upper level nodes are locked.

This is actually a rare case, as if we have an extent buffer in memory,
it typically has the uptodate flag set and passes all the checks done by
btrfs_buffer_uptodate().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8396079709c4..e1e942e1918f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1409,12 +1409,21 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	struct btrfs_key first_key;
 	int ret;
 	int parent_level;
+	bool unlock_up;
 
+	unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
 	blocknr = btrfs_node_blockptr(*eb_ret, slot);
 	gen = btrfs_node_ptr_generation(*eb_ret, slot);
 	parent_level = btrfs_header_level(*eb_ret);
 	btrfs_node_key_to_cpu(*eb_ret, &first_key, slot);
 
+	/*
+	 * If we need to read an extent buffer from disk and we are holding locks
+	 * on upper level nodes, we unlock all the upper nodes before reading the
+	 * extent buffer, and then return -EAGAIN to the caller as it needs to
+	 * restart the search. We don't release the lock on the current level
+	 * because we need to walk this node to figure out which blocks to read.
+	 */
 	tmp = find_extent_buffer(fs_info, blocknr);
 	if (tmp) {
 		if (p->reada == READA_FORWARD_ALWAYS)
@@ -1436,6 +1445,9 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			return 0;
 		}
 
+		if (unlock_up)
+			btrfs_unlock_up_safe(p, level + 1);
+
 		/* now we're allowed to do a blocking uptodate check */
 		ret = btrfs_read_buffer(tmp, gen, parent_level - 1, &first_key);
 		if (ret) {
@@ -1443,17 +1455,14 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			btrfs_release_path(p);
 			return -EIO;
 		}
-		*eb_ret = tmp;
-		return 0;
+
+		if (unlock_up)
+			ret = -EAGAIN;
+
+		goto out;
 	}
 
-	if ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]) {
-		/*
-		 * Reduce lock contention at high levels of the btree by
-		 * dropping locks before we read.  Don't release the lock
-		 * on the current level because we need to walk this node
-		 * to figure out which blocks to read.
-		 */
+	if (unlock_up) {
 		btrfs_unlock_up_safe(p, level + 1);
 		ret = -EAGAIN;
 	} else {
@@ -1478,6 +1487,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	if (!extent_buffer_uptodate(tmp))
 		ret = -EIO;
 
+out:
 	if (ret == 0) {
 		*eb_ret = tmp;
 	} else {
-- 
2.33.0

