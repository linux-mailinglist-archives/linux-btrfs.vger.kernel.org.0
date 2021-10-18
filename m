Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26759432014
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhJROnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 10:43:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58208 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhJROnz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 10:43:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4673F21A8A;
        Mon, 18 Oct 2021 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634568103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Nv6VDeLSeJjStL1NmvTOj3DGfzz5g7YR3ExUVqU9u/s=;
        b=U+p/nivCnXheGC7xz0C8K080fWgbkgT6JwsC4yCxaKZHGDgqcJZJHwTiFJ9AEirOOIyLfg
        g3zBmYlOWTDEUo43KI9JIuGEy8qMqzzZQw5st2gYtaMIoBzugAvBELrb6CMCYiDdqe4ABz
        CExiat2U5Ww3yJby84sVVQaYwjtkUzg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3EC9DA3B96;
        Mon, 18 Oct 2021 14:41:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49497DA7A3; Mon, 18 Oct 2021 16:41:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com, osandov@osandov.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH RFC] btrfs: send: v2 protocol and example OTIME changes
Date:   Mon, 18 Oct 2021 16:41:09 +0200
Message-Id: <20211018144109.18442-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is send protocol update to version 2 with example new commands.

We have many pending protocol update requests but still don't have the
basic protocol rev in place, the first thing that must happen is to do
the actual versioning support. In order to have something to test,
there's an extended and a new command, that should be otherwise harmless
and nobody should depend on it. This should be enough to validate the
non-protocol changes and backward compatibility before we do the big
protocol update.

The protocol version is u32 and is a new member in the send ioctl
struct. Validity of the version field is backed by a new flag bit. Old
kernels would fail when a higher version is requested. Version protocol
0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
that's also exported in sysfs.

Protocol changes:

- new command BTRFS_SEND_C_UTIMES2
- appends OTIME after the output of BTRFS_SEND_C_UTIMES
- this is an example how to extend an existing command based on protocol
  version

- new command BTRFS_SEND_C_OTIME
- path BTRFS_SEND_A_PATH
- timespec attribute BTRFS_SEND_A_OTIME
- it's a separate command so it does not bloat any UTIMES2 commands,
  and is emitted only after inode creation (file, dir, special files).

The patch should be a template for further protocol extensions

RFC:

- set __BTRFS_SEND_C_MAX_V1 to the last command of the version or one
  beyond?
- drop UTIMES2 before release?
- naming?

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c            | 73 ++++++++++++++++++++++++++++++++++++--
 fs/btrfs/send.h            | 11 +++++-
 include/uapi/linux/btrfs.h | 12 +++++--
 3 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index afdcbe7844e0..ca9eba5f2de3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -84,6 +84,8 @@ struct send_ctx {
 	u64 total_send_size;
 	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
+	/* Protocol version compatibility requested */
+	u32 proto;
 
 	struct btrfs_root *send_root;
 	struct btrfs_root *parent_root;
@@ -312,6 +314,15 @@ static void inconsistent_snapshot_error(struct send_ctx *sctx,
 		   sctx->parent_root->root_key.objectid : 0));
 }
 
+static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
+{
+	switch (sctx->proto) {
+	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
+	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
+	default: return false;
+	}
+}
+
 static int is_waiting_for_move(struct send_ctx *sctx, u64 ino);
 
 static struct waiting_dir_move *
@@ -2507,6 +2518,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	struct extent_buffer *eb;
 	struct btrfs_key key;
 	int slot;
+	int cmd;
 
 	btrfs_debug(fs_info, "send_utimes %llu", ino);
 
@@ -2533,7 +2545,12 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	slot = path->slots[0];
 	ii = btrfs_item_ptr(eb, slot, struct btrfs_inode_item);
 
-	ret = begin_cmd(sctx, BTRFS_SEND_C_UTIMES);
+	if (proto_cmd_ok(sctx, BTRFS_SEND_C_UTIMES2))
+		cmd = BTRFS_SEND_C_UTIMES2;
+	else
+		cmd = BTRFS_SEND_C_UTIMES;
+
+	ret = begin_cmd(sctx, cmd);
 	if (ret < 0)
 		goto out;
 
