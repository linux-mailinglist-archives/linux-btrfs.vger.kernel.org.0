Return-Path: <linux-btrfs+bounces-15800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DEB18AF3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814731AA4011
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656572E36E8;
	Sat,  2 Aug 2025 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hJgcAhHj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hJgcAhHj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767B1E32BE
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117783; cv=none; b=B/hcdz5H9IJ3jO9YsOtS8mrBuLTtniZJMXgYDZ919YmAVKMc+XJXg1XqkjrcvlMnVVJnG2WKuK8u75SXnv+V2cNneRPn+oC5hbBwOS/+Vg0rvGPqSB7x9OCMI4aYupFoGSdCtJp4wRq5uE/XlB2BG67yIzPjrH1xNUqb+ksDUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117783; c=relaxed/simple;
	bh=is6RN+UgDkSMpTLy5Pk2QOTmgoVhyu/e2w33Q+iy5PY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXz+KNVXT0zleg6kwXfI5ghIn2s9csXznK8LEpoZlsr0apgmDVQDsOhAJ8bDN2+on8ftwvk67wYCi0Zs7nD4S8Ev+n0MBoAEQIvCNR3EM8yZMa3VWtIDBDzXdsp2JBFVD+oZ59dGasLHFfZrwrhm7elNNQTeXoK5IRsJGe5lLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hJgcAhHj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hJgcAhHj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49A9F21AA5
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L35beHh1tCfGqw7nXyAa081W6nrh1pJIEz5zdKiHixc=;
	b=hJgcAhHjeEEPyAG0O2Xe2fEG44iq6IYqpZDSH6ZIT7xpWa0q9rTOSeMiHOIwBmQ0Pjd8QX
	KEIQsSOFn3R+5t2AcCDRlHFY6TKWF6Orj+ys8cIeBoHbO7mPhRxcL8bwj1yZwA1FYRG3DM
	sIXQpK9x603rKtT9UpXYUEzyJElfosA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hJgcAhHj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L35beHh1tCfGqw7nXyAa081W6nrh1pJIEz5zdKiHixc=;
	b=hJgcAhHjeEEPyAG0O2Xe2fEG44iq6IYqpZDSH6ZIT7xpWa0q9rTOSeMiHOIwBmQ0Pjd8QX
	KEIQsSOFn3R+5t2AcCDRlHFY6TKWF6Orj+ys8cIeBoHbO7mPhRxcL8bwj1yZwA1FYRG3DM
	sIXQpK9x603rKtT9UpXYUEzyJElfosA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EA65133D1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mGfXD422jWhhHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 06:56:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: add error handling for device_get_partition_size_fd_stat()
Date: Sat,  2 Aug 2025 16:25:49 +0930
Message-ID: <45bc07da5d31e1dcea722036bfd455de4e382e34.1754116463.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754116463.git.wqu@suse.com>
References: <cover.1754116463.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 49A9F21AA5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The function device_get_partition_size_fd_state() has two different
error paths:

- The target file is not a regular nor block file
  This should be the common one.

- ioctl failed
  This should be very rare.

But it has no way to return error other than returning 0.
This is not helpful for end users to know what's going wrong.

Change that function to have a dedicated return value for error
handling, and pass a u64 pointer for the result.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c            |  8 +++++++-
 check/mode-lowmem.c     |  8 +++++++-
 common/device-utils.c   | 24 ++++++++++++++----------
 common/device-utils.h   |  2 +-
 image/common.c          |  7 ++++++-
 kernel-shared/volumes.c |  9 +++++++--
 kernel-shared/zoned.c   | 18 +++++++++++++-----
 mkfs/common.c           | 16 ++++++++++++----
 mkfs/main.c             | 12 +++++++++---
 9 files changed, 76 insertions(+), 28 deletions(-)

diff --git a/check/main.c b/check/main.c
index 84b6de597072..8bc1a164e05d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5447,7 +5447,13 @@ static int process_device_item(struct rb_root *dev_cache,
 				device->devid);
 			goto skip;
 		}
-		block_dev_size = device_get_partition_size_fd_stat(device->fd, &st);
+		ret = device_get_partition_size_fd_stat(device->fd, &st, &block_dev_size);
+		if (ret < 0) {
+			warning(
+	"failed to get device size for %s, skipping its block device size check: %m",
+				device->name);
+			goto skip;
+		}
 		if (block_dev_size < rec->total_byte) {
 			error(
 "block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index e05bb0da1709..9aec7eab6e90 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4822,7 +4822,13 @@ next:
 			dev->devid);
 		return 0;
 	}
-	block_dev_size = device_get_partition_size_fd_stat(dev->fd, &st);
+	ret = device_get_partition_size_fd_stat(dev->fd, &st, &block_dev_size);
+	if (ret < 0) {
+		warning(
+	"failed to get device size for %s, skipping its block device size check: %m",
+			dev->name);
+		return 0;
+	}
 	if (block_dev_size < total_bytes) {
 		error(
 "block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
diff --git a/common/device-utils.c b/common/device-utils.c
index 6d89d16b029d..2912375a4d21 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -236,9 +236,10 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
 		return 1;
 	}
 
-	byte_count = device_get_partition_size_fd_stat(fd, &st);
-	if (byte_count == 0) {
-		error("unable to determine size of %s", file);
+	ret = device_get_partition_size_fd_stat(fd, &st, &byte_count);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get device size for %s: %m", file);
 		return 1;
 	}
 	if (max_byte_count)
@@ -315,17 +316,20 @@ err:
 	return 1;
 }
 
