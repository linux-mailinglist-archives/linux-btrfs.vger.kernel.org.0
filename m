Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3730357A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 06:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbhAZFm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 00:42:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbhAYKor (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 05:44:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611571440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe6lCcfR/lVJ31oI/FVTUkgbA3Bo/fUCRAB/Xk1GYEE=;
        b=hiNZFUZGCzWW7n/A7/8jOiIH3xckhGfLMWiwsMv7zGX8aZ0ipOroF+sZllFIItp8Cju4fl
        IXSVE99mm4mcVuuCG49JuetkCR2g+gCzUQoEFWlvU6OW+Ls2Rb+IwPQliMMMFRfmHEkv5P
        pgPgZ9gVIAcvHEBwuDAPJ1bd+UpbQiA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9ED31B759;
        Mon, 25 Jan 2021 10:44:00 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs-progs: Remove duplicate checks from cmd_filesystem_resize
Date:   Mon, 25 Jan 2021 12:43:58 +0200
Message-Id: <20210125104358.817072-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125104358.817072-1-nborisov@suse.com>
References: <20210125104358.817072-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_open_dir already has a check whether the passed path is a
directory and if so it returns a specific error code (-3) when such an
error occurs. Use this instead of open-coding the directory check. To avoid
regression in cli/003 test also move directory checks before fs type in
btrfs_open

Output before this check :

ERROR: resize works on mounted filesystems and accepts only
directories as argument. Passing file containing a btrfs image
would resize the underlying filesystem instead of the image.

After:

ERROR: not a directory: /root/btrfs-progs/tests/test.img
ERROR: resize works on mounted filesystems and accepts only
directories as argument. Passing file containing a btrfs image
would resize the underlying filesystem instead of the image.


Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds/filesystem.c | 21 +++++++--------------
 common/utils.c    | 16 ++++++++--------
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index ba2e5928cc02..8379fd7a8151 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1082,7 +1082,6 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	char	*amount, *path;
 	DIR	*dirstream = NULL;
 	int ret;
-	struct stat st;
 	bool enqueue = false;

 	/*
@@ -1115,21 +1114,15 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 	}

-	res = stat(path, &st);
-	if (res < 0) {
-		error("resize: cannot stat %s: %m", path);
-		return 1;
-	}
-	if (!S_ISDIR(st.st_mode)) {
-		error("resize works on mounted filesystems and accepts only\n"
-			"directories as argument. Passing file containing a btrfs image\n"
-			"would resize the underlying filesystem instead of the image.\n");
-		return 1;
-	}
-
 	fd = btrfs_open_dir(path, &dirstream, 1);
-	if (fd < 0)
+	if (fd < 0) {
+		if (fd == -3) {
+			error("resize works on mounted filesystems and accepts only\n"
+			      "directories as argument. Passing file containing a btrfs image\n"
+			      "would resize the underlying filesystem instead of the image.\n");
+		}
 		return 1;
+	}

 	ret = check_running_fs_exclop(fd, BTRFS_EXCLOP_RESIZE, enqueue);
 	if (ret != 0) {
diff --git a/common/utils.c b/common/utils.c
index f7dc320c8915..15fda84ed291 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -185,24 +185,24 @@ int btrfs_open(const char *path, DIR **dirstream, int verbose, int dir_only)
 	struct stat st;
 	int ret;

-	if (statfs(path, &stfs) != 0) {
+	if (stat(path, &st) != 0) {
 		error_on(verbose, "cannot access '%s': %m", path);
 		return -1;
 	}

-	if (stfs.f_type != BTRFS_SUPER_MAGIC) {
-		error_on(verbose, "not a btrfs filesystem: %s", path);
-		return -2;
+	if (dir_only && !S_ISDIR(st.st_mode)) {
+		error_on(verbose, "not a directory: %s", path);
+		return -3;
 	}

-	if (stat(path, &st) != 0) {
+	if (statfs(path, &stfs) != 0) {
 		error_on(verbose, "cannot access '%s': %m", path);
 		return -1;
 	}

-	if (dir_only && !S_ISDIR(st.st_mode)) {
-		error_on(verbose, "not a directory: %s", path);
-		return -3;
+	if (stfs.f_type != BTRFS_SUPER_MAGIC) {
+		error_on(verbose, "not a btrfs filesystem: %s", path);
+		return -2;
 	}

 	ret = open_file_or_dir(path, dirstream);
--
2.25.1

