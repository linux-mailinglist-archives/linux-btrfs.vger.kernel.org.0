Return-Path: <linux-btrfs+bounces-780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EC580B613
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC04B20D08
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F61C692;
	Sat,  9 Dec 2023 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="T4MFwLb1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 006EED1
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTPZ6; Sat, 09 Dec 2023 19:27:23 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 6/9] Killing dirstream: replace btrfs_open_file_or_dir with btrfs_open_file_or_dir_fd
Date: Sat,  9 Dec 2023 19:53:26 +0100
Message-ID: <810d9d2762dd4f3c77ad32e55c20d6bbfec274ec.1702148009.git.kreijack@inwind.it>
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
	t=1702150043; bh=RJVpd5vU1oCn1gxA81O3c09OEpM7ZuwMgY21vU65iYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=T4MFwLb1jgBS8yFYu6RyfJfZVqtjJmheGNdmRbhnUVc+HRmzVZLQpBQOmkOVcPs8m
	 8UwTdHbbiejjxFEW90aV64k7n4iX9ZPSzWbkI5ege8LLn49rxih6yfY2673SxxGJnU
	 mkIMPGzQt3XJZtC4BmTACIwPcvxduSFcQeY+bA0E=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This patch replace btrfs_open_file_or_dir() with btrfs_open_file_or_dir_fd()
removing any reference to the unused/useless dirstream variables.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/inspect.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 86023270..4d4e24d2 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -369,14 +369,13 @@ static int cmd_inspect_rootid(const struct cmd_struct *cmd,
 	int ret;
 	int fd = -1;
 	u64 rootid;
-	DIR *dirstream = NULL;
 
 	clean_args_no_options(cmd, argc, argv);
 
 	if (check_argc_exact(argc - optind, 1))
 		return 1;
 
-	fd = btrfs_open_file_or_dir(argv[optind], &dirstream, 1);
+	fd = btrfs_open_file_or_dir_fd(argv[optind]);
 	if (fd < 0) {
 		ret = -ENOENT;
 		goto out;
@@ -391,7 +390,7 @@ static int cmd_inspect_rootid(const struct cmd_struct *cmd,
 
 	pr_verbose(LOG_DEFAULT, "%llu\n", rootid);
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 
 	return !!ret;
 }
-- 
2.43.0


