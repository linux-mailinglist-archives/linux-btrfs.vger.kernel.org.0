Return-Path: <linux-btrfs+bounces-14521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0746ACFC4D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 07:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C76E162C72
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 05:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B51D5AC0;
	Fri,  6 Jun 2025 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jAEU75kw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jAEU75kw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AC10E0
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749188874; cv=none; b=NLDnCl+WZzfS/HmKYuLPAj8ILKS0JiIAhXeZRG7iyvq8mYT571C5QGOoaEu9DZpzo3BliNs5AsHyVTiFKCGVRLw3ZEQ/OMdYZ4VzDAnXKAMIi/tlN4eu3lRpFMtDSnyis30WkbyKj/KsyK9hPp4mHwZcBaGylAh5ZTQQglrfO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749188874; c=relaxed/simple;
	bh=s67ZnGwRVJHDBau6HL6DaM+H/6QrpAviB5duKGG9scw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqI+8tJVYUCsJOCHR7qbCCjF5V+iD2VfFZsQhah5SHbokZz979mpIsekSZ7ljnprfb0TDWds+ZnIK/Tyl4qgXIhzUm2KBbnwrOq6CKyaZ3fDVQlFKu7mwn3TJA95/B8ywWbLg3Xv7oCkHmgqcR+v8XUx0vs+J167k/Ej4Pf8kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jAEU75kw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jAEU75kw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6586922D65
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749188857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yO8xgaLLme3JvVbUGu77COQFoMCEZcuzo53yz053iQE=;
	b=jAEU75kwDzA8pArBz7+11BsvKBk9TfQxvMsEA8vZyHDO9CjQB0+QBcA15CJGKpaISknb96
	MJrenxK2tMWhD9wUwDqW5Y6/75hdWMdrsqiWlQJPNiWnQM2geSEjWSYzIUO7V0oTZexXSn
	daa+61dvL5hUgo3PlXc/yS8eGTFVbOo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749188857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yO8xgaLLme3JvVbUGu77COQFoMCEZcuzo53yz053iQE=;
	b=jAEU75kwDzA8pArBz7+11BsvKBk9TfQxvMsEA8vZyHDO9CjQB0+QBcA15CJGKpaISknb96
	MJrenxK2tMWhD9wUwDqW5Y6/75hdWMdrsqiWlQJPNiWnQM2geSEjWSYzIUO7V0oTZexXSn
	daa+61dvL5hUgo3PlXc/yS8eGTFVbOo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A18F51336F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CBfcGPiAQmjsTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Jun 2025 05:47:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add a simple dead device detection mechanism
Date: Fri,  6 Jun 2025 15:17:16 +0930
Message-ID: <d841034baa0e8beb05d7fd392cdfd8be771da567.1749188673.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749188673.git.wqu@suse.com>
References: <cover.1749188673.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Currently btrfs doesn't have a real mechanism to detect a dead device at
runtime.

This makes btrfs to treat intentionally or unintentionally removed
device as usual, making test case generic/730 to fail as btrfs still
return the cached data from page cache.
(The root cause is btrfs has no shutdown support for test cases
requiring shutdown)

Add a very basic and simple dead device detection mechanism for btrfs,
it utilized the blk_holder_ops for all opened btrfs devices, if a device
is removed unexpectedly or is going to be removed, btrfs will:

- Output a warning or info line for that device
- Mark that device as missing
- If the fs can not maintain RW operations mark the fs as error

Furthermore to grab the btrfs_device just from a block device, introduce
one extra member, btrfs_dev_lookup_args::devt.

Unlike other members, if this member is provided it's enough to uniquely
locate a btrfs_device without any other members populated.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/super.c       |  4 +-
 fs/btrfs/super.h       |  2 +
 fs/btrfs/volumes.c     | 88 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h     |  6 +++
 5 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index cf63f4b29327..c7f724dc7892 100644
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
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c1efd20166cc..2b03f54aac67 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2273,7 +2273,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
-static int btrfs_freeze(struct super_block *sb)
+int btrfs_freeze(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
@@ -2339,7 +2339,7 @@ static int check_dev_super(struct btrfs_device *dev)
 	return ret;
 }
 
