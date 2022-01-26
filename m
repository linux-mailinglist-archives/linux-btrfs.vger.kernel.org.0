Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0349D37B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiAZUcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:31 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59422 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230442AbiAZUca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:30 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYU2600t15VSme01YYVS2; Wed, 26 Jan 2022 20:32:29 +0000
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
Date:   Wed, 26 Jan 2022 21:32:26 +0100
Message-Id: <fe9bb5ddeb28b35928d1b02bbb75fb406de0c63d.1643228730.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643228730.git.kreijack@inwind.it>
References: <cover.1643228730.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229149; bh=3faIRUSRmBAHLE2il84rnLFfgCPgxJPkQnk1PrzAwXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=NNmG7+U06jhh0uEU3oRUad0V1TienIREqetibwcxSn1u4QW7UWBioxA+RztreqPw5
         O+ni2y31Oe48USQdC/qyz6N1roXwA+VKe4pE9zH7k80DCg8eY48PuJT2z3f4f+XhE2
         SJDi38LY3PxmybWBJ890UUPszdlw1X1O6QPMSlHw=
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
 cmds/property.c       | 253 ++++++++++++++++++++++++++++++++++++++++++
 kernel-shared/ctree.h |  13 +++
 2 files changed, 266 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index b3ccc0ff..a409f4e9 100644
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
@@ -232,6 +233,252 @@ out:
 	return ret;
 }
 
+/*
+ * @major, @minor -> device to find
+ * @uuid -> uuid of the filesystem (out)
+ * @devid -> devid (out)
+ *
+ * return -> -ENOTSUP	operation not supported (i.e. btrfs doesn't
+ *			support allocation_hint)
+ *	  -> -ENODEV	operation supported, but device not mounted
+ *	  -> -EACCES	error accessing sysfs
+ *	  -> 0		ok
+ */
+#define BTRFSYSFS "/sys/fs/btrfs/"
+static int btrfs_find_devid_uuid_by_major_minor(int major,
+						  int minor,
+						  u64 *devid,
+						  char *uuid) {
+
+	DIR *dp = NULL, *dp2 = NULL;
+	char path[200];  /* should be enough for
+			  * /sys/btrfs/<uuid>/devices/<devid>/major_minor
+			  */
+	int ret;
+	struct dirent *de;
+	int l;
+
+	strcpy(path, BTRFSYSFS);
+	dp = opendir(path);
+	if (!dp) {
+		ret = -EACCES;
+		goto quit;
+	}
+
+	while ((de = readdir(dp)) != NULL) {
+		if (strlen(de->d_name) != 36)
+			continue;
+
+		strcpy(path + sizeof(BTRFSYSFS) - 1, de->d_name);
+		strcat(path, "/devinfo/");
+
+		dp2 = opendir(path);
+		if (!dp2) {
+			ret = -EACCES;
+			goto quit;
+		}
+
+		l = strlen(path);
+		while ((de = readdir(dp2)) != NULL) {
+			FILE *fp;
+			char buf[100];
+			char *endptr;
+			int r, maj, mnr;
+
+			errno = 0;
+			*devid = strtoull(de->d_name, &endptr, 0);
+
+			/* check for invalid devid */
+			if (errno || *endptr != 0)
+				continue;
+
+
+			strcpy(path + l, de->d_name);
+			strcat(path, "/major_minor");
+
+			fp = fopen(path, "r");
+			if (!fp) {
+				if (errno == -ENOENT)
+					ret = -ENOTSUP;
+				else
+					ret = -EACCES;
+				goto quit;
+			}
+			r = fread(buf, 1, sizeof(buf) - 2, fp);
+			buf[r] = 0;
+			fclose(fp);
+
+			if (!strcmp(buf, "N/A\n"))
+				continue;
+
+			r = sscanf(buf, "%d:%d", &maj, &mnr);
+			if (r != 2) {
+				ret = -EACCES;
+				goto quit;
+			}
+
+			if (maj == major && minor == mnr) {
+				strncpy(uuid,
+					path + sizeof(BTRFSYSFS) - 1,
+					36);
+				uuid[36] = 0;
+				ret = 0;
+				goto quit;
+			}
+		}
+	}
+
+	ret = -ENODEV;
+quit:
+	if (dp)
+		closedir(dp);
+	if (dp2)
+		closedir(dp2);
+	return ret;
+}
+
+/*
+ * @dev -> device to find
+ * @uuid -> uuid of the filesystem (out)
+ * @devid -> devid (out)
+ *
+ * return -> -ENOTSUP	operation not supported (i.e. btrfs doesn't
+ *			support allocation_hint)
+ *	  -> -ENODEV	operation supported, but device not mounted
+ *	  -> -EACCES	error accessing sysfs
+ *	  -> 0		ok
+ */
+static int btrfs_find_devid_uuid_by_dev(const char *dev,
+					u64 *devid,
+					char *uuid)
+{
+	struct stat st;
+	int r;
+
+	r = stat(dev, &st);
+	if (r < 0 && errno == -ENODEV)
+		return -ENODEV;
+	if (r < 0)
+		return -EACCES;
+
+	return btrfs_find_devid_uuid_by_major_minor(major(st.st_rdev),
+						    minor(st.st_rdev),
+						    devid, uuid);
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
+	int ret, fd2 = -1;
+	u64 devid;
+	char sysfs_file[PATH_MAX];
+	int i;
+	u64 v;
+	char buf[1024];
+
+	strcpy(sysfs_file, BTRFSYSFS);
+	ret = btrfs_find_devid_uuid_by_dev(object, &devid,
+		sysfs_file + sizeof(BTRFSYSFS) - 1);
+
+	if (ret)
+		goto out;
+
+	sprintf(sysfs_file + strlen(sysfs_file),
+		"/devinfo/%llu/allocation_hint", devid);
+
+	if (!val) {
+		/* READ */
+		fd2 = open(sysfs_file, O_RDONLY);
+		if (fd2 < 0 && errno == ENOENT) {
+			/* older kernel doesn't have allocation_hint; return nothing */
+			ret = 0;
+			goto out;
+		} else if (fd2 < 0) {
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
+			printf("allocation_hint=%s\n",
+				allocation_hint_description[i].descr);
+		else
+			printf("allocation_hint=unknown:%llu\n", v);
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
+
+	return ret;
+}
+
 const struct prop_handler prop_handlers[] = {
 	{
 		.name ="ro",
@@ -254,6 +501,12 @@ const struct prop_handler prop_handlers[] = {
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
index ab2aaed6..628539c0 100644
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

