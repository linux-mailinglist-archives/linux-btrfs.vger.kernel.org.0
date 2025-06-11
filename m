Return-Path: <linux-btrfs+bounces-14600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA08AD50D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120C57A8B49
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54491261575;
	Wed, 11 Jun 2025 10:03:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5C263C9B
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636204; cv=none; b=cJusoVaqQyds4btQw87A+hutmKrre+DFAjyfSC3BqFBqOnB54lddHX6HJaW1SLP3uz5eO3rGP5BrPqnbmS4e51eXkL0IqO/iFK9A3aLKhurjtc0YMjxiC3sB/SJebUTZSLoIa9c5dOk3ByVYQ4o6LZOkixSfUj8z7219yBVY7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636204; c=relaxed/simple;
	bh=VQFTF/y47FvnfHiJ2JS/DuM8gdOjuS6HAOVU6Rbr1pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjcbG2ChGBDraRgcdnIRW0+Wab1NPUqpqK118sTZ/GvkROcpPIhIXyOH1h2Ih3fAkUKowBY4AiFhRtFz+5pA59e0yDABRpCZixdQ9grcdVWQ5lQ+Xh9p5snRqtg7CAx2KT8Qj4gCb8F9loQa35vdRlo+e1g2mOxyn14FiIfXsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a51d552de4so3519481f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636201; x=1750241001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2k+gWkU6Orbx5NDvSshWCaakuQwLKkXw4zWxTj+XB8=;
        b=tSn3TimzrJh+yrmHq2YLFkVOYXqDZuTT4qKfch0g6c3hUTrZIJRKKeGTTDu7+Z3Tu1
         j341WiNhSAgwJdyLLaLZGUWWR9EwfsUW9o6a21MNMtTut4KHu7LUJVBflpw1XdQ7Q2q8
         ewq5HGRA2TVZLPyZYXtN4l83GZ6hSgVNYPxV42CaSgekfrt9d8agT2VqGdkOBSXTD/5o
         B5acg6K8BctefuabeorYcXYcd/ehUEHLly1yrJujFuB6UxckroKLf7noj6qJzxqPLiSE
         KkjdGR9LPoBeHtUI3Rx5yDOf+DRuQ8P6qA5XJ0l2Jin2oFPV0oftiwqLTaCyMk7gMO4w
         1uvw==
X-Gm-Message-State: AOJu0YxLLZ5lOT1/QLkzanBpYQYJML+cd5ueZt4NAGtgJWOoTfVs+3JJ
	+5Nb0vJQEx0YKknIpMGcNIZDX3wiLNhPgSqCApmjIyIuXMhtlpuzBh/h2K19DA==
X-Gm-Gg: ASbGncvUVmuqxzNYvWe+lq4D8fVs05ENqoROrH3Rjk7EeI6C+pR9hXKiFZQWOnQjRSf
	SSGmuIDDr/AeN++xX2Zl5ZNkM7p29+3Z+d0Tvh122TdYFkXLHOn7qBuH8wB6oEc5WIZZSNfbv7/
	YDzNCRderrRbIzhDVDv7qLOsNSP83SwPaZdrJV4myzhodXsSls4brGDwfKpvjJPPf8Fn0RNpBxV
	/JvHIHbuScL5pMPj6mAbU/u5JwFkksRwCOXEVyttu2XoNWfUG2y5/kyZZ646YRUDZX3y93NUq4c
	ZkkgnjFlLVGO1c/RTS0Qwiq/7iJXMNGY/AUJg2v8bxRgf/9kbrW3aqLGXfMHs3lWvIl5nmRCVxL
	10djBpCqvFCsW+Sr6H75pUjqcz8rSU5J7WfWENHceuI4q4A69zw==
X-Google-Smtp-Source: AGHT+IGUrrw0WW8CIM5zOLjMQK5EnEtH1mBP1u5LlURSXJ2Aktb6vP3XGWqAw6EQ/3C31oVe2BiNug==
X-Received: by 2002:a05:6000:230f:b0:3a4:eec5:443d with SMTP id ffacd0b85a97d-3a558acb969mr1587778f8f.29.1749636201150;
        Wed, 11 Jun 2025 03:03:21 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f02asm14654274f8f.83.2025.06.11.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:03:19 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/5] btrfs: split btrfs_fs_devices.opened
