Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46065FB755
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiJKPc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiJKPc3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 11:32:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48629DDA9;
        Tue, 11 Oct 2022 08:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A79EB81633;
        Tue, 11 Oct 2022 14:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5628FC43470;
        Tue, 11 Oct 2022 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665500013;
        bh=wEdwXKsCN6anstaaDpgBE/tfOjXSIg8GvgNaZFp6SOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHEiENsB9hm/mfeBgO9ClUW/wySVJppssV9oaiU0QswpHMfTCGQYlcbeT2DW+VvVs
         h3hfI8jc+c1aCfBo4vKz6GZR7illyrUM+3DlZvuD2R47/1Vorx9jpp15BltGevsV7I
         SAmv7hkYEca5dqykBn1pBcrte+AxyMK3NrBxXor0VBMmMwHqSB8DrBVT1vx/EITZqB
         +fiHM62PHV8pkPKN4yk8BwGQspwyeXB7eY5fQQIRTpofMLGbbYcpdSG9p5OUOwChmH
         RDqsMhc2zgX4XZZQ825sbFdC2lq3wfoEJFx90zXPOMqJt660hIq3HewwXhEc21GE++
         n815pX7Sg0Obw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Goffredo Baroncelli <kreijack@libero.it>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 14/17] btrfs: check superblock to ensure the fs was not modified at thaw time
Date:   Tue, 11 Oct 2022 10:53:09 -0400
Message-Id: <20221011145312.1624341-14-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011145312.1624341-1-sashal@kernel.org>
References: <20221011145312.1624341-1-sashal@kernel.org>
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
index f2abd8bfd4a0..8af0d722ab9a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2400,8 +2400,8 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -2576,7 +2576,7 @@ static int validate_super(struct btrfs_fs_info *fs_info,
  */
 static int btrfs_validate_mount_super(struct btrfs_fs_info *fs_info)
 {
-	return validate_super(fs_info, fs_info->super_copy, 0);
+	return btrfs_validate_super(fs_info, fs_info->super_copy, 0);
 }
 
 /*
@@ -2590,7 +2590,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 {
 	int ret;
 
-	ret = validate_super(fs_info, sb, -1);
+	ret = btrfs_validate_super(fs_info, sb, -1);
 	if (ret < 0)
 		goto out;
 	if (!btrfs_supported_super_csum(btrfs_super_csum_type(sb))) {
@@ -3500,7 +3500,7 @@ static void btrfs_end_super_write(struct bio *bio)
 }
 
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num)
+						   int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
 	struct page *page;
@@ -3511,6 +3511,19 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
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
@@ -3542,7 +3555,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i);
+		super = btrfs_read_dev_one_super(bdev, i, false);
 		if (IS_ERR(super))
 			continue;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 182540bdcea0..a1bcd388dfec 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -54,10 +54,12 @@ int __cold open_ctree(struct super_block *sb,
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
index 8bf8cdb62a3a..97b06c24e443 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2400,11 +2400,71 @@ static int btrfs_freeze(struct super_block *sb)
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
index d4d89e0738ff..e14bd23cc75c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2069,7 +2069,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 		struct page *page;
 		int ret;
 
-		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
+		disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
 		if (IS_ERR(disk_super))
 			continue;
 
-- 
2.35.1

