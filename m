Return-Path: <linux-btrfs+bounces-1007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C18165BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 05:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B582823EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 04:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9686963DD;
	Mon, 18 Dec 2023 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="msLql90W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36863AF
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1XSDTqCZ2FQPKqku3okcR5aMoAlJT6ybFxP3/+al0fo=; b=msLql90WeG99x7qxU5f+H+U6zH
	9ukGRVv2NeillPZha3brHuvTxQnER7rM7NShHVYKpWLT2XmYHJkIZYmCV1G9jryga/g/FXQ5cEuGh
	NiBDl6sUEbNcdBLnsD4QAlWBPZIEFEOyAUIRNEujnnLQSY2u6IRFONJaWVtaPpCVcEyW41wLtOP4x
	p9MkB0YmX5dRg7b21dAKC+5/LcdWzNEgisGOIZ2EP24QvMURXrvCjcQ7NHPClfnJf7eaBbfsGYCov
	b4+Pef0rD/P6mqXtsZxeIINJVgLzXzWiKsAK6ifvumSr9usQf7ZCG//pQHSZBDUadzSyEDxayijYL
	hnHbPY+g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF5ZX-0094Eg-1s;
	Mon, 18 Dec 2023 04:49:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 3/5] btrfs: split btrfs_fs_devices.opened
Date: Mon, 18 Dec 2023 05:49:31 +0100
Message-Id: <20231218044933.706042-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218044933.706042-1-hch@lst.de>
References: <20231218044933.706042-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The btrfs_fs_devices.opened member mixes an in use counter for the
fs_devices structure that prevents it from being garbage collected with
a flag if the underlying devices were actually opened.  This not only
makes the code hard to follow, but also prevents btrfs from switching
to opening the block device only after super block creation.  Split it
into an in_use counter and an is_open boolean flag instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 51 ++++++++++++++++++++++++++--------------------
 fs/btrfs/volumes.h |  6 ++++--
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 02b61757798366..65d28c79402091 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -414,7 +414,8 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device;
 
-	WARN_ON(fs_devices->opened);
+	WARN_ON_ONCE(fs_devices->in_use);
+	WARN_ON_ONCE(fs_devices->is_open);
 	while (!list_empty(&fs_devices->devices)) {
 		device = list_entry(fs_devices->devices.next,
 				    struct btrfs_device, dev_list);
@@ -537,7 +538,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 				continue;
 			if (devt && devt != device->devt)
 				continue;
-			if (fs_devices->opened) {
+			if (fs_devices->in_use) {
 				if (devt)
 					ret = -EBUSY;
 				break;
@@ -609,7 +610,7 @@ static struct btrfs_fs_devices *find_fsid_by_device(
 	if (found_by_devt) {
 		/* Existing device. */
 		if (fsid_fs_devices == NULL) {
-			if (devt_fs_devices->opened == 0) {
+			if (devt_fs_devices->in_use == 0) {
 				/* Stale device. */
 				return NULL;
 			} else {
@@ -797,7 +798,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	if (!device) {
 		unsigned int nofs_flag;
 
-		if (fs_devices->opened) {
+		if (fs_devices->in_use) {
 			btrfs_err(NULL,
 "device %s belongs to fsid %pU, and the fs is already mounted, scanned by %s (%d)",
 				  path, fs_devices->fsid, current->comm,
@@ -862,7 +863,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (!fs_devices->in_use && found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
@@ -923,7 +924,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	 * it back. We need it to pick the disk with largest generation
 	 * (as above).
 	 */
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		device->generation = found_transid;
 		fs_devices->latest_generation = max_t(u64, found_transid,
 						fs_devices->latest_generation);
@@ -1122,15 +1123,19 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 
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
@@ -1142,7 +1147,7 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 
 	mutex_lock(&uuid_mutex);
 	close_fs_devices(fs_devices);
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		list_splice_init(&fs_devices->seed_list, &list);
 
 		/*
@@ -1190,7 +1195,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	if (fs_devices->open_devices == 0)
 		return -EINVAL;
 
-	fs_devices->opened = 1;
+	fs_devices->is_open = true;
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
@@ -1227,16 +1232,14 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
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
@@ -2203,13 +2206,14 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
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
 
@@ -2439,7 +2443,8 @@ static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 	list_add(&old_devices->fs_list, &fs_uuids);
 
 	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
-	seed_devices->opened = 1;
+	seed_devices->in_use = 1;
+	seed_devices->is_open = true;
 	INIT_LIST_HEAD(&seed_devices->devices);
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
@@ -7109,7 +7114,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 			return fs_devices;
 
 		fs_devices->seeding = true;
-		fs_devices->opened = 1;
+		fs_devices->in_use = 1;
+		fs_devices->is_open = true;
 		return fs_devices;
 	}
 
@@ -7126,6 +7132,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
 	}
+	fs_devices->in_use = 1;
 
 	if (!fs_devices->seeding) {
 		close_fs_devices(fs_devices);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3d35c4b92efb94..a136205044898c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -357,8 +357,10 @@ struct btrfs_fs_devices {
 
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
2.39.2


