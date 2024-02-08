Return-Path: <linux-btrfs+bounces-2261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30FD84E9BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F10628DFE2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B544C96;
	Thu,  8 Feb 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="ixDL7vpv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892E3F9F7
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424254; cv=none; b=U0tEyYz3cyo9XecWZNDvfSlT/+zIu8VW7SQEHpsjfGZ+ceAI9CNRpcfcfKUoKIlgDDBmzlBOYFcZVukTiUzjxpj/GzvBDUm4/Ay4EmtloJ3g/aRzCuW+ZZwVFLccO823Oo7ITF9AQnoIB00A4lw5Es2WGijD4eK7K+bl1xeEDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424254; c=relaxed/simple;
	bh=WyDiTA+5fYt32h2UPz33Jpoaux0oLv32u9Ebd/SJ/Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p38RF2zyMuOGbvVm5Pqm4ikU/7l4Y9PYvSxVswzSi72z5HvkOdwoInkdC7AIE3dJXWGbM3jplLwM1QTU+wZfNW0vGzZ+ZShmTJrXpip/iZSk9SQKR5AtDlKcOseUuO/C6toRTWiXwwGUUFZrU7c8uULl/sEKS0kQ2agFwpNdx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=ixDL7vpv; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVfoa; Thu, 08 Feb 2024 20:29:39 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 6/9] Killing dirstream: replace btrfs_open_file_or_dir with btrfs_open_file_or_dir_fd
Date: Thu,  8 Feb 2024 21:19:24 +0100
Message-ID: <7156cf1438f8f2c6442e6f6ba1fe4158080667f6.1707423567.git.kreijack@inwind.it>
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
	t=1707424179; bh=RJVpd5vU1oCn1gxA81O3c09OEpM7ZuwMgY21vU65iYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=ixDL7vpv5rV6xZVzpPggeQj7/xp0jWORzdGYEdZ2ldnKsFvvgqBqWLg3QGjQhxXWj
	 M2kZ8XyiZvCnr6E+hhDZ0i1Tp2a1A3tVBZR8UWM7Fff4b9QRK+RdYoy/cOi47IJoKF
	 nfJWJ6/u2jlyxEQ5m/sEcHg+j3lU1fOcFdGWmD/o=

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


