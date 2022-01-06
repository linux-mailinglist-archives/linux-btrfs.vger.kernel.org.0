Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605D548691E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbiAFRtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:49:21 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:56256 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242374AbiAFRtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 12:49:16 -0500
Received: from venice.bhome ([84.220.25.125])
        by santino.mail.tiscali.it with 
        id fVpB260072hwt0401VpDJJ; Thu, 06 Jan 2022 17:49:13 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/2] btrfs-progs: new "allocation_hint" property.
Date:   Thu,  6 Jan 2022 18:49:02 +0100
Message-Id: <ef45c87a87f32f59545f0093da8835ae01b23792.1641491043.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641491043.git.kreijack@inwind.it>
References: <cover.1641491043.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641491353; bh=JBglZums9YQ5aaQbByVh3QfN4idnVx7qtVndwFrKlIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=j+OB7l+tjYMIOAMTp1vNnHhDkW9E8PsuGCgIrys2YsOIhv8jrAEkNhvU1luwbW1cJ
         2/pIxtV/zA60vOLyIjMMLJHK/kYqhqLkfEujHQFfo9qqbhpt5fTSg1xf4kv75JrFvu
         +veRv/Gjh0ukhmA5fNO1YF0X4o8d22W7DZhdh7BM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Handle the property allocation_hint of a btrfs device. Below
an example of use:

$ # set a new value
$ sudo btrfs property set /dev/vde allocation_hint DATA_ONLY

$ # get the current value
$ sudo btrfs property get /dev/vde allocation_hint
devid=4, path=/dev/vde: allocation_hint=DATA_ONLY

The following values are availables:
- DATA_ONLY
- DATA_PREFERRED (default)
- METADATA_PREFERRED
- METADATA_ONLY

Root privileges are required.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/property.c       | 202 ++++++++++++++++++++++++++++++++++++++++++
 kernel-shared/ctree.h |  13 +++
 2 files changed, 215 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index 59ef997c..1ac4266a 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/xattr.h>
+#include <sys/sysmacros.h>
 #include <uuid/uuid.h>
 #include <btrfsutil.h>
 #include "cmds/commands.h"
@@ -30,6 +31,7 @@
 #include "common/open-utils.h"
 #include "common/utils.h"
 #include "common/help.h"
+#include "common/path-utils.h"
 
 #define XATTR_BTRFS_PREFIX     "btrfs."
 #define XATTR_BTRFS_PREFIX_LEN (sizeof(XATTR_BTRFS_PREFIX) - 1)
@@ -232,6 +234,200 @@ out:
 	return ret;
 }
 
