Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E571F1AB537
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 03:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405912AbgDPBEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 21:04:47 -0400
Received: from gateway30.websitewelcome.com ([192.185.180.41]:26505 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405821AbgDPBEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 21:04:43 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id EF149BA95A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 19:44:23 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id OsdjjuD8E8vkBOsdjjgCsa; Wed, 15 Apr 2020 19:44:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FPrDtuZxJBRFC3hCMADAu+KSjucy8BgOLCucy5y4jYM=; b=qrs9bWSAbnMkzZ6d12Gkli1c4P
        UqfwCgVM6r190IRxmqEJwigu3Q15khau9L2FGhPeWJpBOHIKXzxu0+XskiXTrMn9wkVvp7YlYAxa9
        C8VnwSOgQfFPOQGlRn2dghA2WMxYNlADseEOCt9kJVWJOU88VA6LaJ0tQ43pdGLon81H/abkVBghk
        WOKT9/w8Fa50DkHPImhWUi++eYZWiJJpjm1/nxzwN1RqKkmZpY5rNR8EcSrlD3U6q0BhLsLze+Tkf
        5Ek0joc9QCPjP6zsH110vhHhcy/rhfv7O6A9o+/4U57fmr5o1sMWa/IDM/iNb4eILG7OsnSd90f2Q
        CKXMNfuA==;
Received: from [177.132.129.218] (port=35128 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jOsdj-0046UY-DP; Wed, 15 Apr 2020 21:44:23 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv3 2/3] btrfs-progs: replace: New argument to resize the fs after replace
Date:   Wed, 15 Apr 2020 21:46:41 -0300
Message-Id: <20200416004642.9941-3-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416004642.9941-1-marcos@mpdesouza.com>
References: <20200416004642.9941-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 177.132.129.218
X-Source-L: No
X-Exim-ID: 1jOsdj-0046UY-DP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [177.132.129.218]:35128
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 11
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Add new --autoresize long opt to resize the fs automatically after
replace. The code now checks if the srcdev is a path, and translates it
to a devid, making it being consumed later on if auto resize is
specified.

By using the --autoresize flag on replace makes btrfs issue a resize ioctl after
the replace finishes. This argument is a shortcut for

btrfs replace start -f 3 /dev/sdf BTRFS/
btrfs fi resize 3:max BTRFS/

Fixes: #21

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/btrfs-replace.asciidoc |   5 +-
 cmds/replace.c                       | 105 +++++++++++++++++----------
 2 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/Documentation/btrfs-replace.asciidoc b/Documentation/btrfs-replace.asciidoc
index b73bf1b3..f6eb6d20 100644
--- a/Documentation/btrfs-replace.asciidoc
+++ b/Documentation/btrfs-replace.asciidoc
@@ -18,7 +18,7 @@ SUBCOMMAND
 *cancel* <mount_point>::
 Cancel a running device replace operation.
 
-*start* [-Bfr] <srcdev>|<devid> <targetdev> <path>::
+*start* [options] <srcdev>|<devid> <targetdev> <path>::
 Replace device of a btrfs filesystem.
 +
 On a live filesystem, duplicate the data to the target device which
@@ -53,6 +53,9 @@ never allowed to be used as the <targetdev>.
 +
 -B::::
 no background replace.
+--autoresize::::
+automatically resizes the filesystem to it's max size if the <targetdev> is
+bigger than <srcdev>.
 
 *status* [-1] <mount_point>::
 Print status and progress information of a running device replace operation.
diff --git a/cmds/replace.c b/cmds/replace.c
index 2321aa15..48017c04 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <getopt.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <errno.h>
@@ -91,7 +92,7 @@ static int dev_replace_handle_sigint(int fd)
 }
 
 static const char *const cmd_replace_start_usage[] = {
-	"btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>",
+	"btrfs replace start [options] <srcdev>|<devid> <targetdev> <mount_point>",
 	"Replace device of a btrfs filesystem.",
 	"On a live filesystem, duplicate the data to the target device which",
 	"is currently stored on the source device. If the source device is not",
@@ -104,15 +105,18 @@ static const char *const cmd_replace_start_usage[] = {
 	"from the system, you have to use the <devid> parameter format.",
 	"The <targetdev> needs to be same size or larger than the <srcdev>.",
 	"",
-	"-r     only read from <srcdev> if no other zero-defect mirror exists",
-	"       (enable this if your drive has lots of read errors, the access",
-	"       would be very slow)",
-	"-f     force using and overwriting <targetdev> even if it looks like",
-	"       containing a valid btrfs filesystem. A valid filesystem is",
-	"       assumed if a btrfs superblock is found which contains a",
-	"       correct checksum. Devices which are currently mounted are",
-	"       never allowed to be used as the <targetdev>",
-	"-B     do not background",
+	"Options:",
+	"--autoresize  automatically resizes the filesystem to it's max size if the",
+	"              <targetdev> is bigger than <srcdev>",
+	"-r            only read from <srcdev> if no other zero-defect mirror exists",
+	"              (enable this if your drive has lots of read errors, the access",
+	"              would be very slow)",
+	"-f            force using and overwriting <targetdev> even if it looks like",
+	"              containing a valid btrfs filesystem. A valid filesystem is",
+	"              assumed if a btrfs superblock is found which contains a",
+	"              correct checksum. Devices which are currently mounted are",
+	"              never allowed to be used as the <targetdev>",
+	"-B            do not background",
 	NULL
 };
 
@@ -121,6 +125,8 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 {
 	struct btrfs_ioctl_dev_replace_args start_args = {0};
 	struct btrfs_ioctl_dev_replace_args status_args = {0};
+	struct btrfs_ioctl_fs_info_args fi_args;
+	struct btrfs_ioctl_dev_info_args *di_args = NULL;
 	int ret;
 	int i;
 	int c;
@@ -129,6 +135,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	char *path;
 	char *srcdev;
 	char *dstdev = NULL;
+	bool auto_resize = false;
 	int avoid_reading_from_srcdev = 0;
 	int force_using_targetdev = 0;
 	u64 dstdev_block_count;
@@ -137,8 +144,13 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	u64 srcdev_size;
 	u64 dstdev_size;
 
+	enum { GETOPT_VAL_AUTORESIZE = 257 };
+	static struct option long_opts[] = {
+		{"autoresize", no_argument, NULL, GETOPT_VAL_AUTORESIZE}
+	};
+
 	optind = 0;
-	while ((c = getopt(argc, argv, "Brf")) != -1) {
+	while ((c = getopt_long(argc, argv, "Brf", long_opts, NULL)) != -1) {
 		switch (c) {
 		case 'B':
 			do_not_background = 1;
@@ -149,6 +161,9 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 		case 'f':
 			force_using_targetdev = 1;
 			break;
+		case GETOPT_VAL_AUTORESIZE:
+			auto_resize = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -202,45 +217,46 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 		goto leave_with_error;
 	}
 
-	if (string_is_numerical(srcdev)) {
-		struct btrfs_ioctl_fs_info_args fi_args;
-		struct btrfs_ioctl_dev_info_args *di_args = NULL;
+	ret = get_fs_info(path, &fi_args, &di_args);
+	if (ret) {
+		errno = -ret;
+		error("failed to get device info: %m");
+		free(di_args);
+		goto leave_with_error;
+	}
+	if (!fi_args.num_devices) {
+		error("no devices found");
+		free(di_args);
+		goto leave_with_error;
+	}
 
+	if (string_is_numerical(srcdev)) {
 		start_args.start.srcdevid = arg_strtou64(srcdev);
 
-		ret = get_fs_info(path, &fi_args, &di_args);
-		if (ret) {
-			errno = -ret;
-			error("failed to get device info: %m");
-			free(di_args);
-			goto leave_with_error;
-		}
-		if (!fi_args.num_devices) {
-			error("no devices found");
-			free(di_args);
-			goto leave_with_error;
-		}
-
 		for (i = 0; i < fi_args.num_devices; i++)
 			if (start_args.start.srcdevid == di_args[i].devid)
 				break;
 		srcdev_size = di_args[i].total_bytes;
-		free(di_args);
-		if (i == fi_args.num_devices) {
-			error("'%s' is not a valid devid for filesystem '%s'",
-				srcdev, path);
-			goto leave_with_error;
-		}
 	} else if (path_is_block_device(srcdev) > 0) {
-		strncpy((char *)start_args.start.srcdev_name, srcdev,
-			BTRFS_DEVICE_PATH_NAME_MAX);
-		start_args.start.srcdevid = 0;
-		srcdev_size = get_partition_size(srcdev);
+		for (i = 0; i < fi_args.num_devices; i++)
+			if (strcmp(srcdev, (char *)di_args[i].path) == 0)
+				break;
+
+		start_args.start.srcdevid = di_args[i].devid;
+		srcdev_size = di_args[i].total_bytes;
 	} else {
 		error("source device must be a block device or a devid");
 		goto leave_with_error;
 	}
 
+	free(di_args);
+	di_args = NULL;
+	if (i == fi_args.num_devices) {
+		error("'%s' is not a valid devid for filesystem '%s'",
+			srcdev, path);
+		goto leave_with_error;
+	}
+
 	ret = test_dev_for_mkfs(dstdev, force_using_targetdev);
 	if (ret)
 		goto leave_with_error;
@@ -309,10 +325,25 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 			goto leave_with_error;
 		}
 	}
+
+	if (ret == 0 && auto_resize && dstdev_size > srcdev_size) {
+		char amount[BTRFS_PATH_NAME_MAX + 1];
+		snprintf(amount, BTRFS_DEVICE_PATH_NAME_MAX, "%llu:max",
+						start_args.start.srcdevid);
+
+		if (resize_filesystem(amount, path)) {
+			warning("resize failed, please resize the filesystem manually by executing:"
+				"\nbtrfs fi resize %llu:max %s", start_args.start.srcdevid, path);
+			goto leave_with_error;
+		}
+	}
+
 	close_file_or_dir(fdmnt, dirstream);
 	return 0;
 
 leave_with_error:
+	if (di_args)
+		free(di_args);
 	if (dstdev)
 		free(dstdev);
 	if (fdmnt != -1)
-- 
2.25.1

