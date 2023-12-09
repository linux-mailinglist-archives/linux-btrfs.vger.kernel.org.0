Return-Path: <linux-btrfs+bounces-783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1477380B615
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B383E1F210C6
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9B1D520;
	Sat,  9 Dec 2023 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="s7WLQT2r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00E2413A
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTPZE; Sat, 09 Dec 2023 19:27:23 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 7/9] Killing dirstream: replace open_file_or_dir with btrfs_open_fd2
Date: Sat,  9 Dec 2023 19:53:27 +0100
Message-ID: <fa0072bf75d989568f544697d96afd14cd4b8a27.1702148009.git.kreijack@inwind.it>
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
	t=1702150043; bh=FcohxgN9SIsC52bo1UwLy7QzjN1xO0jMBOFErq01s00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=s7WLQT2rG2FtiHhNsRDd/NtOsmh3lT/LGsYfjK8FRQFgm3sofe17wCfq+Fq1San/i
	 g0ArvbfFkU3ba4RnS6sv1HR4Hu8HA70uuyfJHthqSD/9oxXavmWwWzLklRTdgiB9Or
	 VgPeDf2m7t5B4s4KCw8BkD03QxWLfBWXSZmBVYEg=

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
 cmds/subvolume.c | 5 ++---
 common/utils.c   | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

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
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index cc1a660b..b6653a40 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1492,7 +1492,6 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 	char *fullpath = NULL;
 	int fd = -1;
 	int ret = 1;
-	DIR *dirstream1 = NULL;
 	int by_rootid = 0;
 	int by_uuid = 0;
 	u64 rootid_arg = 0;
@@ -1550,7 +1549,7 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 		goto out;
 	}
 
-	fd = open_file_or_dir(fullpath, &dirstream1);
+	fd = btrfs_open_fd2(fullpath, false, true, false);
 	if (fd < 0) {
 		error("can't access '%s'", fullpath);
 		goto out;
@@ -1688,7 +1687,7 @@ out2:
 
 out:
 	free(subvol_path);
-	close_file_or_dir(fd, dirstream1);
+	close(fd);
 	free(fullpath);
 	return !!ret;
 }
diff --git a/common/utils.c b/common/utils.c
index 0c2fa8fe..3b86c9f3 100644
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


