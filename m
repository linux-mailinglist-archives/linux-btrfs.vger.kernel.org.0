Return-Path: <linux-btrfs+bounces-14953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCDAE84E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C2A161C59
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31125BF06;
	Wed, 25 Jun 2025 13:37:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A725D8E6
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858648; cv=none; b=onShT7pHZQYhttYJu0Yd0cuBlNZMoCE5xbfuzhCQmQfqSsBldD6iz9mhsKs3faYMTkS/Ftas6Yr+o6cvHLTtTH/vEpDoyVPurAjfopeZhPrAwaUyp3vM3CEcBv/vxZ9wW1ycEbCagweBk+nSBN3ZsF534KLqiOsNUi942/+On28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858648; c=relaxed/simple;
	bh=AnxTFFNep8X/7YLaneoP6/sn054a8Lnnw1EG78BE9ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up7jbghxOuQ4yCsshbo8p83z9dJURcO0sghO2vGJh00l+0vC4htGxXII5GZujFuIxePPBeTBP8IXxKPvQlJKR0500fNj+1pAvvYqBYCFa6oUJUVRK04ztdH6BvuG1HKmFYZ3vW0xJBrSYXmCYsZdRUM1OZBpvEHbGPSaxveK7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EEF0211A2;
	Wed, 25 Jun 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25DC213A27;
	Wed, 25 Jun 2025 13:37:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MiA9CZT7W2hkBQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 25 Jun 2025 13:37:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/2] btrfs: open code RCU for device name
Date: Wed, 25 Jun 2025 15:37:19 +0200
Message-ID: <1e539dfd73debc86ddc7c1b1716f86ace14d51aa.1750858539.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750858539.git.dsterba@suse.com>
References: <cover.1750858539.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2EEF0211A2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

The RCU protected string is only used for a device name, and RCU is used
so we can print the name and eventually synchronize against the rare
device rename in device_list_add().

We don't need the whole API just for that. Open code all the helpers and
access to the string itself.

Notable change is in device_list_add() when the device name is changed,
which is the only place that can actually happen at the same time as
message prints using the device name under RCU read lock.

Previously there was kfree_rcu() which used the embedded rcu_head to
delay freeing the object depending on the RCU mechanism. Now there's
kfree_rcu_mightsleep() which does not need the rcu_head and waits for
the grace period.

Sleeping is safe in this context and as this is a rare event it won't
interfere with the rest as it's holding the device_list_mutex.

Straightforward changes:

- rcu_string_strdup -> kstrdup
- rcu_str_deref -> rcu_dereference
- drop ->str from safe contexts

Historical notes:

Introduced in 606686eeac45 ("Btrfs: use rcu to protect device->name")
with a vague reference of the potential problem described in
https://lore.kernel.org/all/20120531155304.GF11775@ZenIV.linux.org.uk/ .

The RCU protection looks like the easiest and most lightweight way of
protecting the rare event of device rename racing device_list_add()
with a random printk() that uses the device name.

Alternatives: a spin lock would require to protect the printk
anyway, a fixed buffer for the name would be eventually wrong in case
the new name is overwritten when being printed, an array switching
pointers and cleaning them up eventually resembles RCU too much.

The cleanups up to this patch should hide special case of RCU to the
minimum that only the name needs rcu_dereference(), which can be further
cleaned up to use btrfs_dev_name().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 28 +++++++++++++++++-----------
 fs/btrfs/volumes.h |  5 +++--
 fs/btrfs/zoned.c   | 22 +++++++++++-----------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 29282f26336e..9ab2ed7cce8d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -658,7 +658,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	if (!device->name)
 		return -EINVAL;
 
-	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
+	ret = btrfs_get_bdev_and_sb(device->name, flags, holder, 1,
 				    &bdev_file, &disk_super);
 	if (ret)
 		return ret;
@@ -702,7 +702,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	if (device->devt != device->bdev->bd_dev) {
 		btrfs_warn(NULL,
 			   "device %s maj:min changed from %d:%d to %d:%d",
-			   device->name->str, MAJOR(device->devt),
+			   device->name, MAJOR(device->devt),
 			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
 			   MINOR(device->bdev->bd_dev));
 
@@ -750,7 +750,7 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 		goto out;
 
 	rcu_read_lock();
-	ret = strscpy(old_path, rcu_str_deref(device->name), PATH_MAX);
+	ret = strscpy(old_path, rcu_dereference(device->name), PATH_MAX);
 	rcu_read_unlock();
 	if (ret < 0)
 		goto out;
@@ -783,7 +783,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices = NULL;
-	struct rcu_string *name;
+	const char *name;
 	u64 found_transid = btrfs_super_generation(disk_super);
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
 	dev_t path_devt;
@@ -891,6 +891,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				current->comm, task_pid_nr(current));
 
 	} else if (!device->name || !is_same_device(device, path)) {
+		const char *old_name;
+
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
@@ -958,13 +960,17 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 					  task_pid_nr(current));
 		}
 
-		name = rcu_string_strdup(path, GFP_NOFS);
+		name = kstrdup(path, GFP_NOFS);
 		if (!name) {
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-ENOMEM);
 		}
-		kfree_rcu(device->name, rcu);
+		rcu_read_lock();
+		old_name = rcu_dereference(device->name);
+		rcu_read_unlock();
 		rcu_assign_pointer(device->name, name);
+		kfree_rcu_mightsleep(old_name);
+
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
 			fs_devices->missing_devices--;
 			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
@@ -1013,7 +1019,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 		 * uuid mutex so nothing we touch in here is going to disappear.
 		 */
 		if (orig_dev->name)
