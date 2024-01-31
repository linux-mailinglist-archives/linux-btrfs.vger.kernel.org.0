Return-Path: <linux-btrfs+bounces-1980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E8844B47
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 23:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566A41F21B18
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550523A8E9;
	Wed, 31 Jan 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lgq0yhbF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lgq0yhbF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7A3AC12
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741478; cv=none; b=JwKq0/vv8CkFoE/4LN8RDacbcdGJNTkSjuHQSyufl/5Uu4XQi9ExpCBjewYcA2SUIXFG0UtS34kuf+sa3rkNsaWdBYkidMJZPPc7bRRPgjwFyl5BtmdglqIH8TS8d+/yJFwaC1FnfvBiDrLBJqawL5x8Ugc/G620rlDATjEhJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741478; c=relaxed/simple;
	bh=r6hF+ha+eel6LaBSU/WVIpA6m8I5aQPHVBnWpava8Bg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Nw+5PYxnQHWndNUr5+CAV/wywnwagUv9q6Z0I8Tlkd4NboT9DulLxTuG1No4qYXcWbn0htg91pLtDEJnbXUtlh5/eL0ugk0NUn6l6uONxSl6Kxe7UBBHznQDOTZ2HW71la4ZgehF/mKUQoDlkvfKr7KoBZe9S9yGMrYimDEgt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lgq0yhbF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lgq0yhbF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29BF921FE4
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706741474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5hEeu73YNyXVLVi1oGqH0pFM/K5T3jsElrSugS5rii0=;
	b=lgq0yhbF3ywnArdv6s4WEo3c1pdWTGgCqJZbsD2+pzYBeMYKl11bL2+2m/YCt+nYzNyQTe
	P+F5IDX04849Rqa+1QtM8MfZCHURhW6u1i8tTptAsuS4qwVANY8WWdZTuyKEK1nbWTc9S7
	mDZswEeMie1Y2IF7AILUFPlufchSZKM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706741474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5hEeu73YNyXVLVi1oGqH0pFM/K5T3jsElrSugS5rii0=;
	b=lgq0yhbF3ywnArdv6s4WEo3c1pdWTGgCqJZbsD2+pzYBeMYKl11bL2+2m/YCt+nYzNyQTe
	P+F5IDX04849Rqa+1QtM8MfZCHURhW6u1i8tTptAsuS4qwVANY8WWdZTuyKEK1nbWTc9S7
	mDZswEeMie1Y2IF7AILUFPlufchSZKM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 64F8E139D9
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 22:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id j9U4CuHOumV/WAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 22:51:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs-progs: mkfs: use flock() to properly prevent race with udev
Date: Thu,  1 Feb 2024 09:20:55 +1030
Message-ID: <00c5eaac9a9165af52ed221d2c61bf097d0bf76c.1706741207.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.71
X-Spamd-Result: default: False [0.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.19)[-0.974];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

[BUG]
Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
descriptors open during whole time"), there is still a bug report about
blkid failed to grab the FSID:

 device=/dev/loop0
 fstype=btrfs

 wipefs -a "$device"*

 parted -s "$device" \
     mklabel gpt \
     mkpart '"EFI system partition"' fat32 1MiB 513MiB \
     set 1 esp on \
     mkpart '"root partition"' "$fstype" 513MiB 100%

 udevadm settle
 partitions=($(lsblk -n -o path "$device"))

 mkfs.fat -F 32 ${partitions[1]}
 mkfs."$fstype" ${partitions[2]}
 udevadm settle

