Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD8421ED2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhJEGZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61147 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhJEGZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415011; x=1664951011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jv8pLMxV6PhfaH3nN9tKbSuoN7QYNwbyOFCiv7B8Qg0=;
  b=ajCcBE3APYyHvgj3ZI57ZJUgs/gRQ3eLIDaQbSsL1PEZhB1syzIrrkB/
   TE4Rbz8HZRMN0g86EF1F+0Qmj0EaN7RqjaTp4tGdwToKboZWT5tPN9gXH
   Uo7AWlEyhmZT4B7mwGJ9cVwFmPo4qm8GeUGk8qDanwQJilCAbWGlgSINc
   06tzhsa10XU4dTqezNWCTMYfd6fzQa4jw4TQBk/kJGJ1uXNldpvGRVEAw
   qJbutI9rq0Y2iWz8mXGU8cJ7ZLYMrgOjDW3PN7h+icN+JCA/2ZBmAqfyp
   SqECemfLBhAq7YhO2ZkJMU1GJY89Lb9/jCSnmKZunk/KbrO62UXdBL0lE
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648915"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:31 +0800
IronPort-SDR: 46R/hzNX8aMn1Pw566l5WUCl3GvPKoj9iZI30LQHWWmWN8rwLMB1EyQjSzhdSbsiHUHxwi3NR2
 K0IPWc9ww+rw3RoxVJaDZknODVlw6V+LTeNClpQIhJSydzyB+nKnQF35YGiu3sBqVk1jp7wRnl
 a8JdTKzHfe0hncDfx20QB3Ed7VMLRHW+fqt9a14m03OtSrh5BZsVBtDXe06Id6x+9HPZvzM5rq
 vDlpUvGoukZZXMpr8EEzY5rSEkM0kKAwec8hwZu3gzDExuywrOF7of/wHHYjBbpY7PgpBZxsVd
 Aao8DpcnqPG+Oqzf02pLF4DF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:55 -0700
IronPort-SDR: AVZfgq8XXanzZoD9y94d5wm0tLXD/mPApTWk//fXG/WteR3xq5Wy95pNbfjOCGhLaXR3hJfjAk
 p2v0x7egbyp7C2DQZkXLwEcbRGYc4PcUsvqZZMD+QOo4fYag875BvkXIXRXTL11CPbufJw4LeW
 zjv7JNMl5oNRCj20UNBEsxQGGHIVXPR4NJoZwH+TgulbUhMK2hJFePCZ0hAvk4a4WBhNJyTp+T
 Z4dY14Nrlo5q3VeMbssiLGrvacCHiwdz+O2vTAJgWH4vr0F0Xa7SHY2YLqdPXAlqjlH7kA3OaI
 Qfc=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:31 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/7] btrfs-progs: introduce btrfs_pwrite wrapper for pwrite
Date:   Tue,  5 Oct 2021 15:23:02 +0900
Message-Id: <20211005062305.549871-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Wrap pwrite with btrfs_pwrite(). It simply calls pwrite() on non-zoned
btrfs (= opened without O_DIRECT). On zoned mode (= opened with O_DIRECT),
it allocates an aligned bounce buffer, copy the contents and use it for
direct-IO writing.

Writes in device_zero_blocks() and btrfs_wipe_existing_sb() are a little
tricky. We don't have fs_info on our hands, so use zinfo to determine it is
a zoned device or not.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/device-utils.c     | 76 ++++++++++++++++++++++++++++++++++++---
 common/device-utils.h     | 19 +++++++++-
 kernel-shared/extent_io.c |  7 ++--
 kernel-shared/zoned.c     |  4 +--
 mkfs/common.c             | 14 +++++---
 5 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 366154b98218..3e58d6d0a412 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -26,6 +26,7 @@
 #include <dirent.h>
 #include <blkid/blkid.h>
 #include <linux/limits.h>
+#include <linux/fs.h>
 #include <limits.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/disk-io.h"
@@ -95,7 +96,7 @@ int device_discard_blocks(int fd, u64 start, u64 len)
 /*
  * Write zeros to the given range [start, start + len)
  */
