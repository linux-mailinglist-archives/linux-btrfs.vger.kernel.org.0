Return-Path: <linux-btrfs+bounces-2265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB2A84E9BC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44D71C264BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD874C618;
	Thu,  8 Feb 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="meyf9q2A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488623F9F4
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424255; cv=none; b=KchqxyWeuTiaHspXoDLj5cUXrywqmOjyr8AY5pZ+ujx+cqpWkfzdv1YOZU/DtPJXApbAO5XPsrbwksVE+lu3qKq8XrN7MmexDHbz41gaWtW+/IowlUXVO6l7YX/M02BU/e4CazVygDX9KcyTUr16lW1kMDp5dmfPhqcyNX+zjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424255; c=relaxed/simple;
	bh=2xW5ZrEII79aC2rt6k/AcY7qZURB3ZBSt7HHBJGugG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfZpDNcFfJCx1f776rFbPpsZAzxvmMgNGqxnIqT/loyq8WML3TPKlDDf6ACXoQVwdnolgIk8E1t4HYoc20xQpE79jSi3w5XaqoxEzKJymcz7o3a1+23ODVIftfYLwb6fp80No7pifSmwD6OcX79JhJA2lJ91Jzd8HDIesxX1tDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=meyf9q2A; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVfo5; Thu, 08 Feb 2024 20:29:39 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/9] Killing dirstream: replace btrfs_open_dir with btrfs_open_dir_fd
Date: Thu,  8 Feb 2024 21:19:20 +0100
Message-ID: <304836c4f8172630ec136f97f907ca9acf8c6b59.1707423567.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707423567.git.kreijack@inwind.it>
References: <cover.1707423567.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1707424179; bh=3ENkWBt2suf21JzmhueI3HycRU424+hbo2k5uAw13YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=meyf9q2A2a4nDHmqQKr7OQHFw7u1mpT/43gA/ozOC3KF/SOi+KeAMGlaXSt5OMiYC
	 L2vpOQ8SYJS/l2CZjbVgKnEP+7hn0zsSRUdFXuhNY+Bb2Q6pypD0tUt5i/NHWpyXnp
	 JkYtUTH2P32w51dkrTXdkxg6Gc5drz8YsTthUrXY=

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
index 4b34300b..cc201ff9 100644
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
 	bool force = false;
@@ -227,7 +225,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 
 	mntpnt = argv[argc - 1];
 
-	fdmnt = btrfs_open_dir(mntpnt, &dirstream, 1);
+	fdmnt = btrfs_open_dir_fd(mntpnt);
 	if (fdmnt < 0)
 		return 1;
 
@@ -236,7 +234,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 		if (cancel) {
 			error("cancel requested but another device specified: %s\n",
 				argv[i]);
-			close_file_or_dir(fdmnt, dirstream);
+			close(fdmnt);
 			return 1;
 		}
 		if (strcmp("cancel", argv[i]) == 0) {
@@ -271,7 +269,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 			if (ret < 0)
 				error(
 			"unable to check status of exclusive operation: %m");
-			close_file_or_dir(fdmnt, dirstream);
+			close(fdmnt);
 			return 1;
 		}
 	}
@@ -337,7 +335,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	}
 
 	btrfs_warn_multiple_profiles(fdmnt);
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 	return !!ret;
 }
 
@@ -900,12 +898,11 @@ static int cmd_device_usage(const struct cmd_struct *cmd, int argc, char **argv)
 
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
@@ -913,7 +910,7 @@ static int cmd_device_usage(const struct cmd_struct *cmd, int argc, char **argv)
 
 		ret = _cmd_device_usage(fd, argv[i], unit_mode);
 		btrfs_warn_multiple_profiles(fd);
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 
 		if (ret)
 			break;
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 52e552dc..eaa732c1 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -1232,11 +1232,10 @@ static int cmd_filesystem_usage(const struct cmd_struct *cmd,
 
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
@@ -1256,7 +1255,7 @@ static int cmd_filesystem_usage(const struct cmd_struct *cmd,
 		ret = print_filesystem_usage_by_chunk(fd, &chunkinfos,
 				&devinfos, argv[i], unit_mode, tabular);
 cleanup:
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		array_free_elements(&chunkinfos);
 		array_free(&chunkinfos);
 		array_free_elements(&devinfos);
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index e0e74fbe..9867403f 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -147,7 +147,6 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	char *path;
-	DIR *dirstream = NULL;
 	unsigned unit_mode;
 
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 1);
@@ -159,7 +158,7 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -177,7 +176,7 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 	}
 
 	btrfs_warn_multiple_profiles(fd);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return !!ret;
 }
 static DEFINE_COMMAND_WITH_FLAGS(filesystem_df, "df", CMD_FORMAT_JSON);
@@ -1362,7 +1361,6 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	struct btrfs_ioctl_vol_args	args;
 	int	fd, res, len, e;
 	char	*amount, *path;
-	DIR	*dirstream = NULL;
 	u64 devid;
 	int ret;
 	bool enqueue = false;
@@ -1400,7 +1398,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 
 	cancel = (strcmp("cancel", amount) == 0);
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0) {
 		/* The path is a directory */
 		if (fd == -3) {
@@ -1423,14 +1421,14 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
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
 
@@ -1445,7 +1443,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
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
index 68791428..61c6505a 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -1741,7 +1741,6 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 	bool rescan = true;
 	char *path;
 	struct btrfs_ioctl_qgroup_assign_args args;
-	DIR *dirstream = NULL;
 
 	optind = 0;
 	while (1) {
@@ -1786,7 +1785,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 		error("bad relation requested: %s", path);
 		return 1;
 	}
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -1795,7 +1794,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 		error("unable to assign quota group: %s",
 				errno == ENOTCONN ? "quota not enabled"
 						: strerror(errno));
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 		return 1;
 	}
 
@@ -1821,7 +1820,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 			ret = 0;
 		}
 	}
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 
@@ -1831,7 +1830,6 @@ static int _cmd_qgroup_create(int create, int argc, char **argv)
 	int fd;
 	char *path;
 	struct btrfs_ioctl_qgroup_create_args args;
