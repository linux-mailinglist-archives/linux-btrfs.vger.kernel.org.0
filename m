Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C11C9BE2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGUPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:15:07 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.175]:42725 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbgEGUPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:15:06 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 8424F400D1604
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 15:15:05 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id WmvBjc0nyXVkQWmvBjjuQk; Thu, 07 May 2020 15:15:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2gez+DGfLVmgeyVjnLwwcC9WMg44RTqvPEng9DKGnhg=; b=gFtMme1oOL2xMMFk25AEWyAKK4
        pjN8mmGOWoBKCLdoPpG0KBZa/7upu2+pW0OI7fsWHOLa+QeqQ5Bip6NNz7etwX2QTbrnlwf/70TVf
        Da8UBs3SjXsA7RtoTvaD3Y/M/atXu3kQZkiqnVdZr4FCE63I09/GLuwtwHDGIaSqY9l07r6BwhVz4
        KzQWK311EKQGL48efHH4fl6pkWgu//wxKyRMgi9+rqJxDMUmGS8VCALI4PdzFnsZpR3VIKgRDvRu2
        OIMFFxNMR1eKxJM5XZ6i3Hxj5uVzgBLoXSA0jeKnUFmBu1i7RGAwXAOchXKvXIWlN2E4KFkeJ2wgJ
        Yg6lVlJQ==;
Received: from [186.212.88.45] (port=41550 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jWmvA-003P4B-Rv; Thu, 07 May 2020 17:15:05 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com,
        fdmanana@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v1] btrfs: send: Emit file capabilities after chown
Date:   Thu,  7 May 2020 17:18:04 -0300
Message-Id: <20200507201804.1623-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 186.212.88.45
X-Source-L: No
X-Exim-ID: 1jWmvA-003P4B-Rv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [186.212.88.45]:41550
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

[PROBLEM]
Whenever a chown is executed, all capabilities of the file being touched are
lost.  When doing incremental send with a file with capabilities, there is a
situation where the capability can be lost in the receiving side. The
sequence of actions bellow shows the problem:

$ mount /dev/sda fs1
$ mount /dev/sdb fs2

$ touch fs1/foo.bar
$ setcap cap_sys_nice+ep fs1/foo.bar
$ btrfs subvol snap -r fs1 fs1/snap_init
$ btrfs send fs1/snap_init | btrfs receive fs2

$ chgrp adm fs1/foo.bar
$ setcap cap_sys_nice+ep fs1/foo.bar

$ btrfs subvol snap -r fs1 fs1/snap_complete
$ btrfs subvol snap -r fs1 fs1/snap_incremental

$ btrfs send fs1/snap_complete | btrfs receive fs2
$ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2

At this point, only a chown was emitted by "btrfs send" since only the group
was changed. This makes the cap_sys_nice capability to be dropped from
fs2/snap_incremental/foo.bar

[FIX]
Only emit capabilities after chown is emitted. The current code
first checks for xattrs that are new/changed, emits them, and later emit
the chown. Now, __process_new_xattr skips capabilities, letting only
finish_inode_if_needed to emit them, if they exist, for the inode being
processed.

Also, this patch also fixes a longstanding problem that was issuing an xattr
_before_ chown. This behavior was being worked around in "btrfs receive"
side by caching the capability and only applying it after chown. Now,
xattrs are only emmited _after_ chown, making that hack not needed
anymore.

Link: https://github.com/kdave/btrfs-progs/issues/202
Suggested-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 The first version of the patch was an RFC

 Changes from RFC:
 * Explained about chown + drop capabilities problem in the commit message (suggested
   by Filipe and David)
 * Changed the commit message to show describe the fix (suggested by Filipe)
 * Skip the xattr in __process_new_xattr if it's a capability, since it'll be
   handled in finish_inode_if_needed now (suggested by Filipe).
 * Created function send_capabilities to query if the inode has caps, and if
   yes, emit them.
 * Call send_capabilities in finish_inode_if_needed _after_ the needs_chown
   check. (suggested by Filipe)

 fs/btrfs/send.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6b86841315be..4f19965bdd82 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -23,6 +23,7 @@
 #include "btrfs_inode.h"
 #include "transaction.h"
 #include "compression.h"
+#include "xattr.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
@@ -4545,6 +4546,10 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 	struct fs_path *p;
 	struct posix_acl_xattr_header dummy_acl;
 
+	/* capabilities are emitted by finish_inode_if_needed */
+	if (!strncmp(name, XATTR_NAME_CAPS, name_len))
+		return 0;
+
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -5107,6 +5112,66 @@ static int send_extent_data(struct send_ctx *sctx,
 	return 0;
 }
 
+/*
+ * Search for a capability xattr related to sctx->cur_ino. If the capability if
+ * found, call send_set_xattr function to emit it.
+ *
+ * Return %0 if there isn't a capability, or when the capability was emitted
+ * successfully, or < %0 if an error occurred.
+ */
+static int send_capabilities(struct send_ctx *sctx)
+{
+	struct fs_path *fspath = NULL;
+	struct btrfs_path *path;
+	struct btrfs_dir_item *di;
+	struct extent_buffer *leaf;
+	unsigned long data_ptr;
+	char *name = XATTR_NAME_CAPS;
+	char *buf = NULL;
+	int buf_len;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	di = btrfs_lookup_xattr(NULL, sctx->send_root, path, sctx->cur_ino,
+				name, strlen(name), 0);
+	if (!di) {
+		/* there is no xattr for this inode */
+		goto out;
+	} else if (IS_ERR(di)) {
+		ret = PTR_ERR(di);
+		goto out;
+	}
+
+	leaf = path->nodes[0];
+	buf_len = btrfs_dir_data_len(leaf, di);
+
+	fspath = fs_path_alloc();
+	buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!fspath || !buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
+	if (ret < 0)
+		goto out;
+
+	data_ptr = (unsigned long)((char *)(di + 1) +
+				   btrfs_dir_name_len(leaf, di));
+	read_extent_buffer(leaf, buf, data_ptr,
+			   btrfs_dir_data_len(leaf, di));
+
+	ret = send_set_xattr(sctx, fspath, name, strlen(name), buf, buf_len);
+out:
+	kfree(buf);
+	fs_path_free(fspath);
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int clone_range(struct send_ctx *sctx,
 		       struct clone_root *clone_root,
 		       const u64 disk_byte,
@@ -6010,6 +6075,10 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 			goto out;
 	}
 
+	ret = send_capabilities(sctx);
+	if (ret < 0)
+		goto out;
+
 	/*
 	 * If other directory inodes depended on our current directory
 	 * inode's move/rename, now do their move/rename operations.
-- 
2.25.1

