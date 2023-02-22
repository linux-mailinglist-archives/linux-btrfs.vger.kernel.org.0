Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9869EF93
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 08:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBVHsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 02:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBVHsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 02:48:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B21024A
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 23:47:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 224025D1ED
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677052078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3zl2pYJooGcmDaqK92Py8XXr5tHg7YeuKwaS5RsFDK4=;
        b=t3iA/PmiTtr9zCpHyOWjP8gnPqt/ov4YfZEjQsqihsHtguBNqawGX++yE5uezuo1rUHfLD
        iUyIWhCbzTEAV0GjSjqz8OA3Fx6mzvebqgNhxYzAYuX5P2/1ExpMlPltiMsiR4VZcqNRbh
        wToZWMoIUQFYq7Y31KgwToF4h5TE/HI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70BA1133E0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 07:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J5B/Dq3I9WPVKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 07:47:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not use replace target device as an extra mirror
Date:   Wed, 22 Feb 2023 15:47:40 +0800
Message-Id: <5032646bf05bad479eb170b1d3e5b1c78dbdfb10.1677052042.git.wqu@suse.com>
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
Currently btrfs can use dev-replace device as an extra mirror for
read-repair.

But it can lead to NODATASUM corruption in the following case:

 There is a RAID1 data chunk, and dev-replace is running from
 dev2 to dev0.

 |//| = Replaced data
          X       X+1MB     X+2MB
  Dev 2:  |       |         |           <- Source dev
  Dev 0:  |///////|         |           <- Target dev

Then a read on dev 2 X+2MB happens.
And something wrong happened inside devid 2, causing an -EIO.

In that case, read-repair would try the next mirror, and since we can
use target device as an extra mirror, we will use that mirror instead.

But unfortunately since the read is beyond the current replace cursor,
we should not trust it at all, what we get would be just uninitialized
garbage.

But if this read is for NODATASUM range, then we just trust them and
cause data corruption.

[CAUSE]
We used to have some checks to make sure we only return such extra
mirror when the range is before our left cursor.

The first commit introducing this behavior is ad6d620e2a57 ("Btrfs:
allow repair code to include target disk when searching mirrors").

But later a fix, 22ab04e814f4 ("Btrfs: fix race between device replace
and chunk allocation") changed the behavior, to always let
btrfs_map_block() to include the extra mirror to address a race in
dev-replace which can cause missing writes to target device.

This means, we lose the tracking of cursor for the extra mirror, thus
can lead to above corruption.

[FIX]
The extra mirror is never a reliable one, at the beginning of
dev-replace, the reliability is 0, while only at the end of the replace
it's a fully reliable mirror.

We either do the complex tracking, or never trust it.

IMHO it's much easier to maintain if we don't trust it at all, and the
extra mirror can only benefit for a limited period of time (during
replace).

Thus this patch would completely remove the ability to use target device
as an extra mirror.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
In a thread discussing the situation with Stefan, he mentioned some
cases where we want to avoid read from an unreliable source device.

The problem is, using the target device as an extra mirror is not
affecting replace itself (I recently fixed that by patch "btrfs: make
dev-replace properly follow its read mode"), and read-repair is already
avoiding read from source device when mode avoid is specified.

So the argument to avoid read from the source device should not be a big
deal already, as long as the user specify "-r" option for "btrfs replace
start".

Changelog:
RFC->v1:
- Update the commit message to focus on the data corruption case
- Rebased to the latest misc-next
---
 fs/btrfs/volumes.c | 127 +++------------------------------------------
 1 file changed, 7 insertions(+), 120 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d528e6aca8ee..6f56512c99b8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5767,13 +5767,6 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 */
 		ret = map->num_stripes;
 	free_extent_map(em);
-
-	down_read(&fs_info->dev_replace.rwsem);
-	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
-	    fs_info->dev_replace.tgtdev)
-		ret++;
-	up_read(&fs_info->dev_replace.rwsem);
-
 	return ret;
 }
 
@@ -6060,83 +6053,6 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	return ERR_PTR(ret);
 }
 
