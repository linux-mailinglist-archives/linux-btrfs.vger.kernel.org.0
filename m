Return-Path: <linux-btrfs+bounces-14551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B68AD183F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 07:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ED31889D38
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 05:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A427327FB2B;
	Mon,  9 Jun 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qPFfvXMt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qPFfvXMt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674D1A841F
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446417; cv=none; b=PFga4s3bFT2Yj7VaUzDAmx3mtMjh+2xYhJYghZ3LqmyaKtNIV0Det3YljPwaosdQASQBr0vAJY1ZtvqP0i0+PM5LkaAulti3j65TjmrUoSHvbDAbW21VdcAFqjhETvpnAnknKnG0WlpK+wUZwivY93L1WD6tPzxHO3xspbaVrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446417; c=relaxed/simple;
	bh=9kqtDkijQoEaxuGa8KmUNAnpYsdFIFgUf1vxJqzxU7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUZwyZRkmXWYB2sr4XCx1CWEbqG0UkFJxd/xjRH/j/ujeV75bDZ6xjvWT9QgIg+mXzt4luk0PHJOJtfG5hlahtN7T3I4oSQpwbsCq3zD+oAxCaUwVA7Q4AZSBh2UFpVvpjwDrQOeCZSTICiXfkK/U27uZwjxhMijj18pB+nWLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qPFfvXMt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qPFfvXMt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DC7021175
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/qx1FGTHt8/9XAZY6Ar8qbykKtK7k/SYukp3ulW28I=;
	b=qPFfvXMtK2Fucl2ZRbFl1XiWqB3dzf1ugVsYplDuQ2nwtk8PokmfuRtzpjiy1OpsbglAhm
	IEyzDyWzald2lobIEGULIJ4Mfh//lPde08ics1Hp+42AMEF1IXqMCSLpjBXPcVxZVBgUCS
	WzIfHBLNc+4rQjRung7YchM48oUar6U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qPFfvXMt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/qx1FGTHt8/9XAZY6Ar8qbykKtK7k/SYukp3ulW28I=;
	b=qPFfvXMtK2Fucl2ZRbFl1XiWqB3dzf1ugVsYplDuQ2nwtk8PokmfuRtzpjiy1OpsbglAhm
	IEyzDyWzald2lobIEGULIJ4Mfh//lPde08ics1Hp+42AMEF1IXqMCSLpjBXPcVxZVBgUCS
	WzIfHBLNc+4rQjRung7YchM48oUar6U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88A32137FE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YC/CEgtvRmjqVQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 09 Jun 2025 05:20:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: implement a basic per-block-device call backs
Date: Mon,  9 Jun 2025 14:49:49 +0930
Message-ID: <1f8ab4b5fd228849fbf30411a968cc1d6dfadece.1749446257.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749446257.git.wqu@suse.com>
References: <cover.1749446257.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4DC7021175
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

Currently btrfs doesn't implement any per-block-device call backs, nor
utilize the single device generic one from fs_holder_ops, as btrfs is a
multi-device fs and it doesn't go through the common setup_bdev_super()
path.

For the incoming support of mark_dead() call back, implement a basic
sync/freeze/thaw callbacks first.

Those call backs are just a wrapper of the per-fs ioctl versions, with
the extra modifications to handle mount/unmount races:

- Add a atomic_t to record how many bdev callbacks are running
  So that at unmount time we can properly wait for them.

- Add a helper to properly grab the fs_info
  The fs_info stored inside block_devices::bd_holder is ensured to be
  valid, as the life span of the fs_info covers the bdev:

  fs_info creation                                      fs_info free
  |      |                                    |         |
         btrfs devs open                      btrfs devs close
	 (bdev_file_open_*())                 (bdev_fput())

  But it doesn't mean it's safe to do thing when the fs is not yet
  mounted nor is closing.

  So a helper, get_bdev_fs_info() is introduecd to:

  * Check if the fs_info is properly mounted and not being closed
  * Increase the bdev_ops_running atomic
  * Make fs closing to wait for any unfinished bdev operations

  This should help us to avoid race against mount/unmount races

- Add a helper to release the fs_info for bdev call backs
  The helper put_bdev_fs_info() will decrease the bdev_ops_running
  atomic and wakeup the wait.

