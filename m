Return-Path: <linux-btrfs+bounces-2257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A946E84E9B9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE99DB25ED0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6700B47F59;
	Thu,  8 Feb 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="glDMhIri"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486FA3F9E3
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424253; cv=none; b=OLvxISdP0LMvnVU/zN5CJT4vbt3F84tAt5OjC+Ivark192k/Gzp6PGjWlUf1A/CAWaYN5aGoAmtWVJrgCCMOk6fNdbLzxbcT9XUwpSzvlxv19LN0uCaD15Wl+d55YYG98tFlDGxMRxmhjrQALvljhmy8FH/MXUIEjfcBS36EkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424253; c=relaxed/simple;
	bh=iolS9GcuxxCYyqsFPJDGKpGzY/YKpFbE+vgw0p7hjkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWZwpSRj4oV46Z7Euh/NCyc70/jqViepgyGYg/gRTcGL9XJ9Q4ohNppPXHfHp0hiHAZXmZ0OGKQgCKCu5TrwIyPqph4QZswvEVAiI+qPrLlyvQIZxURCEkSKtFuM3K4/p5sZ9lmya3cBrLUm6zZGJQBGjhoylcQ6ahELUeAuBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=glDMhIri; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVfoV; Thu, 08 Feb 2024 20:29:39 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 5/9] Killing dirstream: replace open_file_or_dir3 with btrfs_open_fd2
Date: Thu,  8 Feb 2024 21:19:23 +0100
Message-ID: <28a66d261b14f17625bd355f837beb18c7546014.1707423567.git.kreijack@inwind.it>
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
	t=1707424179; bh=CaRC4LGdNXxKgL18ZnqV/Sz8/ySRzSMr1RihS6k6psA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=glDMhIrip0Z+0Uft/1Zk1RDq1bhuLE5m47+RGaZDh84/j1vI+Qm0ZY4WDKhzNhU6u
	 kr13qU9EesoIbG9m881uXa0/pAXd4VtRLi2uSPY/vaB/29Owpn5+BW3iUKBcDPH8Cp
	 iAXQBdAvXQvZSiBC2ABWPzPNKGO1Ybk9QENzDk68=

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
index d37b52a3..408ebe82 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1004,7 +1004,6 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	bool recursive = false;
 	int ret = 0;
 	int compress_type = BTRFS_COMPRESS_NONE;
-	DIR *dirstream;
 
 	/*
 	 * Kernel 4.19+ supports defragmention of files open read-only,
@@ -1142,8 +1141,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 		struct stat st;
 		int defrag_err = 0;
 
-		dirstream = NULL;
-		fd = open_file_or_dir3(argv[i], &dirstream, defrag_open_mode);
+		fd = btrfs_open_fd2(argv[i], false, defrag_open_mode==O_RDWR, false);
 		if (fd < 0) {
 			error("cannot open %s: %m", argv[i]);
 			ret = -errno;
@@ -1177,7 +1175,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 				error(
 "defrag range ioctl not supported in this kernel version, 2.6.33 and newer is required");
 				defrag_global_errors++;
-				close_file_or_dir(fd, dirstream);
+				close(fd);
 				break;
 			}
 			if (ret) {
@@ -1189,7 +1187,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
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