The above script can sometimes result empty fsid:

 loop0
 |-loop0p1 BDF3-552B
 `-loop0p2

[CAUSE]
Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors
open during whole time") changed the lifespan of the fds, it doesn't
properly inform udev about our change to certain partition.

Thus for a multi-partition case, udev can start scanning the whole disk,
meanwhile our mkfs is still happening halfway.

If the scan is done before our new super blocks written, and our close()
calls happens later just before the current scan is finished, udev can
got the temporary super blocks (which is not a valid one).

And since our close() calls happens during the scan, there would be no
new scan, thus leading to the bad result.

[FIX]
The proper way to avoid race with udev is to flock() the whole disk
(aka, the parent block device, not the partition disk).
The behavior would be the same as "udevadm lock", the only difference is
we won't have the advanced deadline feature of "udevadm lock".

Thus this patch would introduce such mechanism by:

- btrfs_flock_one_device()
  This would resolve the path to a whole disk path.
  Then make sure the whole disk is not already locked (this can happen
  for cases like "mkfs.btrfs -f /dev/sda[123]").

  If the device is not already locked, then flock() the device, and
  insert a new entry into the list.

- btrfs_unlock_all_devices()
  Would go unlock all devices recorded in locked_devices list, and free
  the memory.

And mkfs.btrfs would be the first one to utilize the new mechanism, to
prevent such race with udev.

Issue: #734
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-utils.c | 126 ++++++++++++++++++++++++++++++++++++++++++
 common/device-utils.h |   3 +
 mkfs/main.c           |  11 ++++
 3 files changed, 140 insertions(+)
---
Changelog:
v2:
- Fix the patch prefix
  From "btrfs" to "btrfs-progs"

v3:
- Use correct st.st_rdev instead of st.st_dev
  St.st_dev is the device number of the fs where the block device is.
  It's st.st_rdev the real device number of a block device file.

- Constify the parameter for btrfs_flock_one_device()
  The function blkid_devno_to_wholedisk() would modify the parameter to
  the basename of the parent block device.
  thus we have to dump the string in the first place, or it would
  remove the "/dev/" string and make later device open to fail.

diff --git a/common/device-utils.c b/common/device-utils.c
index f86120afa00c..27475eb6b77c 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -17,11 +17,13 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/file.h>
 #include <linux/limits.h>
 #ifdef BTRFS_ZONED
 #include <linux/blkzoned.h>
 #endif
 #include <linux/fs.h>
+#include <linux/kdev_t.h>
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -48,6 +50,24 @@
 #define BLKDISCARD	_IO(0x12,119)
 #endif

+static LIST_HEAD(locked_devices);
+
+/*
+ * This is to record flock()ed devices.
+ * For flock() to prevent udev races, we must lock the parent block device,
+ * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that case
+ * we should only lock "/dev/sda" once.
+ *
+ * This structure would be used to record any flocked block device (not
+ * the partition one), and avoid double locking.
+ */
+struct btrfs_locked_wholedisk {
+	char *full_path;
+	dev_t devno;
+	int fd;
+	struct list_head list;
+};
+
 /*
  * Discard the given range in one go
  */
@@ -633,3 +653,109 @@ ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset)
 	free(bounce_buf);
 	return ret;
 }
+
+int btrfs_flock_one_device(const char *path)
+{
+	struct btrfs_locked_wholedisk *entry;
+	struct stat st = { 0 };
+	char *path_dump;
+	char *wholedisk_path;
+	dev_t wholedisk_devno;
+	int ret;
+
+	ret = stat(path, &st);
+	if (ret < 0) {
+		error("failed to stat %s: %m", path);
+		return -errno;
+	}
+	/* Non-block device, skipping the locking. */
+	if (!S_ISBLK(st.st_mode))
+		return 0;
+
+	/*
+	 * Dump the path as blkid_devno_to_wholedisk() would modify the path to
+	 * the basename of the wholedisk.
+	 */
+	path_dump = strdup(path);
+	if (!path_dump) {
+		error("failed to copy the string \"%s\": %m", path);
+		return -ENOMEM;
+	}
+	ret = blkid_devno_to_wholedisk(st.st_rdev, path_dump, strlen(path_dump),
+				       &wholedisk_devno);
+	if (ret < 0) {
+		free(path_dump);
+		error("failed to get the whole disk devno for %s: %m", path);
+		return -errno;
+	}
+	free(path_dump);
+	wholedisk_path = blkid_devno_to_devname(wholedisk_devno);
+	if (!wholedisk_path) {
+		error("failed to get the devname of dev %ld:%ld",
+			MAJOR(wholedisk_devno), MINOR(wholedisk_devno));
+	}
+
+	/* Check if we already have the whole disk in the list. */
+	list_for_each_entry(entry, &locked_devices, list) {
+		/* The wholedisk is already locked, need to do nothing. */
+		if (entry->devno == wholedisk_devno ||
+		    entry->full_path == wholedisk_path) {
+			free(wholedisk_path);
+			return 0;
+		}
+	}
+
+	/* Allocate new entry. */
+	entry = malloc(sizeof(*entry));
+	if (!entry) {
+		errno = ENOMEM;
+		error("unable to allocate new memory for %s: %m",
+		      wholedisk_path);
+		free(wholedisk_path);
+		return -errno;
+	}
+	entry->devno = wholedisk_devno;
+	entry->full_path = wholedisk_path;
+
+	/* Lock the whole disk. */
+	entry->fd = open(wholedisk_path, O_RDONLY);
+	if (entry->fd < 0) {
+		error("failed to open device %s: %m",
+		      wholedisk_path);
+		free(wholedisk_path);
+		free(entry);
+		return -errno;
+	}
+	ret = flock(entry->fd, LOCK_EX);
+	if (ret < 0) {
+		error("failed to hold an exclusive lock on %s: %m",
+		      wholedisk_path);
+		free(wholedisk_path);
+		free(entry);
+		return -errno;
+	}
+
+	/* Insert it into the list. */
+	list_add_tail(&entry->list, &locked_devices);
+	return 0;
+}
+
+void btrfs_unlock_all_devices(void)
+{
+	while (!list_empty(&locked_devices)) {
+		struct btrfs_locked_wholedisk *entry;
+		int ret;
+
+		entry = list_entry(locked_devices.next,
+				   struct btrfs_locked_wholedisk, list);
+
+		list_del_init(&entry->list);
+		ret = flock(entry->fd, LOCK_UN);
+		if (ret < 0)
+			warning("failed to unlock %s (fd %d dev %ld:%ld), skipping it",
+				entry->full_path, entry->fd, MAJOR(entry->devno),
+				MINOR(entry->devno));
+		free(entry->full_path);
+		free(entry);
+	}
+}
diff --git a/common/device-utils.h b/common/device-utils.h
index 853d17b5ab98..4f2481c87cc9 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -57,6 +57,9 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t offset);
 ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset);

+int btrfs_flock_one_device(const char *path);
+void btrfs_unlock_all_devices(void);
+
 #ifdef BTRFS_ZONED
 static inline ssize_t btrfs_pwrite(int fd, const void *buf, size_t count,
 				   off_t offset, bool direct)
diff --git a/mkfs/main.c b/mkfs/main.c
index b50b78b5665a..1297d790b1f8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1723,6 +1723,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}

+	/* Lock all devices to prevent race with udev probing. */
+	for (i = 0; i < device_count; i++) {
+		char *path = argv[optind + i - 1];
+
+		ret = btrfs_flock_one_device(path);
+		if (ret < 0)
+			warning("failed to flock %s, skipping it", path);
+	}
+
 	/* Start threads */
 	for (i = 0; i < device_count; i++) {
 		prepare_ctx[i].file = argv[optind + i - 1];
@@ -2079,6 +2088,7 @@ out:
 	free(label);
 	free(source_dir);

+	btrfs_unlock_all_devices();
 	return !!ret;

 error:
@@ -2090,6 +2100,7 @@ error:
 	free(prepare_ctx);
 	free(label);
 	free(source_dir);
+	btrfs_unlock_all_devices();
 	exit(1);
 success:
 	exit(0);
--
2.43.0


