Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A559F961
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiHXMRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiHXMQu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 08:16:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9E72B7B
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 05:16:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2C6E342CB;
        Wed, 24 Aug 2022 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661343400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PZewWktnyw7UviIO/HBIWxKCFCRjbRhBa+Otj9ehbxs=;
        b=RhJS8AZE3GjqFv416qAkEMIlVq3m51u1xKvny2dqGXbKs+XRjj0JsHbSOiWs654vRbcrc3
        4ytsaZlfgbKq3TYdJuRy15u7Pa3JMCm+QCXqdwk7dEP+1s/Hy4eXj79Fk8+Dc8V3pX5pc/
        AcoFWst+u9Bze5XA7vPrQoSTcnNsaX4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D039013AC0;
        Wed, 24 Aug 2022 12:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id swcrJqcWBmPHSwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 24 Aug 2022 12:16:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH v3] btrfs: check the superblock to ensure the fs is not modified at thaw time
Date:   Wed, 24 Aug 2022 20:16:22 +0800
Message-Id: <e0a051edb23223036ebe21a01dd5d9ab63e54cc9.1661343122.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
and if there is any unexpected change, we just mark the fs read-only, and
thaw the fs.

By this we can limit the damage to minimal, and I hope no one would lose
their data by this anymore.

Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Use invalidate_inode_pages2_range() to avoid tricky page alignment
  Previously I use truncate_inode_pages_range() with page aligned range.
  But this can be confusing since truncate_inode_pages_ragen() can
  fill unaligned range with zero. (thus I intentionally align the
  range).

  Since we're only interesting dropping the page cache, use
  invalidate_inode_pages2_range() should be better.

- Export btrfs_validate_super() to do full super block check at thaw
  time
  This brings all the checks, and since freeze/thaw should be a cold
  path, the extra check shouldn't bother us much.

- Add an extra comment on why we don't need to hold device_list_mutex.

v2:
- Remove one unrelated debug pr_info()
- Slightly re-word some comments
- Add suggested-by tag
---
 fs/btrfs/disk-io.c | 25 ++++++++++++++-----
 fs/btrfs/disk-io.h |  4 +++-
 fs/btrfs/super.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 +-
 4 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e67614afcf4f..bc94feba2fe3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2600,8 +2600,8 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -2785,7 +2785,7 @@ static int validate_super(struct btrfs_fs_info *fs_info,
  */
 static int btrfs_validate_mount_super(struct btrfs_fs_info *fs_info)
 {
-	return validate_super(fs_info, fs_info->super_copy, 0);
+	return btrfs_validate_super(fs_info, fs_info->super_copy, 0);
 }
 
 /*
@@ -2799,7 +2799,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 {
 	int ret;
 
-	ret = validate_super(fs_info, sb, -1);
+	ret = btrfs_validate_super(fs_info, sb, -1);
 	if (ret < 0)
 		goto out;
 	if (!btrfs_supported_super_csum(btrfs_super_csum_type(sb))) {
@@ -3847,7 +3847,7 @@ static void btrfs_end_super_write(struct bio *bio)
 }
 
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num)
+						   int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
 	struct page *page;
@@ -3865,6 +3865,19 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
 		return ERR_PTR(-EINVAL);
 
+	if (drop_cache) {
+		/* This should only be called with the primary sb. */
+		ASSERT(copy_num == 0);
+
+		/*
+		 * Drop the page of the primary superblock, so later
+		 * read will always read from the device.
+		 */
+		invalidate_inode_pages2_range(mapping,
+				bytenr >> PAGE_SHIFT,
+				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
+	}
+
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
@@ -3896,7 +3909,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i);
+		super = btrfs_read_dev_one_super(bdev, i, false);
 		if (IS_ERR(super))
 			continue;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 47ad8e0a2d33..aef981de672c 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -46,10 +46,12 @@ int __cold open_ctree(struct super_block *sb,
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
index f1c6ca59299e..0857265ea8d8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2553,11 +2553,71 @@ static int btrfs_freeze(struct super_block *sb)
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
+	 * We still return 0, to allow VFS layer to unfreeze the fs even above
+	 * checks failed. Since the fs is either fine or RO, we're safe to
+	 * continue, without causing further damage.
+	 */
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 95a2eaf8a958..5b2cafafce2e 100644
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
2.37.2

