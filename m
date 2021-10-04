Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A521E421518
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhJDRXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbhJDRVW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:21:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7BC061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:19:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l13so16591785qtv.3
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U1u6BV9WuT0LIbMQi1GZJmi1knwHR2eIgZxfIcOBoBU=;
        b=yX8duMooEJZPPaYr4g/4xBqdiN0unzhbRFGyU7kpZ+WEy8rB6QOG1+uy3LL6PsJFdF
         GNubWHvO7CI/9Mf13rIcbm9cnQIUSVNk5tNwCiKdEVF4FmJ8un10GdYGggA0et1HHMje
         U4Jyg9a3PZ6Wpk6WNURTCaIGcViXvL6I3Xe5pU7GIgVwXkjEG/CGKFBiITCkQIFp+muy
         +YsA6cbI8mEB+4VGiDqWJIzTrlQkCF+nWm70KEQ7XvVYFXYNJKYMZTz4wxCTB8BKtf8I
         xcgBzo5jRodYwuf0xo8ECdjoDJvevSXalE2qJdaXrEEqM2hU5YKdXUyZQL/CLBk13/l2
         IF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1u6BV9WuT0LIbMQi1GZJmi1knwHR2eIgZxfIcOBoBU=;
        b=4Fg96f587mN8h7rBtbonDJVYHRVNK0kEpO7ykQjwiI9JzseoNxXHzpWogR1RYyvuhW
         rmbrIuptQewEBXAFqDc0Yb66u+FBV4w9VYuxKd5X8bmk/y8Ra64qkTd9Kh8BYCjBG/zX
         91MMhtZqL0LxjERygsJa20WVrM0OOodEtFpoxNkC6EZO1s+PJi7WvdhbMcvAbZyB6y92
         lo1xBICfUJ+xDibJ1ip60LUKH3YDSFVNgMVY6t/ycl8j5xV9xAP2ieJ92HKTtqxlRxtr
         P4pvgbKrGAq16fC9P0DbzvVT9SbsL83G5+Ssa/xsltWFI3Lb5RqOwHMAG9we7p7eIakZ
         3+9Q==
X-Gm-Message-State: AOAM530QQP42w74I/BYM2lPRsQMWrZSUPeEymZ6x/D5bLQwg6PvrwMrB
        o7y2M0bng5Uwb86xfEcq+3U4iAcBjHcn/w==
X-Google-Smtp-Source: ABdhPJzCXu2B4OyVZaQsPO45TBDPqoWvivmr3I+6PvuNUX0ESplOcp1LWOpY+2TyZKJP50y/CjpEog==
X-Received: by 2002:ac8:57d4:: with SMTP id w20mr14472741qta.261.1633367972085;
        Mon, 04 Oct 2021 10:19:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o21sm8980483qtt.12.2021.10.04.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:19:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/6] btrfs: handle device lookup with btrfs_dev_lookup_args
Date:   Mon,  4 Oct 2021 13:19:20 -0400
Message-Id: <5fb28919a4034e6ebd0c677e5bb1b52bf8fb4fdd.1633367810.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633367810.git.josef@toxicpanda.com>
References: <cover.1633367810.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a lot of device lookup functions that all do something slightly
different.  Clean this up by adding a struct to hold the different
lookup criteria, and then pass this around to btrfs_find_device() so it
can do the proper matching based on the lookup criteria.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c |  18 +++----
 fs/btrfs/ioctl.c       |  13 ++---
 fs/btrfs/scrub.c       |   6 ++-
 fs/btrfs/volumes.c     | 120 +++++++++++++++++++++++++----------------
 fs/btrfs/volumes.h     |  15 +++++-
 5 files changed, 108 insertions(+), 64 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d029be40ea6f..ff25da2dbd59 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -70,6 +70,7 @@ static int btrfs_dev_replace_kthread(void *data);
 
 int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_key key;
 	struct btrfs_root *dev_root = fs_info->dev_root;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
@@ -84,6 +85,8 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 	if (!dev_root)
 		return 0;
 
+	args.devid = BTRFS_DEV_REPLACE_DEVID;
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
@@ -100,8 +103,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		 * We don't have a replace item or it's corrupted.  If there is
 		 * a replace target, fail the mount.
 		 */
