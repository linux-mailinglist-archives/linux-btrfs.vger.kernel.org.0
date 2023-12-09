Return-Path: <linux-btrfs+bounces-787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C690780B61A
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89CF1C20866
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB661E514;
	Sat,  9 Dec 2023 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="fjchcrL2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00F311BB
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTNYe; Sat, 09 Dec 2023 19:27:23 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/9] Killing dirstream: replace btrfs_open_dir with btrfs_open_dir_fd
Date: Sat,  9 Dec 2023 19:53:22 +0100
Message-ID: <40eccb4ab3c47dc77f868755b7dce2f79f6823ba.1702148009.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702148009.git.kreijack@inwind.it>
References: <cover.1702148009.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1702150043; bh=kpeBWLG0gagT05Mo8ded7516OPgVCxi7k/mlJmRH/pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=fjchcrL22Qt3OW5MQXl2BuVpwDJBSu3D7XZh9/+VFKekfUyybQosp2dFw2BNLw2ep
	 YMtR3GBYxYwf6bSYXSHKUN75W7pZ7L9cH+wta3N57D6YvelUyoFUp01byrVX14/9K6
	 NZGlPALbVNQYAW0A6K5OGb4jfYL9BcWqAuJ/OwcA=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This patch replaces btrfs_open_dir() with btrfs_open_dir_fd() removing
