Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B3953EA7B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiFFJl2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiFFJlZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 05:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BF1CC5FB
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 02:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EF7612ED
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA4BC34119
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654508483;
        bh=1Kkmv7RvysoiAcWh7izam54CvAKr323UmyyIEQ5t1wA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sOZw9VOBq4QS3Jn+LGIEGZUEWqlh+DP2wKNagmdIV8lY2MtSYXysqaOCyav26k/1p
         G6g5uBsk+QKlcghXB6NMLP6kqtzhqMiVELq40CIewdMxvfxkkvauAGDgE4jQgBv9Zn
         0TOXrI2MEpJTPgdRdIYdZFPD07GPMYHrG6U7fKagTOnTkuUT4Nh8HCj48S33xySahv
         YCn8ZR57OIU1jotZq/wzN1Kv2tBg6f6iXWKMunyxDAs05yOwhLFDoX+ZB4w7BfS3g7
         xjY+8HjL5lJjJ55Qrv7JCUnGCSluWBebvE81d0OnJHcuxZ4lzQT8M1UgA75gjDV0kO
         IxIlHxH2pZ9yA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix race between reflinking and ordered extent completion
Date:   Mon,  6 Jun 2022 10:41:17 +0100
Message-Id: <e4fedf38e6197e82ab53913a5c7e2fcc0d41e3d0.1654508104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654508104.git.fdmanana@suse.com>
References: <cover.1654508104.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

While doing a reflink operation, if an ordered extent for a file range
that does not overlap with the source and destination ranges of the
reflink operation happens, we can end up having a failure in the reflink
operation and return -EINVAL to user space.

The following sequence of steps explains how this can happen:

1) We have the page at file offset 315392 dirty (under delalloc);

2) A reflink operation for this file starts, using the same file as both
   source and destination, the source range is [372736, 409600[ (length of
   36864 bytes) and the destination range is [208896, 245760[;

3) At btrfs_remap_file_range_prep(), we flush all delalloc in the source
   and destination ranges, and wait for any ordered extents in those range
   to complete;

4) Still at btrfs_remap_file_range_prep(), we then flush all delalloc in
   the inode, but we neither wait for it to complete nor any ordered
   extents to complete. This results in starting delalloc for the page at
   file offset 315392 and creating an ordered extent for that single page
   range;

5) We then move to btrfs_clone() and enter the loop to find file extent
   items to copy from the source range to destination range;

6) In the first iteration we end up at last file extent item stored in
   leaf A:

   (...)
   item 131 key (143616 108 315392) itemoff 5101 itemsize 53
            extent data disk bytenr 1903988736 nr 73728
            extent data offset 12288 nr 61440 ram 73728

   This represents the file range [315392, 376832[, which overlaps with
   the source range to clone.

   @datal is set to 61440, key.offset is 315392 and @next_key_min_offset
   is therefore set to 376832 (315392 + 61440).

   @off (372736) is > key.offset (315392), so @new_key.offset is set to
   the value of @destoff (208896).

   @new_key.offset == @last_dest_end (208896) so @drop_start is set to
   208896 (@new_key.offset).

   @datal is adjusted to 4096, as @off is > @key.offset.

   So in this iteration we call btrfs_replace_file_extents() for the range
   [208896, 212991] (a single page, which is
   [@drop_start, @new_key.offset + @datal - 1]).

   @last_dest_end is set to 212992 (@new_key.offset + @datal =
   208896 + 4096 = 212992).

   Before the next iteration of the loop, @key.offset is set to the value
   376832, which is @next_key_min_offset;

7) On the second iteration btrfs_search_slot() leaves us again at leaf A,
   but this time pointing beyond the last slot of leaf A, as that's where
   a key with offset 376832 should be at if it existed. So end up calling
   btrfs_next_leaf();

8) btrfs_next_leaf() releases the path, but before it searches again the
   tree for the next key/leaf, the ordered extent for the single page
   range at file offset 315392 completes. That results in trimming the
   file extent item we processed before, adjusting its key offset from
   315392 to 319488, reducing its length from 61440 to 57344 and inserting
   a new file extent item for that single page range, with a key offset of
   315392 and a length of 4096.

   Leaf A now looks like:

     (...)
     item 132 key (143616 108 315392) itemoff 4995 itemsize 53
              extent data disk bytenr 1801666560 nr 4096
              extent data offset 0 nr 4096 ram 4096
     item 133 key (143616 108 319488) itemoff 4942 itemsize 53
              extent data disk bytenr 1903988736 nr 73728
              extent data offset 16384 nr 57344 ram 73728

9) When btrfs_next_leaf() returns, it gives us a path pointing to leaf A
   at slot 133, since it's the first key that follows what was the last
   key we saw (143616 108 315392). In fact it's the same item we processed
   before, but its key offset was changed, so it counts as a new key;

10) So now we have:

    @key.offset == 319488
    @datal == 57344

    @off (372736) is > key.offset (319488), so @new_key.offset is set to
    208896 (@destoff value).

    @new_key.offset (208896) != @last_dest_end (212992), so @drop_start
    is set to 212992 (@last_dest_end value).

    @datal is adjusted to 4096 because @off > @key.offset.

    So in this iteration we call btrfs_replace_file_extents() for the
    invalid range of [212992, 212991] (which is
    [@drop_start, @new_key.offset + @datal - 1]).

    This range is empty, the end offset is smaller than the start offset
    so btrfs_replace_file_extents() returns -EINVAL, which we end up
    returning to user space and fail the reflink operation.

    This all happens because the range of this file extent item was
    already processed in the previous iteration.

This scenario can be triggered very sporadically by fsx from fstests, for
example with test case generic/522.

So fix this by having btrfs_clone() skip file extent items that cover a
file range that we have already processed.

CC: stable@vger.kernel.org # 5.10+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c0f1456be998..7e3b0aa318c1 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -345,6 +345,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	int ret;
 	const u64 len = olen_aligned;
 	u64 last_dest_end = destoff;
+	u64 prev_extent_end = off;
 
 	ret = -ENOMEM;
 	buf = kvmalloc(fs_info->nodesize, GFP_KERNEL);
@@ -364,7 +365,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	key.offset = off;
 
 	while (1) {
-		u64 next_key_min_offset = key.offset + 1;
 		struct btrfs_file_extent_item *extent;
 		u64 extent_gen;
 		int type;
@@ -432,14 +432,21 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		 * The first search might have left us at an extent item that
 		 * ends before our target range's start, can happen if we have
 		 * holes and NO_HOLES feature enabled.
+		 *
+		 * Subsequent searches may leave us on a file range we have
+		 * processed before - this happens due to a race with ordered
+		 * extent completion for a file range that is outside our source
+		 * range, but that range was part of a file extent item that
+		 * also covered a leading part of our source range.
 		 */
-		if (key.offset + datal <= off) {
+		if (key.offset + datal <= prev_extent_end) {
 			path->slots[0]++;
 			goto process_slot;
 		} else if (key.offset >= off + len) {
 			break;
 		}
-		next_key_min_offset = key.offset + datal;
+
+		prev_extent_end = key.offset + datal;
 		size = btrfs_item_size(leaf, slot);
 		read_extent_buffer(leaf, buf, btrfs_item_ptr_offset(leaf, slot),
 				   size);
@@ -551,7 +558,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			break;
 
 		btrfs_release_path(path);
-		key.offset = next_key_min_offset;
+		key.offset = prev_extent_end;
 
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
-- 
2.35.1

