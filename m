Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1110E322175
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhBVVch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:32:37 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:59684 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231986AbhBVVcc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:32:32 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-34.iol.local with ESMTPA
        id EInxl5gOr5WrZEInylGr7y; Mon, 22 Feb 2021 22:31:46 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614029506; bh=1fI3iq/CeKgOo9d8Hl0AEt6ZXV8NnPiUzN8kHMz0Ytk=;
        h=From;
        b=FB5j6FEiMdhp5B3GU/eWZQkq3aWVyzyNqXMyMM42luWD07TlJvkzo09yG3DfE7MHa
         35Q1F3EfZxAyXYiCpd6Gi2mKULcAniRvz32m4n0sCmzawQbZT5OM6JTYc1UKb0kX27
         zru3xkKIeQVn88GIdCK/VDQKDIIvsClC17jtL5K7ESyyCn6vsNA5Jo/2X06PYIMXS/
         XX8YynfCszRfkEJ09jVLCaHsFacyVtGKPAAcTlur1qCMBS9luKi06PPoJj+PgmYJju
         rEpexRv18uzWeJpaH8LzwCwWMWEKEpSbJfC46JAdXqUqU9ng20HJWjxJWWG0KGQxq9
         Nc6J85C34W+7Q==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=603422c2 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=H_GH1sqfpLVmWqknqvIA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/2] btrfs-progs: new "allocation_hint" property.
Date:   Mon, 22 Feb 2021 22:31:45 +0100
Message-Id: <2866fcc492b4af878e156879737d1955cdbcc0d6.1614029416.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614029416.git.kreijack@inwind.it>
References: <cover.1614029416.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF+JSnrEr4uWSLWg1DPbjSrB4BtcDYKl4m9q4MuRXjbBIaveeYCtOjbETRW2kQEDH7mvtJ5Qxb5GOJnbxrP6rJA0EZhlC1i0N+zFGrRHnCJw38BxR7DZ
 HGmz3Ew+dgv8ylsQd6uxptrssDW7wHmsf+5QPyuQGaFtWVBZkkZxelY2jUn2sURmsSOxZMm2vMOFfVdK/AkgisDcXqbYLZDqSdYtftt/dI5ML52D6QgcIWT8
 IV0EL8M/cOJCSWl1d9xmJsnMZONdebEsFBV/s3uHmTm7SKWUSj9oNsexBMzx3c0t
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
devid=4, path=/dev/vde: dedicated_metadata=DATA_ONLY

The following properties are availables:
- DATA_ONLY
- PREFERRED_DATA (default)
- PREFERRED_METADATA
- METADATA_ONLY

Root privileges are required.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 kernel-shared/ctree.h |  15 ++++
 props.c               | 171 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7683b8bb..1c9cb22d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -219,6 +219,21 @@ struct btrfs_mapping_tree {
 	struct cache_tree cache_tree;
 };
 
+/* btrfs chunk allocation hints */
+#define BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT    3
+#define BTRFS_DEV_ALLOCATION_MASK ((1ULL << \
+	       BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) - 1)
+/* preferred metadata chunk, but data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_PREFERRED_METADATA        (1ULL)
+/* only metadata chunk are allowed */
+#define BTRFS_DEV_ALLOCATION_METADATA_ONLY     (2ULL)
+/* only data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_DATA_ONLY         (3ULL)
+/* preferred data chunk, but metadata chunk allowed */
+#define BTRFS_DEV_ALLOCATION_PREFERRED_DATA    (0ULL)
+/* 5..7 are unused values */
+
+
 #define BTRFS_UUID_SIZE 16
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
diff --git a/props.c b/props.c
index 0cfc358d..d5fe361a 100644
--- a/props.c
+++ b/props.c
@@ -20,6 +20,7 @@
 #include <sys/xattr.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <sys/sysmacros.h>
 
 #include <btrfsutil.h>
 
