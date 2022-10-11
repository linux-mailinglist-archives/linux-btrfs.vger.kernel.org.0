Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062ED5FB5DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJKPAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJKO5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 10:57:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FADB9DFA8;
        Tue, 11 Oct 2022 07:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A3F8B8136F;
        Tue, 11 Oct 2022 14:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453B5C433D6;
        Tue, 11 Oct 2022 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665499938;
        bh=ev730NRNp/d5VsJc7QVwcPuWFte6qmRuVQ9h9ihlr2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHlvr7Vhp4VlogbCLLgG3wIR8o7pjJ9L73vYEBtZW6SDqXiVitTF0igzzqbE3IBEe
         JIVCkkYI+vZGBPwvHBQ3eEBw8QGtRuy3lYWOJAudM4fVyWTFSjAh6bHpy10LuM5gtn
         xJT6rjq+91jrmYP6FJ4mi/MSBMRPWYMQRCXKZnK2Qyx9aaFprAJsh/XPiu/Wlqf7YY
         UIJRIY3H+ASlZGQpP+GZKTovUoUhqLmJ0XqMafDUNpbecNFycOQQCJXvOIN8Hk1uao
         jIOey2Ty6mYgQH2BR7OxiOiM6biaj8XD1JCaje9QBxhcJPlWaL0QxZ8LKQf6UZR74V
         yXGn9KqfCHTZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Goffredo Baroncelli <kreijack@libero.it>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 31/40] btrfs: check superblock to ensure the fs was not modified at thaw time
Date:   Tue, 11 Oct 2022 10:51:20 -0400
Message-Id: <20221011145129.1623487-31-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011145129.1623487-1-sashal@kernel.org>
References: <20221011145129.1623487-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit a05d3c9153145283ce9c58a1d7a9056fbb85f6a1 ]

[BACKGROUND]
There is an incident report that, one user hibernated the system, with
one btrfs on removable device still mounted.

Then by some incident, the btrfs got mounted and modified by another
system/OS, then back to the hibernated system.

After resuming from the hibernation, new write happened into the victim btrfs.

Now the fs is completely broken, since the underlying btrfs is no longer
the same one before the hibernation, and the user lost their data due to
various transid mismatch.

[REPRODUCER]
We can emulate the situation using the following small script:

  truncate -s 1G $dev
  mkfs.btrfs -f $dev
  mount $dev $mnt
  fsstress -w -d $mnt -n 500
  sync
  xfs_freeze -f $mnt
  cp $dev $dev.backup

  # There is no way to mount the same cloned fs on the same system,
  # as the conflicting fsid will be rejected by btrfs.
  # Thus here we have to wipe the fs using a different btrfs.
  mkfs.btrfs -f $dev.backup

  dd if=$dev.backup of=$dev bs=1M
  xfs_freeze -u $mnt
  fsstress -w -d $mnt -n 20
  umount $mnt
  btrfs check $dev

The final fsck will fail due to some tree blocks has incorrect fsid.

This is enough to emulate the problem hit by the unfortunate user.

[ENHANCEMENT]
Although such case should not be that common, it can still happen from
time to time.

From the view of btrfs, we can detect any unexpected super block change,
and if there is any unexpected change, we just mark the fs read-only,
and thaw the fs.

By this we can limit the damage to minimal, and I hope no one would lose
their data by this anymore.

Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 25 ++++++++++++++-----
 fs/btrfs/disk-io.h |  4 +++-
 fs/btrfs/super.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 +-
 4 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 20ad619a8a97..218f62fb76a0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2705,8 +2705,8 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
  * 		1, 2	2nd and 3rd backup copy
  * 	       -1	skip bytenr check
  */
-static int validate_super(struct btrfs_fs_info *fs_info,
-			    struct btrfs_super_block *sb, int mirror_num)
+int btrfs_validate_super(struct btrfs_fs_info *fs_info,
+			 struct btrfs_super_block *sb, int mirror_num)
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
 	u64 sectorsize = btrfs_super_sectorsize(sb);
