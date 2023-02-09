Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD34868FF82
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 05:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBIEsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 23:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBIEsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 23:48:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECE448F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 20:47:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C3595BE94
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 04:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675918039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t+9eSBYsVzASRz+af3Xoua8X3NDeLfy0koGByC0NAh0=;
        b=hsCQ2gB9xpPzC11i7ObnyoYMnc7AVosYXJCrmI+fyqTzCipa6124KZLOo4hUhbDZUHVl7c
        tdwdd9Dok9Vcba/KqO29JFIvnNx6wJSwRfQw0hZe9djh1tPE48XnpS64L9ShsnVMhNCOjE
        KlDgHvSg2FxcsJ/lNpKvIokPuL2GQ6Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7477D1339E
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 04:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hDj6D9Z65GNfSQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Feb 2023 04:47:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: do not use the replace target device as an extra mirror
Date:   Thu,  9 Feb 2023 12:47:01 +0800
Message-Id: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
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

Since the ancient time of btrfs, if a dev-replace is running, we can use
that replace target as an extra mirror for read.

But there are some extra problems with that:

- No reliable checks on if that target device is even involved
  For profiles like RAID0/RAID10, it's very possible that the replace
  is happening on one device which is not involved in the stripe.

  E.g. a 4-disks RAID0, involving disk A~D, and disk A is being replaced.
  In that case, if our read lands at disk B, there is no extra mirror to
  start with.

- No indicator on whether the target device even contains correct data
  Since dev-replace is running, the target device is progressively
  filled with data from the source device.

  Thus if our read is beyond the currently replaced range, we may just
  read out some garbage.
  This can be extremely dangerous if the range doesn't have data
  checksum, then we may silently trust the garbage.

Thus this RFC patch would just remove this feature.

Yes, I know this would reduce the chance we recover some data, if we're
replacing a failing disk.
But in that case, if we're really relying on the failing disk, but not
some extra mirrors, I'd say we have a much bigger problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 124 +++------------------------------------------
 1 file changed, 7 insertions(+), 117 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3a2a256fa9cd..385fc89b6702 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5754,12 +5754,6 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		ret = map->num_stripes;
 	free_extent_map(em);
 
-	down_read(&fs_info->dev_replace.rwsem);
-	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
-	    fs_info->dev_replace.tgtdev)
-		ret++;
-	up_read(&fs_info->dev_replace.rwsem);
-
 	return ret;
 }
 
@@ -6046,83 +6040,6 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
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
@@ -6335,14 +6252,13 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int i;
 	int ret = 0;
 	int mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
+	int num_copies;
 	int num_stripes;
 	int max_errors = 0;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	int dev_replace_is_ongoing = 0;
-	int patch_the_first_stripe_for_dev_replace = 0;
 	u16 num_alloc_stripes;
-	u64 physical_to_patch_in_first_stripe = 0;
 	u64 raid56_full_stripe_start = (u64)-1;
 	struct btrfs_io_geometry geom;
 
@@ -6365,6 +6281,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	raid56_full_stripe_start = geom.raid56_stripe_offset;
 	data_stripes = nr_data_stripes(map);
 
+	num_copies = btrfs_num_copies(fs_info, logical, geom.len);
+
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 	/*
@@ -6374,19 +6292,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
+	if (mirror_num > num_copies)
 		mirror_num = 0;
-	}
 
 	num_stripes = 1;
 	stripe_index = 0;
@@ -6511,15 +6418,9 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6584,17 +6485,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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