-u64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
+int device_get_partition_size_fd_stat(int fd, const struct stat *st, u64 *result_ret)
 {
-	u64 size;
+	int ret;
 
-	if (S_ISREG(st->st_mode))
-		return st->st_size;
-	if (!S_ISBLK(st->st_mode))
+	if (S_ISREG(st->st_mode)) {
+		*result_ret = st->st_size;
 		return 0;
-	if (ioctl(fd, BLKGETSIZE64, &size) >= 0)
-		return size;
+	}
+	if (!S_ISBLK(st->st_mode))
+		return -EINVAL;
 
+	ret = ioctl(fd, BLKGETSIZE64, result_ret);
+	if (ret < 0)
+		return -errno;
 	return 0;
 }
 
diff --git a/common/device-utils.h b/common/device-utils.h
index bf04eb0f2fdd..c55b6944693a 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -44,7 +44,7 @@ int device_discard_blocks(int fd, u64 start, u64 len);
 int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
 int device_get_partition_size(const char *dev, u64 *result_ret);
 u64 device_get_partition_size_fd(int fd);
-u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
+int device_get_partition_size_fd_stat(int fd, const struct stat *st, u64 *result_ret);
 int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
 u64 device_get_zone_unusable(int fd, u64 flags);
 u64 device_get_zone_size(int fd, const char *name);
diff --git a/image/common.c b/image/common.c
index 3faf803f91e5..74ad7fd426bb 100644
--- a/image/common.c
+++ b/image/common.c
@@ -118,7 +118,12 @@ void write_backup_supers(int fd, u8 *buf)
 		return;
 	}
 
-	size = device_get_partition_size_fd_stat(fd, &st);
+	ret = device_get_partition_size_fd_stat(fd, &st, &size);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get device size: %m");
+		return;
+	}
 
 	for (i = 1; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index be01bdb4d3f6..0608933ebc9a 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -3096,8 +3096,13 @@ static int btrfs_fix_block_device_size(struct btrfs_fs_info *fs_info,
 		return -errno;
 	}
 
-	block_dev_size = round_down(device_get_partition_size_fd_stat(device->fd, &st),
-				    fs_info->sectorsize);
+	ret = device_get_partition_size_fd_stat(device->fd, &st, &block_dev_size);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get device size for %s: %m", device->name);
+		return ret;
+	}
+	block_dev_size = round_down(block_dev_size, fs_info->sectorsize);
 
 	/*
 	 * Total_bytes in device item is no larger than the device block size,
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index d96311af70b2..f88f4fbd3465 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -166,7 +166,8 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
 {
 	const sector_t zone_sectors = emulated_zone_size >> SECTOR_SHIFT;
 	struct stat st;
-	sector_t bdev_size;
+	u64 bdev_size;
+	sector_t bdev_nr_sectors;
 	unsigned int i;
 	int ret;
 
@@ -176,7 +177,13 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
 		return -EIO;
 	}
 
-	bdev_size = device_get_partition_size_fd_stat(fd, &st) >> SECTOR_SHIFT;
+	ret = device_get_partition_size_fd_stat(fd, &st, &bdev_size);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get device size for %s: %m", file);
+		return ret;
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
@@ -325,8 +332,9 @@ static int report_zones(int fd, const char *file,
 		return -EIO;
 	}
 
-	device_size = device_get_partition_size_fd_stat(fd, &st);
-	if (device_size == 0) {
+	ret = device_get_partition_size_fd_stat(fd, &st, &device_size);
+	if (ret < 0) {
+		errno = -ret;
 		error("zoned: failed to read size of %s: %m", file);
 		exit(1);
 	}
diff --git a/mkfs/common.c b/mkfs/common.c
index d7a1dc5867eb..f146f4a414a6 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -1173,6 +1173,7 @@ int is_vol_small(const char *file)
 	int e;
 	struct stat st;
 	u64 size;
+	int ret;
 
 	fd = open(file, O_RDONLY);
 	if (fd < 0)
@@ -1182,10 +1183,10 @@ int is_vol_small(const char *file)
 		close(fd);
 		return e;
 	}
-	size = device_get_partition_size_fd_stat(fd, &st);
-	if (size == 0) {
+	ret = device_get_partition_size_fd_stat(fd, &st, &size);
+	if (ret < 0) {
 		close(fd);
-		return -1;
+		return ret;
 	}
 	if (size < BTRFS_MKFS_SMALL_VOLUME_SIZE) {
 		close(fd);
@@ -1200,6 +1201,8 @@ int test_minimum_size(const char *file, u64 min_dev_size)
 {
 	int fd;
 	struct stat statbuf;
+	u64 device_size;
+	int ret;
 
 	fd = open(file, O_RDONLY);
 	if (fd < 0)
@@ -1208,7 +1211,12 @@ int test_minimum_size(const char *file, u64 min_dev_size)
 		close(fd);
 		return -errno;
 	}
-	if (device_get_partition_size_fd_stat(fd, &statbuf) < min_dev_size) {
+	ret = device_get_partition_size_fd_stat(fd, &statbuf, &device_size);
+	if (ret < 0) {
+		close(fd);
+		return ret;
+	}
+	if (device_size < min_dev_size) {
 		close(fd);
 		return 1;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index c3529044a836..546cc74735a9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1818,9 +1818,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		 * Block_count not specified, use file/device size first.
 		 * Or we will always use source_dir_size calculated for mkfs.
 		 */
-		if (!byte_count)
-			byte_count = round_down(device_get_partition_size_fd_stat(fd, &statbuf),
-						sectorsize);
+		if (!byte_count) {
+			ret = device_get_partition_size_fd_stat(fd, &statbuf, &byte_count);
+			if (ret < 0) {
+				errno = -ret;
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


