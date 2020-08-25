Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20130251BC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHYPEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 11:04:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:52890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgHYPEB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 11:04:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A334AECA;
        Tue, 25 Aug 2020 15:04:30 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/4] btrfs-progs: Enqueue command if it can't be performed immediately
Date:   Tue, 25 Aug 2020 10:03:38 -0500
Message-Id: <20200825150338.32610-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825150338.32610-1-rgoldwyn@suse.de>
References: <20200825150233.30294-1-rgoldwyn@suse.de>
 <20200825150338.32610-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Wait for the current exclusive operation to finish before issuing the
command ioctl, so we have a better chance of success.

Q: The resize argument parsing is hackish. Is there a better way to do
this?

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 cmds/device.c     | 56 +++++++++++++++++++++++++++++++++++++++--------
 cmds/filesystem.c | 25 +++++++++++++++++----
 common/sysfs.c    | 26 ++++++++++++++++++++++
 common/utils.h    |  1 +
 4 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 6acd4ae6..12d92dac 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -49,6 +49,7 @@ static const char * const cmd_device_add_usage[] = {
 	"",
 	"-K|--nodiscard    do not perform whole device TRIM on devices that report such capability",
 	"-f|--force        force overwrite existing filesystem on the disk",
+	"-q|--enqueue	   enqueue if an exclusive operation is running",
 	NULL
 };
 
@@ -62,6 +63,7 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	int force = 0;
 	int last_dev;
 	char exop[BTRFS_SYSFS_EXOP_SIZE];
+	bool enqueue = false;
 
 	optind = 0;
 	while (1) {
@@ -69,10 +71,11 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 		static const struct option long_options[] = {
 			{ "nodiscard", optional_argument, NULL, 'K'},
 			{ "force", no_argument, NULL, 'f'},
+			{ "enqueue", no_argument, NULL, 'q'},
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "Kf", long_options, NULL);
+		c = getopt_long(argc, argv, "Kfq", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -82,6 +85,9 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 		case 'f':
 			force = 1;
 			break;
+		case 'q':
+			enqueue = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -98,9 +104,15 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 		return 1;
 
 	if (get_exclusive_operation(fdmnt, exop) > 0 && strcmp(exop, "none")) {
-		error("unable to add device: %s in progress", exop);
-		close_file_or_dir(fdmnt, dirstream);
-		return 1;
+		if (enqueue) {
+			printf("%s in progress. Waiting for %s to finish.\n",
+					exop, exop);
+			wait_for_exclusive_operation(fdmnt);
+		} else {
+			error("unable to add: %s in progress", exop);
+			close_file_or_dir(fdmnt, dirstream);
+			return 1;
+		}
 	}
 
 	for (i = optind; i < last_dev; i++){
@@ -163,8 +175,27 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	int i, fdmnt, ret = 0;
 	DIR	*dirstream = NULL;
 	char exop[BTRFS_SYSFS_EXOP_SIZE];
+	bool enqueue = false;
 
-	clean_args_no_options(cmd, argc, argv);
+
+	while (1) {
+		int c;
+		static const struct option long_options[] = {
+			{ "enqueue", no_argument, NULL, 'q'},
+			{ NULL, 0, NULL, 0}
+		};
+
+		c = getopt_long(argc, argv, "q", long_options, NULL);
+		if (c < 0)
+			break;
+		switch (c) {
+		case 'q':
+			enqueue = true;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
 
 	if (check_argc_min(argc - optind, 2))
 		return 1;
@@ -176,9 +207,15 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 		return 1;
 
 	if (get_exclusive_operation(fdmnt, exop) > 0 && strcmp(exop, "none")) {
-		error("unable to remove device: %s in progress", exop);
-		close_file_or_dir(fdmnt, dirstream);
-		return 1;
+		if (enqueue) {
+			printf("%s in progress. Waiting for %s to finish.\n",
+					exop, exop);
+			wait_for_exclusive_operation(fdmnt);
+		} else {
+			error("unable to remove device: %s in progress", exop);
+			close_file_or_dir(fdmnt, dirstream);
+			return 1;
+		}
 	}
 
 	for(i = optind; i < argc - 1; i++) {
@@ -251,7 +288,8 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	"the device.",								\
 	"If 'missing' is specified for <device>, the first device that is",	\
 	"described by the filesystem metadata, but not present at the mount",	\
-	"time will be removed. (only in degraded mode)"
+	"time will be removed. (only in degraded mode)", \
+	"-q|--enqueue	   enqueue if an exclusive operation is running"
 
 static const char * const cmd_device_remove_usage[] = {
 	"btrfs device remove <device>|<devid> [<device>|<devid>...] <path>",
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index c3efb405..a584b1d3 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1080,8 +1080,19 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	DIR	*dirstream = NULL;
 	struct stat st;
 	char exop[BTRFS_SYSFS_EXOP_SIZE];
+	bool enqueue = false;
 
-	clean_args_no_options_relaxed(cmd, argc, argv);
+	while(1) {
+		int c = getopt(argc - 2, argv, "q");
+		if (c < 0)
+			break;
+
+		switch(c) {
+		case 'q':
+			enqueue = true;
+			break;
+		}
+	}
 
 	if (check_argc_exact(argc - optind, 2))
 		return 1;
@@ -1112,9 +1123,15 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 
 	if (get_exclusive_operation(fd, exop) > 0 && strcmp(exop, "none")) {
-		error("unable to resize: %s in progress", exop);
-		close_file_or_dir(fd, dirstream);
-		return 1;
+		if (enqueue) {
+			printf("%s in progress. Waiting for %s to finish.\n",
+					exop, exop);
+			wait_for_exclusive_operation(fd);
+		} else {
+			error("unable to resize: %s in progress", exop);
+			close_file_or_dir(fd, dirstream);
+			return 1;
+		}
 	}
 
 	printf("Resize '%s' of '%s'\n", path, amount);
diff --git a/common/sysfs.c b/common/sysfs.c
index b2c95cfb..3b6df52e 100644
--- a/common/sysfs.c
+++ b/common/sysfs.c
@@ -50,3 +50,29 @@ int get_exclusive_operation(int mp_fd, char *val)
 	val[n - 1] = '\0';
 	return n;
 }
+
+int sysfs_wait(int fd, int seconds)
+{
+	fd_set fds;
+	struct timeval tv;
+
+	FD_ZERO(&fds);
+	FD_SET(fd, &fds);
+
+	tv.tv_sec = seconds;
+	tv.tv_usec = 0;
+
+	return select(fd+1, NULL, NULL, &fds, &tv);
+}
+
+void wait_for_exclusive_operation(int dirfd)
+{
+        char exop[BTRFS_SYSFS_EXOP_SIZE];
+	int fd;
+
+        fd = sysfs_open(dirfd, "exclusive_operation");
+        while ((sysfs_get_str_fd(fd, exop, BTRFS_SYSFS_EXOP_SIZE) > 0) &&
+		strncmp(exop, "none", 4))
+			sysfs_wait(fd, 1);
+	close(fd);
+}
diff --git a/common/utils.h b/common/utils.h
index be8aab58..f141edb6 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -155,5 +155,6 @@ int btrfs_warn_multiple_profiles(int fd);
 
 #define BTRFS_SYSFS_EXOP_SIZE		16
 int get_exclusive_operation(int fd, char *val);
+void wait_for_exclusive_operation(int fd);
 
 #endif
-- 
2.26.2

