Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744617BCAB5
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Oct 2023 02:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjJHAtF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 20:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbjJHAtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 20:49:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F0BC;
        Sat,  7 Oct 2023 17:49:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB13AC433C8;
        Sun,  8 Oct 2023 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726143;
        bh=sA0/nicX7nC1P+pWnJXcU9ifbUJJQIZG7AVMdagXU34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7fNbWEDBkZXGvNlBwRfd1m1kziBy6K2u/zNXo0EcG4jIWVxU1A8H+3oatcbsmRZB
         SWLEbhncITgzs8lrRP9VlptMsBJ0nD3bdxDxt37y5m/nl0HTOx6MPVlMdBa1QmbH/b
         Y6atvPnqtHVUQ/WS9S+eiX33ke4F6sEkvAE/Syqm8WUMCvuLL/eHMNDTvSvirMAcW+
         CJNIuWwReQ21R3ELQMZd8vKdwVchNtFwQowHnZ5sdgvgG5QHZuksesqf8mAFoGvV3c
         pyMiDHo95kGoBB4Jc90JTO8x3bFI6GQ200qwf8jzrs8Z/B5Hlrc0QWa0QAP1Lvny2s
         W+DR3MzRbMzkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 05/18] btrfs: fix race when refilling delayed refs block reserve
Date:   Sat,  7 Oct 2023 20:48:39 -0400
Message-Id: <20231008004853.3767621-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004853.3767621-1-sashal@kernel.org>
References: <20231008004853.3767621-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 2ed45c0f1879079b30248568c515cf60fc668d8a ]

If we have two (or more) tasks attempting to refill the delayed refs block
reserve we can end up with the delayed block reserve being over reserved,
that is, with a reserved space greater than its size. If this happens, we
are holding to more reserved space than necessary for a while.

The race happens like this:

1) The delayed refs block reserve has a size of 8M and a reserved space of
   6M for example;

2) Task A calls btrfs_delayed_refs_rsv_refill();

3) Task B also calls btrfs_delayed_refs_rsv_refill();

4) Task A sees there's a 2M difference between the size and the reserved
   space of the delayed refs rsv, so it will reserve 2M of space by
   calling btrfs_reserve_metadata_bytes();

5) Task B also sees that 2M difference, and like task A, it reserves
   another 2M of metadata space;

6) Both task A and task B increase the reserved space of block reserve
   by 2M, by calling btrfs_block_rsv_add_bytes(), so the block reserve
   ends up with a size of 8M and a reserved space of 10M;

7) The extra, over reserved space will eventually be freed by some task
   calling btrfs_delayed_refs_rsv_release() -> btrfs_block_rsv_release()
   -> block_rsv_release_bytes(), as there we will detect the over reserve
   and release that space.

So fix this by checking if we still need to add space to the delayed refs
block reserve after reserving the metadata space, and if we don't, just
release that space immediately.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-ref.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6a13cf00218bc..1043f66cc130d 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -163,6 +163,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
 	u64 limit = btrfs_calc_delayed_ref_bytes(fs_info, 1);
 	u64 num_bytes = 0;
+	u64 refilled_bytes;
+	u64 to_free;
 	int ret = -ENOSPC;
 
 	spin_lock(&block_rsv->lock);
@@ -178,9 +180,38 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes, flush);
 	if (ret)
 		return ret;
-	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
-	trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
-				      0, num_bytes, 1);
+
+	/*
+	 * We may have raced with someone else, so check again if we the block
+	 * reserve is still not full and release any excess space.
+	 */
+	spin_lock(&block_rsv->lock);
+	if (block_rsv->reserved < block_rsv->size) {
+		u64 needed = block_rsv->size - block_rsv->reserved;
+
+		if (num_bytes >= needed) {
+			block_rsv->reserved += needed;
+			block_rsv->full = true;
+			to_free = num_bytes - needed;
+			refilled_bytes = needed;
+		} else {
+			block_rsv->reserved += num_bytes;
+			to_free = 0;
+			refilled_bytes = num_bytes;
+		}
+	} else {
+		to_free = num_bytes;
+		refilled_bytes = 0;
+	}
+	spin_unlock(&block_rsv->lock);
+
+	if (to_free > 0)
+		btrfs_space_info_free_bytes_may_use(fs_info, block_rsv->space_info,
+						    to_free);
+
+	if (refilled_bytes > 0)
+		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv", 0,
+					      refilled_bytes, 1);
 	return 0;
 }
 
-- 
2.40.1