any reference to the unused/useless dirstream variables.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/balance.c          | 27 +++++++++++----------------
 cmds/device.c           | 21 +++++++++------------
 cmds/filesystem-usage.c |  5 ++---
 cmds/filesystem.c       | 14 ++++++--------
 cmds/inspect.c          | 25 ++++++++++---------------
 cmds/qgroup.c           | 29 ++++++++++++-----------------
 cmds/quota.c            | 16 +++++++---------
 cmds/replace.c          | 10 ++++------
 cmds/subvolume-list.c   |  5 ++---
 cmds/subvolume.c        | 31 +++++++++++++------------------
 10 files changed, 76 insertions(+), 107 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 65c7da0b..7c15729c 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -299,9 +299,8 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 {
 	int fd;
 	int ret;
-	DIR *dirstream = NULL;
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -309,7 +308,7 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	if (ret != 0) {
 		if (ret < 0)
 			error("unable to check status of exclusive operation: %m");
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		return 1;
 	}
 
@@ -348,7 +347,7 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	}
 
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 
@@ -606,7 +605,6 @@ static int cmd_balance_pause(const struct cmd_struct *cmd,
 	const char *path;
 	int fd;
 	int ret;
-	DIR *dirstream = NULL;
 
 	clean_args_no_options(cmd, argc, argv);
 
@@ -615,7 +613,7 @@ static int cmd_balance_pause(const struct cmd_struct *cmd,
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -630,7 +628,7 @@ static int cmd_balance_pause(const struct cmd_struct *cmd,
 	}
 
 	btrfs_warn_multiple_profiles(fd);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(balance_pause, "pause");
@@ -647,7 +645,6 @@ static int cmd_balance_cancel(const struct cmd_struct *cmd,
 	const char *path;
 	int fd;
 	int ret;
-	DIR *dirstream = NULL;
 
 	clean_args_no_options(cmd, argc, argv);
 
@@ -656,7 +653,7 @@ static int cmd_balance_cancel(const struct cmd_struct *cmd,
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -671,7 +668,7 @@ static int cmd_balance_cancel(const struct cmd_struct *cmd,
 	}
 
 	btrfs_warn_multiple_profiles(fd);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(balance_cancel, "cancel");
@@ -689,7 +686,6 @@ static int cmd_balance_resume(const struct cmd_struct *cmd,
 {
 	struct btrfs_ioctl_balance_args args;
 	const char *path;
-	DIR *dirstream = NULL;
 	int fd;
 	int ret;
 
@@ -700,7 +696,7 @@ static int cmd_balance_resume(const struct cmd_struct *cmd,
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -734,7 +730,7 @@ static int cmd_balance_resume(const struct cmd_struct *cmd,
 			   args.stat.completed, args.stat.considered);
 	}
 
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(balance_resume, "resume");
@@ -760,7 +756,6 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 {
 	struct btrfs_ioctl_balance_args args;
 	const char *path;
-	DIR *dirstream = NULL;
 	int fd;
 	int ret;
 
@@ -790,7 +785,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 2;
 
@@ -828,7 +823,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 
 	ret = 1;
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(balance_status, "status");
diff --git a/cmds/device.c b/cmds/device.c
index 5e20498d..0b75e110 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -62,7 +62,6 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 {
 	char	*mntpnt;
 	int i, fdmnt, ret = 0;
-	DIR	*dirstream = NULL;
 	bool discard = true;
 	bool force = false;
 	int last_dev;
@@ -105,7 +104,7 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	last_dev = argc - 1;
 	mntpnt = argv[last_dev];
 
-	fdmnt = btrfs_open_dir(mntpnt, &dirstream, 1);
+	fdmnt = btrfs_open_dir_fd(mntpnt);
 	if (fdmnt < 0)
 		return 1;
 
@@ -113,7 +112,7 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	if (ret != 0) {
 		if (ret < 0)
 			error("unable to check status of exclusive operation: %m");
-		close_file_or_dir(fdmnt, dirstream);
+		close(fdmnt);
 		return 1;
 	}
 
@@ -181,7 +180,7 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 
 error_out:
 	btrfs_warn_multiple_profiles(fdmnt);
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 	return !!ret;
 }
 static DEFINE_SIMPLE_COMMAND(device_add, "add");
@@ -191,7 +190,6 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 {
 	char	*mntpnt;
 	int i, fdmnt, ret = 0;
-	DIR	*dirstream = NULL;
 	bool enqueue = false;
 	bool cancel = false;
 
@@ -221,7 +219,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 
 	mntpnt = argv[argc - 1];
 
-	fdmnt = btrfs_open_dir(mntpnt, &dirstream, 1);
+	fdmnt = btrfs_open_dir_fd(mntpnt);
 	if (fdmnt < 0)
 		return 1;
 
@@ -230,7 +228,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 		if (cancel) {
 			error("cancel requested but another device specified: %s\n",
 				argv[i]);
-			close_file_or_dir(fdmnt, dirstream);
+			close(fdmnt);
 			return 1;
 		}
 		if (strcmp("cancel", argv[i]) == 0) {
@@ -246,7 +244,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 			if (ret < 0)
 				error(
 			"unable to check status of exclusive operation: %m");
-			close_file_or_dir(fdmnt, dirstream);
+			close(fdmnt);
 			return 1;
 		}
 	}
@@ -312,7 +310,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	}
 
 	btrfs_warn_multiple_profiles(fdmnt);
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 	return !!ret;
 }
 
@@ -875,12 +873,11 @@ static int cmd_device_usage(const struct cmd_struct *cmd, int argc, char **argv)
 
 	for (i = optind; i < argc; i++) {
 		int fd;
-		DIR *dirstream = NULL;
 
 		if (i > 1)
 			pr_verbose(LOG_DEFAULT, "\n");
 
-		fd = btrfs_open_dir(argv[i], &dirstream, 1);
+		fd = btrfs_open_dir_fd(argv[i]);
 		if (fd < 0) {
 			ret = 1;
 			break;
@@ -888,7 +885,7 @@ static int cmd_device_usage(const struct cmd_struct *cmd, int argc, char **argv)
 
 		ret = _cmd_device_usage(fd, argv[i], unit_mode);
 		btrfs_warn_multiple_profiles(fd);
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 
 		if (ret)
 			break;
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 0db91e9c..d9d218fe 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -1216,11 +1216,10 @@ static int cmd_filesystem_usage(const struct cmd_struct *cmd,
 
 	for (i = optind; i < argc; i++) {
 		int fd;
-		DIR *dirstream = NULL;
 		struct array chunkinfos = { 0 };
 		struct array devinfos = { 0 };
 
-		fd = btrfs_open_dir(argv[i], &dirstream, 1);
+		fd = btrfs_open_dir_fd(argv[i]);
 		if (fd < 0) {
 			ret = 1;
 			goto out;
@@ -1240,7 +1239,7 @@ static int cmd_filesystem_usage(const struct cmd_struct *cmd,
 		ret = print_filesystem_usage_by_chunk(fd, &chunkinfos,
 				&devinfos, argv[i], unit_mode, tabular);
 cleanup:
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		array_free_elements(&chunkinfos);
 		array_free(&chunkinfos);
 		array_free_elements(&devinfos);
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 1b444b8f..cad97238 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -146,7 +146,6 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	char *path;
-	DIR *dirstream = NULL;
 	unsigned unit_mode;
 
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 1);
@@ -158,7 +157,7 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -176,7 +175,7 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 	}
 
 	btrfs_warn_multiple_profiles(fd);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return !!ret;
 }
 static DEFINE_COMMAND_WITH_FLAGS(filesystem_df, "df", CMD_FORMAT_JSON);
@@ -1361,7 +1360,6 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	struct btrfs_ioctl_vol_args	args;
 	int	fd, res, len, e;
 	char	*amount, *path;
-	DIR	*dirstream = NULL;
 	u64 devid;
 	int ret;
 	bool enqueue = false;
@@ -1399,7 +1397,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 
 	cancel = (strcmp("cancel", amount) == 0);
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0) {
 		/* The path is a directory */
 		if (fd == -3) {
@@ -1422,14 +1420,14 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 			if (ret < 0)
 				error(
 			"unable to check status of exclusive operation: %m");
-			close_file_or_dir(fd, dirstream);
+			close(fd);
 			return 1;
 		}
 	}
 
 	ret = check_resize_args(amount, path, &devid);
 	if (ret != 0) {
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		return 1;
 	}
 
@@ -1444,7 +1442,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	pr_verbose(LOG_VERBOSE, "adjust resize argument to: %s\n", args.name);
 	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
 	e = errno;
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	if( res < 0 ){
 		switch (e) {
 		case EFBIG:
diff --git a/cmds/inspect.c b/cmds/inspect.c
index a90c373a..86023270 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -109,7 +109,6 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 {
 	int fd;
 	int ret;
-	DIR *dirstream = NULL;
 
 	optind = 0;
 	while (1) {
@@ -129,12 +128,12 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (check_argc_exact(argc - optind, 2))
 		return 1;
 
-	fd = btrfs_open_dir(argv[optind + 1], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[optind + 1]);
 	if (fd < 0)
 		return 1;
 
 	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, argv[optind+1]);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return !!ret;
 
 }
@@ -169,7 +168,6 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	u64 size = SZ_64K;
 	char full_path[PATH_MAX];
 	char *path_ptr;
-	DIR *dirstream = NULL;
 	u64 flags = 0;
 	unsigned long request = BTRFS_IOC_LOGICAL_INO;
 
@@ -214,7 +212,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	loi.flags = flags;
 	loi.inodes = ptr_to_u64(inodes);
 
-	fd = btrfs_open_dir(argv[optind + 1], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[optind + 1]);
 	if (fd < 0) {
 		ret = 12;
 		goto out;
@@ -247,7 +245,6 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		u64 offset = inodes->val[i+1];
 		u64 root = inodes->val[i+2];
 		int path_fd;
-		DIR *dirs = NULL;
 
 		if (getpath) {
 			char mount_path[PATH_MAX];
@@ -296,7 +293,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 				strncpy(mount_path, mounted, PATH_MAX);
 				free(mounted);
 
-				path_fd = btrfs_open_dir(mount_path, &dirs, 1);
+				path_fd = btrfs_open_dir_fd(mount_path);
 				if (path_fd < 0) {
 					ret = -ENOENT;
 					goto out;
@@ -304,7 +301,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 			}
 			ret = __ino_to_path_fd(inum, path_fd, mount_path);
 			if (path_fd != fd)
-				close_file_or_dir(path_fd, dirs);
+				close(path_fd);
 		} else {
 			pr_verbose(LOG_DEFAULT, "inode %llu offset %llu root %llu\n", inum,
 				offset, root);
@@ -312,7 +309,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	}
 
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	free(inodes);
 	return !!ret;
 }
@@ -331,14 +328,13 @@ static int cmd_inspect_subvolid_resolve(const struct cmd_struct *cmd,
 	int fd = -1;
 	u64 subvol_id;
 	char path[PATH_MAX];
-	DIR *dirstream = NULL;
 
 	clean_args_no_options(cmd, argc, argv);
 
 	if (check_argc_exact(argc - optind, 2))
 		return 1;
 
-	fd = btrfs_open_dir(argv[optind + 1], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[optind + 1]);
 	if (fd < 0) {
 		ret = -ENOENT;
 		goto out;
@@ -356,7 +352,7 @@ static int cmd_inspect_subvolid_resolve(const struct cmd_struct *cmd,
 	pr_verbose(LOG_DEFAULT, "%s\n", path);
 
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return !!ret;
 }
 static DEFINE_SIMPLE_COMMAND(inspect_subvolid_resolve, "subvolid-resolve");
@@ -655,7 +651,6 @@ static int cmd_inspect_min_dev_size(const struct cmd_struct *cmd,
 {
 	int ret;
 	int fd = -1;
-	DIR *dirstream = NULL;
 	u64 devid = 1;
 
 	optind = 0;
@@ -682,14 +677,14 @@ static int cmd_inspect_min_dev_size(const struct cmd_struct *cmd,
 	if (check_argc_exact(argc - optind, 1))
 		return 1;
 
-	fd = btrfs_open_dir(argv[optind], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[optind]);
 	if (fd < 0) {
 		ret = -ENOENT;
 		goto out;
 	}
 
 	ret = print_min_dev_size(fd, devid);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 out:
 	return !!ret;
 }
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 2f1893cb..43f973d7 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -1740,7 +1740,6 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 	bool rescan = true;
 	char *path;
 	struct btrfs_ioctl_qgroup_assign_args args;
-	DIR *dirstream = NULL;
 
 	optind = 0;
 	while (1) {
@@ -1785,7 +1784,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 		error("bad relation requested: %s", path);
 		return 1;
 	}
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -1794,7 +1793,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 		error("unable to assign quota group: %s",
 				errno == ENOTCONN ? "quota not enabled"
 						: strerror(errno));
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		return 1;
 	}
 
@@ -1820,7 +1819,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 			ret = 0;
 		}
 	}
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 
@@ -1830,7 +1829,6 @@ static int _cmd_qgroup_create(int create, int argc, char **argv)
 	int fd;
 	char *path;
 	struct btrfs_ioctl_qgroup_create_args args;
-	DIR *dirstream = NULL;
 
 	if (check_argc_exact(argc - optind, 2))
 		return 1;
@@ -1844,12 +1842,12 @@ static int _cmd_qgroup_create(int create, int argc, char **argv)
 	}
 	path = argv[optind + 1];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
 	ret = ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	if (ret < 0) {
 		error("unable to %s quota group: %s",
 			create ? "create":"destroy",
@@ -1957,7 +1955,6 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 	char *path;
 	int ret = 0;
 	int fd;
-	DIR *dirstream = NULL;
 	u64 qgroupid;
 	int filter_flag = 0;
 	unsigned unit_mode;
@@ -2030,7 +2027,7 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 		return 1;
 
 	path = argv[optind];
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0) {
 		free(filter_set);
 		free(comparer_set);
@@ -2048,7 +2045,7 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 		if (ret < 0) {
 			errno = -ret;
 			error("cannot resolve rootid for %s: %m", path);
-			close_file_or_dir(fd, dirstream);
+			close(fd);
 			goto out;
 		}
 		if (filter_flag & 0x1)
@@ -2061,7 +2058,7 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 					qgroupid);
 	}
 	ret = show_qgroups(fd, filter_set, comparer_set);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	free(filter_set);
 	free(comparer_set);
 
@@ -2088,7 +2085,6 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
 	unsigned long long size;
 	bool compressed = false;
 	bool exclusive = false;
-	DIR *dirstream = NULL;
 	enum btrfs_util_error err;
 
 	optind = 0;
@@ -2146,12 +2142,12 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
 	} else
 		usage(cmd, 1);
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
 	ret = ioctl(fd, BTRFS_IOC_QGROUP_LIMIT, &args);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	if (ret < 0) {
 		error("unable to limit requested quota group: %s",
 				errno == ENOTCONN ? "quota not enabled"
@@ -2179,7 +2175,6 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 	int ret = 0;
 	int fd;
 	char *path = NULL;
-	DIR *dirstream = NULL;
 	struct qgroup_lookup qgroup_lookup;
 	struct rb_node *node;
 	struct btrfs_qgroup *entry;
@@ -2189,7 +2184,7 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -2225,7 +2220,7 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 	}
 
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return !!ret;
 }
 static DEFINE_SIMPLE_COMMAND(qgroup_clear_stale, "clear-stale");
diff --git a/cmds/quota.c b/cmds/quota.c
index fa069d79..adf7bf1a 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -41,17 +41,16 @@ static int quota_ctl(int cmd, char *path)
 	int ret = 0;
 	int fd;
 	struct btrfs_ioctl_quota_ctl_args args;
-	DIR *dirstream = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.cmd = cmd;
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
 	ret = ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	if (ret < 0) {
 		error("quota command failed: %m");
 		return 1;
@@ -148,7 +147,6 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
 	char *path = NULL;
 	struct btrfs_ioctl_quota_rescan_args args;
 	unsigned long ioctlnum = BTRFS_IOC_QUOTA_RESCAN;
-	DIR *dirstream = NULL;
 	bool wait_for_completion = false;
 
 	optind = 0;
@@ -193,7 +191,7 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
 	memset(&args, 0, sizeof(args));
 
 	path = argv[optind];
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -203,7 +201,7 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (ioctlnum == BTRFS_IOC_QUOTA_RESCAN_STATUS) {
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		if (ret < 0) {
 			error("could not obtain quota rescan status: %m");
 			return 1;
@@ -221,7 +219,7 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
 		fflush(stdout);
 	} else if (ret < 0 && (!wait_for_completion || e != EINPROGRESS)) {
 		error("quota rescan failed: %m");
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		return 1;
 	}
 
@@ -230,12 +228,12 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
 		e = errno;
 		if (ret < 0) {
 			error("quota rescan wait failed: %m");
-			close_file_or_dir(fd, dirstream);
+			close(fd);
 			return 1;
 		}
 	}
 
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return 0;
 }
 static DEFINE_SIMPLE_COMMAND(quota_rescan, "rescan");
diff --git a/cmds/replace.c b/cmds/replace.c
index 138a22e4..171a72b4 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -378,7 +378,6 @@ static int cmd_replace_status(const struct cmd_struct *cmd,
 	char *path;
 	int once = 0;
 	int ret;
-	DIR *dirstream = NULL;
 
 	optind = 0;
 	while ((c = getopt(argc, argv, "1")) != -1) {
@@ -395,12 +394,12 @@ static int cmd_replace_status(const struct cmd_struct *cmd,
 		return 1;
 
 	path = argv[optind];
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
 	ret = print_replace_status(fd, path, once);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return !!ret;
 }
 static DEFINE_SIMPLE_COMMAND(replace_status, "status");
@@ -546,7 +545,6 @@ static int cmd_replace_cancel(const struct cmd_struct *cmd,
 	int c;
 	int fd;
 	char *path;
-	DIR *dirstream = NULL;
 
 	optind = 0;
 	while ((c = getopt(argc, argv, "")) != -1) {
@@ -561,14 +559,14 @@ static int cmd_replace_cancel(const struct cmd_struct *cmd,
 		return 1;
 
 	path = argv[optind];
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
 	args.cmd = BTRFS_IOCTL_DEV_REPLACE_CMD_CANCEL;
 	args.result = BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT;
 	ret = ioctl(fd, BTRFS_IOC_DEV_REPLACE, &args);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	if (ret < 0) {
 		error("ioctl(DEV_REPLACE_CANCEL) failed on \"%s\": %m", path);
 		if (args.result != BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT)
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 5a91f41d..a26e8b02 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -1587,7 +1587,6 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 	char *subvol;
 	bool is_list_all = false;
 	bool is_only_in_path = false;
-	DIR *dirstream = NULL;
 	enum btrfs_list_layout layout = BTRFS_LIST_LAYOUT_DEFAULT;
 
 	filter_set = btrfs_list_alloc_filter_set();
@@ -1689,7 +1688,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 		goto out;
 
 	subvol = argv[optind];
-	fd = btrfs_open_dir(subvol, &dirstream, 1);
+	fd = btrfs_open_dir_fd(subvol);
 	if (fd < 0) {
 		ret = -1;
 		error("can't access '%s'", subvol);
@@ -1729,7 +1728,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 			layout, !is_list_all && !is_only_in_path, NULL);
 
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	if (filter_set)
 		free(filter_set);
 	if (comparer_set)
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 8504c380..17fb23fb 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -136,7 +136,6 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
 	char	*dstdir;
 	char	*dst;
 	struct btrfs_qgroup_inherit *inherit = NULL;
-	DIR	*dirstream = NULL;
 	bool create_parents = false;
 
 	optind = 0;
@@ -238,7 +237,7 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
 		}
 	}
 
-	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
+	fddst = btrfs_open_dir_fd(dstdir);
 	if (fddst < 0)
 		goto out;
 
@@ -269,7 +268,7 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
 
 	retval = 0;	/* success */
 out:
-	close_file_or_dir(fddst, dirstream);
+	close(fddst);
 	free(inherit);
 	free(dupname);
 	free(dupdir);
@@ -610,7 +609,6 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 	enum btrfs_util_error err;
 	struct btrfs_ioctl_vol_args_v2	args;
 	struct btrfs_qgroup_inherit *inherit = NULL;
-	DIR *dirstream1 = NULL, *dirstream2 = NULL;
 
 	memset(&args, 0, sizeof(args));
 	optind = 0;
@@ -697,11 +695,11 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 		goto out;
 	}
 
-	fddst = btrfs_open_dir(dstdir, &dirstream1, 1);
+	fddst = btrfs_open_dir_fd(dstdir);
 	if (fddst < 0)
 		goto out;
 
-	fd = btrfs_open_dir(subvol, &dirstream2, 1);
+	fd = btrfs_open_dir_fd(subvol);
 	if (fd < 0)
 		goto out;
 
@@ -736,8 +734,8 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 	retval = 0;	/* success */
 
 out:
-	close_file_or_dir(fddst, dirstream1);
-	close_file_or_dir(fd, dirstream2);
+	close(fddst);
+	close(fd);
 	free(inherit);
 	free(dupname);
 	free(dupdir);
@@ -761,7 +759,6 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 	int fd = -1;
 	int ret = 1;
 	uint64_t default_id;
-	DIR *dirstream = NULL;
 	enum btrfs_util_error err;
 	struct btrfs_util_subvolume_info subvol;
 	struct format_ctx fctx;
@@ -772,7 +769,7 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 	if (check_argc_exact(argc - optind, 1))
 		return 1;
 
-	fd = btrfs_open_dir(argv[1], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[1]);
 	if (fd < 0)
 		return 1;
 
@@ -824,7 +821,7 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 
 	ret = 0;
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 #if EXPERIMENTAL
@@ -1295,7 +1292,6 @@ static int cmd_subvolume_find_new(const struct cmd_struct *cmd, int argc, char *
 	int ret;
 	char *subvol;
 	u64 last_gen;
-	DIR *dirstream = NULL;
 	enum btrfs_util_error err;
 
 	clean_args_no_options(cmd, argc, argv);
@@ -1312,19 +1308,19 @@ static int cmd_subvolume_find_new(const struct cmd_struct *cmd, int argc, char *
 		return 1;
 	}
 
-	fd = btrfs_open_dir(subvol, &dirstream, 1);
+	fd = btrfs_open_dir_fd(subvol);
 	if (fd < 0)
 		return 1;
 
 	err = btrfs_util_sync_fd(fd);
 	if (err) {
 		error_btrfs_util(err);
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		return 1;
 	}
 
 	ret = btrfs_list_find_updated_files(fd, 0, last_gen);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return !!ret;
 }
 static DEFINE_SIMPLE_COMMAND(subvolume_find_new, "find-new");
@@ -1721,7 +1717,6 @@ static int cmd_subvolume_sync(const struct cmd_struct *cmd, int argc, char **arg
 {
 	int fd = -1;
 	int ret = 1;
-	DIR *dirstream = NULL;
 	uint64_t *ids = NULL;
 	size_t id_count, i;
 	int sleep_interval = 1;
@@ -1751,7 +1746,7 @@ static int cmd_subvolume_sync(const struct cmd_struct *cmd, int argc, char **arg
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	fd = btrfs_open_dir(argv[optind], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[optind]);
 	if (fd < 0) {
 		ret = 1;
 		goto out;
@@ -1804,7 +1799,7 @@ static int cmd_subvolume_sync(const struct cmd_struct *cmd, int argc, char **arg
 
 out:
 	free(ids);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 
 	return !!ret;
 }
-- 
2.43.0