-/*
- * In dev-replace case, for repair case (that's the only case where the mirror
- * is selected explicitly when calling btrfs_map_block), blocks left of the
- * left cursor can also be read from the target drive.
- *
- * For REQ_GET_READ_MIRRORS, the target drive is added as the last one to the
- * array of stripes.
- * For READ, it also needs to be supported using the same mirror number.
- *
- * If the requested block is not left of the left cursor, EIO is returned. This
- * can happen because btrfs_num_copies() returns one more in the dev-replace
- * case.
- */
-static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
-					 u64 logical, u64 length,
-					 u64 srcdev_devid, int *mirror_num,
-					 u64 *physical)
-{
-	struct btrfs_io_context *bioc = NULL;
-	int num_stripes;
-	int index_srcdev = 0;
-	int found = 0;
-	u64 physical_of_found = 0;
-	int i;
-	int ret = 0;
-
-	ret = __btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				logical, &length, &bioc, NULL, NULL, 0);
-	if (ret) {
-		ASSERT(bioc == NULL);
-		return ret;
-	}
-
-	num_stripes = bioc->num_stripes;
-	if (*mirror_num > num_stripes) {
-		/*
-		 * BTRFS_MAP_GET_READ_MIRRORS does not contain this mirror,
-		 * that means that the requested area is not left of the left
-		 * cursor
-		 */
-		btrfs_put_bioc(bioc);
-		return -EIO;
-	}
-
-	/*
-	 * process the rest of the function using the mirror_num of the source
-	 * drive. Therefore look it up first.  At the end, patch the device
-	 * pointer to the one of the target drive.
-	 */
-	for (i = 0; i < num_stripes; i++) {
-		if (bioc->stripes[i].dev->devid != srcdev_devid)
-			continue;
-
-		/*
-		 * In case of DUP, in order to keep it simple, only add the
-		 * mirror with the lowest physical address
-		 */
-		if (found &&
-		    physical_of_found <= bioc->stripes[i].physical)
-			continue;
-
-		index_srcdev = i;
-		found = 1;
-		physical_of_found = bioc->stripes[i].physical;
-	}
-
-	btrfs_put_bioc(bioc);
-
-	ASSERT(found);
-	if (!found)
-		return -EIO;
-
-	*mirror_num = index_srcdev + 1;
-	*physical = physical_of_found;
-	return ret;
-}
-
 static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 {
 	struct btrfs_block_group *cache;
@@ -6310,19 +6226,21 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int ret = 0;
 	int mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
 	int num_stripes;
+	int num_copies = btrfs_num_copies(fs_info, logical, fs_info->sectorsize);
 	int max_errors = 0;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	int dev_replace_is_ongoing = 0;
-	int patch_the_first_stripe_for_dev_replace = 0;
 	u16 num_alloc_stripes;
-	u64 physical_to_patch_in_first_stripe = 0;
 	u64 raid56_full_stripe_start = (u64)-1;
 	u64 max_len;
 
 	ASSERT(bioc_ret);
 	ASSERT(op != BTRFS_MAP_DISCARD);
 
+	if (mirror_num > num_copies)
+		return -EINVAL;
+
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
 
@@ -6343,20 +6261,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (!dev_replace_is_ongoing)
 		up_read(&dev_replace->rwsem);
 
-	if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
-	    !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
-		ret = get_extra_mirror_from_replace(fs_info, logical, *length,
-						    dev_replace->srcdev->devid,
-						    &mirror_num,
-					    &physical_to_patch_in_first_stripe);
-		if (ret)
-			goto out;
-		else
-			patch_the_first_stripe_for_dev_replace = 1;
-	} else if (mirror_num > map->num_stripes) {
-		mirror_num = 0;
-	}
-
 	num_stripes = 1;
 	stripe_index = 0;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
@@ -6480,15 +6384,9 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
 	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
 	     !dev_replace->tgtdev)) {
-		if (patch_the_first_stripe_for_dev_replace) {
-			smap->dev = dev_replace->tgtdev;
-			smap->physical = physical_to_patch_in_first_stripe;
-			*mirror_num_ret = map->num_stripes + 1;
-		} else {
-			set_io_stripe(smap, map, stripe_index, stripe_offset,
-				      stripe_nr);
-			*mirror_num_ret = mirror_num;
-		}
+		set_io_stripe(smap, map, stripe_index, stripe_offset,
+			      stripe_nr);
+		*mirror_num_ret = mirror_num;
 		*bioc_ret = NULL;
 		ret = 0;
 		goto out;
@@ -6550,17 +6448,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->max_errors = max_errors;
 	bioc->mirror_num = mirror_num;
 
-	/*
-	 * this is the case that REQ_READ && dev_replace_is_ongoing &&
-	 * mirror_num == num_stripes + 1 && dev_replace target drive is
-	 * available as a mirror
-	 */
-	if (patch_the_first_stripe_for_dev_replace && num_stripes > 0) {
-		WARN_ON(num_stripes > 1);
-		bioc->stripes[0].dev = dev_replace->tgtdev;
-		bioc->stripes[0].physical = physical_to_patch_in_first_stripe;
-		bioc->mirror_num = map->num_stripes + 1;
-	}
 out:
 	if (dev_replace_is_ongoing) {
 		lockdep_assert_held(&dev_replace->rwsem);
-- 
2.39.1