-static int btrfs_unfreeze(struct super_block *sb)
+int btrfs_unfreeze(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_device *device;
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
index dae946ee6b07..96ee84ef0be0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -256,6 +256,88 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
 out_overflow:;
 }
 
+static void btrfs_dev_mark_dead(struct block_device *bdev, bool surprise)
+	__releases(&bdev->bd_holder_lock)
+{
+	struct btrfs_fs_info *fs_info = bdev->bd_holder;
+	struct btrfs_dev_lookup_args args = { .devt = bdev->bd_dev, };
+	struct btrfs_device *device;
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	device = btrfs_find_device(fs_info->fs_devices, &args);
+	if (unlikely(!device)) {
+		btrfs_crit(fs_info, "can't find a btrfs_device for %pg", bdev);
+		mutex_unlock(&bdev->bd_holder_lock);
+		goto out;
+	}
+	if (surprise)
+		btrfs_warn_in_rcu(fs_info, "devid %llu device %pg path %s is dead",
+				  device->devid, device->bdev, btrfs_dev_name(device));
+	else
+		btrfs_info_in_rcu(fs_info, "devid %llu device %pg path %s is going to be removed",
+				  device->devid, device->bdev, btrfs_dev_name(device));
+	mutex_unlock(&bdev->bd_holder_lock);
+	set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+	device->fs_devices->missing_devices++;
+	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
+		list_del_init(&device->dev_alloc_list);
+		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+		device->fs_devices->rw_devices--;
+	}
+	/*
+	 * If we can no longer maintain the RW opeartions for the fs, mark the
+	 * fs error.
+	 */
+	if (!btrfs_check_rw_degradable(fs_info, device)) {
+		btrfs_handle_fs_error(fs_info, -EIO,
+			"btrfs can no longer maintain read-write due to missing device(s)");
+	} else  {
+		btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+		btrfs_warn(fs_info, "filesystem degraded due to missing device(s)");
+	}
+out:
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+}
+
+static void btrfs_dev_sync(struct block_device *bdev)
+	__releases(&bdev->bd_holder_lock)
+{
+	struct btrfs_fs_info *fs_info = bdev->bd_holder;
+	int ret;
+
+	mutex_unlock(&bdev->bd_holder_lock);
+	ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
+	if (ret)
+		return;
+	ret = btrfs_sync_fs(fs_info->sb, 1);
+	wake_up_process(fs_info->cleaner_kthread);
+}
+
+static int btrfs_dev_freeze(struct block_device *bdev)
+	__releases(&bdev->bd_holder_lock)
+{
+	struct btrfs_fs_info *fs_info = bdev->bd_holder;
+
+	mutex_unlock(&bdev->bd_holder_lock);
+	return btrfs_freeze(fs_info->sb);
+}
+
+static int btrfs_dev_unfreeze(struct block_device *bdev)
+	__releases(&bdev->bd_holder_lock)
+{
+	struct btrfs_fs_info *fs_info = bdev->bd_holder;
+
+	mutex_unlock(&bdev->bd_holder_lock);
+	return btrfs_unfreeze(fs_info->sb);
+}
+
+const struct blk_holder_ops btrfs_bdev_ops = {
+	.mark_dead = btrfs_dev_mark_dead,
+	.sync = btrfs_dev_sync,
+	.freeze = btrfs_dev_freeze,
+	.thaw = btrfs_dev_unfreeze,
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
 
@@ -6798,6 +6880,8 @@ static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
 			return true;
 		return false;
 	}
+	if (args->devt)
+		return device->devt == args->devt;
 
 	if (device->devid != args->devid)
 		return false;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6d8b1f38e3ee..a16c6109154b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -607,6 +607,7 @@ struct btrfs_raid_attr {
 };
 
 extern const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES];
+extern const struct blk_holder_ops btrfs_bdev_ops;
 
 struct btrfs_chunk_map {
 	struct rb_node rb_node;
@@ -652,6 +653,11 @@ struct btrfs_dev_lookup_args {
 	u64 devid;
 	u8 *uuid;
 	u8 *fsid;
+	/*
+	 * If @devt is set (non-zero), then args will be ignored since the
+	 * non-zero dev_t can locate the device.
+	 */
+	dev_t devt;
 	bool missing;
 };
 
-- 
2.49.0