- Harden unfreeze checks
  Since it's possible to call free/unfree on two different devices of
  btrfs at the same time, we may hit a race that two processes are
  trying to unfreeze the same fs at the same time.

  Normally the freeze/thaw is just a single bit operation, but for
  thaw btrfs will do extra super block checks, we need to protect the
  super block checks with the proper device_list_mutex.

  And since it's possible that two processes are running the same thaw
  operation, add an extra mutex and extra checks for freeze/thaw.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/disk-io.c     | 11 ++++++
 fs/btrfs/fs.h          | 12 ++++++
 fs/btrfs/super.c       | 24 +++++++++---
 fs/btrfs/super.h       |  2 +
 fs/btrfs/volumes.c     | 86 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h     |  1 +
 7 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 42d795156397..81091e22478c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -250,7 +250,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					   fs_info, NULL);
+					   fs_info, &btrfs_bdev_ops);
 	if (IS_ERR(bdev_file)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev_file);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3def93016963..a71ea9eb5646 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2843,6 +2843,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	atomic_set(&fs_info->async_delalloc_pages, 0);
 	atomic_set(&fs_info->defrag_running, 0);
 	atomic_set(&fs_info->nr_delayed_iputs, 0);
+	atomic_set(&fs_info->bdev_ops_running, 0);
 	atomic64_set(&fs_info->tree_mod_seq, 0);
 	fs_info->global_root_tree = RB_ROOT;
 	fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
@@ -2876,6 +2877,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->transaction_kthread_mutex);
 	mutex_init(&fs_info->cleaner_mutex);
 	mutex_init(&fs_info->ro_block_group_mutex);
+	mutex_init(&fs_info->freeze_mutex);
 	init_rwsem(&fs_info->commit_root_sem);
 	init_rwsem(&fs_info->cleanup_work_sem);
 	init_rwsem(&fs_info->subvol_sem);
@@ -2893,6 +2895,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	init_waitqueue_head(&fs_info->transaction_blocked_wait);
 	init_waitqueue_head(&fs_info->async_submit_wait);
 	init_waitqueue_head(&fs_info->delayed_iputs_wait);
+	init_waitqueue_head(&fs_info->bdev_ops_wait);
 
 	/* Usable values until the real ones are cached from the superblock */
 	fs_info->nodesize = 4096;
@@ -4197,6 +4200,14 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	set_bit(BTRFS_FS_CLOSING_START, &fs_info->flags);
 
