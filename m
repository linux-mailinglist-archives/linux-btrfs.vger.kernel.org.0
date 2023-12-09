Return-Path: <linux-btrfs+bounces-785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F1080B618
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F166281138
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686AB1DDC7;
	Sat,  9 Dec 2023 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="SHKmkMVT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 012D810C8
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTNYW; Sat, 09 Dec 2023 19:27:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/9] Killing dirstream: add helpers
Date: Sat,  9 Dec 2023 19:53:21 +0100
Message-ID: <802bd72e2f67add884e8725ec87063e7554f8f40.1702148009.git.kreijack@inwind.it>
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
	t=1702150042; bh=9x4u0mYTUs1yQZRmVU9e994uQ8ynuFpiVdFtB4c0xco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=SHKmkMVTofiQits1GtDV1bDEtJXQrji345dglZt2vmdW+k7rT4uEY98uDV7+isvVD
	 p9EpjhDa1i2FmiZxVlSWuvVFwX4pIm9DE07s6hE8Id6sP1+aWzdTxf97kHA/zmmSyL
	 BDna40yUpGuBevpD/6AbWj4txwn1um7ChiXNdZlo=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This is a preparatory patch that adds some helpers.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 common/open-utils.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 common/open-utils.h |  5 +++
 2 files changed, 85 insertions(+)

diff --git a/common/open-utils.c b/common/open-utils.c
index 111a51d9..61153294 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -318,3 +318,83 @@ void close_file_or_dir(int fd, DIR *dirstream)
 }
 
 
+/*
+ * Do the following checks before calling open:
+ * 1: path is in a btrfs filesystem
+ */
+int btrfs_open_fd2(const char *path, bool verbose, bool read_write, bool dir_only)
+{
+	struct statfs stfs;
+	struct stat st;
+	int ret;
+
+	if (stat(path, &st) != 0) {
+		error_on(verbose, "cannot access '%s': %m", path);
+		return -1;
+	}
+
+	if (statfs(path, &stfs) != 0) {
+		error_on(verbose, "cannot access '%s': %m", path);
+		return -1;
+	}
+
+	if (stfs.f_type != BTRFS_SUPER_MAGIC) {
+		error_on(verbose, "not a btrfs filesystem: %s", path);
+		return -2;
+	}
+
+	if (dir_only && !S_ISDIR(st.st_mode)) {
+		error_on(verbose, "not a directory: %s", path);
+		return -3;
+	}
+
+	if (S_ISDIR(st.st_mode) || !read_write)
+		ret = open(path, O_RDONLY);
+	else
+		ret = open(path, O_RDWR);
+	if (ret < 0) {
+		error_on(verbose, "cannot access '%s': %m", path);
+	}
+
+	return ret;
+}
+
+int btrfs_open_file_or_dir_fd(const char *path)
+{
+	return btrfs_open_fd2(path, true, true, false);
+}
+
+int btrfs_open_dir_fd(const char *path)
+{
+	return btrfs_open_fd2(path, true, true, true);
+}
+
+
+/*
+ * Given a pathname, return a filehandle to:
+ * 	the original pathname or,
+ * 	if the pathname is a mounted btrfs device, to its mountpoint.
+ *
+ * On error, return -1, errno should be set.
+ */
+int btrfs_open_mnt_fd(const char *path, bool verbose)
+{
+	char mp[PATH_MAX];
+	int ret;
+
+	if (path_is_block_device(path)) {
+		ret = get_btrfs_mount(path, mp, sizeof(mp));
+		if (ret < 0) {
+			/* not a mounted btrfs dev */
+			error_on(verbose, "'%s' is not a mounted btrfs device",
+				 path);
+			errno = EINVAL;
+			return -1;
+		}
+		ret = btrfs_open_fd2(mp, verbose, true, true);
+	} else {
+		ret = btrfs_open_dir_fd(path);
+	}
+
+	return ret;
+}
diff --git a/common/open-utils.h b/common/open-utils.h
index 3f8c004e..96d99f5d 100644
--- a/common/open-utils.h
+++ b/common/open-utils.h
@@ -39,4 +39,9 @@ int btrfs_open_file_or_dir(const char *path, DIR **dirstream, int verbose);
 
 void close_file_or_dir(int fd, DIR *dirstream);
 
+int btrfs_open_fd2(const char *path, bool verbose, bool read_write, bool dir_only);
+int btrfs_open_file_or_dir_fd(const char *path);
+int btrfs_open_dir_fd(const char *path);
+int btrfs_open_mnt_fd(const char *path, bool verbose);
+
 #endif
-- 
2.43.0


