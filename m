Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32396273D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 01:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiKNA1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 19:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiKNA04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 19:26:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AACDFDA
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 16:26:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4A5822DEA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668385613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvlHGmx+mrWuEP5k35uemNXzovmEeLP5kyALGmTdrn8=;
        b=gNH6pDGXqB5xsoV0sDFli5EzrwkWpF5luf2bXlgEbb0aG0CYr/lWBCGjMdjI381HZYQU6M
        XrmWSLFffouR4xp4m5DQ3u4ipiqMABMRV1lCm++aR08DXUiV+skKAykOjW7ZCF4PrlPS5E
        Kh0xW4iWdrwGA3kiaS+Dz5x8CjvkNhY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2531313A18
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OG8SN0yLcWN9dAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: use btrfs_dev_name() helper to handle missing devices better
Date:   Mon, 14 Nov 2022 08:26:30 +0800
Message-Id: <3382bb8f7ab90e52ffa86cb39253ab5bdb78026e.1668384746.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668384746.git.wqu@suse.com>
References: <cover.1668384746.git.wqu@suse.com>
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
If dev-replace failed to re-construct its data/metadata, the kernel
message would be incorrect for the missing device:

 BTRFS info (device dm-1): dev_replace from <missing disk> (devid 2) to /dev/mapper/test-scratch2 started
 BTRFS error (device dm-1): failed to rebuild valid logical 38862848 for dev (efault)

Note the above "dev (efault)" of the second line.
While the first line is properly reporting "<missing disk>".

[CAUSE]
Although dev-replace is using btrfs_dev_name(), the heavy lifting work
is still done by scrub (scrub is reused by both dev-replace and regular
scrub).

Unfortunately scrub code never uses btrfs_dev_name() helper, as it's
only declared locally inside dev-replace.c.

[FIX]
Fix the output by:

- Move the btrfs_dev_name() helper to volumes.h

- Use btrfs_dev_name() to replace open-coded rcu_str_defref() calls
  Only zoned code is not touched, as I'm not familiar with degraded
  zoned code.

