Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0144D306
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 09:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhKKIRw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 03:17:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56940 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhKKIRm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 03:17:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B2B121B33;
        Thu, 11 Nov 2021 08:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636618491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=54aGChwXqpd/691EAaA9gfl5L591hO5BJGvwGqM6ju4=;
        b=ucQ9TPKWZ9r+xunPwLIMBwpMwAUdONEw2oE7KLH9/B8Tx8YZbU4T0gMlYKTTiUkAFwxAcO
        7hMKPsUUTxMcLGWDCqU0cfmab6846sFqsTde0mXnvhOA3BfKHquYabmgvKVQih+sZWGjW7
        QllEcGtX5r4zoySeXxHOJA30dN8IN6U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7721D13D51;
        Thu, 11 Nov 2021 08:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ju9hEPrQjGENQwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 11 Nov 2021 08:14:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     "S ." <sb56637@gmail.com>
Subject: [PATCH v2] btrfs-progs: rescue: introduce clear-uuid-tree
Date:   Thu, 11 Nov 2021 16:14:33 +0800
Message-Id: <20211111081433.95253-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that a corrupted key type (expected
UUID_KEY_SUBVOL, has EXTENT_ITEM) causing newer kernel to reject a
mount.

Although the root cause is not determined yet, with roll out of v5.11
kernel to various distros, such problem should be prevented by
tree-checker, no matter if it's hardware problem or not.

And older kernel with "-o uuid_rescan" mount option won't help, as
uuid_rescan will only delete items with
UUID_KEY_SUBVOL/UUID_KEY_RECEIVED_SUBVOL key types, not deleting such
corrupted key.

[FIX]
To fix such problem we have to rely on offline tool, thus there we
introduce a new rescue tool, clear-uuid-tree, to empty and then remove
uuid tree.

Kernel will re-generate the correct uuid tree at next mount.

Reported-by: S. <sb56637@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add proper man page entry
---
 Documentation/btrfs-rescue.asciidoc |   7 ++
 Documentation/btrfs-rescue.rst      |   9 +++
 cmds/rescue.c                       | 104 ++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/Documentation/btrfs-rescue.asciidoc b/Documentation/btrfs-rescue.asciidoc
index af5443722b5e..d38797c97fbb 100644
--- a/Documentation/btrfs-rescue.asciidoc
+++ b/Documentation/btrfs-rescue.asciidoc
@@ -50,6 +50,13 @@ The mismatch may also exhibit as a kernel warning:
 WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559 btrfs_update_device+0x1c5/0x1d0 [btrfs]
 ----
 
+*clear-uuid-tree* <device>::
+Clear uuid tree, so that kernel can re-generate it at next read-write mount.
++
+Since kernel v4.16, btrfs has more and more sanity check, and sometimes
+non-critical trees like uuid tree can cause problem and reject the mount.
+In such case, clearing uuid tree may make the filesystem to be mountable again.
+
 *super-recover* [options] <device>::
 Recover bad superblocks from good copies.
 +
diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
index f3e73f199dd8..787136aab51a 100644
--- a/Documentation/btrfs-rescue.rst
+++ b/Documentation/btrfs-rescue.rst
@@ -50,6 +50,15 @@ fix-device-size <device>
 
                 WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559 btrfs_update_device+0x1c5/0x1d0 [btrfs]
 
+clear-uuid-tree <device>
+        Clear uuid tree, so that kernel can re-generate it at next read-write
+        mount.
+
+        Since kernel v4.16, btrfs has more and more sanity check, and sometimes
+        non-critical trees like uuid tree can cause problem and reject the mount.
+        In such case, clearing uuid tree may make the filesystem to be mountable
+        again.
+
 super-recover [options] <device>
         Recover bad superblocks from good copies.
 
diff --git a/cmds/rescue.c b/cmds/rescue.c
index a98b255ad328..8b5b619da4f6 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -296,6 +296,109 @@ static int cmd_rescue_create_control_device(const struct cmd_struct *cmd,
 }
 static DEFINE_SIMPLE_COMMAND(rescue_create_control_device, "create-control-device");
 
+static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *uuid_root = fs_info->uuid_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = {};
+	struct btrfs_key key = {};
+	int ret;
+
+	if (!uuid_root)
+		return 0;
+
+	fs_info->uuid_root = NULL;
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	while (1) {
+		int nr;
+
+		ret = btrfs_search_slot(trans, uuid_root, &key, &path, -1, 1);
+		if (ret < 0)
+			goto out;
+		ASSERT(ret > 0);
+		ASSERT(path.slots[0] == 0);
+
+		nr = btrfs_header_nritems(path.nodes[0]);
+		if (nr == 0) {
+			btrfs_release_path(&path);
+			break;
+		}
+
+		ret = btrfs_del_items(trans, uuid_root, &path, 0, nr);
+		btrfs_release_path(&path);
+		if (ret < 0)
+			goto out;
+	}
+	ret = btrfs_del_root(trans, fs_info->tree_root, &uuid_root->root_key);
+	if (ret < 0)
+		goto out;
+	list_del(&uuid_root->dirty_list);
+	ret = clean_tree_block(uuid_root->node);
+	if (ret < 0)
+		goto out;
+	ret = btrfs_free_tree_block(trans, uuid_root, uuid_root->node, 0, 1);
+	if (ret < 0)
+		goto out;
+	free_extent_buffer(uuid_root->node);
+	free_extent_buffer(uuid_root->commit_root);
+	kfree(uuid_root);
+out:
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
+	else
+		ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	return ret;
+}
+
+static const char * const cmd_rescue_clear_uuid_tree_usage[] = {
+	"btrfs rescue clear-uuid-tree",
+	"Delete uuid tree so that kernel can rebuild it at mount time",
+	NULL,
+};
+
+static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
+				      int argc, char **argv)
+{
+	struct btrfs_fs_info *fs_info;
+	struct open_ctree_flags ocf = {};
+	char *devname;
+	int ret;
+
+	clean_args_no_options(cmd, argc, argv);
+	if (check_argc_exact(argc, 2))
+		return -EINVAL;
+
+	devname = argv[optind];
+	ret = check_mounted(devname);
+	if (ret < 0) {
+		errno = -ret;
+		error("could not check mount status: %m");
+		goto out;
+	} else if (ret) {
+		error("%s is currently mounted", devname);
+		ret = -EBUSY;
+		goto out;
+	}
+	ocf.filename = devname;
+	ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
+	fs_info = open_ctree_fs_info(&ocf);
+	if (!fs_info) {
+		error("could not open btrfs");
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = clear_uuid_tree(fs_info);
+	close_ctree(fs_info->tree_root);
+out:
+	return !!ret;
+}
+
+static DEFINE_SIMPLE_COMMAND(rescue_clear_uuid_tree, "clear-uuid-tree");
+
 static const char rescue_cmd_group_info[] =
 "toolbox for specific rescue operations";
 
@@ -306,6 +409,7 @@ static const struct cmd_group rescue_cmd_group = {
 		&cmd_struct_rescue_zero_log,
 		&cmd_struct_rescue_fix_device_size,
 		&cmd_struct_rescue_create_control_device,
+		&cmd_struct_rescue_clear_uuid_tree,
 		NULL
 	}
 };
-- 
2.33.1

