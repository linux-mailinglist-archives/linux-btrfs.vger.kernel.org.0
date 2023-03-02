Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE126A799D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 03:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCBCpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 21:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBCpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 21:45:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1E1B2E5
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 18:45:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D8391FE5F
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 02:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677725119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/VfDTGGxkdNa2RlDN5Zo+YhV4V1yHkiY5uPgXRwIA4Y=;
        b=uyXufhFOE2To3aJUeoZrXsi0itM0Y5YbbOa8j6GGe/KlRmtC6t0S5SaNuH7fOfWLNC2UOC
        IByRP108+GmPoC6euXRZQNkdq83Xyr+k9GKw7dbxwludE5r8pt9wNZqBkEYjiWxSKTrAwu
        YqgnpM9aY62TcaoLGylYgmExhBk4CXo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B73013A5C
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 02:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8YuxEL4NAGSwDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 02:45:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree search for simple stripes
Date:   Thu,  2 Mar 2023 10:45:00 +0800
Message-Id: <8d8e77d19cb56fc954353a659b5382ecf0c4a0d6.1677723997.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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
When scrubing an empty fs with RAID0, we will call scrub_simple_mirror()
again and again on ranges which has no extent at all.

This is especially obvious if we have both RAID0 and SINGLE.

 # mkfs.btrfs -f -m single -d raid0 $dev
 # mount $dev $mnt
 # xfs_io -f -c "pwrite 0 4k" $mnt/file
 # sync
 # btrfs scrub start -B $mnt

With extra call trace on scrub_simple_mirror(), we got the following
trace:

  256.028473: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
  256.028930: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
  256.029891: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
  256.029892: scrub_simple_mirror: logical=22085632 len=65536 bg=22020096 bg_len=1073741824
  256.029893: scrub_simple_mirror: logical=22151168 len=65536 bg=22020096 bg_len=1073741824
  ... 16K lines skipped ...
  256.048777: scrub_simple_mirror: logical=1095630848 len=65536 bg=22020096 bg_len=1073741824
  256.048778: scrub_simple_mirror: logical=1095696384 len=65536 bg=22020096 bg_len=1073741824

The first two lines shows we just call scrub_simple_mirror() for the
metadata and system chunks once.

But later 16K lines are all scrub_simple_mirror() for the almost empty
RAID0 data block group.

Most of the calls would exit very quickly since there is no extent in
that data chunk.

[CAUSE]
For RAID0/RAID10 we go scrub_simple_stripe() to handle the scrub for the
block group. And since inside each stripe it's just plain SINGLE/RAID1,
thus we reuse scrub_simple_mirror().

But there is a pitfall, that inside scrub_simple_mirror() we will do at
least one extent tree search to find the extent in the range.

Just like above case, we can have a huge gap which has no extent in them
at all.
In that case, we will do extent tree search again and again, even we
already know there is no more extent in the block group.

[FIX]
To fix the super inefficient extent tree search, we introduce
@found_next parameter for the following functions:

- find_first_extent_item()
- scrub_simple_mirror()

If the function find_first_extent_item() returns 1 and @found_next
pointer is provided, it will store the bytenr of the bytenr of the next
extent (if at the end of the extent tree, U64_MAX is used).

So for scrub_simple_stripe(), after scrubing the current stripe and
increased the logical bytenr, we check if our next range reaches
@found_next.

If not, increase our @cur_logical by our increment until we reached
@found_next.

By this, even for an almost empty RAID0 block group, we just execute
"cur_logical += logical_increment;" 16K times, not doing tree search 16K
times.

With the optimization, the same trace looks like this now:

  1283.376212: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
  1283.376754: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
  1283.377623: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
  1283.377625: scrub_simple_mirror: logical=67108864 len=65536 bg=22020096 bg_len=1073741824
  1283.377627: scrub_simple_mirror: logical=67174400 len=65536 bg=22020096 bg_len=1073741824

Note the scrub at logical 67108864, that's because the 4K write only
lands there, not at the beginning of the data chunk (due to super block
reserved space split the 1G chunk into two parts).

And the time duration of the chunk 22020096 is much shorter
(18887us vs 4us).

Unfortunately this optimization only works for RAID0/RAID10 with big
holes in the block group.

For real world cases it's much harder to find huge gaps (although we can
still skip several stripes).
And even for the huge gap cases, the optimization itself is hardly
observable (less than 1 second even for an almost empty 10G block group).

And also unfortunately for RAID5 data stripes, we can not go the similar
optimization for RAID0/RAID10 due to the extra rotation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Rebased to latest misc-next
  There are some minor conflicts related to map->stripe_len.

- Update the comments for find_first_extent_item()
  Mostly for the new parameter @found_next.