@@ -166,6 +167,170 @@ out:
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
+	{BTRFS_DEV_ALLOCATION_PREFERRED_METADATA, "PREFERRED_METADATA"},
+	{BTRFS_DEV_ALLOCATION_METADATA_ONLY, "METADATA_ONLY"},
+	{BTRFS_DEV_ALLOCATION_PREFERRED_DATA, "PREFERRED_DATA"},
+	{BTRFS_DEV_ALLOCATION_DATA_ONLY, "DATA_ONLY"},
+	{0, NULL}
+};
+
+
+static int prop_allocation_hint(enum prop_object_type type,
+				const char *object,
+				const char *name,
+				const char *value)
+{
+	int ret, devid, fd;
+	char path[PATH_MAX];
+	DIR *dir;
+	struct btrfs_ioctl_dev_properties props;
+	int i;
+	u64 v;
+
+	ret = btrfs_find_devid_and_mnt(object, &devid, path, sizeof(path));
+	if (ret)
+		return -5;
+
+	fd = btrfs_open_dir(path, &dir, 1);
+	if (fd < 0)
+		return fd;
+
+	memset(&props, 0, sizeof(props));
+	props.devid = devid;
+	props.properties = BTRFS_DEV_PROPERTY_TYPE|BTRFS_DEV_PROPERTY_READ;
+	ret = ioctl(fd, BTRFS_IOC_DEV_PROPERTIES, &props);
+	if (ret < 0) {
+		error("Cannot perform BTRFS_IOC_DEV_PROPERTIES ioctl on '%s'",
+				path);
+		ret = -1;
+		goto out;
+	}
+
+	if (!value) {
+		v = props.type & BTRFS_DEV_ALLOCATION_MASK;
+		for (i = 0 ; allocation_hint_description[i].descr ; i++)
+			if (v == allocation_hint_description[i].value)
+				break;
+		if (allocation_hint_description[i].descr)
+			printf("devid=%d, path=%s: allocation_hint=%s\n",
+				devid, object,
+				allocation_hint_description[i].descr);
+		else
+			printf("devid=%d, path=%s: allocation_hint=unknown:%llu\n",
+				devid, object,
+				v);
+		ret = 0;
+		goto out;
+	}
+
+	for (i = 0 ; allocation_hint_description[i].descr ; i++)
+		if (!strcmp(value, allocation_hint_description[i].descr))
+			break;
+
+	if (allocation_hint_description[i].descr) {
+		v = allocation_hint_description[i].value;
+	} else if (sscanf(value, "%llu", &v) != 1) {
+		error("Invalid value '%s'\n", value);
+		ret = -3;
+		goto out;
+	} else if (v & ~BTRFS_DEV_ALLOCATION_MASK) {
+		error("Invalid value '%s'\n", value);
+		ret = -3;
+		goto out;
+	}
+
+	props.type &= ~BTRFS_DEV_ALLOCATION_MASK;
+	props.type |= (v & BTRFS_DEV_ALLOCATION_MASK);
+
+	props.properties = BTRFS_DEV_PROPERTY_TYPE;
+	props.devid = devid;
+	ret = ioctl(fd, BTRFS_IOC_DEV_PROPERTIES, &props);
+	if (ret < 0) {
+		error("Cannot perform BTRFS_IOC_DEV_PROPERTIES ioctl on '%s'",
+			path);
+		ret = -4;
+		goto out;
+	}
+
+	ret = 0;
+out:
+	close_file_or_dir(fd, dir);
+	return ret;
+}
+
 const struct prop_handler prop_handlers[] = {
 	{
 		.name ="ro",
@@ -187,5 +352,11 @@ const struct prop_handler prop_handlers[] = {
 		.read_only = 0,
 	 	.types = prop_object_inode, prop_compression
 	},
+	{
+		.name = "allocation_hint",
+		.desc = "hint to store the data/metadata chunks",
+		.types = prop_object_dev,
+		.handler = prop_allocation_hint
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
-- 
2.30.0

