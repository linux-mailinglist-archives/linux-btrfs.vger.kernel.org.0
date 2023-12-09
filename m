Return-Path: <linux-btrfs+bounces-782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC680B616
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA23B20CF2
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5F1CFBE;
	Sat,  9 Dec 2023 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="tz4dudy+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBEE1B7
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTPYu; Sat, 09 Dec 2023 19:27:23 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/9] Killing dirstream: replace open_path_or_dev_mnt with btrfs_open_mnt_fd
Date: Sat,  9 Dec 2023 19:53:24 +0100
Message-ID: <ae844eb1981e943b2d1df8263ff804c6b4ab4425.1702148009.git.kreijack@inwind.it>
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
	t=1702150043; bh=P6OCVooQgoBWxiByXjNP2g9KEq5EHhoq33NLkrfbqbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=tz4dudy+Hd/nHqPDx6QjAYIjRhurb3k1+olsOtqv6V6RKfSXaUfZlY/Q8mwiQYGAS
	 VDBUE3RKB6g4mqDZOKA7wP7Il5NYU4e3/GBzRgfMVLVnXxaQPL/5cqhkWvYMX0hgRX
	 jtwQOsIlYQeQNvMrTGV+ElIUeGG4QA8aduS8Pdrw=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This patch replace open_path_or_dev_mnt() with btrfs_open_mnt_fd() removing
any reference to the unused/useless dirstream variables.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/device.c  |  5 ++---
 cmds/replace.c |  7 +++----
 cmds/scrub.c   | 15 ++++++---------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 0b75e110..3ff7120f 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -692,7 +692,6 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 	bool free_table = false;
 	bool tabular = false;
 	__u64 flags = 0;
-	DIR *dirstream = NULL;
 	struct format_ctx fctx;
 
 	optind = 0;
@@ -728,7 +727,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 
 	dev_path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(dev_path, &dirstream, 1);
+	fdmnt = btrfs_open_mnt_fd(dev_path, true);
 	if (fdmnt < 0)
 		return 1;
 
@@ -814,7 +813,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 
 out:
 	free(di_args);
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 	if (free_table)
 		table_free(table);
 
diff --git a/cmds/replace.c b/cmds/replace.c
index 171a72b4..f1db9477 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -136,7 +136,6 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	bool force_using_targetdev = false;
 	u64 dstdev_block_count;
 	bool do_not_background = false;
-	DIR *dirstream = NULL;
 	u64 srcdev_size;
 	u64 dstdev_size;
 	bool enqueue = false;
@@ -184,7 +183,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 		return 1;
 	path = argv[optind + 2];
 
-	fdmnt = open_path_or_dev_mnt(path, &dirstream, 1);
+	fdmnt = btrfs_open_mnt_fd(path, true);
 	if (fdmnt < 0)
 		goto leave_with_error;
 
@@ -200,7 +199,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	if (ret != 0) {
 		if (ret < 0)
 			error("unable to check status of exclusive operation: %m");
-		close_file_or_dir(fdmnt, dirstream);
+		close(fdmnt);
 		goto leave_with_error;
 	}
 
@@ -348,7 +347,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 			goto leave_with_error;
 		}
 	}
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 	return 0;
 
 leave_with_error:
diff --git a/cmds/scrub.c b/cmds/scrub.c
index 4a741355..85626d11 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1203,7 +1203,6 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	pthread_mutex_t spc_write_mutex = PTHREAD_MUTEX_INITIALIZER;
 	void *terr;
 	u64 devid;
-	DIR *dirstream = NULL;
 	bool force = false;
 	bool nothing_to_resume = false;
 
@@ -1260,7 +1259,7 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 
 	path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(path, &dirstream, !do_quiet);
+	fdmnt = btrfs_open_mnt_fd(path, !do_quiet);
 	if (fdmnt < 0)
 		return 1;
 
@@ -1618,7 +1617,7 @@ out:
 		if (sock_path[0])
 			unlink(sock_path);
 	}
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 
 	if (err)
 		return 1;
@@ -1671,7 +1670,6 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 	char *path;
 	int ret;
 	int fdmnt = -1;
-	DIR *dirstream = NULL;
 
 	clean_args_no_options(cmd, argc, argv);
 
@@ -1680,7 +1678,7 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 
 	path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(path, &dirstream, 1);
+	fdmnt = btrfs_open_mnt_fd(path, true);
 	if (fdmnt < 0) {
 		ret = 1;
 		goto out;
@@ -1702,7 +1700,7 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 	pr_verbose(LOG_DEFAULT, "scrub cancelled\n");
 
 out:
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(scrub_cancel, "cancel");
@@ -1761,7 +1759,6 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 	char fsid[BTRFS_UUID_UNPARSED_SIZE];
 	int fdres = -1;
 	int err = 0;
-	DIR *dirstream = NULL;
 
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 0);
 
@@ -1784,7 +1781,7 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 
 	path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(path, &dirstream, 1);
+	fdmnt = btrfs_open_mnt_fd(path, true);
 	if (fdmnt < 0)
 		return 1;
 
@@ -1888,7 +1885,7 @@ out:
 	free(si_args);
 	if (fdres > -1)
 		close(fdres);
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 
 	return !!err;
 }
-- 
2.43.0


