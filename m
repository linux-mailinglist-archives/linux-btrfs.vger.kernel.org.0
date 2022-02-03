Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA814A8719
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 15:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbiBCO4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 09:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351565AbiBCO4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 09:56:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9EC06173B
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 06:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D598CB83475
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F62CC340ED
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900157;
        bh=WBCQpNXahoAbT8YOv5mgf0i4DJclSOx80DMtMsEXX3E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J1Q2TN1dzw8LlOAKX8VXXTcEyVZaPaC40FjhjHW0zSOw97F4UMgi8q70NuXAkUxKz
         ghcuKQujaZGRtnkmhJxab0SsxQ6XVCymP8of9ORtqgKDE0RxVSzpvWGnXbUPRd74la
         BDAqRUT4ftBrGeJPJWnfpiMEzG+0RN1Pr6lDQKCZlB2Fbie6BSGsM66Z+QG7uRym8U
         5uMcbgPMXuf0irdgbz4nc6z1BApOR5vVXbMY+OK3o2Hd6bR2ue5AXWVgo56uP94F8C
         n1NwArKmyiJa6FeE9vF+cZhK6bS5/7q3f02yXVn2nZ/0pcqUGJo2s0IYrwooBm7nx0
         gz1U8HXeoh8qA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: remove constraint on number of visited leaves when replacing extents
Date:   Thu,  3 Feb 2022 14:55:48 +0000
Message-Id: <fa90e3eb347aae04d000cd6f4c33ec62797b0193.1643898314.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643898312.git.fdmanana@suse.com>
References: <cover.1643898312.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_drop_extents(), we try to replace a range of file extent items
with a new file extent in a single btree search, to avoid the need to do
a search for deletion, followed by a path release and followed by yet
another search for insertion.

When I originally added that optimization, in commit 1acae57b161ef1
("Btrfs: faster file extent item replace operations"), I left a constraint
to do the fast replace only if we visited a single leaf. That was because
in the most common case we find all file extent items that need to be
deleted (or trimmed) in a single leaf, however it can work for other
common cases like when we need to delete a few file extent items located
at the end of a leaf and a few more located at the beginning of the next
leaf. The key for the new file extent item is greater than the key of
any deleted or trimmed file extent item from previous leaves, so we are
fine to use the last leaf that we found as long as we are holding a
write lock on it - even if the new key ends up at slot 0, as if that's
the case, the btree search has obtained a write lock on any upper nodes
that need to have a key pointer updated.

So removed the constraint that limits the optimization to the case where
we visited only a single leaf.

This change if part of a patchset that is comprised of the following
patches:

  1/6 btrfs: remove unnecessary leaf free space checks when pushing items
  2/6 btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
  3/6 btrfs: avoid unnecessary computation when deleting items from a leaf
  4/6 btrfs: remove constraint on number of visited leaves when replacing extents
  5/6 btrfs: remove useless path release in the fast fsync path
  6/6 btrfs: prepare extents to be logged before locking a log tree path

The last patch in the series has some performance test result in its
changelog.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 11204dbbe053..c462896122dc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -718,7 +718,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	int modify_tree = -1;
 	int update_refs;
 	int found = 0;
-	int leafs_visited = 0;
 	struct btrfs_path *path = args->path;
 
 	args->bytes_found = 0;
@@ -756,7 +755,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				path->slots[0]--;
 		}
 		ret = 0;
-		leafs_visited++;
 next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
@@ -768,7 +766,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				ret = 0;
 				break;
 			}
-			leafs_visited++;
 			leaf = path->nodes[0];
 			recow = 1;
 		}
@@ -1014,7 +1011,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	 * which case it unlocked our path, so check path->locks[0] matches a
 	 * write lock.
 	 */
-	if (!ret && args->replace_extent && leafs_visited == 1 &&
+	if (!ret && args->replace_extent &&
 	    path->locks[0] == BTRFS_WRITE_LOCK &&
 	    btrfs_leaf_free_space(leaf) >=
 	    sizeof(struct btrfs_item) + args->extent_item_size) {
-- 
2.33.0

