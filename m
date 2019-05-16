Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC2420179
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEPImz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 04:42:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfEPImy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 04:42:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 995F6AEC8
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 08:42:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs-progs: Make btrfs_scan_devices take a path
Date:   Thu, 16 May 2019 11:42:48 +0300
Message-Id: <20190516084250.19363-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516084250.19363-1-nborisov@suse.com>
References: <20190516084250.19363-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_scan_devices will only scan devices under /dev (and
some other places that libblkid understands). This may cause a btrfs
filesystem housed on a file to be missed when issuing certain commands.
This patch allow the caller to explicitly pass a path that should be
probed for a btrfs filesystem and added to libblkid's cache. This is a
prep patch and currently brings no functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds-device.c     |  2 +-
 cmds-filesystem.c |  2 +-
 disk-io.c         |  2 +-
 utils.c           | 18 +++++++++++++++---
 utils.h           |  2 +-
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/cmds-device.c b/cmds-device.c
index d3102ba7c1df..c65de8957ed6 100644
--- a/cmds-device.c
+++ b/cmds-device.c
@@ -294,7 +294,7 @@ static int cmd_device_scan(int argc, char **argv)
 
 	if (all || argc - optind == 0) {
 		printf("Scanning for Btrfs filesystems\n");
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(NULL);
 		error_on(ret, "error %d while scanning", ret);
 		ret = btrfs_register_all_devices();
 		error_on(ret, "there are %d errors while registering devices", ret);
diff --git a/cmds-filesystem.c b/cmds-filesystem.c
index b8beec13f0e5..4657deb20fde 100644
--- a/cmds-filesystem.c
+++ b/cmds-filesystem.c
@@ -771,7 +771,7 @@ static int cmd_filesystem_show(int argc, char **argv)
 		goto out;
 
 devs_only:
-	ret = btrfs_scan_devices();
+	ret = btrfs_scan_devices(NULL);
 
 	if (ret) {
 		error("blkid device scan returned %d", ret);
diff --git a/disk-io.c b/disk-io.c
index 797b9b79ea3c..0b9f3723d00a 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1056,7 +1056,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	}
 
 	if (!skip_devices && total_devs != 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(NULL);
 		if (ret)
 			return ret;
 	}
diff --git a/utils.c b/utils.c
index 9e26c884cc6c..d4f590049cf3 100644
--- a/utils.c
+++ b/utils.c
@@ -928,7 +928,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 
 	/* scan other devices */
 	if (is_btrfs && total_devs > 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(NULL);
 		if (ret)
 			return ret;
 	}
@@ -1979,8 +1979,14 @@ int group_profile_max_safe_loss(u64 flags)
 		return -1;
 	}
 }
-
-int btrfs_scan_devices(void)
+/**
+ * btrfs_scan_devices - scan all devices known to libblkid for the presence of
+ *			btrfs filesystems
+ *
+ * @device - if given, points to either a block device or regular file that
+ * should explicitly be added to libblkid's cache. Can be NULL
+ */
+int btrfs_scan_devices(char *device)
 {
 	int fd = -1;
 	int ret;
@@ -1998,7 +2004,13 @@ int btrfs_scan_devices(void)
 		error("blkid cache get failed");
 		return 1;
 	}
+
 	blkid_probe_all(cache);
+
+	/* Add passed device to libblkid's cache if needed */
+	if (device)
+		blkid_get_dev(cache, device, BLKID_DEV_NORMAL);
+
 	iter = blkid_dev_iterate_begin(cache);
 	blkid_dev_set_search(iter, "TYPE", "btrfs");
 	while (blkid_dev_next(iter, &dev) == 0) {
diff --git a/utils.h b/utils.h
index 7c5eb798557d..4df63a5b0260 100644
--- a/utils.h
+++ b/utils.h
@@ -140,7 +140,7 @@ int csum_tree_block(struct btrfs_fs_info *root, struct extent_buffer *buf,
 		    int verify);
 int ask_user(const char *question);
 int lookup_path_rootid(int fd, u64 *rootid);
-int btrfs_scan_devices(void);
+int btrfs_scan_devices(char *device);
 int get_btrfs_mount(const char *dev, char *mp, size_t mp_size);
 int find_mount_root(const char *path, char **mount_root);
 int get_device_info(int fd, u64 devid,
-- 
2.7.4