-int device_zero_blocks(int fd, off_t start, size_t len)
+int device_zero_blocks(int fd, off_t start, size_t len, const bool direct)
 {
 	char *buf = malloc(len);
 	int ret = 0;
@@ -104,7 +105,7 @@ int device_zero_blocks(int fd, off_t start, size_t len)
 	if (!buf)
 		return -ENOMEM;
 	memset(buf, 0, len);
-	written = pwrite(fd, buf, len, start);
+	written = btrfs_pwrite(fd, buf, len, start, direct);
 	if (written != len)
 		ret = -EIO;
 	free(buf);
@@ -134,7 +135,7 @@ static int zero_dev_clamped(int fd, struct btrfs_zoned_device_info *zinfo,
 	if (zinfo && zinfo->model == ZONED_HOST_MANAGED)
 		return zero_zone_blocks(fd, zinfo, start, end - start);
 
-	return device_zero_blocks(fd, start, end - start);
+	return device_zero_blocks(fd, start, end - start, false);
 }
 
 /*
@@ -176,8 +177,10 @@ static int btrfs_wipe_existing_sb(int fd, struct btrfs_zoned_device_info *zinfo)
 		len = sizeof(buf);
 
 	if (!zone_is_sequential(zinfo, offset)) {
+		const bool direct = zinfo && zinfo->model == ZONED_HOST_MANAGED;
+
 		memset(buf, 0, len);
-		ret = pwrite(fd, buf, len, offset);
+		ret = btrfs_pwrite(fd, buf, len, offset, direct);
 		if (ret < 0) {
 			error("cannot wipe existing superblock: %m");
 			ret = -1;
@@ -510,3 +513,68 @@ out:
 	close(sysfs_fd);
 	return ret;
 }
+
+ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
+{
+	int alignment;
+	size_t iosize;
+	void *bounce_buf = NULL;
+	struct stat stat_buf;
+	unsigned long req;
+	int ret;
+	ssize_t ret_rw;
+
+	ASSERT(rw == READ || rw == WRITE);
+
+	if (fstat(fd, &stat_buf) == -1) {
+		error("fstat failed (%m)");
+		return 0;
+	}
+
+	if ((stat_buf.st_mode & S_IFMT) == S_IFBLK)
+		req = BLKSSZGET;
+	else
+		req = FIGETBSZ;
+
+	if (ioctl(fd, req, &alignment)) {
+		error("failed to get block size: %m");
+		return 0;
+	}
+
+	if (IS_ALIGNED((size_t)buf, alignment) && IS_ALIGNED(count, alignment)) {
+		if (rw == WRITE)
+			return pwrite(fd, buf, count, offset);
+		else
+			return pread(fd, buf, count, offset);
+	}
+
+	/* Cannot do anything if the write size is not aligned */
+	if (rw == WRITE && !IS_ALIGNED(count, alignment)) {
+		error("%lu is not aligned to %d", count, alignment);
+		return 0;
+	}
+
+	iosize = round_up(count, alignment);
+
+	ret = posix_memalign(&bounce_buf, alignment, iosize);
+	if (ret) {
+		error("failed to allocate bounce buffer: %m");
+		errno = ret;
+		return 0;
+	}
+
+	if (rw == WRITE) {
+		ASSERT(iosize == count);
+		memcpy(bounce_buf, buf, count);
+		ret_rw = pwrite(fd, bounce_buf, iosize, offset);
+	} else {
+		ret_rw = pread(fd, bounce_buf, iosize, offset);
+		if (ret_rw >= count) {
+			ret_rw = count;
+			memcpy(buf, bounce_buf, count);
+		}
+	}
+
+	free(bounce_buf);
+	return ret_rw;
+}
diff --git a/common/device-utils.h b/common/device-utils.h
index 099520bf9737..767dab4370e1 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -17,6 +17,8 @@
 #ifndef __DEVICE_UTILS_H__
 #define __DEVICE_UTILS_H__
 
+#include <stdbool.h>
+#include <unistd.h>
 #include "kerncompat.h"
 #include "sys/stat.h"
 
