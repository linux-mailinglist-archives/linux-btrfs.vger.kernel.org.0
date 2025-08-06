Return-Path: <linux-btrfs+bounces-15885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BAB1BFB3
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FF2188639D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 04:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1411EDA1B;
	Wed,  6 Aug 2025 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VUy8xwj1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VUy8xwj1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1A1EB5FE
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455779; cv=none; b=g0iTWV8wchfIh7/GIQi5k7Ycc+v9m5q6QsFrBXAls3xEvCe35lylKQKHKmC7ZNl1aBiPooWvIDrFbEpYN8z65s1DD8xdGUI45KU/KVwgAM1sz4EK1QFoodHAhHsQ9hHcDtYl8Pi2fsRj5Mmux5Nig6h76qwKAM2pESE9zVYqza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455779; c=relaxed/simple;
	bh=25GKJStM0EYA+KVgl5iRA4p28+/FAkGA9P1odVhZgUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAI2Ixnh6oIMHup70I1IJgKBUXSghQFjwzXCrU6YSKZGc1w1/MvuZdVlmsnolwXG9avuGvSgqvEvRb1VqTATh/NVkAjk7HKWQAKv24g1D4s72QX7KJScKxCgGDkH1T6hB+ZDku1l8lAz/+rwBgmX08XOP2cJRscxpa5cgN8K4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VUy8xwj1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VUy8xwj1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16D941F38E
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN7I4eDB8jtFXvDfhJONAkmzfDst3xfik7qqfRe9pXQ=;
	b=VUy8xwj1eZXtOQrNMHjWPIV/8ERNdsIEQfFkDYH162ov0479YSuSjZWmLCN4gzvifxiZzI
	SG1HwnqACYx/EwkyCIS/GTdGSRfldJt/rsM3jHqIvlVnE1lmTI/6Y3jGGwAKK5hSicwj6a
	IO/EtZwMfODNM/dCXky64Lm8Bw9uYaQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VUy8xwj1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN7I4eDB8jtFXvDfhJONAkmzfDst3xfik7qqfRe9pXQ=;
	b=VUy8xwj1eZXtOQrNMHjWPIV/8ERNdsIEQfFkDYH162ov0479YSuSjZWmLCN4gzvifxiZzI
	SG1HwnqACYx/EwkyCIS/GTdGSRfldJt/rsM3jHqIvlVnE1lmTI/6Y3jGGwAKK5hSicwj6a
	IO/EtZwMfODNM/dCXky64Lm8Bw9uYaQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53F4913AA8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CGIDBtDekmjFRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Aug 2025 04:49:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/6] btrfs-progs: add error handling for device_get_partition_size_fd_stat()
Date: Wed,  6 Aug 2025 14:18:55 +0930
Message-ID: <529ae91e63a07645b0d9f2d769c785de92e1fc23.1754455239.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754455239.git.wqu@suse.com>
References: <cover.1754455239.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 16D941F38E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

The function device_get_partition_size_fd_state() has two different
error paths:

- The target file is not a regular nor block file
  This should be the common one.

- ioctl failed
  This should be very rare.

But it has no way to return error other than returning 0.
This is not helpful for end users to know what's going wrong.

Change that function to return s64, and since block device size should
be no larger than LLONG_MAX, it's safe to use the minus range to
indicate errors.

And since we're here, also enhance the error handling of the callers to
do an explicit error message.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c            |  8 +++++++-
 check/mode-lowmem.c     |  9 ++++++++-
 common/device-utils.c   | 27 ++++++++++++++++-----------
 common/device-utils.h   |  2 +-
 kernel-shared/volumes.c | 11 ++++++++---
 kernel-shared/zoned.c   | 18 +++++++++++++-----
 mkfs/common.c           | 10 ++++++----
 mkfs/main.c             | 14 ++++++++++----
 8 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/check/main.c b/check/main.c
