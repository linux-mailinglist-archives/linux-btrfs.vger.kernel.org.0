Return-Path: <linux-btrfs+bounces-784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9607480B617
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596172810DA
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D561DA37;
	Sat,  9 Dec 2023 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="D09qd70n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0068DC2
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTQZP; Sat, 09 Dec 2023 19:27:24 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 9/9] Killing dirstream: remove unused functions
Date: Sat,  9 Dec 2023 19:53:29 +0100
Message-ID: <a6dc3d618c48823e5bb56ed5eff56fc9396c2c7a.1702148009.git.kreijack@inwind.it>
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
	t=1702150044; bh=9vsTl0CLqSlnwEuZrKYJscjxFnDAn2nI+/ivlehqY1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=D09qd70n1qrq/7/iZACDBltQm4aC3al709e2/BpqKzD3kgGQote+NcDmUcY3WtulT
	 PzKaCTAWa7kFj/69Y3vR0/u5TRq/5jVeskX48lEX2dNd/E726xtl2dGVwk9wWZdg7C
	 q1jvdcjz+grD811SsXfJS2jO3siX5Q+raHYWlDq0=

From: Goffredo Baroncelli <kreijack@inwind.it>

Remove the following unused functions:
- btrfs_open_dir()
- open_file_or_dir()
- btrfs_open_file_or_dir()
- btrfs_open()
- open_path_or_dev_mnt()
- open_file_or_dir3()
- close_file_or_dir()

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 common/open-utils.c | 135 --------------------------------------------
 common/open-utils.h |  10 ----
 2 files changed, 145 deletions(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index 61153294..2a201fd4 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -183,141 +183,6 @@ out:
 	return ret;
 }
 
-/*
- * Given a pathname, return a filehandle to:
- * 	the original pathname or,
- * 	if the pathname is a mounted btrfs device, to its mountpoint.
- *
- * On error, return -1, errno should be set.
- */
-int open_path_or_dev_mnt(const char *path, DIR **dirstream, int verbose)
-{
-	char mp[PATH_MAX];
-	int ret;
-
-	if (path_is_block_device(path)) {
-		ret = get_btrfs_mount(path, mp, sizeof(mp));
-		if (ret < 0) {
-			/* not a mounted btrfs dev */
-			error_on(verbose, "'%s' is not a mounted btrfs device",
-				 path);
-			errno = EINVAL;
-			return -1;
-		}
-		ret = open_file_or_dir(mp, dirstream);
-		error_on(verbose && ret < 0, "can't access '%s': %m",
-			 path);
-	} else {
-		ret = btrfs_open_dir(path, dirstream, 1);
-	}
-
-	return ret;
-}
-
-/*
- * Do the following checks before calling open_file_or_dir():
- * 1: path is in a btrfs filesystem
- * 2: path is a directory if dir_only is 1
- */
-int btrfs_open(const char *path, DIR **dirstream, int verbose, int dir_only)
-{
-	struct statfs stfs;
-	struct stat st;
-	int ret;
-
-	if (stat(path, &st) != 0) {
-		error_on(verbose, "cannot access '%s': %m", path);
-		return -1;
-	}
-
-	if (dir_only && !S_ISDIR(st.st_mode)) {
-		error_on(verbose, "not a directory: %s", path);
-		return -3;
-	}
-
-	if (statfs(path, &stfs) != 0) {
-		error_on(verbose, "cannot access '%s': %m", path);
-		return -1;
-	}
-
-	if (stfs.f_type != BTRFS_SUPER_MAGIC) {
-		error_on(verbose, "not a btrfs filesystem: %s", path);
-		return -2;
-	}
-
-	ret = open_file_or_dir(path, dirstream);
-	if (ret < 0) {
-		error_on(verbose, "cannot access '%s': %m", path);
-	}
-
-	return ret;
-}
-
-int btrfs_open_dir(const char *path, DIR **dirstream, int verbose)
-{
-	return btrfs_open(path, dirstream, verbose, 1);
-}
-
-int btrfs_open_file_or_dir(const char *path, DIR **dirstream, int verbose)
-{
-	return btrfs_open(path, dirstream, verbose, 0);
-}
-
-int open_file_or_dir3(const char *fname, DIR **dirstream, int open_flags)
-{
-	int ret;
-	struct stat st;
-	int fd;
-
-	ret = stat(fname, &st);
-	if (ret < 0) {
-		return -1;
-	}
-	if (S_ISDIR(st.st_mode)) {
-		*dirstream = opendir(fname);
-		if (!*dirstream)
-			return -1;
-		fd = dirfd(*dirstream);
-	} else if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-		fd = open(fname, open_flags);
-	} else {
-		/*
-		 * we set this on purpose, in case the caller output
-		 * strerror(errno) as success
-		 */
-		errno = EINVAL;
-		return -1;
-	}
-	if (fd < 0) {
-		fd = -1;
-		if (*dirstream) {
-			closedir(*dirstream);
-			*dirstream = NULL;
-		}
-	}
-	return fd;
-}
-
-int open_file_or_dir(const char *fname, DIR **dirstream)
-{
-	return open_file_or_dir3(fname, dirstream, O_RDWR);
-}
-
-void close_file_or_dir(int fd, DIR *dirstream)
-{
-	int old_errno;
-
-	old_errno = errno;
-	if (dirstream) {
-		closedir(dirstream);
-	} else if (fd >= 0) {
-		close(fd);
-	}
-
-	errno = old_errno;
-}
-
-
 /*
  * Do the following checks before calling open:
  * 1: path is in a btrfs filesystem
diff --git a/common/open-utils.h b/common/open-utils.h
index 96d99f5d..5642b951 100644
--- a/common/open-utils.h
+++ b/common/open-utils.h
@@ -28,16 +28,6 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 			bool noscan);
 int check_mounted(const char* file);
 int get_btrfs_mount(const char *dev, char *mp, size_t mp_size);
-int open_path_or_dev_mnt(const char *path, DIR **dirstream, int verbose);
-
-int open_file_or_dir3(const char *fname, DIR **dirstream, int open_flags);
-int open_file_or_dir(const char *fname, DIR **dirstream);
-
-int btrfs_open(const char *path, DIR **dirstream, int verbose, int dir_only);
-int btrfs_open_dir(const char *path, DIR **dirstream, int verbose);
-int btrfs_open_file_or_dir(const char *path, DIR **dirstream, int verbose);
-
-void close_file_or_dir(int fd, DIR *dirstream);
 
 int btrfs_open_fd2(const char *path, bool verbose, bool read_write, bool dir_only);
 int btrfs_open_file_or_dir_fd(const char *path);
-- 
2.43.0


