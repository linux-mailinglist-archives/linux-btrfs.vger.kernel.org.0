Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129F4CED27
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiCFSRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiCFSRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:17:10 -0500
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58AFB65D39
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:16:17 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36FE270011dDdji016FEbh; Sun, 06 Mar 2022 18:15:14 +0000
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
Date:   Sun,  6 Mar 2022 19:15:11 +0100
Message-Id: <9295d92559068dd00714289a97b2d47fc54d1494.1646590206.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646590206.git.kreijack@inwind.it>
References: <cover.1646590206.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590514; bh=n1wJjRllSH3rLq+KilCnlu9b4uemxlA5IVTyrMxYfPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=hXK9vuz5NuW8GcIBd6FE+FyQzAfDWJyCvprHqn1Eu7LlmqBvq5Bx+sKhV+P9NhDGA
         cVkCkAcn5xgrY8dY8gyHsOjv0zxp/pEu8Wo1v53DLwv8cYGBzvBaUfG8plutgDyfGM
         EMkcxRCpa+2c2B1QQbVOuCdNNmjGGG1y4AhMOLFc=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 cmds/property.c       | 162 ++++++++++++++++++++++++++++++++++++++++++
 kernel-shared/ctree.h |  13 ++++
 2 files changed, 175 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index b3ccc0ff..b35c8ed3 100644
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
@@ -232,6 +234,160 @@ out:
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
+static int prop_allocation_hint(enum prop_object_type type,
+				const char *object,
+				const char *name,
+				const char *value,
+				bool force)
+{
+	int ret, devid, fd, fd2;
+	char path[PATH_MAX];
+	DIR *dir;
+	u8 fsid[BTRFS_UUID_SIZE];
+	char fsid_str[BTRFS_UUID_UNPARSED_SIZE];
+	char sysfs_file[PATH_MAX];
+	char filename[PATH_MAX];
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
+	fd2 = open(sysfs_file, O_RDONLY);
+	if (fd2 < 0) {
+		error("'allocation_hint' property not available or accessible.");
+		ret = -errno;
+		goto out;
+	}
+
+	ret = read(fd2, buf, sizeof(buf) - 1);
+	close(fd2);
+	if (ret < 0) {
+		error("Unable to read the 'allocation_hint' property.");
+		ret = -errno;
+		goto out;
+	}
+
+	buf[sizeof(buf) - 1] = 0;
+
+	if (!value) {
+		/* READ */
+		printf("devid=%d, path=%s: allocation_hint=%s\n",
+			devid, object, buf);
+		ret = 0;
+	} else {
+		/* WRITE */
+		fd2 = open(sysfs_file, O_RDWR);
+		if (fd2 < 0) {
+			error("'allocation_hint' not accessible for updating.");
+			ret = -errno;
+			goto out;
+		}
+
+		ret = write(fd2, value, strlen(value));
+		close(fd2);
+		if (ret < 0) {
+			if (errno == EINVAL)
+				error("Invalid '%s' allocation_hint property.", value);
+			else
+				error("Unable to update 'allocation_hint' property.");
+			ret = -errno;
+			goto out;
+		}
+
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
@@ -254,6 +410,12 @@ const struct prop_handler prop_handlers[] = {
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
index de5452f2..7bff3952 100644
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
2.35.1