index 84b6de597072..f0ca78bb2e19 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5438,7 +5438,7 @@ static int process_device_item(struct rb_root *dev_cache,
 	device = btrfs_find_device_by_devid(gfs_info->fs_devices, rec->devid, 0);
 	if (device && device->fd >= 0) {
 		struct stat st;
-		u64 block_dev_size;
+		s64 block_dev_size;
 
 		ret = fstat(device->fd, &st);
 		if (ret < 0) {
@@ -5448,6 +5448,12 @@ static int process_device_item(struct rb_root *dev_cache,
 			goto skip;
 		}
 		block_dev_size = device_get_partition_size_fd_stat(device->fd, &st);
+		if (block_dev_size < 0) {
+			errno = -block_dev_size;
+			warning("failed to get device size for %s, skipping size check: %m",
+				device->name);
+			goto skip;
+		}
 		if (block_dev_size < rec->total_byte) {
 			error(
 "block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index e05bb0da1709..8d1b4c3f3f2d 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4716,7 +4716,7 @@ static int check_dev_item(struct extent_buffer *eb, int slot,
 	struct btrfs_dev_extent *ptr;
 	struct btrfs_device *dev;
 	struct stat st;
-	u64 block_dev_size;
+	s64 block_dev_size;
 	u64 total_bytes;
 	u64 dev_id;
 	u64 used;
@@ -4823,6 +4823,13 @@ next:
 		return 0;
 	}
 	block_dev_size = device_get_partition_size_fd_stat(dev->fd, &st);
+	if (block_dev_size < 0) {
+		errno = -block_dev_size;
+		warning(
+	"failed to get device size for %s, skipping its block device size check: %m",
+			dev->name);
+		return 0;
+	}
 	if (block_dev_size < total_bytes) {
 		error(
 "block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
diff --git a/common/device-utils.c b/common/device-utils.c
index 8b545d171b18..b4daf7605fff 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -226,7 +226,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
 			 u64 max_byte_count, unsigned opflags)
 {
 	struct btrfs_zoned_device_info *zinfo = NULL;
-	u64 byte_count;
+	s64 byte_count;
 	struct stat st;
 	int i, ret;
 
@@ -237,12 +237,13 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
 	}
 
 	byte_count = device_get_partition_size_fd_stat(fd, &st);
-	if (byte_count == 0) {
-		error("unable to determine size of %s", file);
+	if (byte_count < 0) {
+		errno = -byte_count;
+		error("unable to determine size of %s: %m", file);
 		return 1;
 	}
 	if (max_byte_count)
-		byte_count = min(byte_count, max_byte_count);
+		byte_count = min_t(u64, byte_count, max_byte_count);
 
 	if (opflags & PREP_DEVICE_ZONED) {
 		ret = btrfs_get_zone_info(fd, file, &zinfo);
@@ -315,18 +316,22 @@ err:
 	return 1;
 }
 
-u64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
+s64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
 {
 	u64 size;
 
-	if (S_ISREG(st->st_mode))
+	if (S_ISREG(st->st_mode)) {
+		if (st->st_size > LLONG_MAX)
+			return -ERANGE;
 		return st->st_size;
+	}
 	if (!S_ISBLK(st->st_mode))
-		return 0;
-	if (ioctl(fd, BLKGETSIZE64, &size) >= 0)
-		return size;
-
-	return 0;
+		return -EINVAL;
+	if (ioctl(fd, BLKGETSIZE64, &size) < 0)
+		return -errno;
+	if (size > LLONG_MAX)
+		return -ERANGE;
+	return size;
 }
 
 static s64 device_get_partition_size_sysfs(const char *dev)
diff --git a/common/device-utils.h b/common/device-utils.h
index 2ada057adcd3..666dc3196e2f 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -43,7 +43,7 @@ enum {
 int device_discard_blocks(int fd, u64 start, u64 len);
 int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
 s64 device_get_partition_size(const char *dev);
-u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
+s64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
 int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
 u64 device_get_zone_unusable(int fd, u64 flags);
 u64 device_get_zone_size(int fd, const char *name);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index be01bdb4d3f6..fccff07ba761 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -3081,7 +3081,7 @@ static int btrfs_fix_block_device_size(struct btrfs_fs_info *fs_info,
 				       struct btrfs_device *device)
 {
 	struct stat st;
-	u64 block_dev_size;
+	s64 block_dev_size;
 	int ret;
 
 	if (device->fd < 0 || !device->writeable) {
@@ -3096,8 +3096,13 @@ static int btrfs_fix_block_device_size(struct btrfs_fs_info *fs_info,
 		return -errno;
 	}
 
-	block_dev_size = round_down(device_get_partition_size_fd_stat(device->fd, &st),
-				    fs_info->sectorsize);
+	block_dev_size = device_get_partition_size_fd_stat(device->fd, &st);
+	if (block_dev_size < 0) {
+		errno = -block_dev_size;
+		error("failed to get device size for %s: %m", device->name);
+		return -errno;
+	}
+	block_dev_size = round_down(block_dev_size, fs_info->sectorsize);
 
 	/*
 	 * Total_bytes in device item is no larger than the device block size,
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index d96311af70b2..1036dbd153ad 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -166,7 +166,8 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
 {
 	const sector_t zone_sectors = emulated_zone_size >> SECTOR_SHIFT;
 	struct stat st;
-	sector_t bdev_size;
+	s64 bdev_size;
+	sector_t bdev_nr_sectors;
 	unsigned int i;
 	int ret;
 
@@ -176,7 +177,13 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
 		return -EIO;
 	}
 
-	bdev_size = device_get_partition_size_fd_stat(fd, &st) >> SECTOR_SHIFT;
+	bdev_size = device_get_partition_size_fd_stat(fd, &st);
+	if (bdev_size < 0) {
+		errno = -bdev_size;
+		error("failed to get device size for %s: %m", file);
+		return bdev_size;
+	}
+	bdev_nr_sectors = bdev_size >> SECTOR_SHIFT;
 
 	pos >>= SECTOR_SHIFT;
 	for (i = 0; i < nr_zones; i++) {
@@ -187,7 +194,7 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
 		zones[i].type = BLK_ZONE_TYPE_CONVENTIONAL;
 		zones[i].cond = BLK_ZONE_COND_NOT_WP;
 
-		if (zones[i].wp >= bdev_size) {
+		if (zones[i].wp >= bdev_nr_sectors) {
 			i++;
 			break;
 		}
@@ -289,7 +296,7 @@ int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
 static int report_zones(int fd, const char *file,
 			struct btrfs_zoned_device_info *zinfo)
 {
-	u64 device_size;
+	s64 device_size;
 	u64 zone_bytes = zone_size(file);
 	size_t rep_size;
 	u64 sector = 0;
@@ -326,7 +333,8 @@ static int report_zones(int fd, const char *file,
 	}
 
 	device_size = device_get_partition_size_fd_stat(fd, &st);
-	if (device_size == 0) {
+	if (device_size < 0) {
+		errno = -device_size;
 		error("zoned: failed to read size of %s: %m", file);
 		exit(1);
 	}
diff --git a/mkfs/common.c b/mkfs/common.c
index c5f73de81194..12a9a0bd8176 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -1171,6 +1171,7 @@ int test_minimum_size(const char *file, u64 min_dev_size)
 {
 	int fd;
 	struct stat statbuf;
+	s64 size;
 
 	fd = open(file, O_RDONLY);
 	if (fd < 0)
@@ -1179,11 +1180,12 @@ int test_minimum_size(const char *file, u64 min_dev_size)
 		close(fd);
 		return -errno;
 	}
-	if (device_get_partition_size_fd_stat(fd, &statbuf) < min_dev_size) {
-		close(fd);
-		return 1;
-	}
+	size = device_get_partition_size_fd_stat(fd, &statbuf);
 	close(fd);
+	if (size < 0)
+		return size;
+	if (size < min_dev_size)
+		return 1;
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index c3529044a836..166a4fc0fd32 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1254,7 +1254,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	bool metadata_profile_set = false;
 	u64 data_profile = 0;
 	bool data_profile_set = false;
-	u64 byte_count = 0;
+	s64 byte_count = 0;
 	u64 dev_byte_count = 0;
 	bool mixed = false;
 	char *label = NULL;
@@ -1818,9 +1818,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		 * Block_count not specified, use file/device size first.
 		 * Or we will always use source_dir_size calculated for mkfs.
 		 */
-		if (!byte_count)
-			byte_count = round_down(device_get_partition_size_fd_stat(fd, &statbuf),
-						sectorsize);
+		if (!byte_count) {
+			byte_count = device_get_partition_size_fd_stat(fd, &statbuf);
+			if (byte_count < 0) {
+				errno = -byte_count;
+				error("failed to get device size for %s: %m", file);
+				goto error;
+			}
+			byte_count = round_down(byte_count, sectorsize);
+		}
 		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
 				min_dev_size, metadata_profile, data_profile);
 		UASSERT(IS_ALIGNED(source_dir_size, sectorsize));
-- 
2.50.1


