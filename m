Return-Path: <linux-btrfs+bounces-2384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283ED854F12
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632ACB3009C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8D612E7;
	Wed, 14 Feb 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e8giFPlK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BF60DC4;
	Wed, 14 Feb 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928943; cv=none; b=J7rETqQN4RVmIdQn6JYycW/CisxrQTu7upZsgSIRUu8MPXakz1Ww4U6W498kUPFvy1TWWdjEKOCAN17MPXwuWv19nviHHTBStFNwWVTxDwXN6Xky1KoVG8Xg5LpO6j7VsjVrS8TVjZPOfbF+ry1kwpwPgta9bVyfspzDHrc04eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928943; c=relaxed/simple;
	bh=x+9XsgsJofMkp/phXpfhTtoOFnnITRJ8Y+D2z+U3vrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ha9GObcN3dZkAMqmhqKUUz366vrGoxBM40aoY9FrwK4DWySzSf5fYcAET+tUnteqwPY8lYwpwbHMtU2PinDWEMXAIOTYAs8Iz6ZcVWDuLcJiRXUoptMWCctyzw9BlR7UXpP0cbkL1ngL8ne5+ajQ2dGHpiIfpKR9he9iK6A9H5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e8giFPlK; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707928941; x=1739464941;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=x+9XsgsJofMkp/phXpfhTtoOFnnITRJ8Y+D2z+U3vrI=;
  b=e8giFPlKAyYFeuj9BXHpasdhA6aTK9PVDhueudCFBc9C8pyykB5ejcwa
   LL5JpzG3ouBhFdlunhQcMR0OrRdIt7Tzn9sgRSX3J55nT0h9Hj0/5SKqa
   JMdkKTewDVCTIL/hdb1LXTgG+EG5tj3TGlz9KkMe38I9LPvxO/HX5BGAS
   ElUrSaVxsJx8iF0BCjzt4TePyFoR1WNZT+/CSs5zsifdtqTWGZrgmxqdD
   HGLp+9u10xU6fsWrVrsd5a3kc6glvgymtViv2LNcY30OBUGy0lbp9MQaU
   AEkSRChUeLY+XKmM3MZBgaB/T+1VKIQ0w+XcCJfo0v9w35R7DNDRUO7Iy
   A==;
X-CSE-ConnectionGUID: 6xxSmU/ORtSOGRLm4HW5nw==
X-CSE-MsgGUID: w0+miKYWQCuvoZ7o/OvvBg==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9294741"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 00:42:20 +0800
IronPort-SDR: 8TCrt7yX0Q48V8HjcqzQEwKMlalzZRSlOa3kRgFQBfGmlg1Im2R1bmF7wNuHCcXlRGPOCP61+a
 RdtngOX2GeBQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 07:51:55 -0800
IronPort-SDR: iuSycV2C7J0cH1F3CsA6m8xOWSjY3EWg//M6hxtOqxSaWP2SjXECa+d46LefzsFRyg0ezdBZCN
 BD6Qy+KqWBqg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2024 08:42:18 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 14 Feb 2024 08:42:14 -0800
Subject: [PATCH 3/5] btrfs: split btrfs_fs_devices.opened
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hch-device-open-v1-3-b153428b4f72@wdc.com>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
In-Reply-To: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707928933; l=7104;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=7OH2aIo02sm6W0LG0E/ZUUuGzuFnEGpt1qc6hy3w+JE=;
 b=FkYNdzB4EGUPbJR4wd55k6sFzciP0YyBfUAzNUq1ey9V5wEM/iIDoRfoMUh/Vw8IxzfKp+2VQ
 t40Z+ink6bQCOPfiFPCC+9oIcuwtwtNXlxrWawYpnyLqFQKjxkLU/EV
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

From: Christoph Hellwig <hch@lst.de>

The btrfs_fs_devices.opened member mixes an in use counter for the
fs_devices structure that prevents it from being garbage collected with
a flag if the underlying devices were actually opened.  This not only
makes the code hard to follow, but also prevents btrfs from switching
to opening the block device only after super block creation.  Split it
into an in_use counter and an is_open boolean flag instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 51 +++++++++++++++++++++++++++++----------------------
 fs/btrfs/volumes.h |  6 ++++--
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 44caf1a48d33..f27af155abf0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -412,7 +412,8 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device;
 
