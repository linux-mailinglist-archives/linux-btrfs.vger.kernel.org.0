Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8286F58F7E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 08:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiHKGrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 02:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiHKGrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 02:47:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49188A6C6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 23:47:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 556F4207A9;
        Thu, 11 Aug 2022 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660200448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OAAdzT6DYRIKmCrKAbsOcV2PaejTUkJssa4lmlYiQPo=;
        b=QPvtl1x/NSM955kpS88nK3bOdtsl21SwAxkNfEt/A+4iSlsV08afYc68JvT9WNjNEIho2E
        mzfkIvQaWW7wO1ad8/06VM9/KCizpRZi5MjmhwnC749QzfRMORyv0PjjNbSjEg4Y5XDo0i
        PKTKi9fvuSI5BR+IAHV8K1ZGBtsg7Gc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D014F1342A;
        Thu, 11 Aug 2022 06:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IHO0Bv6l9GKNJQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 11 Aug 2022 06:47:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH v2] btrfs: check the superblock to ensure the fs is not modified at thaw time
Date:   Thu, 11 Aug 2022 14:47:08 +0800
Message-Id: <8032f0bba42927fb4d87909060e03a647bb60c32.1660200417.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
and if there is any unexpected change, we just mark the fs RO, and thaw
the fs.

By this we can limit the damage to minimal, and I hope no one would lose
their data by this anymore.

Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove one unrelated debug pr_info()
- Slightly re-word some comments
- Add suggested-by tag
---
 fs/btrfs/disk-io.c |  9 +++++--
 fs/btrfs/disk-io.h |  2 +-
 fs/btrfs/super.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 +-
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6268dafeeb2d..7d99c42bdc51 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3849,7 +3849,7 @@ static void btrfs_end_super_write(struct bio *bio)
 }
 
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num)
+						   int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
 	struct page *page;
@@ -3867,6 +3867,11 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
 		return ERR_PTR(-EINVAL);
 
+	if (drop_cache)
+		truncate_inode_pages_range(bdev->bd_inode->i_mapping,
+				round_down(bytenr, PAGE_SIZE),
+				round_up(bytenr + BTRFS_SUPER_INFO_SIZE,
+					 PAGE_SIZE) - 1);
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
@@ -3898,7 +3903,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i);
+		super = btrfs_read_dev_one_super(bdev, i, false);
 		if (IS_ERR(super))
 			continue;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 47ad8e0a2d33..d0946f502f62 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -49,7 +49,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
 struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num);
+						   int copy_num, bool drop_cache);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4c7089b1681b..913b951981a9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2548,11 +2548,69 @@ static int btrfs_freeze(struct super_block *sb)
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
+	/* Missing dev,  no need to check. */
+	if (!dev->bdev)
+		return 0;
+
+	/* Only need to check the primary super block. */
+	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (memcmp(sb->fsid, dev->fs_devices->fsid, BTRFS_FSID_SIZE)) {
+		btrfs_err(fs_info, "fsid doesn't match, has %pU expect %pU",
+			  sb->fsid, dev->fs_devices->fsid);
+		ret = -EUCLEAN;
+		goto out;
+	}
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
+	 */
+	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
+		ret = check_dev_super(device);
+		if (ret < 0) {
+			btrfs_handle_fs_error(fs_info, ret,
+				"filesystem got modified unexpectedly");
+			break;
+		}
+	}
 	clear_bit(BTRFS_FS_FROZEN, &fs_info->flags);
+
+	/*
+	 * We still return 0, to allow VFS layer to unfreeze the fs even above
+	 * checks failed. Since the fs is either fine or RO, we're safe to
+	 * continue, without causing further damage.
+	 */
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8c64dda69404..a02066ae5812 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2017,7 +2017,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 		struct page *page;
 		int ret;
 
-		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
+		disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
 		if (IS_ERR(disk_super))
 			continue;
 
-- 
2.37.1