+	/*
+	 * Wait for any bdev operations first.
+	 * After setting the above CLOSING_START bit, we will no longer
+	 * accept any new bdev operations.
+	 */
+	wait_event(fs_info->bdev_ops_wait,
+		   (atomic_read(&fs_info->bdev_ops_running) == 0));
+
 	/*
 	 * If we had UNFINISHED_DROPS we could still be processing them, so
 	 * clear that bit and wake up relocation so it can stop.
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d90304d4e32c..4c8df5f4ba1a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -541,6 +541,14 @@ struct btrfs_fs_info {
 	struct mutex transaction_kthread_mutex;
 	struct mutex cleaner_mutex;
 	struct mutex chunk_mutex;
+	/*
+	 * Serialize freeze/unfreeze operations.
+	 *
+	 * Freeze/thaw is shared by not only the per-fs freeze/thaw but also
+	 * per-bdev callbacks, thus need a unified mutex inside btrfs to handle
+	 * per-fs and per-bdev races correctly.
+	 */
+	struct mutex freeze_mutex;
 
 	/*
 	 * This is taken to make sure we don't set block groups ro after the
@@ -690,6 +698,10 @@ struct btrfs_fs_info {
 	struct rb_root defrag_inodes;
 	atomic_t defrag_running;
 
+	/* For per-block-device callbacks.*/
+	atomic_t bdev_ops_running;
+	wait_queue_head_t bdev_ops_wait;
+
 	/* Used to protect avail_{data, metadata, system}_alloc_bits */
 	seqlock_t profiles_lock;
 	/*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c1efd20166cc..a847d64803cb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2273,11 +2273,19 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
-static int btrfs_freeze(struct super_block *sb)
+int btrfs_freeze(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
+	mutex_lock(&fs_info->freeze_mutex);
+	if (test_bit(BTRFS_FS_FROZEN, &fs_info->flags)) {
+		mutex_unlock(&fs_info->freeze_mutex);
+		return -EBUSY;
+	}
+
+
 	set_bit(BTRFS_FS_FROZEN, &fs_info->flags);
+	mutex_unlock(&fs_info->freeze_mutex);
 	/*
 	 * We don't need a barrier here, we'll wait for any transaction that
 	 * could be in progress on other threads (and do delayed iputs that
@@ -2339,20 +2347,24 @@ static int check_dev_super(struct btrfs_device *dev)
 	return ret;
 }
 
-static int btrfs_unfreeze(struct super_block *sb)
+int btrfs_unfreeze(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_device *device;
 	int ret = 0;
 
+	mutex_lock(&fs_info->freeze_mutex);
+	if (!test_bit(BTRFS_FS_FROZEN, &fs_info->flags)) {
+		mutex_unlock(&fs_info->freeze_mutex);
+		return -EINVAL;
+	}
+
 	/*
 	 * Make sure the fs is not changed by accident (like hibernation then
 	 * modified by other OS).
 	 * If we found anything wrong, we mark the fs error immediately.
-	 *
-	 * And since the fs is frozen, no one can modify the fs yet, thus
-	 * we don't need to hold device_list_mutex.
 	 */
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
 		ret = check_dev_super(device);
 		if (ret < 0) {
@@ -2362,7 +2374,9 @@ static int btrfs_unfreeze(struct super_block *sb)
 			break;
 		}
 	}
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 	clear_bit(BTRFS_FS_FROZEN, &fs_info->flags);
+	mutex_unlock(&fs_info->freeze_mutex);
 
 	/*
 	 * We still return 0, to allow VFS layer to unfreeze the fs even the
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index d80a86acfbbe..1d4a029a6042 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -14,6 +14,8 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
 			 unsigned long long *mount_opt,
 			 unsigned long flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
+int btrfs_freeze(struct super_block *sb);
+int btrfs_unfreeze(struct super_block *sb);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
 void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d17d898fd12b..d7cfc883c834 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -256,6 +256,88 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
 out_overflow:;
 }
 
+static struct btrfs_fs_info *get_bdev_fs_info(struct block_device *bdev)
+	__releases(&bdev->bd_holder_lock)
+{
+	struct btrfs_fs_info *fs_info = bdev->bd_holder;
+
+	if (!fs_info)
+		goto out;
+
+	/*
+	 * The fs_info's lifespan is ensured to cover the lifespan of an opened
+	 * bdev, so we are safe to access the fs_info.
+	 */
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags) ||
+	    btrfs_fs_closing(fs_info)) {
+		fs_info = NULL;
+		goto out;
+	}
+	atomic_inc(&fs_info->bdev_ops_running);
+
+out:
+	mutex_unlock(&bdev->bd_holder_lock);
+	return fs_info;
+}
+
+static void put_bdev_fs_info(struct btrfs_fs_info *fs_info)
+{
+	if (!fs_info)
+		return;
+	if (atomic_dec_and_test(&fs_info->bdev_ops_running))
+		wake_up(&fs_info->bdev_ops_wait);
+}
+
+static void btrfs_bdev_sync(struct block_device *bdev)
+{
+	struct btrfs_fs_info *fs_info = get_bdev_fs_info(bdev);
+	int ret;
+
+	if (!fs_info)
+		goto out;
+	ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
+	if (ret)
+		goto out;
+	btrfs_sync_fs(fs_info->sb, 1);
+	wake_up_process(fs_info->cleaner_kthread);
+out:
+	put_bdev_fs_info(fs_info);
+}
+
+static int btrfs_bdev_freeze(struct block_device *bdev)
+{
+	struct btrfs_fs_info *fs_info = get_bdev_fs_info(bdev);
+	int ret = 0;
+
+	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
+	if (!fs_info)
+		goto out;
+	ret = btrfs_freeze(fs_info->sb);
+out:
+	put_bdev_fs_info(fs_info);
+	return ret;
+}
+
+static int btrfs_bdev_unfreeze(struct block_device *bdev)
+{
+	struct btrfs_fs_info *fs_info = get_bdev_fs_info(bdev);
+	int ret = 0;
+
+	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
+	if (!fs_info)
+		goto out;
+	ret = btrfs_unfreeze(fs_info->sb);
+out:
+	put_bdev_fs_info(fs_info);
+	return ret;
+}
+
+const struct blk_holder_ops btrfs_bdev_ops = {
+	.sync = btrfs_bdev_sync,
+	.freeze = btrfs_bdev_freeze,
+	.thaw = btrfs_bdev_unfreeze,
+};
+
 static int init_first_rw_device(struct btrfs_trans_handle *trans);
 static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info);
 static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
@@ -473,7 +555,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	struct block_device *bdev;
 	int ret;
 
-	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, NULL);
+	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, &btrfs_bdev_ops);
 
 	if (IS_ERR(*bdev_file)) {
 		ret = PTR_ERR(*bdev_file);
@@ -2705,7 +2787,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					   fs_info, NULL);
+					   fs_info, &btrfs_bdev_ops);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6d8b1f38e3ee..b4b8adc80e52 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -607,6 +607,7 @@ struct btrfs_raid_attr {
 };
 
 extern const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES];
+extern const struct blk_holder_ops btrfs_bdev_ops;
 
 struct btrfs_chunk_map {
 	struct rb_node rb_node;
-- 
2.49.0


