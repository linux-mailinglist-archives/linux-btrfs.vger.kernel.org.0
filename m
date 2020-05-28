Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85D01E69A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbgE1SnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:43:19 -0400
Received: from smtp-35-i2.italiaonline.it ([213.209.12.35]:40341 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391483AbgE1SnO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:43:14 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id eNMpjt6z1LNQWeNMqjtDfZ; Thu, 28 May 2020 20:35:00 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590690900; bh=Z/c8sPKQZF5X+1S7c3rx9dxUlgk3AQKaQLOkAqa2tOU=;
        h=From;
        b=RVa3rKtW7CRnANIeegddRT6g4uWuYjMdpucVCpXMZNBiJmvOC/Ncd58gcq7g/bbIF
         lAgc7WMjKlK3SVmpTD31Rh/OFUb4XXq/RdcWk18kNqCFXWoKSpoCIbJ8fgXz2GZIzP
         BILGYPrEJCSFK+1BgYXV8PhEJPNtG6dd6zvF1lGfUzxU63th+0NvdDWm7KFT96UmfF
         y6aRmMt/Ya3X1gZklUSrz/QURWGNGlOjqrYvBGCAIjgtfuGVg5BrAU8NbKhkAiaeWt
         vE/zFR5O/QKMG+9vlMQaz5IfZehbYEGHGG8dw0lVIatIEpOsPsVmdC104dLhqLbDV1
         45SeEm38VbuUw==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=LLAD7uNQPy0wFs_dbF8A:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/3] Add property "preferred_metadata" to the btrfs property cmd.
Date:   Thu, 28 May 2020 20:34:55 +0200
Message-Id: <20200528183456.18030-3-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200528183456.18030-1-kreijack@libero.it>
References: <20200528183456.18030-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLMktXZF/NLz8gW5JWErp17mvovLSk3VXUW20thWXTr8hbT3unapcCAqjKxNdJdNwAd8tMv4+ohQzRZLbu+2QPw2PdfPhyaZShww1V9z/wKAKOF51aTC
 tYvZXiM25snZBOsDgVi9Mum4NM9uvkOOY7tnew8yBYCsmnOhud85lJdLN7ld/DcGAMASlhyrFMN5lwba9g0/euCjkwTidlfwQMQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Handle the property preferred_metadata to a btrfs device. Below
an example of use:

$ # set a new value
$ sudo btrfs property set /dev/vde preferred_metadata 1

$ # get the current value
$ sudo btrfs property get /dev/vde preferred_metadata
devid=4, path=/dev/vde: dedicated_metadata=1

Root privileges are required.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 props.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/props.c b/props.c
index 67d106af..123b3813 100644
--- a/props.c
+++ b/props.c
@@ -20,6 +20,7 @@
 #include <sys/xattr.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <sys/sysmacros.h>
 
 #include <btrfsutil.h>
 
@@ -166,6 +167,139 @@ out:
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
+        if (ret < 0) {
+                if (errno == EPERM)
+                        return -errno;
+                error("cannot get filesystem info: %m");
+		ret = -10;
+		goto out;
+        }
+
+	for (i = 0 ; i <= fi_args.max_id ; i++) {
+		struct stat st;
+                memset(&dev_info, 0, sizeof(dev_info));
+                ret = get_device_info(fd, i, &dev_info);
+                if (ret == -ENODEV)
+                        continue;
+                if (ret) {
+                        error("cannot get info about device devid=%d", i);
+                        goto out;
+                }
+
+		if (!dev_info.path)
+			/* missing devices */
+			continue;
+
+		ret = stat((char*)dev_info.path, &st);
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
+static int prop_preferred_metadata(enum prop_object_type type,
+				   const char *object,
+				   const char *name,
+				   const char *value)
+{
+	int ret, devid, fd, ival;
+	char path[PATH_MAX];
+	DIR *dir;
+	struct btrfs_ioctl_dev_properties props;
+
+	ret = btrfs_find_devid_and_mnt(object, &devid, path, sizeof(path));
+	if (ret)
+                return -5;
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
+		printf("devid=%d, path=%s: dedicated_metadata=%d\n",
+			devid, object,
+			!!(props.type & BTRFS_DEV_DEDICATED_METADATA));
+		ret = 0;
+		goto out;
+	}
+
+	ret = sscanf(value, "%d", &ival);
+	if (ret != 1) {
+		error("Cannot parse '%s'", value);
+		ret = -3;
+		goto out;
+	}
+
+	if (ival)
+		props.type |= BTRFS_DEV_DEDICATED_METADATA;
+	else
+		props.type &= ~BTRFS_DEV_DEDICATED_METADATA;
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
@@ -187,5 +321,11 @@ const struct prop_handler prop_handlers[] = {
 		.read_only = 0,
 	 	.types = prop_object_inode, prop_compression
 	},
+	{
+		.name = "preferred_metadata",
+		.desc = "preferred disk for storing metadata information",
+		.types = prop_object_dev,
+		.handler = prop_preferred_metadata,
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
-- 
2.27.0.rc2