-	WARN_ON(fs_devices->opened);
+	WARN_ON_ONCE(fs_devices->in_use);
+	WARN_ON_ONCE(fs_devices->is_open);
 	while (!list_empty(&fs_devices->devices)) {
 		device = list_entry(fs_devices->devices.next,
 				    struct btrfs_device, dev_list);
@@ -535,7 +536,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 				continue;
 			if (devt && devt != device->devt)
 				continue;
-			if (fs_devices->opened) {
+			if (fs_devices->in_use) {
 				if (devt)
 					ret = -EBUSY;
 				break;
@@ -607,7 +608,7 @@ static struct btrfs_fs_devices *find_fsid_by_device(
 	if (found_by_devt) {
 		/* Existing device. */
 		if (fsid_fs_devices == NULL) {
-			if (devt_fs_devices->opened == 0) {
+			if (devt_fs_devices->in_use == 0) {
 				/* Stale device. */
 				return NULL;
 			} else {
@@ -795,7 +796,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	if (!device) {
 		unsigned int nofs_flag;
 
-		if (fs_devices->opened) {
+		if (fs_devices->in_use) {
 			btrfs_err(NULL,
 "device %s belongs to fsid %pU, and the fs is already mounted, scanned by %s (%d)",
 				  path, fs_devices->fsid, current->comm,
@@ -860,7 +861,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (!fs_devices->in_use && found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
@@ -921,7 +922,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	 * it back. We need it to pick the disk with largest generation
 	 * (as above).
 	 */
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		device->generation = found_transid;
 		fs_devices->latest_generation = max_t(u64, found_transid,
 						fs_devices->latest_generation);
@@ -1120,15 +1121,19 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (--fs_devices->opened > 0)
+	if (--fs_devices->in_use > 0)
 		return;
 
+	if (!fs_devices->is_open)
+		goto done;
+
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list)
 		btrfs_close_one_device(device);
 
 	WARN_ON(fs_devices->open_devices);
 	WARN_ON(fs_devices->rw_devices);
-	fs_devices->opened = 0;
+	fs_devices->is_open = false;
+done:
 	fs_devices->seeding = false;
 	fs_devices->fs_info = NULL;
 }
@@ -1140,7 +1145,7 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 
 	mutex_lock(&uuid_mutex);
 	close_fs_devices(fs_devices);
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		list_splice_init(&fs_devices->seed_list, &list);
 
 		/*
@@ -1188,7 +1193,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	if (fs_devices->open_devices == 0)
 		return -EINVAL;
 
-	fs_devices->opened = 1;
+	fs_devices->is_open = true;
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
@@ -1225,16 +1230,14 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	 * We also don't need the lock here as this is called during mount and
 	 * exclusion is provided by uuid_mutex
 	 */
-
-	if (fs_devices->opened) {
-		fs_devices->opened++;
-		ret = 0;
-	} else {
+	if (!fs_devices->is_open) {
 		list_sort(NULL, &fs_devices->devices, devid_cmp);
 		ret = open_fs_devices(fs_devices, flags, holder);
+		if (ret)
+			return ret;
 	}
-
-	return ret;
+	fs_devices->in_use++;
+	return 0;
 }
 
 void btrfs_release_disk_super(struct btrfs_super_block *super)
@@ -2201,13 +2204,14 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * This can happen if cur_devices is the private seed devices list.  We
 	 * cannot call close_fs_devices() here because it expects the uuid_mutex
 	 * to be held, but in fact we don't need that for the private
-	 * seed_devices, we can simply decrement cur_devices->opened and then
+	 * seed_devices, we can simply decrement cur_devices->in_use and then
 	 * remove it from our list and free the fs_devices.
 	 */
 	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
-		ASSERT(cur_devices->opened == 1);
-		cur_devices->opened--;
+		ASSERT(cur_devices->in_use == 1);
+		cur_devices->in_use--;
+		cur_devices->is_open = false;
 		free_fs_devices(cur_devices);
 	}
 
@@ -2437,7 +2441,8 @@ static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 	list_add(&old_devices->fs_list, &fs_uuids);
 
 	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
-	seed_devices->opened = 1;
+	seed_devices->in_use = 1;
+	seed_devices->is_open = true;
 	INIT_LIST_HEAD(&seed_devices->devices);
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
@@ -7115,7 +7120,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 			return fs_devices;
 
 		fs_devices->seeding = true;
-		fs_devices->opened = 1;
+		fs_devices->in_use = 1;
+		fs_devices->is_open = true;
 		return fs_devices;
 	}
 
@@ -7132,6 +7138,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
 	}
+	fs_devices->in_use = 1;
 
 	if (!fs_devices->seeding) {
 		close_fs_devices(fs_devices);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 97c7284e7565..d6dc41c62998 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -372,8 +372,10 @@ struct btrfs_fs_devices {
 
 	struct list_head seed_list;
 
-	/* Count fs-devices opened. */
-	int opened;
+	/* Count if fs_device is in used. */
+	unsigned int in_use;
+	/* True if the devices were opened. */
+	bool is_open;
 
 	/* Set when we find or add a device that doesn't have the nonrot flag set. */
 	bool rotating;

-- 
2.43.0