Now the output looks pretty sane:

 BTRFS info (device dm-1): dev_replace from <missing disk> (devid 2) to /dev/mapper/test-scratch2 started
 BTRFS error (device dm-1): failed to rebuild valid logical 38862848 for dev <missing disk>

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/check-integrity.c |  2 +-
 fs/btrfs/dev-replace.c     | 15 +++------------
 fs/btrfs/disk-io.c         |  2 +-
 fs/btrfs/extent-tree.c     |  2 +-
 fs/btrfs/extent_io.c       |  3 +--
 fs/btrfs/ioctl.c           |  4 ++--
 fs/btrfs/scrub.c           | 20 +++++++++-----------
 fs/btrfs/super.c           |  2 +-
 fs/btrfs/volumes.c         | 16 ++++++++--------
 fs/btrfs/volumes.h         |  9 +++++++++
 10 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 7ff0703ef3e4..82e49d985019 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -757,7 +757,7 @@ static int btrfsic_process_superblock_dev_mirror(
 			btrfs_info_in_rcu(fs_info,
 			"new initial S-block (bdev %p, %s) @%llu (%pg/%llu/%d)",
 				     superblock_bdev,
-				     rcu_str_deref(device->name), dev_bytenr,
+				     btrfs_dev_name(device), dev_bytenr,
 				     dev_state->bdev, dev_bytenr,
 				     superblock_mirror_num);
 		list_add(&superblock_tmp->all_blocks_node,
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 9c4a8649a0f4..78696d331639 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -18,7 +18,6 @@
 #include "volumes.h"
 #include "async-thread.h"
 #include "check-integrity.h"
-#include "rcu-string.h"
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "zoned.h"
@@ -451,14 +450,6 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
-static char* btrfs_dev_name(struct btrfs_device *device)
-{
-	if (!device || test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
-		return "<missing disk>";
-	else
-		return rcu_str_deref(device->name);
-}
-
 static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 				    struct btrfs_device *src_dev)
 {
@@ -674,7 +665,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		      "dev_replace from %s (devid %llu) to %s started",
 		      btrfs_dev_name(src_device),
 		      src_device->devid,
-		      rcu_str_deref(tgt_device->name));
+		      btrfs_dev_name(tgt_device));
 
 	/*
 	 * from now on, the writes to the srcdev are all duplicated to
@@ -933,7 +924,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				 "btrfs_scrub_dev(%s, %llu, %s) failed %d",
 				 btrfs_dev_name(src_device),
 				 src_device->devid,
-				 rcu_str_deref(tgt_device->name), scrub_ret);
+				 btrfs_dev_name(tgt_device), scrub_ret);
 error:
 		up_write(&dev_replace->rwsem);
 		mutex_unlock(&fs_info->chunk_mutex);
@@ -951,7 +942,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 			  "dev_replace from %s (devid %llu) to %s finished",
 			  btrfs_dev_name(src_device),
 			  src_device->devid,
-			  rcu_str_deref(tgt_device->name));
+			  btrfs_dev_name(tgt_device));
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &tgt_device->dev_state);
 	tgt_device->devid = src_device->devid;
 	src_device->devid = BTRFS_DEV_REPLACE_DEVID;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 559e7f3d727e..91a088210e5a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3944,7 +3944,7 @@ static void btrfs_end_super_write(struct bio *bio)
 		if (bio->bi_status) {
 			btrfs_warn_rl_in_rcu(device->fs_info,
 				"lost page write due to IO error on %s (%d)",
-				rcu_str_deref(device->name),
+				btrfs_dev_name(device),
 				blk_status_to_errno(bio->bi_status));
 			ClearPageUptodate(page);
 			SetPageError(page);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 10cc757a602b..17f599027c3d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6048,7 +6048,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 			btrfs_warn_in_rcu(fs_info,
 "ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
 					  start, end - start + 1,
-					  rcu_str_deref(device->name),
+					  btrfs_dev_name(device),
 					  device->total_bytes);
 			mutex_unlock(&fs_info->chunk_mutex);
 			ret = 0;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 704ae7c08867..65ba5c3658cf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -611,8 +611,7 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 
 	btrfs_info_rl_in_rcu(fs_info,
 		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
-				  ino, start,
-				  rcu_str_deref(dev->name), sector);
+			     ino, start, btrfs_dev_name(dev), sector);
 	ret = 0;
 
 out_bio_uninit:
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7a9e697d9931..bed74a3ff574 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1228,7 +1228,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	if (ret == 0 && new_size != old_size)
 		btrfs_info_in_rcu(fs_info,
 			"resize device %s (devid %llu) from %llu to %llu",
-			rcu_str_deref(device->name), device->devid,
+			btrfs_dev_name(device), device->devid,
 			old_size, new_size);
 out_finish:
 	btrfs_exclop_finish(fs_info);
@@ -2860,7 +2860,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 	di_args->total_bytes = btrfs_device_get_total_bytes(dev);
 	memcpy(di_args->uuid, dev->uuid, sizeof(di_args->uuid));
 	if (dev->name) {
-		strncpy(di_args->path, rcu_str_deref(dev->name),
+		strncpy(di_args->path, btrfs_dev_name(dev),
 				sizeof(di_args->path) - 1);
 		di_args->path[sizeof(di_args->path) - 1] = 0;
 	} else {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 288a97992aa4..0ce5b773867f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -17,7 +17,6 @@
 #include "extent_io.h"
 #include "dev-replace.h"
 #include "check-integrity.h"
-#include "rcu-string.h"
 #include "raid56.h"
 #include "block-group.h"
 #include "zoned.h"
@@ -877,7 +876,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 		btrfs_warn_in_rcu(fs_info,
 "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
 				  swarn->errstr, swarn->logical,
-				  rcu_str_deref(swarn->dev->name),
+				  btrfs_dev_name(swarn->dev),
 				  swarn->physical,
 				  root, inum, offset,
 				  fs_info->sectorsize, nlink,
@@ -891,7 +890,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	btrfs_warn_in_rcu(fs_info,
 			  "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
 			  swarn->errstr, swarn->logical,
-			  rcu_str_deref(swarn->dev->name),
+			  btrfs_dev_name(swarn->dev),
 			  swarn->physical,
 			  root, inum, offset, ret);
 
@@ -922,8 +921,7 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	/* Super block error, no need to search extent tree. */
 	if (sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
 		btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %llu",
-			errstr, rcu_str_deref(dev->name),
-			sblock->physical);
+			errstr, btrfs_dev_name(dev), sblock->physical);
 		return;
 	}
 	path = btrfs_alloc_path();
@@ -954,7 +952,7 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 			btrfs_warn_in_rcu(fs_info,
 "%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
 				errstr, swarn.logical,
-				rcu_str_deref(dev->name),
+				btrfs_dev_name(dev),
 				swarn.physical,
 				ref_level ? "node" : "leaf",
 				ret < 0 ? -1 : ref_level,
@@ -1377,7 +1375,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			spin_unlock(&sctx->stat_lock);
 			btrfs_err_rl_in_rcu(fs_info,
 				"fixed up error at logical %llu on dev %s",
-				logical, rcu_str_deref(dev->name));
+				logical, btrfs_dev_name(dev));
 		}
 	} else {
 did_not_correct_error:
@@ -1386,7 +1384,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		spin_unlock(&sctx->stat_lock);
 		btrfs_err_rl_in_rcu(fs_info,
 			"unable to fixup (regular) error at logical %llu on dev %s",
-			logical, rcu_str_deref(dev->name));
+			logical, btrfs_dev_name(dev));
 	}
 
 out:
