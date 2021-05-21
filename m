Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54EE38C646
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhEUMKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhEUMKl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QH61R75O2WTcgEVm34cKODaXZBQzZm8WBNpcKyynI4M=;
        b=nwlaaEb+hRD8b5tal8suYyAvXNNAHxRkJTePOKbh2kf+n3FfMaMBLAviww35Vxm63pBvQ3
        xz9mUEA2w4dyqO+Z6QsijrHT0P/SACaklDU9Jr/lJtSJYTGePuq35RnXKrszB4J0H9mQ3Q
        oz6nCcow7lr7/ieBVVwjbYKyWUN4dN4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7CBDAAFD;
        Fri, 21 May 2021 12:09:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A2AFDA725; Fri, 21 May 2021 14:06:43 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs-progs: fi resize: add support for cancel
Date:   Fri, 21 May 2021 14:06:43 +0200
Message-Id: <20210521120643.16990-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recognize special resize amount 'cancel' for resize operation.  This
will request kernel to stop running any resize operation (most likely
shrinking resize). This needs support in kernel, otherwise this will
fail due to another exclusive operation running (though could be the
same one).

The command returns after kernel finishes any work that got interrupted,
but this should not take long in kernels 5.10+ that allow interruptible
relocation. The waiting inside kernel is interruptible so this command
(and the waiting stage) can be interrupted.

The resize operation could relocate block groups but the nominal
filesystem size will be restored when resize won't finish. It's
recommended to review the filesystem state.

Note: in kernels 5.10+ sending a fatal signal (TERM, KILL, Ctrl-C) to
the process running the resize will cancel it too.

Example:

  $ btrfs fi resize -10G /mnt
  ...
  $ btrfs fi resize cancel /mnt

Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/filesystem.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f123d25320f..db8433ba3542 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1151,6 +1151,10 @@ static int check_resize_args(const char *amount, const char *path) {
 
 	if (strcmp(sizestr, "max") == 0) {
 		res_str = "max";
+	} else if (strcmp(sizestr, "cancel") == 0) {
+		/* Different format, print and exit */
+		printf("Request to cancel resize\n");
+		goto out;
 	} else {
 		if (sizestr[0] == '-') {
 			mod = -1;
@@ -1211,6 +1215,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	DIR	*dirstream = NULL;
 	int ret;
 	bool enqueue = false;
+	bool cancel = false;
 
 	/*
 	 * Simplified option parser, accept only long options, the resize value
@@ -1242,6 +1247,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 	}
 
+	cancel = (strcmp("cancel", amount) == 0);
+
 	fd = btrfs_open_dir(path, &dirstream, 1);
 	if (fd < 0) {
 		/* The path is a directory */
@@ -1254,12 +1261,20 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	ret = check_running_fs_exclop(fd, BTRFS_EXCLOP_RESIZE, enqueue);
-	if (ret != 0) {
-		if (ret < 0)
-			error("unable to check status of exclusive operation: %m");
-		close_file_or_dir(fd, dirstream);
-		return 1;
+	/*
+	 * Check if there's an exclusive operation running if possible, otherwise
+	 * let kernel handle it. Cancel request is completely handled in kernel
+	 * so make it pass.
+	 */
+	if (!cancel) {
+		ret = check_running_fs_exclop(fd, BTRFS_EXCLOP_RESIZE, enqueue);
+		if (ret != 0) {
+			if (ret < 0)
+				error(
+			"unable to check status of exclusive operation: %m");
+			close_file_or_dir(fd, dirstream);
+			return 1;
+		}
 	}
 
 	ret = check_resize_args(amount, path);
-- 
2.29.2