-		if (btrfs_find_device(fs_info->fs_devices,
-				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
+		if (btrfs_find_device(fs_info->fs_devices, &args)) {
 			btrfs_err(fs_info,
 			"found replace target device without a valid replace item");
 			ret = -EUCLEAN;
@@ -163,8 +165,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		 * We don't have an active replace item but if there is a
 		 * replace target, fail the mount.
 		 */
-		if (btrfs_find_device(fs_info->fs_devices,
-				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
+		if (btrfs_find_device(fs_info->fs_devices, &args)) {
 			btrfs_err(fs_info,
 			"replace devid present without an active replace item");
 			ret = -EUCLEAN;
@@ -175,11 +176,10 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
-		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices,
-						src_devid, NULL, NULL);
-		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices,
-							BTRFS_DEV_REPLACE_DEVID,
-							NULL, NULL);
+		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices, &args);
+		args.devid = src_devid;
+		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices, &args);
+
 		/*
 		 * allow 'btrfs dev replace_cancel' if src/tgt device is
 		 * missing
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9eb0c1eb568e..b8508af4e539 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1602,6 +1602,7 @@ static int exclop_start_or_cancel_reloc(struct btrfs_fs_info *fs_info,
 static noinline int btrfs_ioctl_resize(struct file *file,
 					void __user *arg)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 new_size;
@@ -1657,7 +1658,8 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		btrfs_info(fs_info, "resizing devid %llu", devid);
 	}
 
-	device = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
+	args.devid = devid;
+	device = btrfs_find_device(fs_info->fs_devices, &args);
 	if (!device) {
 		btrfs_info(fs_info, "resizer unable to find device %llu",
 			   devid);
@@ -3317,22 +3319,21 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 				 void __user *arg)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_ioctl_dev_info_args *di_args;
 	struct btrfs_device *dev;
 	int ret = 0;
-	char *s_uuid = NULL;
 
 	di_args = memdup_user(arg, sizeof(*di_args));
 	if (IS_ERR(di_args))
 		return PTR_ERR(di_args);
 
+	args.devid = di_args->devid;
 	if (!btrfs_is_empty_uuid(di_args->uuid))
-		s_uuid = di_args->uuid;
+		args.uuid = di_args->uuid;
 
 	rcu_read_lock();
-	dev = btrfs_find_device(fs_info->fs_devices, di_args->devid, s_uuid,
-				NULL);
-
+	dev = btrfs_find_device(fs_info->fs_devices, &args);
 	if (!dev) {
 		ret = -ENODEV;
 		goto out;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bd3cd7427391..1e29b9aa45df 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4067,6 +4067,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
 		    int readonly, int is_dev_replace)
 {
+	struct btrfs_dev_lookup_args args = { .devid = devid };
 	struct scrub_ctx *sctx;
 	int ret;
 	struct btrfs_device *dev;
@@ -4114,7 +4115,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		goto out_free_ctx;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
+	dev = btrfs_find_device(fs_info->fs_devices, &args);
 	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
 		     !is_dev_replace)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -4287,11 +4288,12 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev)
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress)
 {
+	struct btrfs_dev_lookup_args args = { .devid = devid };
 	struct btrfs_device *dev;
 	struct scrub_ctx *sctx = NULL;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
+	dev = btrfs_find_device(fs_info->fs_devices, &args);
 	if (dev)
 		sctx = dev->scrub_ctx;
 	if (sctx)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5f19d0863094..191360e44a20 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -812,9 +812,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 		device = NULL;
 	} else {
+		struct btrfs_dev_lookup_args args = {
+			.devid = devid,
+			.uuid = disk_super->dev_item.uuid,
+		};
+
 		mutex_lock(&fs_devices->device_list_mutex);
-		device = btrfs_find_device(fs_devices, devid,
-				disk_super->dev_item.uuid, NULL);
+		device = btrfs_find_device(fs_devices, &args);
 
 		/*
 		 * If this disk has been pulled into an fs devices created by
@@ -2323,10 +2327,9 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 static struct btrfs_device *btrfs_find_device_by_path(
 		struct btrfs_fs_info *fs_info, const char *device_path)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	int ret = 0;
 	struct btrfs_super_block *disk_super;
-	u64 devid;
-	u8 *dev_uuid;
 	struct block_device *bdev;
 	struct btrfs_device *device;
 
@@ -2335,14 +2338,14 @@ static struct btrfs_device *btrfs_find_device_by_path(
 	if (ret)
 		return ERR_PTR(ret);
 
-	devid = btrfs_stack_device_id(&disk_super->dev_item);
-	dev_uuid = disk_super->dev_item.uuid;
+	args.devid = btrfs_stack_device_id(&disk_super->dev_item);
+	args.uuid = disk_super->dev_item.uuid;
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
-		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   disk_super->metadata_uuid);
+		args.fsid = disk_super->metadata_uuid;
 	else
-		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   disk_super->fsid);
+		args.fsid = disk_super->fsid;
+
+	device = btrfs_find_device(fs_info->fs_devices, &args);
 
 	btrfs_release_disk_super(disk_super);
 	if (!device)
@@ -2358,11 +2361,12 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 		struct btrfs_fs_info *fs_info, u64 devid,
 		const char *device_path)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_device *device;
 
 	if (devid) {
-		device = btrfs_find_device(fs_info->fs_devices, devid, NULL,
-					   NULL);
+		args.devid = devid;
+		device = btrfs_find_device(fs_info->fs_devices, &args);
 		if (!device)
 			return ERR_PTR(-ENOENT);
 		return device;
@@ -2372,14 +2376,11 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 		return ERR_PTR(-EINVAL);
 
 	if (strcmp(device_path, "missing") == 0) {
-		/* Find first missing device */
-		list_for_each_entry(device, &fs_info->fs_devices->devices,
-				    dev_list) {
-			if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
-				     &device->dev_state) && !device->bdev)
-				return device;
-		}
-		return ERR_PTR(-ENOENT);
+		args.missing = true;
+		device = btrfs_find_device(fs_info->fs_devices, &args);
+		if (!device)
+			return ERR_PTR(-ENOENT);
+		return device;
 	}
 
 	return btrfs_find_device_by_path(fs_info, device_path);