@@ -35,7 +37,7 @@
  * Generic block device helpers
  */
 int device_discard_blocks(int fd, u64 start, u64 len);
-int device_zero_blocks(int fd, off_t start, size_t len);
+int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
 u64 device_get_partition_size(const char *dev);
 u64 device_get_partition_size_fd(int fd);
 int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
@@ -47,5 +49,20 @@ u64 device_get_zone_size(int fd, const char *name);
 u64 btrfs_device_size(int fd, struct stat *st);
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags);
+ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset);
+
+#ifdef BTRFS_ZONED
+static inline ssize_t btrfs_pwrite(int fd, void *buf, size_t count,
+				   off_t offset, bool direct)
+{
+	if (!direct)
+		return pwrite(fd, buf, count, offset);
+
+	return btrfs_direct_pio(WRITE, fd, buf, count, offset);
+}
+#else
+#define btrfs_pwrite(fd, buf, count, offset, direct) \
+	({ (void)(direct); pwrite(fd, buf, count, offset); })
+#endif
 
 #endif
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index d3d79bc8f748..b5984949f431 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
 #include "common/utils.h"
+#include "common/device-utils.h"
 #include "common/internal.h"
 
 void extent_io_tree_init(struct extent_io_tree *tree)
@@ -809,7 +810,8 @@ out:
 int write_extent_to_disk(struct extent_buffer *eb)
 {
 	int ret;
-	ret = pwrite(eb->fd, eb->data, eb->len, eb->dev_bytenr);
+	ret = btrfs_pwrite(eb->fd, eb->data, eb->len, eb->dev_bytenr,
+			   eb->fs_info->zoned);
 	if (ret < 0)
 		goto out;
 	if (ret != eb->len) {
@@ -932,7 +934,8 @@ int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 			this_len = min(this_len, bytes_left);
 			dev_nr++;
 
-			ret = pwrite(device->fd, buf + total_write, this_len, dev_bytenr);
+			ret = btrfs_pwrite(device->fd, buf + total_write,
+					   this_len, dev_bytenr, info->zoned);
 			if (ret != this_len) {
 				if (ret < 0) {
 					fprintf(stderr, "Error writing to "
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 8d94f98a7fce..c2cce3b5f366 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -424,7 +424,7 @@ int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
 			count = zone_len - (ofst & (zone_len - 1));
 
 		if (!zone_is_sequential(zinfo, ofst)) {
-			ret = device_zero_blocks(fd, ofst, count);
+			ret = device_zero_blocks(fd, ofst, count, true);
 			if (ret != 0)
 				return ret;
 		}
@@ -595,7 +595,7 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 	if (rw == READ)
 		ret_sz = pread64(fd, buf, count, mapped);
 	else
-		ret_sz = pwrite64(fd, buf, count, mapped);
+		ret_sz = btrfs_pwrite(fd, buf, count, mapped, true);
 
 	if (ret_sz != count)
 		return ret_sz;
diff --git a/mkfs/common.c b/mkfs/common.c
index 20a7d1155972..5c8d6ac13a3b 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -54,7 +54,7 @@ static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_header_nritems(buf, 0);
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, block);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize, block, cfg->zone_size);
 	if (ret != cfg->nodesize)
 		return ret < 0 ? -errno : -EIO;
 	return 0;
@@ -134,7 +134,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 			     cfg->csum_type);
 
 	/* write back root tree */
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_ROOT_TREE]);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_ROOT_TREE], cfg->zone_size);
 	if (ret != cfg->nodesize)
 		return (ret < 0 ? -errno : -EIO);
 
@@ -422,7 +423,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_nritems(buf, nritems);
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_EXTENT_TREE]);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_EXTENT_TREE], cfg->zone_size);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
@@ -510,7 +512,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_nritems(buf, nritems);
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CHUNK_TREE]);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_CHUNK_TREE], cfg->zone_size);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
@@ -550,7 +553,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_nritems(buf, nritems);
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_DEV_TREE]);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_DEV_TREE], cfg->zone_size);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
-- 
2.33.0