---
 fs/btrfs/scrub.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3cdf73277e7e..49c52cced5a5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3193,12 +3193,14 @@ static int compare_extent_item_range(struct btrfs_path *path,
  * return the extent item. This is for data extent crossing stripe boundary.
  *
  * Return 0 if we found such extent item, and @path will point to the extent item.
- * Return >0 if no such extent item can be found, and @path will be released.
+ * Return >0 if no such extent item can be found, @path will be released, and
+ * update @found_next to the first extent we found after the search range.
  * Return <0 if hit fatal error, and @path will be released.
  */
 static int find_first_extent_item(struct btrfs_root *extent_root,
 				  struct btrfs_path *path,
-				  u64 search_start, u64 search_len)
+				  u64 search_start, u64 search_len,
+				  u64 *found_next)
 {
 	struct btrfs_fs_info *fs_info = extent_root->fs_info;
 	struct btrfs_key key;
@@ -3234,8 +3236,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 search_forward:
 	while (true) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		if (key.objectid >= search_start + search_len)
+		if (key.objectid >= search_start + search_len) {
+			if (found_next)
+				*found_next = key.objectid;
 			break;
+		}
 		if (key.type != BTRFS_METADATA_ITEM_KEY &&
 		    key.type != BTRFS_EXTENT_ITEM_KEY)
 			goto next;
@@ -3243,8 +3248,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 		ret = compare_extent_item_range(path, search_start, search_len);
 		if (ret == 0)
 			return ret;
-		if (ret > 0)
+		if (ret > 0) {
+			if (found_next)
+				*found_next = key.objectid;
 			break;
+		}
 next:
 		path->slots[0]++;
 		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
@@ -3252,6 +3260,10 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 			if (ret) {
 				/* Either no more item or fatal error */
 				btrfs_release_path(path);
+
+				/* No more extent tree items. */
+				if (ret > 0 && found_next)
+					*found_next = U64_MAX;
 				return ret;
 			}
 		}
@@ -3318,7 +3330,8 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 		u64 extent_mirror_num;
 
 		ret = find_first_extent_item(extent_root, path, cur_logical,
-					     logical + BTRFS_STRIPE_LEN - cur_logical);
+					     logical + BTRFS_STRIPE_LEN - cur_logical,
+					     NULL);
 		/* No more extent item in this data stripe */
 		if (ret > 0) {
 			ret = 0;
@@ -3513,7 +3526,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			       struct map_lookup *map,
 			       u64 logical_start, u64 logical_length,
 			       struct btrfs_device *device,
-			       u64 physical, int mirror_num)
+			       u64 physical, int mirror_num,
+			       u64 *found_next)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bg->start);
@@ -3567,7 +3581,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		spin_unlock(&bg->lock);
 
 		ret = find_first_extent_item(extent_root, &path, cur_logical,
-					     logical_end - cur_logical);
+					     logical_end - cur_logical,
+					     found_next);
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
 			sctx->stat.last_physical = physical + logical_length;
@@ -3681,6 +3696,8 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 	int ret = 0;
 
 	while (cur_logical < bg->start + bg->length) {
+		u64 found_next = 0;
+
 		/*
 		 * Inside each stripe, RAID0 is just SINGLE, and RAID10 is
 		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
@@ -3688,13 +3705,23 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 		 */
 		ret = scrub_simple_mirror(sctx, bg, map, cur_logical,
 					  BTRFS_STRIPE_LEN, device, cur_physical,
-					  mirror_num);
+					  mirror_num, &found_next);
 		if (ret)
 			return ret;
 		/* Skip to next stripe which belongs to the target device */
 		cur_logical += logical_increment;
 		/* For physical offset, we just go to next stripe */
 		cur_physical += BTRFS_STRIPE_LEN;
+
+		/*
+		 * If the next extent is still beyond our current range, we
+		 * can skip them until the @found_next.
+		 */
+		while (cur_logical + BTRFS_STRIPE_LEN < found_next &&
+		       cur_logical < bg->start + bg->length) {
+			cur_logical += logical_increment;
+			cur_physical += BTRFS_STRIPE_LEN;
+		}
 	}
 	return ret;
 }
@@ -3761,7 +3788,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 */
 		ret = scrub_simple_mirror(sctx, bg, map, bg->start, bg->length,
 				scrub_dev, map->stripes[stripe_index].physical,
-				stripe_index + 1);
+				stripe_index + 1, NULL);
 		offset = 0;
 		goto out;
 	}
@@ -3813,7 +3840,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * is still based on @mirror_num.
 		 */
 		ret = scrub_simple_mirror(sctx, bg, map, logical, BTRFS_STRIPE_LEN,
-					  scrub_dev, physical, 1);
+					  scrub_dev, physical, 1, NULL);
 		if (ret < 0)
 			goto out;
 next:
-- 
2.39.1