@@ -2544,7 +2561,8 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_CTIME, eb, &ii->ctime);
-	/* TODO Add otime support when the otime patches get into upstream */
+	if (proto_cmd_ok(sctx, BTRFS_SEND_C_UTIMES2))
+		TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, eb, &ii->otime);
 
 	ret = send_cmd(sctx);
 
@@ -2555,6 +2573,43 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	return ret;
 }
 
+static int send_inode_otime(struct send_ctx *sctx, const struct fs_path *fsp, u64 ino)
+{
+	int ret;
+	struct btrfs_path *path;
+	struct btrfs_inode_item *ii;
+	struct btrfs_key key;
+
+	if (!proto_cmd_ok(sctx, BTRFS_SEND_C_OTIME))
+		return 0;
+
+	path = alloc_path_for_send();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(NULL, sctx->send_root, &key, path, 0, 0);
+	if (ret) {
+		if (ret > 0)
+			ret = -ENOENT;
+		goto out;
+	}
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_OTIME);
+	ii = btrfs_item_ptr(path->nodes[0], path->slots[0], struct btrfs_inode_item);
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, fsp);
+	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, path->nodes[0], &ii->otime);
+	ret = send_cmd(sctx);
+
+tlv_put_failure:
+out:
+	btrfs_free_path(path);
+
+	return ret;
+}
+
 /*
  * Sends a BTRFS_SEND_C_MKXXX or SYMLINK command to user space. We don't have
  * a valid path yet because we did not process the refs yet. So, the inode
@@ -2633,6 +2688,9 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 	if (ret < 0)
 		goto out;
 
+	ret = send_inode_otime(sctx, p, ino);
+	if (ret < 0)
+		goto out;
 
 tlv_put_failure:
 out:
@@ -7269,6 +7327,17 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	sctx->flags = arg->flags;
 
+	if (arg->flags & BTRFS_SEND_FLAG_VERSION) {
+		if (arg->version > BTRFS_SEND_STREAM_VERSION) {
+			ret = -EPROTO;
+			goto out;
+		}
+		/* Zero means "use the highest version" */
+		sctx->proto = arg->version ?: BTRFS_SEND_STREAM_VERSION;
+	} else {
+		sctx->proto = 1;
+	}
+
 	sctx->send_filp = fget(arg->send_fd);
 	if (!sctx->send_filp) {
 		ret = -EBADF;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index de91488b7cd0..eeafbe2fdd9f 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -10,7 +10,7 @@
 #include "ctree.h"
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 #define BTRFS_SEND_BUF_SIZE SZ_64K
 
@@ -48,6 +48,7 @@ struct btrfs_tlv_header {
 enum btrfs_send_cmd {
 	BTRFS_SEND_C_UNSPEC,
 
+	/* Version 1 */
 	BTRFS_SEND_C_SUBVOL,
 	BTRFS_SEND_C_SNAPSHOT,
 
@@ -76,6 +77,14 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+	__BTRFS_SEND_C_MAX_V1,
+
+	/* Version 2 */
+	BTRFS_SEND_C_UTIMES2,
+	BTRFS_SEND_C_OTIME,
+	__BTRFS_SEND_C_MAX_V2,
+
+	/* End */
 	__BTRFS_SEND_C_MAX,
 };
 #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d7d3cfead056..c1a665d87f61 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -771,10 +771,16 @@ struct btrfs_ioctl_received_subvol_args {
  */
 #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
 
+/*
+ * Read the protocol version in the structure
+ */
+#define BTRFS_SEND_FLAG_VERSION			0x8
+
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_VERSION)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
@@ -782,7 +788,9 @@ struct btrfs_ioctl_send_args {
 	__u64 __user *clone_sources;	/* in */
 	__u64 parent_root;		/* in */
 	__u64 flags;			/* in */
-	__u64 reserved[4];		/* in */
+	__u32 version;			/* in */
+	__u32 reserved32;
+	__u64 reserved[3];		/* in */
 };
 
 /*
-- 
2.33.0

