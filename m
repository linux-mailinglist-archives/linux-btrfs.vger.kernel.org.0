Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC3A1476
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfH2JOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 05:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfH2JOL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 05:14:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F2DC10C6974
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 09:14:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A39AF600C1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 09:14:07 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: print procentage of used space
Date:   Thu, 29 Aug 2019 11:14:05 +0200
Message-Id: <1567070045-10592-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 29 Aug 2019 09:14:10 +0000 (UTC)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds -p option for 'fi df' and 'fi show' commands to print
procentate of used space. Output with the option will look like on
example below:

Data, single: total=43.99GiB, used=37.25GiB (84.7%)
System, single: total=4.00MiB, used=12.00KiB (0.3%)
Metadata, single: total=1.01GiB, used=511.23MiB (49.5%)
GlobalReserve, single: total=92.50MiB, used=0.00B (0.0%)

I considered to change the prints by default without extra option,
but not sure if that would not break existing scripts that could parse
the output.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 cmds/filesystem.c | 55 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089abeaa..c25301aa0df9 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -61,20 +61,39 @@ static const char * const cmd_filesystem_df_usage[] = {
 	"Show space usage information for a mount point",
 	"",
 	HELPINFO_UNITS_SHORT_LONG,
+	"-p                 show procentage of disk usage",
 	NULL
 };
 
-static void print_df(struct btrfs_ioctl_space_args *sargs, unsigned unit_mode)
+static char *usage_procentage(struct btrfs_ioctl_space_info *sp, int p)
+{
+	static char __thread s[12];
+	float procentage;
+
+	if (p) {
+		ASSERT(sp->total_bytes);
+		procentage = 100.0*((float) sp->used_bytes / sp->total_bytes);
+		snprintf(s, 12, " (%.1f%)", procentage);
+	} else {
+		s[0] = '\0';
+	}
+
+	return s;
+}
+
+static void print_df(struct btrfs_ioctl_space_args *sargs, unsigned unit_mode,
+		     int p)
 {
 	u64 i;
 	struct btrfs_ioctl_space_info *sp = sargs->spaces;
 
 	for (i = 0; i < sargs->total_spaces; i++, sp++) {
-		printf("%s, %s: total=%s, used=%s\n",
+		printf("%s, %s: total=%s, used=%s%s\n",
 			btrfs_group_type_str(sp->flags),
 			btrfs_group_profile_str(sp->flags),
 			pretty_size_mode(sp->total_bytes, unit_mode),
-			pretty_size_mode(sp->used_bytes, unit_mode));
+			pretty_size_mode(sp->used_bytes, unit_mode),
+			usage_procentage(sp, p));
 	}
 }
 
@@ -84,12 +103,17 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 	struct btrfs_ioctl_space_args *sargs = NULL;
 	int ret;
 	int fd;
+	int p;
 	char *path;
 	DIR *dirstream = NULL;
 	unsigned unit_mode;
 
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 1);
 
+	p = getopt(argc, argv, "p");
+	if (p != 'p')
+		p = 0;
+
 	clean_args_no_options(cmd, argc, argv);
 
 	if (check_argc_exact(argc - optind, 1))
@@ -104,7 +128,7 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 	ret = get_df(fd, &sargs);
 
 	if (ret == 0) {
-		print_df(sargs, unit_mode);
+		print_df(sargs, unit_mode, p);
 		free(sargs);
 	} else {
 		errno = -ret;
@@ -280,7 +304,7 @@ static u64 calc_used_bytes(struct btrfs_ioctl_space_args *si)
 static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 		struct btrfs_ioctl_dev_info_args *dev_info,
 		struct btrfs_ioctl_space_args *space_info,
-		char *label, unsigned unit_mode)
+		char *label, unsigned unit_mode, int p)
 {
 	int i;
 	int fd;
@@ -308,6 +332,7 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 
 	for (i = 0; i < fs_info->num_devices; i++) {
 		char *canonical_path;
+		struct btrfs_ioctl_space_info tmp_sp;
 
 		tmp_dev_info = (struct btrfs_ioctl_dev_info_args *)&dev_info[i];
 
@@ -319,10 +344,15 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 		}
 		close(fd);
 		canonical_path = canonicalize_path((char *)tmp_dev_info->path);
-		printf("\tdevid %4llu size %s used %s path %s\n",
+
+		tmp_sp.total_bytes = tmp_dev_info->total_bytes;
+		tmp_sp.used_bytes = tmp_dev_info->bytes_used;
+
+		printf("\tdevid %4llu size %s used %s%s path %s\n",
 			tmp_dev_info->devid,
 			pretty_size_mode(tmp_dev_info->total_bytes, unit_mode),
 			pretty_size_mode(tmp_dev_info->bytes_used, unit_mode),
+			usage_procentage(&tmp_sp, p),
 			canonical_path);
 
 		free(canonical_path);
@@ -334,7 +364,7 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 	return 0;
 }
 
-static int btrfs_scan_kernel(void *search, unsigned unit_mode)
+static int btrfs_scan_kernel(void *search, unsigned unit_mode, int p)
 {
 	int ret = 0, fd;
 	int found = 0;
@@ -381,7 +411,7 @@ static int btrfs_scan_kernel(void *search, unsigned unit_mode)
 		fd = open(mnt->mnt_dir, O_RDONLY);
 		if ((fd != -1) && !get_df(fd, &space_info_arg)) {
 			print_one_fs(&fs_info_arg, dev_info_arg,
-				     space_info_arg, label, unit_mode);
+				     space_info_arg, label, unit_mode, p);
 			free(space_info_arg);
 			memset(label, 0, sizeof(label));
 			found = 1;
@@ -630,6 +660,7 @@ static const char * const cmd_filesystem_show_usage[] = {
 	"-d|--all-devices   show only disks under /dev containing btrfs filesystem",
 	"-m|--mounted       show only mounted btrfs",
 	HELPINFO_UNITS_LONG,
+	"-p                 show procentage of disk usage",
 	"If no argument is given, structure of all present filesystems is shown.",
 	NULL
 };
@@ -644,6 +675,7 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 	/* default, search both kernel and udev */
 	int where = -1;
 	int type = 0;
+	int p = 0;
 	char mp[PATH_MAX];
 	char path[PATH_MAX];
 	u8 fsid[BTRFS_FSID_SIZE];
@@ -662,7 +694,7 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 			{ NULL, 0, NULL, 0 }
 		};
 
-		c = getopt_long(argc, argv, "dm", long_options, NULL);
+		c = getopt_long(argc, argv, "dmp", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -672,6 +704,9 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 		case 'm':
 			where = BTRFS_SCAN_MOUNTED;
 			break;
+		case 'p':
+			p = 1;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -725,7 +760,7 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 		goto devs_only;
 
 	/* show mounted btrfs */
-	ret = btrfs_scan_kernel(search, unit_mode);
+	ret = btrfs_scan_kernel(search, unit_mode, p);
 	if (search && !ret) {
 		/* since search is found we are done */
 		goto out;
-- 
1.9.3