Date: Wed, 11 Jun 2025 12:03:01 +0200
Message-ID: <20250611100303.110311-4-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100303.110311-1-jth@kernel.org>
References: <20250611100303.110311-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 fs/btrfs/volumes.c | 53 ++++++++++++++++++++++++++--------------------
 fs/btrfs/volumes.h |  6 ++++--
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1ebfc69012a2..00b64f98e3bd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -413,7 +413,8 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device;
 
-	WARN_ON(fs_devices->opened);
+	WARN_ON_ONCE(fs_devices->in_use);
+	WARN_ON_ONCE(fs_devices->is_open);
 	while (!list_empty(&fs_devices->devices)) {
 		device = list_first_entry(&fs_devices->devices,
 					  struct btrfs_device, dev_list);
@@ -541,7 +542,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 				continue;
 			if (devt && devt != device->devt)
 				continue;
-			if (fs_devices->opened) {
+			if (fs_devices->in_use) {
 				if (devt)
 					ret = -EBUSY;
 				break;
@@ -613,7 +614,7 @@ static struct btrfs_fs_devices *find_fsid_by_device(
 	if (found_by_devt) {
 		/* Existing device. */
 		if (fsid_fs_devices == NULL) {
-			if (devt_fs_devices->opened == 0) {
+			if (devt_fs_devices->in_use == 0) {
 				/* Stale device. */
 				return NULL;
 			} else {
@@ -848,7 +849,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	if (!device) {
 		unsigned int nofs_flag;
 
-		if (fs_devices->opened) {
+		if (fs_devices->in_use) {
 			btrfs_err(NULL,
 "device %s (%d:%d) belongs to fsid %pU, and the fs is already mounted, scanned by %s (%d)",
 				  path, MAJOR(path_devt), MINOR(path_devt),
@@ -916,7 +917,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (!fs_devices->in_use && found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
@@ -977,7 +978,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	 * it back. We need it to pick the disk with largest generation
 	 * (as above).
 	 */
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		device->generation = found_transid;
 		fs_devices->latest_generation = max_t(u64, found_transid,
 						fs_devices->latest_generation);
@@ -1177,15 +1178,19 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 
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
@@ -1197,7 +1202,7 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 
 	mutex_lock(&uuid_mutex);
 	close_fs_devices(fs_devices);
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		list_splice_init(&fs_devices->seed_list, &list);
 
 		/*
@@ -1253,7 +1258,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 	}
 
-	fs_devices->opened = 1;
+	fs_devices->is_open = true;
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
@@ -1306,16 +1311,14 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
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
@@ -1407,7 +1410,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
 
 		mutex_lock(&fs_devices->device_list_mutex);
 
-		if (!fs_devices->opened) {
+		if (!fs_devices->is_open) {
 			mutex_unlock(&fs_devices->device_list_mutex);
 			continue;
 		}
@@ -2314,13 +2317,14 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * This can happen if cur_devices is the private seed devices list.  We
 	 * cannot call close_fs_devices() here because it expects the uuid_mutex
 	 * to be held, but in fact we don't need that for the private
-	 * seed_devices, we can simply decrement cur_devices->opened and then
+	 * seed_devices, we can simply decrement cur_devices->in_use and then
 	 * remove it from our list and free the fs_devices.
 	 */
 	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
-		ASSERT(cur_devices->opened == 1, "opened=%d", cur_devices->opened);
-		cur_devices->opened--;
+		ASSERT(cur_devices->in_use == 1, "opened=%d", cur_devices->in_use);
+		cur_devices->in_use--;
+		cur_devices->is_open = false;
 		free_fs_devices(cur_devices);
 	}
 
@@ -2549,7 +2553,8 @@ static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 	list_add(&old_devices->fs_list, &fs_uuids);
 
 	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
-	seed_devices->opened = 1;
+	seed_devices->in_use = 1;
+	seed_devices->is_open = true;
 	INIT_LIST_HEAD(&seed_devices->devices);
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
@@ -7162,7 +7167,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 			return fs_devices;
 
 		fs_devices->seeding = true;
-		fs_devices->opened = 1;
+		fs_devices->in_use = 1;
+		fs_devices->is_open = true;
 		return fs_devices;
 	}
 
@@ -7179,6 +7185,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
 	}
+	fs_devices->in_use = 1;
 
 	if (!fs_devices->seeding) {
 		close_fs_devices(fs_devices);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index afa71d315c46..06cf8c99befe 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -419,8 +419,10 @@ struct btrfs_fs_devices {
 
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
2.49.0