-	DIR *dirstream = NULL;
 
 	if (check_argc_exact(argc - optind, 2))
 		return 1;
@@ -1845,12 +1843,12 @@ static int _cmd_qgroup_create(int create, int argc, char **argv)
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
@@ -1958,7 +1956,6 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 	char *path;
 	int ret = 0;
 	int fd;
-	DIR *dirstream = NULL;
 	u64 qgroupid;
 	int filter_flag = 0;
 	unsigned unit_mode;
@@ -2031,7 +2028,7 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 		return 1;
 
 	path = argv[optind];
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0) {
 		free(filter_set);
 		free(comparer_set);
@@ -2049,7 +2046,7 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 		if (ret < 0) {
 			errno = -ret;
 			error("cannot resolve rootid for %s: %m", path);
-			close_file_or_dir(fd, dirstream);
+			close(fd);
 			goto out;
 		}
 		if (filter_flag & 0x1)
@@ -2062,7 +2059,7 @@ static int cmd_qgroup_show(const struct cmd_struct *cmd, int argc, char **argv)
 					qgroupid);
 	}
 	ret = show_qgroups(fd, filter_set, comparer_set);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	free(filter_set);
 	free(comparer_set);
 
@@ -2089,7 +2086,6 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
 	unsigned long long size;
 	bool compressed = false;
 	bool exclusive = false;
-	DIR *dirstream = NULL;
 	enum btrfs_util_error err;
 
 	optind = 0;
@@ -2147,12 +2143,12 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
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
@@ -2180,7 +2176,6 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 	int ret = 0;
 	int fd;
 	char *path = NULL;
-	DIR *dirstream = NULL;
 	struct qgroup_lookup qgroup_lookup;
 	struct rb_node *node;
 	struct btrfs_qgroup *entry;
@@ -2190,7 +2185,7 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 
 	path = argv[optind];
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
+	fd = btrfs_open_dir_fd(path);
 	if (fd < 0)
 		return 1;
 
@@ -2226,7 +2221,7 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
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
index b01d5c80..cca73379 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -150,7 +150,6 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 	char	*dupdir = NULL;
 	char	*newname;
 	char	*dstdir;
-	DIR	*dirstream = NULL;
 
 	ret = path_is_dir(dst);
 	if (ret < 0 && ret != -ENOENT) {
@@ -224,7 +223,7 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 		}
 	}
 
-	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
+	fddst = btrfs_open_dir_fd(dstdir);
 	if (fddst < 0) {
 		ret = fddst;
 		goto out;
@@ -256,7 +255,7 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 	}
 
 out:
-	close_file_or_dir(fddst, dirstream);
+	close(fddst);
 	free(dupname);
 	free(dupdir);
 
@@ -684,7 +683,6 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 	enum btrfs_util_error err;
 	struct btrfs_ioctl_vol_args_v2	args;
 	struct btrfs_qgroup_inherit *inherit = NULL;
-	DIR *dirstream1 = NULL, *dirstream2 = NULL;
 
 	memset(&args, 0, sizeof(args));
 	optind = 0;
@@ -771,11 +769,11 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
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
 
@@ -810,8 +808,8 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 	retval = 0;	/* success */
 
 out:
-	close_file_or_dir(fddst, dirstream1);
-	close_file_or_dir(fd, dirstream2);
+	close(fddst);
+	close(fd);
 	free(inherit);
 	free(dupname);
 	free(dupdir);
@@ -835,7 +833,6 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 	int fd = -1;
 	int ret = 1;
 	uint64_t default_id;
-	DIR *dirstream = NULL;
 	enum btrfs_util_error err;
 	struct btrfs_util_subvolume_info subvol;
 	struct format_ctx fctx;
@@ -846,7 +843,7 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 	if (check_argc_exact(argc - optind, 1))
 		return 1;
 
-	fd = btrfs_open_dir(argv[1], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[1]);
 	if (fd < 0)
 		return 1;
 
@@ -898,7 +895,7 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 
 	ret = 0;
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 #if EXPERIMENTAL
@@ -1369,7 +1366,6 @@ static int cmd_subvolume_find_new(const struct cmd_struct *cmd, int argc, char *
 	int ret;
 	char *subvol;
 	u64 last_gen;
-	DIR *dirstream = NULL;
 	enum btrfs_util_error err;
 
 	clean_args_no_options(cmd, argc, argv);
@@ -1386,19 +1382,19 @@ static int cmd_subvolume_find_new(const struct cmd_struct *cmd, int argc, char *
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
@@ -1795,7 +1791,6 @@ static int cmd_subvolume_sync(const struct cmd_struct *cmd, int argc, char **arg
 {
 	int fd = -1;
 	int ret = 1;
-	DIR *dirstream = NULL;
 	uint64_t *ids = NULL;
 	size_t id_count, i;
 	int sleep_interval = 1;
@@ -1825,7 +1820,7 @@ static int cmd_subvolume_sync(const struct cmd_struct *cmd, int argc, char **arg
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	fd = btrfs_open_dir(argv[optind], &dirstream, 1);
+	fd = btrfs_open_dir_fd(argv[optind]);
 	if (fd < 0) {
 		ret = 1;
 		goto out;
@@ -1878,7 +1873,7 @@ static int cmd_subvolume_sync(const struct cmd_struct *cmd, int argc, char **arg
 
 out:
 	free(ids);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 
 	return !!ret;
 }
-- 
2.43.0