@@ -2459,6 +2460,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
  */
 static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_path *path;
@@ -2468,7 +2470,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	struct btrfs_key key;
 	u8 fs_uuid[BTRFS_FSID_SIZE];
 	u8 dev_uuid[BTRFS_UUID_SIZE];
-	u64 devid;
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -2505,13 +2506,14 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 
 		dev_item = btrfs_item_ptr(leaf, path->slots[0],
 					  struct btrfs_dev_item);
-		devid = btrfs_device_id(leaf, dev_item);
+		args.devid = btrfs_device_id(leaf, dev_item);
 		read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
 				   BTRFS_UUID_SIZE);
 		read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
 				   BTRFS_FSID_SIZE);
-		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   fs_uuid);
+		args.uuid = dev_uuid;
+		args.fsid = fs_uuid;
+		device = btrfs_find_device(fs_info->fs_devices, &args);
 		BUG_ON(!device); /* Logic error */
 
 		if (device->fs_devices->seeding) {
@@ -6753,6 +6755,32 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	return BLK_STS_OK;
 }
 
+static inline bool dev_args_match_fs_devices(struct btrfs_dev_lookup_args *args,
+					     struct btrfs_fs_devices *fs_devices)
+{
+	if (args->fsid == NULL)
+		return true;
+	if (!memcmp(fs_devices->metadata_uuid, args->fsid, BTRFS_FSID_SIZE))
+		return true;
+	return false;
+}
+
+static inline bool dev_args_match_device(struct btrfs_dev_lookup_args *args,
+					 struct btrfs_device *device)
+{
+	ASSERT((args->devid != (u64)-1) || args->missing);
+	if ((args->devid != (u64)-1) && device->devid != args->devid)
+		return false;
+	if (args->uuid && memcmp(device->uuid, args->uuid, BTRFS_UUID_SIZE))
+		return false;
+	if (!args->missing)
+		return true;
+	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
+	    !device->bdev)
+		return true;
+	return false;
+}
+
 /*
  * Find a device specified by @devid or @uuid in the list of @fs_devices, or
  * return NULL.
@@ -6761,30 +6789,24 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
  * only devid is used.
  */
 struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
-				       u64 devid, u8 *uuid, u8 *fsid)
+				       struct btrfs_dev_lookup_args *args)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *seed_devs;
 
