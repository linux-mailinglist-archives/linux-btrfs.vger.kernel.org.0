Return-Path: <linux-btrfs+bounces-778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9180B611
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FDE281072
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8941B272;
	Sat,  9 Dec 2023 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="YFEVddXD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011FD10C7
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTQZK; Sat, 09 Dec 2023 19:27:24 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 8/9] Killing dirstream: remove open_file_or_dir3 from du_add_file
Date: Sat,  9 Dec 2023 19:53:28 +0100
Message-ID: <6207263a33cbcb58f42aa0d2a6bf6172bdbf25da.1702148009.git.kreijack@inwind.it>
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
	t=1702150044; bh=9+Hk8PG7unnIWsd+ScnXTytvNF70D/z2HQgHku2x6PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=YFEVddXD3mkd1Q8rN9zjyEf8mZWsSO6gIhb829xlccQBooy+oQomWG5gp8f21+IK1
	 MbH9Ur6ckct/OU272+yy80Y0GiVpIh7oJoXgTUqq/cTcsgvmojHzO9gqJUlVmZgBSv
	 IiANzJMRt2M5vvb99uZb/P11+55/7uyrSv99alhE=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

This patch replace the last reference to btrfs_open_file_or_dir3()
with btrfs_open_fd2().

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/filesystem-du.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 4982123d..cffeafd5 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -456,7 +456,7 @@ static int du_add_file(const char *filename, int dirfd,
 		ret = sprintf(pathp, "/%s", filename);
 	pathp += ret;
 
-	fd = open_file_or_dir3(path, &dirstream, O_RDONLY);
+	fd = btrfs_open_fd2(path, false, false, false);
 	if (fd < 0) {
 		ret = -errno;
 		goto out;
@@ -489,6 +489,12 @@ static int du_add_file(const char *filename, int dirfd,
 	} else if (S_ISDIR(st.st_mode)) {
 		struct rb_root *root = shared_extents;
 
+		dirstream = fdopendir(fd);
+		if (!dirstream) {
+			ret = -errno;
+			goto out_close;
+		}
+
 		/*
 		 * We collect shared extents in an rb_root, the top
 		 * level caller will not pass a root down, so use the
@@ -542,7 +548,15 @@ static int du_add_file(const char *filename, int dirfd,
 		*ret_shared = file_shared;
 
 out_close:
-	close_file_or_dir(fd, dirstream);
+	/*
+	 * if dirstream is not NULL, it is derived by fd, so it is enough
+	 * to close the former
+	 */
+	if (dirstream)
+		closedir(dirstream);
+	else
+		close(fd);
+
 out:
 	/* reset path to just before this element */
 	pathp = pathtmp;
-- 
2.43.0


