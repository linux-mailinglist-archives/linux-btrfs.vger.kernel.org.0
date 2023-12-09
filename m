Return-Path: <linux-btrfs+bounces-779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28D880B612
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B48B20BC5
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2C1B28C;
	Sat,  9 Dec 2023 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="rzQvh1xS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00AEB125
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTPZ1; Sat, 09 Dec 2023 19:27:23 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 5/9] Killing dirstream: replace open_file_or_dir3 with btrfs_open_fd2
Date: Sat,  9 Dec 2023 19:53:25 +0100
Message-ID: <8ebd67be39098ee89e8ebe3a7be941d19a01b99e.1702148009.git.kreijack@inwind.it>
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
	t=1702150043; bh=NmIjD40OhPIG2VpzVhHgKP0/9Df8/s6MvoOc7aIVREM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=rzQvh1xSiR/aRfwDPPuH/mfE/p2Tn/9O8iOrcsdLbbYscAkfttYBLIKj7/jpIrI7I
	 jjWXV69P2RyKc4U41U2lq2bPeTLJThISyGvETkklhuOFPe/0gAH5SCgGpyTo5dNm2n
	 VY2uvDEY6JjZ1ZTsesQQll6t3G41+KuHxlcQIZ3E=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This patch replace open_file_or_dir3() with btrfs_open_fd2() removing
any reference to the unused/useless dirstream variables.
btrfs_open_fd2() is needed because sometime the caller need
to set the RDONLY/RDWRITE mode, and to avoid spourios diagnosis messages.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/filesystem.c | 8 +++-----
 cmds/property.c   | 5 ++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 9a89e2c6..65370886 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1003,7 +1003,6 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	bool recursive = false;
 	int ret = 0;
 	int compress_type = BTRFS_COMPRESS_NONE;
-	DIR *dirstream;
 
 	/*
 	 * Kernel 4.19+ supports defragmention of files open read-only,
@@ -1141,8 +1140,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 		struct stat st;
 		int defrag_err = 0;
 
-		dirstream = NULL;
-		fd = open_file_or_dir3(argv[i], &dirstream, defrag_open_mode);
+		fd = btrfs_open_fd2(argv[i], false, defrag_open_mode==O_RDWR, false);
 		if (fd < 0) {
 			error("cannot open %s: %m", argv[i]);
 			ret = -errno;
@@ -1176,7 +1174,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 				error(
 "defrag range ioctl not supported in this kernel version, 2.6.33 and newer is required");
 				defrag_global_errors++;
-				close_file_or_dir(fd, dirstream);
+				close(fd);
 				break;
 			}
 			if (ret) {
@@ -1188,7 +1186,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 next:
 		if (ret)
 			defrag_global_errors++;
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 	}
 
 	if (defrag_global_errors)
diff --git a/cmds/property.c b/cmds/property.c
index be9bdf63..e189e505 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -175,12 +175,11 @@ static int prop_compression(enum prop_object_type type,
 	int ret;
 	ssize_t sret;
 	int fd = -1;
-	DIR *dirstream = NULL;
 	char *buf = NULL;
 	char *xattr_name = NULL;
 	int open_flags = value ? O_RDWR : O_RDONLY;
 
-	fd = open_file_or_dir3(object, &dirstream, open_flags);
+	fd = btrfs_open_fd2(object, false, open_flags == O_RDWR, false);
 	if (fd == -1) {
 		ret = -errno;
 		error("failed to open %s: %m", object);
@@ -232,7 +231,7 @@ out:
 	free(xattr_name);
 	free(buf);
 	if (fd >= 0)
-		close_file_or_dir(fd, dirstream);
+		close(fd);
 
 	return ret;
 }
-- 
2.43.0


