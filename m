Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB983EA063
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhHLIQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 04:16:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhHLIQO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 04:16:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98D421FF1E;
        Thu, 12 Aug 2021 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628756148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=yieD9y7B7O6dnKL7Ylwg70/upI9jb4A3eR9SJJl42v4=;
        b=SdDktgNNpSYmwmmMkM5he/AE3EZmYWmN9EzIvI29UZVJGOGBZm4WV7b+c8uFAEq0o6+hXa
        380IidApd0a671VnQOCfbfXFgsjxh2pAEEQBeiWc2VxviCAK0KcQFqAe1rqpkRX48BoMdl
        3dUjBPlWjPGTWCXhuKdSzK7w43L0LKs=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6B95413846;
        Thu, 12 Aug 2021 08:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id afa7F7TYFGFyCAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 12 Aug 2021 08:15:48 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Replace OPEN_CTREE_NO_BLOCK_GROUPS with OPEN_CTREE_PARTIAL
Date:   Thu, 12 Aug 2021 11:15:46 +0300
Message-Id: <20210812081546.20724-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When OPEN_CTREE_PARTIAL is used errors in loading the extent/csum/log
trees are turned into non-fatal ones and those roots are initialized
with dummy root nodes, which don't have uptodate flag set on the
respective extent buffer. On the other hand reading block groups during
mount is predicated on OPEN_CTREE_NO_BLOCK_GROUPS being unset and
the extent tree's root extent buffer to have the uptodate flag set to
true. Furthermore, OPEN_CTREE_NO_BLOCK_GROUP is used when there is a
high chance the filesystem being opened can be damaged, similarly to
OPEN_CTREE_PARTIAL.

Considering this logic, it's not possible to load block groups when both
OPEN_CTREE_NO_BLOCK_GROUPS and OPEN_CTREE_PARTIAL are passed and the
extent tree is corrupted. This allows to eliminate
OPEN_CTREE_NO_BLOCK_GROUPS and replace its usage with
OPEN_CTREE_PARTIAL, since it's sufficient to check only for the extent
tree's extent buffer's uptodate state, which is controlled by
OPEN_CTREE_PARTIAL.
---
 check/main.c             | 2 +-
 cmds/inspect-dump-tree.c | 2 +-
 cmds/rescue.c            | 4 ++--
 cmds/restore.c           | 2 +-
 kernel-shared/disk-io.c  | 2 +-
 kernel-shared/disk-io.h  | 7 ++++---
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/check/main.c b/check/main.c
index a88518159830..84dd96fc167a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10342,7 +10342,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			case GETOPT_VAL_INIT_EXTENT:
 				init_extent_tree = 1;
 				ctree_flags |= (OPEN_CTREE_WRITES |
-						OPEN_CTREE_NO_BLOCK_GROUPS);
+						OPEN_CTREE_PARTIAL);
 				repair = 1;
 				break;
 			case GETOPT_VAL_CHECK_CSUM:
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index e1c90be7e81f..fca79cd11599 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -330,7 +330,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	 * to inspect fs with corrupted extent tree blocks, and show as many good
 	 * tree blocks as possible.
 	 */
-	open_ctree_flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS;
+	open_ctree_flags = OPEN_CTREE_PARTIAL;
 	cache_tree_init(&block_root);
 	optind = 0;
 	while (1) {
diff --git a/cmds/rescue.c b/cmds/rescue.c
index a98b255ad328..7ebe9b6c1e54 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -194,8 +194,8 @@ static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	root = open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL |
-			  OPEN_CTREE_NO_BLOCK_GROUPS);
+	root = open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL);
+
 	if (!root) {
 		error("could not open ctree");
 		return 1;
diff --git a/cmds/restore.c b/cmds/restore.c
index 39fcc69d8e19..f30d8b7532c0 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1214,7 +1214,7 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 		ocf.filename = dev;
 		ocf.sb_bytenr = bytenr;
 		ocf.root_tree_bytenr = root_location;
-		ocf.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS;
+		ocf.flags = OPEN_CTREE_PARTIAL;
 		fs_info = open_ctree_fs_info(&ocf);
 		if (fs_info)
 			break;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 84990a521178..cc635152c46d 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1045,7 +1045,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	fs_info->generation = generation;
 	fs_info->last_trans_committed = generation;
 	if (extent_buffer_uptodate(fs_info->extent_root->node) &&
-	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
+	    !(flags & OPEN_CTREE_PARTIAL)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
 		 * If we don't find any blockgroups (ENOENT) we're either
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 603ff8a3f945..16e13e4f5524 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -32,7 +32,10 @@
 enum btrfs_open_ctree_flags {
 	/* Open filesystem for writes */
 	OPEN_CTREE_WRITES		= (1U << 0),
-	/* Allow to open filesystem with some broken tree roots (eg log root) */
+	/*
+	 * Allow to open filesystem with some broken tree roots
+	 * (eg log root/csum/extent tree)
+	 */
 	OPEN_CTREE_PARTIAL		= (1U << 1),
 	/* If primary root pinters are invalid, try backup copies */
 	OPEN_CTREE_BACKUP_ROOT		= (1U << 2),
@@ -40,8 +43,6 @@ enum btrfs_open_ctree_flags {
 	OPEN_CTREE_RECOVER_SUPER	= (1U << 3),
 	/* Restoring filesystem image */
 	OPEN_CTREE_RESTORE		= (1U << 4),
-	/* Do not read block groups (extent tree) */
-	OPEN_CTREE_NO_BLOCK_GROUPS	= (1U << 5),
 	/* Open all devices in O_EXCL mode */
 	OPEN_CTREE_EXCLUSIVE		= (1U << 6),
 	/* Do not scan devices */
-- 
2.17.1