-			dev_path = orig_dev->name->str;
+			dev_path = orig_dev->name;
 
 		device = btrfs_alloc_device(NULL, &orig_dev->devid,
 					    orig_dev->uuid, dev_path);
@@ -1415,7 +1421,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
 
 		list_for_each_entry(device, &fs_devices->devices, dev_list) {
 			if (device->bdev && (device->bdev->bd_dev == devt) &&
-			    strcmp(device->name->str, path) != 0) {
+			    strcmp(device->name, path) != 0) {
 				mutex_unlock(&fs_devices->device_list_mutex);
 
 				/* Do not skip registration. */
@@ -2165,7 +2171,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device->name->str);
+	update_dev_time(device->name);
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
@@ -6924,9 +6930,9 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 		generate_random_uuid(dev->uuid);
 
 	if (path) {
-		struct rcu_string *name;
+		const char *name;
 
-		name = rcu_string_strdup(path, GFP_KERNEL);
+		name = kstrdup(path, GFP_KERNEL);
 		if (!name) {
 			btrfs_free_device(dev);
 			return ERR_PTR(-ENOMEM);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6d8b1f38e3ee..149434e42f7a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -114,7 +114,8 @@ struct btrfs_device {
 	struct btrfs_fs_devices *fs_devices;
 	struct btrfs_fs_info *fs_info;
 
-	struct rcu_string __rcu *name;
+	/* Device path or NULL if missing. */
+	const char __rcu *name;
 
 	u64 generation;
 
@@ -846,7 +847,7 @@ static inline const char *btrfs_dev_name(const struct btrfs_device *device)
 	if (!device || test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 		return "<missing disk>";
 	else
-		return rcu_str_deref(device->name);
+		return rcu_dereference(device->name);
 }
 
 static inline void btrfs_warn_unknown_chunk_allocation(enum btrfs_chunk_allocation_policy pol)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bd987c90a05c..27264db4b7ca 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -266,7 +266,7 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	if (ret < 0) {
 		btrfs_err(device->fs_info,
 				 "zoned: failed to read zone %llu on %s (devid %llu)",
-				 pos, rcu_str_deref(device->name),
+				 pos, rcu_dereference(device->name),
 				 device->devid);
 		return ret;
 	}
@@ -398,14 +398,14 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
 		btrfs_err(fs_info,
 		"zoned: %s: zone size %llu larger than supported maximum %llu",
-				 rcu_str_deref(device->name),
+				 rcu_dereference(device->name),
 				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
 		ret = -EINVAL;
 		goto out;
 	} else if (zone_info->zone_size < BTRFS_MIN_ZONE_SIZE) {
 		btrfs_err(fs_info,
 		"zoned: %s: zone size %llu smaller than supported minimum %u",
-				 rcu_str_deref(device->name),
+				 rcu_dereference(device->name),
 				 zone_info->zone_size, BTRFS_MIN_ZONE_SIZE);
 		ret = -EINVAL;
 		goto out;
@@ -421,7 +421,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
 		btrfs_err(fs_info,
 "zoned: %s: max active zones %u is too small, need at least %u active zones",
-				 rcu_str_deref(device->name), max_active_zones,
+				 rcu_dereference(device->name), max_active_zones,
 				 BTRFS_MIN_ACTIVE_ZONES);
 		ret = -EINVAL;
 		goto out;
@@ -463,7 +463,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		if (!zone_info->zone_cache) {
 			btrfs_err(device->fs_info,
 				"zoned: failed to allocate zone cache for %s",
-				rcu_str_deref(device->name));
+				rcu_dereference(device->name));
 			ret = -ENOMEM;
 			goto out;
 		}
@@ -500,7 +500,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	if (nreported != zone_info->nr_zones) {
 		btrfs_err(device->fs_info,
 				 "inconsistent number of zones on %s (%u/%u)",
-				 rcu_str_deref(device->name), nreported,
+				 rcu_dereference(device->name), nreported,
 				 zone_info->nr_zones);
 		ret = -EIO;
 		goto out;
@@ -510,7 +510,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		if (nactive > max_active_zones) {
 			btrfs_err(device->fs_info,
 			"zoned: %u active zones on %s exceeds max_active_zones %u",
-					 nactive, rcu_str_deref(device->name),
+					 nactive, rcu_dereference(device->name),
 					 max_active_zones);
 			ret = -EIO;
 			goto out;
@@ -578,7 +578,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 
 	btrfs_info(fs_info,
 		"%s block device %s, %u %szones of %llu bytes",
-		model, rcu_str_deref(device->name), zone_info->nr_zones,
+		model, rcu_dereference(device->name), zone_info->nr_zones,
 		emulated, zone_info->zone_size);
 
 	return 0;
@@ -1186,7 +1186,7 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 		btrfs_warn(
 			device->fs_info,
 		"zoned: resetting device %s (devid %llu) zone %llu for allocation",
-			rcu_str_deref(device->name), device->devid, pos >> shift);
+			rcu_dereference(device->name), device->devid, pos >> shift);
 		WARN_ON_ONCE(1);
 
 		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
@@ -1348,7 +1348,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		btrfs_err(fs_info,
 		"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
-			zone.start << SECTOR_SHIFT, rcu_str_deref(device->name),
+			zone.start << SECTOR_SHIFT, rcu_dereference(device->name),
 			device->devid);
 		up_read(&dev_replace->rwsem);
 		return -EIO;
@@ -1362,7 +1362,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		btrfs_err(fs_info,
 		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
 			  (info->physical >> device->zone_info->zone_size_shift),
-			  rcu_str_deref(device->name), device->devid);
+			  rcu_dereference(device->name), device->devid);
 		info->alloc_offset = WP_MISSING_DEV;
 		break;
 	case BLK_ZONE_COND_EMPTY:
-- 
2.49.0