+static int btrfs_find_devid_and_mnt(const char *devpath, int *devid,
+				    char *path, int maxpath)
+{
+	int ret, i, fd;
+	DIR *dir;
+	struct stat stdevpath;
+	struct btrfs_ioctl_fs_info_args fi_args;
+	struct btrfs_ioctl_dev_info_args dev_info;
+
+	ret = get_btrfs_mount(devpath, path, maxpath);
+	if (ret)
+		return ret;
+
+	fd = btrfs_open_dir(path, &dir, 1);
+	if (fd < 0)
+		return fd;
+
+	ret = stat(devpath, &stdevpath);
+	if (ret) {
+		error("cannot stat '%s'", devpath);
+		goto out;
+	}
+
+	ret = ioctl(fd, BTRFS_IOC_FS_INFO, &fi_args);
+	if (ret < 0) {
+		if (errno == EPERM)
+			return -errno;
+		error("cannot get filesystem info: %m");
+		ret = -10;
+		goto out;
+	}
+
+	for (i = 0 ; i <= fi_args.max_id ; i++) {
+		struct stat st;
+
+		memset(&dev_info, 0, sizeof(dev_info));
+		ret = get_device_info(fd, i, &dev_info);
+		if (ret == -ENODEV)
+			continue;
+		if (ret) {
+			error("cannot get info about device devid=%d", i);
+			goto out;
+		}
+
+		if (!dev_info.path)
+			/* missing devices */
+			continue;
+
+		ret = stat((char *)dev_info.path, &st);
+		if (ret) {
+			error("cannot stat '%s'", devpath);
+			goto out;
+		}
+
+		if (major(st.st_rdev) == major(stdevpath.st_rdev) &&
+		    minor(st.st_rdev) == minor(stdevpath.st_rdev)) {
+			*devid = dev_info.devid;
+			ret = 0;
+			goto out;
+		}
+	}
+
+	ret = -12;
+
+out:
+	close_file_or_dir(fd, dir);
+	return ret;
+}
+
+static struct ull_charp_pair_t {
+	u64		value;
+	const char	*descr;
+} allocation_hint_description[] = {
+	{BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED, "METADATA_PREFERRED"},
+	{BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY, "METADATA_ONLY"},
+	{BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED, "DATA_PREFERRED"},
+	{BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY, "DATA_ONLY"},
+	{0, NULL}
+};
+
+static int prop_allocation_hint(enum prop_object_type type,
+				const char *object,
+				const char *name,
+				const char *val,
+				bool force)
+{
+	int ret, devid, fd, fd2 = -1;
+	char path[PATH_MAX];
+	DIR *dir;
+	u8 fsid[BTRFS_UUID_SIZE];
+	char fsid_str[BTRFS_UUID_UNPARSED_SIZE];
+	char sysfs_file[PATH_MAX];
+	char filename[PATH_MAX];
+	int i;
+	u64 v;
+	char buf[1024];
+
+	ret = btrfs_find_devid_and_mnt(object, &devid, path, sizeof(path));
+	if (ret)
+		return -5;
+
+	fd = btrfs_open_dir(path, &dir, 1);
+	if (fd < 0)
+		return fd;
+
+	ret = get_fsid_fd(fd, fsid);
+	if (ret < 0)
+		goto out;
+
+	uuid_unparse(fsid, fsid_str);
+	sprintf(filename, "devinfo/%d/allocation_hint", devid);
+
+	/* build /sys/fs/btrfs/<UUID>/devinfo/<DEVID>/type */
+	ret = path_cat3_out(sysfs_file, "/sys/fs/btrfs", fsid_str, filename);
+	if (ret < 0)
+		goto out;
+
+	if (!val) {
+		/* READ */
+		fd2 = open(sysfs_file, O_RDONLY);
+		if (fd2 < 0) {
+			error("'allocation_hint' property not available or accessible.");
+			ret = -errno;
+			goto out;
+		}
+
+		ret = read(fd2, buf, sizeof(buf) - 1);
+		if (ret < 0) {
+			error("Unable to read the 'allocation_hint' property.");
+			ret = -errno;
+			goto out;
+		}
+
+		buf[sizeof(buf) - 1] = 0;
+		v = strtoull(buf, NULL, 0);
+
+		for (i = 0 ; allocation_hint_description[i].descr ; i++)
+			if (v == allocation_hint_description[i].value)
+				break;
+
+		if (allocation_hint_description[i].descr)
+			printf("devid=%d, path=%s: allocation_hint=%s\n",
+				devid, object,
+				allocation_hint_description[i].descr);
+		else
+			printf("devid=%d, path=%s: allocation_hint=unknown:%llu\n",
+				devid, object, v);
+		ret = 0;
+	} else {
+		/* WRITE */
+		for (i = 0 ; allocation_hint_description[i].descr ; i++)
+			if (!strcmp(val, allocation_hint_description[i].descr))
+				break;
+
+		if (allocation_hint_description[i].descr) {
+			v = allocation_hint_description[i].value;
+		} else if (sscanf(val, "%llu", &v) != 1) {
+			error("Invalid value '%s'\n", val);
+			ret = -3;
+			goto out;
+		}
+		if (v & ~BTRFS_DEV_ALLOCATION_HINT_MASK) {
+			error("Invalid value '%s'\n", val);
+			ret = -3;
+			goto out;
+		}
+
+		fd2 = open(sysfs_file, O_RDWR);
+		if (fd2 < 0) {
+			error("'allocation_hint' property not available or accessible for updating.");
+			ret = -errno;
+			goto out;
+		}
+
+		sprintf(buf, "%llu", v);
+
+		ret = write(fd2, buf, strlen(buf));
+
+		if (ret != strlen(buf)) {
+			error("Unable to update 'allocation_hint' property.");
+			ret = -errno;
+			goto out;
+		}
+
+	}
+
+	ret = 0;
+out:
+	if (fd2 >= 0)
+		close(fd2);
+	close_file_or_dir(fd, dir);
+	return ret;
+}
+
 const struct prop_handler prop_handlers[] = {
 	{
 		.name ="ro",
@@ -254,6 +450,12 @@ const struct prop_handler prop_handlers[] = {
 		.types = prop_object_inode,
 		.handler = prop_compression
 	},
+	{
+		.name = "allocation_hint",
+		.desc = "hint to store the data/metadata chunks",
+		.types = prop_object_dev,
+		.handler = prop_allocation_hint
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 6ca49c09..597ad1af 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -216,6 +216,19 @@ struct btrfs_mapping_tree {
 	struct cache_tree cache_tree;
 };
 
+/* btrfs chunk allocation hints */
+#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT    2
+#define BTRFS_DEV_ALLOCATION_HINT_MASK ((1ULL << \
+	       BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
+/* preferred metadata chunk, but data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED        (1ULL)
+/* only metadata chunk are allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY     (2ULL)
+/* only data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY         (3ULL)
+/* preferred data chunk, but metadata chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED    (0ULL)
+
 #define BTRFS_UUID_SIZE 16
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
-- 
2.34.1