@@ -2332,14 +2330,14 @@ static void scrub_missing_raid56_worker(struct work_struct *work)
 		spin_unlock(&sctx->stat_lock);
 		btrfs_err_rl_in_rcu(fs_info,
 			"IO error rebuilding logical %llu for dev %s",
-			logical, rcu_str_deref(dev->name));
+			logical, btrfs_dev_name(dev));
 	} else if (sblock->header_error || sblock->checksum_error) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.uncorrectable_errors++;
 		spin_unlock(&sctx->stat_lock);
 		btrfs_err_rl_in_rcu(fs_info,
 			"failed to rebuild valid logical %llu for dev %s",
-			logical, rcu_str_deref(dev->name));
+			logical, btrfs_dev_name(dev));
 	} else {
 		scrub_write_block_to_dev_replace(sblock);
 	}
@@ -4303,7 +4301,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		btrfs_err_in_rcu(fs_info,
 			"scrub on devid %llu: filesystem on %s is not writable",
-				 devid, rcu_str_deref(dev->name));
+				 devid, btrfs_dev_name(dev));
 		ret = -EROFS;
 		goto out;
 	}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d54bfec8e506..ea83dd9f735a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2336,7 +2336,7 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 	 * the end of RCU grace period.
 	 */
 	rcu_read_lock();
-	seq_escape(m, rcu_str_deref(fs_info->fs_devices->latest_dev->name), " \t\n\\");
+	seq_escape(m, btrfs_dev_name(fs_info->fs_devices->latest_dev), " \t\n\\");
 	rcu_read_unlock();
 
 	return 0;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 49d6e79d4343..2d0950a17f48 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -941,7 +941,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			}
 			btrfs_info_in_rcu(NULL,
 	"devid %llu device path %s changed to %s scanned by %s (%d)",
-					  devid, rcu_str_deref(device->name),
+					  devid, btrfs_dev_name(device),
 					  path, current->comm,
 					  task_pid_nr(current));
 		}
@@ -2101,7 +2101,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	if (btrfs_pinned_by_swapfile(fs_info, device)) {
 		btrfs_warn_in_rcu(fs_info,
 		  "cannot remove device %s (devid %llu) due to active swapfile",
-				  rcu_str_deref(device->name), device->devid);
+				  btrfs_dev_name(device), device->devid);
 		return -ETXTBSY;
 	}
 
@@ -6827,7 +6827,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	btrfs_debug_in_rcu(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
-		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
+		(unsigned long)dev->bdev->bd_dev, btrfs_dev_name(dev),
 		dev->devid, bio->bi_iter.bi_size);
 
 	btrfsic_check_bio(bio);
@@ -7908,7 +7908,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 	if (ret < 0) {
 		btrfs_warn_in_rcu(fs_info,
 			"error %d while searching for dev_stats item for device %s",
-			      ret, rcu_str_deref(device->name));
+				  ret, btrfs_dev_name(device));
 		goto out;
 	}
 
@@ -7919,7 +7919,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		if (ret != 0) {
 			btrfs_warn_in_rcu(fs_info,
 				"delete too small dev_stats item for device %s failed %d",
-				      rcu_str_deref(device->name), ret);
+					  btrfs_dev_name(device), ret);
 			goto out;
 		}
 		ret = 1;
@@ -7933,7 +7933,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		if (ret < 0) {
 			btrfs_warn_in_rcu(fs_info,
 				"insert dev_stats item for device %s failed %d",
-				rcu_str_deref(device->name), ret);
+				btrfs_dev_name(device), ret);
 			goto out;
 		}
 	}
@@ -7998,7 +7998,7 @@ void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index)
 		return;
 	btrfs_err_rl_in_rcu(dev->fs_info,
 		"bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, gen %u",
-			   rcu_str_deref(dev->name),
+			   btrfs_dev_name(dev),
 			   btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WRITE_ERRS),
 			   btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_READ_ERRS),
 			   btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_FLUSH_ERRS),
@@ -8018,7 +8018,7 @@ static void btrfs_dev_stat_print_on_load(struct btrfs_device *dev)
 
 	btrfs_info_in_rcu(dev->fs_info,
 		"bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, gen %u",
-	       rcu_str_deref(dev->name),
+	       btrfs_dev_name(dev),
 	       btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WRITE_ERRS),
 	       btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_READ_ERRS),
 	       btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_FLUSH_ERRS),
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index efa6a3d48cd8..db6b69c96c0d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -12,6 +12,7 @@
 #include "async-thread.h"
 #include "messages.h"
 #include "disk-io.h"
+#include "rcu-string.h"
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
@@ -770,6 +771,14 @@ static inline void btrfs_dev_stat_set(struct btrfs_device *dev,
 	atomic_inc(&dev->dev_stats_ccnt);
 }
 
+static inline char* btrfs_dev_name(struct btrfs_device *device)
+{
+	if (!device || test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+		return "<missing disk>";
+	else
+		return rcu_str_deref(device->name);
+}
+
 void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
 struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
-- 
2.38.1