@@ -2890,7 +2890,7 @@ static int validate_super(struct btrfs_fs_info *fs_info,
  */
 static int btrfs_validate_mount_super(struct btrfs_fs_info *fs_info)
 {
-	return validate_super(fs_info, fs_info->super_copy, 0);
+	return btrfs_validate_super(fs_info, fs_info->super_copy, 0);
 }
 
 /*
@@ -2904,7 +2904,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 {
 	int ret;
 
-	ret = validate_super(fs_info, sb, -1);
+	ret = btrfs_validate_super(fs_info, sb, -1);
 	if (ret < 0)
 		goto out;
 	if (!btrfs_supported_super_csum(btrfs_super_csum_type(sb))) {
@@ -3945,7 +3945,7 @@ static void btrfs_end_super_write(struct bio *bio)
 }
 
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num)
+						   int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
 	struct page *page;
@@ -3963,6 +3963,19 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
 		return ERR_PTR(-EINVAL);
 
+	if (drop_cache) {
+		/* This should only be called with the primary sb. */
+		ASSERT(copy_num == 0);
+
+		/*
+		 * Drop the page of the primary superblock, so later read will
+		 * always read from the device.
+		 */
+		invalidate_inode_pages2_range(mapping,
+				bytenr >> PAGE_SHIFT,
+				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
+	}
+
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
@@ -3994,7 +4007,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i);
+		super = btrfs_read_dev_one_super(bdev, i, false);
 		if (IS_ERR(super))
 			continue;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index b4962b7d7117..ece5a3112b4f 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -53,10 +53,12 @@ int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
+int btrfs_validate_super(struct btrfs_fs_info *fs_info,
+			 struct btrfs_super_block *sb, int mirror_num);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
 struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num);
+						   int copy_num, bool drop_cache);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index aff66f99b343..83cc09d98c0c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2562,11 +2562,71 @@ static int btrfs_freeze(struct super_block *sb)
 	return btrfs_commit_transaction(trans);
 }
 
+static int check_dev_super(struct btrfs_device *dev)
+{
+	struct btrfs_fs_info *fs_info = dev->fs_info;
+	struct btrfs_super_block *sb;
+	int ret = 0;
+
+	/* This should be called with fs still frozen. */
+	ASSERT(test_bit(BTRFS_FS_FROZEN, &fs_info->flags));
+
+	/* Missing dev, no need to check. */
+	if (!dev->bdev)
+		return 0;
+
+	/* Only need to check the primary super block. */
+	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	/* Btrfs_validate_super() includes fsid check against super->fsid. */
+	ret = btrfs_validate_super(fs_info, sb, 0);
+	if (ret < 0)
+		goto out;
+
+	if (btrfs_super_generation(sb) != fs_info->last_trans_committed) {
+		btrfs_err(fs_info, "transid mismatch, has %llu expect %llu",
+			btrfs_super_generation(sb),
+			fs_info->last_trans_committed);
+		ret = -EUCLEAN;
+		goto out;
+	}
+out:
+	btrfs_release_disk_super(sb);
+	return ret;
+}
+
 static int btrfs_unfreeze(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_device *device;
+	int ret = 0;
 
+	/*
+	 * Make sure the fs is not changed by accident (like hibernation then
+	 * modified by other OS).
+	 * If we found anything wrong, we mark the fs error immediately.
+	 *
+	 * And since the fs is frozen, no one can modify the fs yet, thus
+	 * we don't need to hold device_list_mutex.
+	 */
+	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
+		ret = check_dev_super(device);
+		if (ret < 0) {
+			btrfs_handle_fs_error(fs_info, ret,
+				"super block on devid %llu got modified unexpectedly",
+				device->devid);
+			break;
+		}
+	}
 	clear_bit(BTRFS_FS_FROZEN, &fs_info->flags);
+
+	/*
+	 * We still return 0, to allow VFS layer to unfreeze the fs even the
+	 * above checks failed. Since the fs is either fine or read-only, we're
+	 * safe to continue, without causing further damage.
+	 */
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 16e01fbdcec8..4f9c0c5b9613 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2016,7 +2016,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 		struct page *page;
 		int ret;
 
-		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
+		disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
 		if (IS_ERR(disk_super))
 			continue;
 
-- 
2.35.1

