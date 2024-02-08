Return-Path: <linux-btrfs+bounces-2264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC084E9BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB51B27EB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D03F9F7;
	Thu,  8 Feb 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="lYBdQlm5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A73F9F5
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424254; cv=none; b=UhQCm+d+v7dpb//D242PKm1AFORL9FBD7ZPLZqghN4wzG7xDbvCV9mp/l178yh6/o5vjjEDcSATPVjKJa70VtZr8tRNVd0AKqfdXnenPlJPfPsacmNynYcNWmoEMw237ZJP5qrSKrUJpM1Z538WpeErZeGtijVsoAjpbZWIHxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424254; c=relaxed/simple;
	bh=WgtJuWzhi4zxVkayVTRKYLEv3rCbLQWRpVK6lkZ8eGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYuPNAtrmUpVh2S+rRpDuOFiY2VWJusykdx7zPgy7hOX/Tve3Sbm2oBM+2musWvzOIwkeFR08bo/vazgsQlMzwC1LTJuyuG5haGWNiGpHEY/8GZwmb8TF7buU/BgiA6CDHOQfu92OrKgTB45Pfi/35IwV19diHe+rPeryGJpnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=lYBdQlm5; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVfoM; Thu, 08 Feb 2024 20:29:39 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/9] Killing dirstream: replace open_path_or_dev_mnt with btrfs_open_mnt_fd
Date: Thu,  8 Feb 2024 21:19:22 +0100
Message-ID: <cf201cdf204712200a3c852b8c9a760e5df27556.1707423567.git.kreijack@inwind.it>
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
	t=1707424179; bh=AYJQe+1TJUuxiFNhf39k7fVVrH++mHgY9oIWRvfe/e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=lYBdQlm5JQH7QxyoRwAuRSk5sljZjZS/eMNI4StXvN8uHzgJ0RbM6RYSLsUqus5Xw
	 Fxg+vnlIYjXz64Ms+Vj7+21fV8VJro/Zv6CxUzaq9j4CCiVyXXAxYzemMTNqjBksxE
	 LcJ+d9UlS/gCBmQp7GQI9F5YvjntuOze6jM1MMkQ=

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
index cc201ff9..5be76595 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -717,7 +717,6 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 	bool free_table = false;
 	bool tabular = false;
 	__u64 flags = 0;
-	DIR *dirstream = NULL;
 	struct format_ctx fctx;
 
 	optind = 0;
@@ -753,7 +752,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 
 	dev_path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(dev_path, &dirstream, 1);
+	fdmnt = btrfs_open_mnt_fd(dev_path, true);
 	if (fdmnt < 0)
 		return 1;
 
@@ -839,7 +838,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 
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
index e105ecb2..039a67d1 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1269,7 +1269,6 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	pthread_mutex_t spc_write_mutex = PTHREAD_MUTEX_INITIALIZER;
 	void *terr;
 	u64 devid;
-	DIR *dirstream = NULL;
 	bool force = false;
 	bool nothing_to_resume = false;
 
@@ -1326,7 +1325,7 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 
 	path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(path, &dirstream, !do_quiet);
+	fdmnt = btrfs_open_mnt_fd(path, !do_quiet);
 	if (fdmnt < 0)
 		return 1;
 
@@ -1698,7 +1697,7 @@ out:
 		if (sock_path[0])
 			unlink(sock_path);
 	}
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 
 	if (err)
 		return 1;
@@ -1751,7 +1750,6 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 	char *path;
 	int ret;
 	int fdmnt = -1;
-	DIR *dirstream = NULL;
 
 	clean_args_no_options(cmd, argc, argv);
 
@@ -1760,7 +1758,7 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 
 	path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(path, &dirstream, 1);
+	fdmnt = btrfs_open_mnt_fd(path, true);
 	if (fdmnt < 0) {
 		ret = 1;
 		goto out;
@@ -1782,7 +1780,7 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 	pr_verbose(LOG_DEFAULT, "scrub cancelled\n");
 
 out:
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(scrub_cancel, "cancel");
@@ -1841,7 +1839,6 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 	char fsid[BTRFS_UUID_UNPARSED_SIZE];
 	int fdres = -1;
 	int err = 0;
-	DIR *dirstream = NULL;
 
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 0);
 
@@ -1864,7 +1861,7 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 
 	path = argv[optind];
 
-	fdmnt = open_path_or_dev_mnt(path, &dirstream, 1);
+	fdmnt = btrfs_open_mnt_fd(path, true);
 	if (fdmnt < 0)
 		return 1;
 
@@ -1978,7 +1975,7 @@ out:
 	free(si_args);
 	if (fdres > -1)
 		close(fdres);
-	close_file_or_dir(fdmnt, dirstream);
+	close(fdmnt);
 
 	return !!err;
 }
-- 
2.43.0


