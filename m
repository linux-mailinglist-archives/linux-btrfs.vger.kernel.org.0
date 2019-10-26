Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663D0E598B
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJZKLd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 06:11:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfJZKLd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 06:11:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 070BBB14F;
        Sat, 26 Oct 2019 10:11:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christian Pernegger <pernegger@gmail.com>
Subject: [PATCH] btrfs-progs: rescue-zero-log: Modify super block directly
Date:   Sat, 26 Oct 2019 18:11:27 +0800
Message-Id: <20191026101127.36851-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For log zeroing, we only need to reset log_root and log_root_level to 0.

However current zero-log still goes full open_ctree() which can be
rejected easily by extent tree corruption.

So this patch will change the behavior to modifying super block
directly, avoid any possible rejection from open_ctree()

Reported-by: Christian Pernegger <pernegger@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index e8eab6808bc3..3e2dedf04fda 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -19,6 +19,9 @@
 #include "kerncompat.h"
 
 #include <getopt.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/stat.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "transaction.h"
@@ -164,10 +167,11 @@ static const char * const cmd_rescue_zero_log_usage[] = {
 static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 			       int argc, char **argv)
 {
-	struct btrfs_root *root;
-	struct btrfs_trans_handle *trans;
-	struct btrfs_super_block *sb;
 	char *devname;
+	u8 buf[BTRFS_SUPER_INFO_SIZE];
+	u8 result[BTRFS_CSUM_SIZE];
+	struct btrfs_super_block *sb = (struct btrfs_super_block *)buf;
+	int fd;
 	int ret;
 
 	clean_args_no_options(cmd, argc, argv);
@@ -187,24 +191,44 @@ static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	root = open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL);
-	if (!root) {
-		error("could not open ctree");
-		return 1;
+	fd = open(devname, O_RDWR);
+	if (fd < 0) {
+		ret = -errno;
+		error("failed to open '%s': %m", devname);
+		goto out;
+	}
+	/*
+	 * Log tree only exists in the primary super block, so SBREAD_DEFAULT
+	 * is enough.
+	 */
+	ret = btrfs_read_dev_super(fd, sb, BTRFS_SUPER_INFO_OFFSET,
+				   SBREAD_DEFAULT);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to read super block on '%s': %m", devname);
+		goto close_fd;
 	}
 
-	sb = root->fs_info->super_copy;
 	printf("Clearing log on %s, previous log_root %llu, level %u\n",
 			devname,
 			(unsigned long long)btrfs_super_log_root(sb),
 			(unsigned)btrfs_super_log_root_level(sb));
-	trans = btrfs_start_transaction(root, 1);
-	BUG_ON(IS_ERR(trans));
 	btrfs_set_super_log_root(sb, 0);
 	btrfs_set_super_log_root_level(sb, 0);
-	btrfs_commit_transaction(trans, root);
-	close_ctree(root);
+	btrfs_csum_data(btrfs_super_csum_type(sb), (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+	memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
+	ret = pwrite64(fd, sb, BTRFS_SUPER_INFO_SIZE, BTRFS_SUPER_INFO_OFFSET);
+	if (ret != BTRFS_SUPER_INFO_SIZE) {
+		ret = -EIO;
+		errno = -ret;
+		error("failed to write super block for '%s': %m", devname);
+	} else {
+		ret = 0;
+	}
 
+close_fd:
+	close(fd);
 out:
 	return !!ret;
 }
-- 
2.23.0