-	if (!fsid || !memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
+	if (dev_args_match_fs_devices(args, fs_devices)) {
 		list_for_each_entry(device, &fs_devices->devices, dev_list) {
-			if (device->devid == devid &&
-			    (!uuid || memcmp(device->uuid, uuid,
-					     BTRFS_UUID_SIZE) == 0))
+			if (dev_args_match_device(args, device))
 				return device;
 		}
 	}
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
-		if (!fsid ||
-		    !memcmp(seed_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
-			list_for_each_entry(device, &seed_devs->devices,
-					    dev_list) {
-				if (device->devid == devid &&
-				    (!uuid || memcmp(device->uuid, uuid,
-						     BTRFS_UUID_SIZE) == 0))
-					return device;
-			}
+		if (!dev_args_match_fs_devices(args, seed_devs))
+			continue;
+		list_for_each_entry(device, &seed_devs->devices, dev_list) {
+			if (dev_args_match_device(args, device))
+				return device;
 		}
 	}
 
@@ -6950,6 +6972,7 @@ static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
 static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			  struct btrfs_chunk *chunk)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
 	struct map_lookup *map;
@@ -7026,12 +7049,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	for (i = 0; i < num_stripes; i++) {
 		map->stripes[i].physical =
 			btrfs_stripe_offset_nr(leaf, chunk, i);
-		devid = btrfs_stripe_devid_nr(leaf, chunk, i);
+		args.devid = btrfs_stripe_devid_nr(leaf, chunk, i);
 		read_extent_buffer(leaf, uuid, (unsigned long)
 				   btrfs_stripe_dev_uuid_nr(chunk, i),
 				   BTRFS_UUID_SIZE);
-		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices,
-							devid, uuid, NULL);
+		args.uuid = uuid;
+		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, &args);
 		if (!map->stripes[i].dev &&
 		    !btrfs_test_opt(fs_info, DEGRADED)) {
 			free_extent_map(em);
@@ -7149,6 +7172,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 static int read_one_dev(struct extent_buffer *leaf,
 			struct btrfs_dev_item *dev_item)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
@@ -7157,11 +7181,13 @@ static int read_one_dev(struct extent_buffer *leaf,
 	u8 fs_uuid[BTRFS_FSID_SIZE];
 	u8 dev_uuid[BTRFS_UUID_SIZE];
 
-	devid = btrfs_device_id(leaf, dev_item);
+	args.devid = btrfs_device_id(leaf, dev_item);
 	read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
 			   BTRFS_UUID_SIZE);
 	read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
 			   BTRFS_FSID_SIZE);
+	args.uuid = dev_uuid;
+	args.fsid = fs_uuid;
 
 	if (memcmp(fs_uuid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE)) {
 		fs_devices = open_seed_devices(fs_info, fs_uuid);
@@ -7169,8 +7195,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 			return PTR_ERR(fs_devices);
 	}
 
-	device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-				   fs_uuid);
+	device = btrfs_find_device(fs_info->fs_devices, &args);
 	if (!device) {
 		if (!btrfs_test_opt(fs_info, DEGRADED)) {
 			btrfs_report_missing_device(fs_info, devid,
@@ -7839,12 +7864,14 @@ static void btrfs_dev_stat_print_on_load(struct btrfs_device *dev)
 int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 			struct btrfs_ioctl_get_dev_stats *stats)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_device *dev;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	int i;
 
 	mutex_lock(&fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, stats->devid, NULL, NULL);
+	args.devid = stats->devid;
+	dev = btrfs_find_device(fs_info->fs_devices, &args);
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	if (!dev) {
@@ -7920,6 +7947,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 				 u64 chunk_offset, u64 devid,
 				 u64 physical_offset, u64 physical_len)
 {
+	struct btrfs_dev_lookup_args args = { .devid = devid };
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -7975,7 +8003,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	/* Make sure no dev extent is beyond device boundary */
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
+	dev = btrfs_find_device(fs_info->fs_devices, &args);
 	if (!dev) {
 		btrfs_err(fs_info, "failed to find devid %llu", devid);
 		ret = -EUCLEAN;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c7ac43d8a7e8..fa9a56c37d45 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -452,6 +452,19 @@ struct btrfs_balance_control {
 	struct btrfs_balance_progress stat;
 };
 
+struct btrfs_dev_lookup_args {
+	u64 devid;
+	u8 *uuid;
+	u8 *fsid;
+	bool missing;
+};
+
+/* We have to init to -1 because BTRFS_DEV_REPLACE_DEVID is 0 */
+#define BTRFS_DEV_LOOKUP_ARGS_INIT { .devid = (u64)-1 }
+
+#define BTRFS_DEV_LOOKUP_ARGS(name) \
+	struct btrfs_dev_lookup_args name = BTRFS_DEV_LOOKUP_ARGS_INIT
+
 enum btrfs_map_op {
 	BTRFS_MAP_READ,
 	BTRFS_MAP_WRITE,
@@ -517,7 +530,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		      struct btrfs_device *device, u64 new_size);
 struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
-				       u64 devid, u8 *uuid, u8 *fsid);
+				       struct btrfs_dev_lookup_args *args);
 int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
 int btrfs_balance(struct btrfs_fs_info *fs_info,
-- 
2.26.3

