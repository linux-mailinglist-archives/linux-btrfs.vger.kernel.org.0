Return-Path: <linux-btrfs+bounces-2262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5384E9BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395CF1F3124E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A39F4BA8D;
	Thu,  8 Feb 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="yLRqFdoa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487333F9EB
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424254; cv=none; b=U+VX+65h30BF8U7bKEJI+lHuMlPk0EAS12iohICurzhDhVL/ocFlooUMs36I1Pr3iKevf9Zez0OguRQCB+Q1hCsz0W17VoBUcs3+1NWPjK4dr7QXcTUmIdQl/3zL3ncNzpFAMYmzSgHffBCi+sUXKTc6Ktn9GvBkp1NLONjcgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424254; c=relaxed/simple;
	bh=iOuGM5eP03WUspaTbuvlLp2oWEjYHeoEOXRTO5n5bF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjB5jrSgXn3Q53zmLfcVGpX74cur8xjAEUPYsIzGjEG7PeQYg5zzHaVTTlHQgy+DaT/uVfRBtfsL2FtaeqIXiYwq69L1Mak3A8Y9ZjTK2wa+B6pvot0iKG4WAgcsCm3NxsqijRBJ464dIhKm0aDoHUabi1Gcv94UdN4r3aY7Gzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=yLRqFdoa; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVfog; Thu, 08 Feb 2024 20:29:40 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 7/9] Killing dirstream: replace open_file_or_dir with btrfs_open_fd2
Date: Thu,  8 Feb 2024 21:19:25 +0100
Message-ID: <6e9ed797da5f24ac25356aedf16c9dbc3af190c6.1707423567.git.kreijack@inwind.it>
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
	t=1707424180; bh=AS24lxN/1pW38pls7Jz4PiKtKYBdmEAQzdJOVM/ZySU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=yLRqFdoacFd0o4g/SwfqVGdogErILkxsI2xry0p0ygUw0vfdGZwqF8LQmKdpuUd5z
	 MGNODfaWrVbXC0AjVa9X1Ili0UPWS0+LW40PqvZrh4vom3WAHqPIijBDwrtwsB5zKl
	 TyvsDbeNE2sHPhciuDZi0D5KdrcRcDcrQ0sb5q5g=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This patch replace open_file_or_dir() with btrfs_open_fd2() removing
any reference to the unused/useless dirstream variables.
btrfs_open_fd2() is required to avoid spourious error messages.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/inspect.c   | 5 ++---
 cmds/scrub.c     | 5 ++---
 cmds/subvolume.c | 5 ++---
 common/utils.c   | 5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 4d4e24d2..268a902a 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -1020,7 +1020,6 @@ static int cmd_inspect_list_chunks(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	int i;
-	DIR *dirstream = NULL;
 	unsigned unit_mode;
 	char *sortmode = NULL;
 	bool with_usage = true;
@@ -1083,7 +1082,7 @@ static int cmd_inspect_list_chunks(const struct cmd_struct *cmd,
 
 	path = argv[optind];
 
-	fd = open_file_or_dir(path, &dirstream);
+	fd = btrfs_open_fd2(path, false, true, false);
 	if (fd < 0) {
 	        error("cannot access '%s': %m", path);
 		return 1;
@@ -1187,7 +1186,7 @@ static int cmd_inspect_list_chunks(const struct cmd_struct *cmd,
 	}
 
 	ret = print_list_chunks(&ctx, sortmode, unit_mode, with_usage, with_empty);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 
 out_nomem:
 	free(ctx.stats);
diff --git a/cmds/scrub.c b/cmds/scrub.c
index 039a67d1..55dacd57 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1999,7 +1999,6 @@ static int cmd_scrub_limit(const struct cmd_struct *cmd, int argc, char **argv)
 	struct string_table *table = NULL;
 	int ret;
 	int fd = -1;
-	DIR *dirstream = NULL;
 	int cols, idx;
 	u64 opt_devid = 0;
 	bool devid_set = false;
@@ -2060,7 +2059,7 @@ static int cmd_scrub_limit(const struct cmd_struct *cmd, int argc, char **argv)
 		return 1;
 	}
 
-	fd = open_file_or_dir(argv[optind], &dirstream);
+	fd = btrfs_open_fd2(argv[optind], false, true, false);
 	if (fd < 0)
 		return 1;
 
@@ -2182,7 +2181,7 @@ static int cmd_scrub_limit(const struct cmd_struct *cmd, int argc, char **argv)
 out:
 	if (table)
 		table_free(table);
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 
 	return !!ret;
 }
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 65582f67..a93dd408 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1566,7 +1566,6 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 	char *fullpath = NULL;
 	int fd = -1;
 	int ret = 1;
-	DIR *dirstream1 = NULL;
 	int by_rootid = 0;
 	int by_uuid = 0;
 	u64 rootid_arg = 0;
@@ -1624,7 +1623,7 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 		goto out;
 	}
 
-	fd = open_file_or_dir(fullpath, &dirstream1);
+	fd = btrfs_open_fd2(fullpath, false, true, false);
 	if (fd < 0) {
 		error("can't access '%s'", fullpath);
 		goto out;
@@ -1762,7 +1761,7 @@ out2:
 
 out:
 	free(subvol_path);
-	close_file_or_dir(fd, dirstream1);
+	close(fd);
 	free(fullpath);
 	return !!ret;
 }
diff --git a/common/utils.c b/common/utils.c
index 8d860726..72520641 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -211,7 +211,6 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 	struct btrfs_ioctl_dev_info_args *di_args;
 	struct btrfs_ioctl_dev_info_args tmp;
 	char mp[PATH_MAX];
-	DIR *dirstream = NULL;
 
 	memset(fi_args, 0, sizeof(*fi_args));
 
@@ -251,7 +250,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 	}
 
 	/* at this point path must not be for a block device */
-	fd = open_file_or_dir(path, &dirstream);
+	fd = btrfs_open_fd2(path, false, true, false);
 	if (fd < 0) {
 		ret = -errno;
 		goto out;
@@ -317,7 +316,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 	}
 
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 	return ret;
 }
 
-- 
2.43.0


