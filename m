Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453CD437965
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhJVO40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 10:56:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhJVO4Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 10:56:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4629E1FD3D;
        Fri, 22 Oct 2021 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634914447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=z6cfbHy+IqENGMXQBXINpDPwt1EoBPVFc9W8p+udLZU=;
        b=sVSSgZyEx73qLX7B2kyiGgpfZbQXPTJ6pp0tiuCJCPU6mqW3UrOaIyfIxvP+WnhuUIVRxV
        yhhOx+KxFZqCTV03qk0NndEVm2UEx6XnDRX6uJASfOyOJIftgaHiyZtKsz+4RkFcQSNAkW
        qARKoPwuS4YSVJch0QHSobp8vG156Cg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3FACDA3B87;
        Fri, 22 Oct 2021 14:54:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05F79DA7A9; Fri, 22 Oct 2021 16:53:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com, nborisov@suse.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: send: prepare for v2 protocol
Date:   Fri, 22 Oct 2021 16:53:36 +0200
Message-Id: <20211022145336.29711-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the infrastructure part only, without any new updates, thus safe
to be applied now and all other changes built on top of it, unless there
are further comments.

---

This is preparatory work for send protocol update to version 2 and
higher.

We have many pending protocol update requests but still don't have the
basic protocol rev in place, the first thing that must happen is to do
the actual versioning support.

The protocol version is u32 and is a new member in the send ioctl
struct. Validity of the version field is backed by a new flag bit. Old
kernels would fail when a higher version is requested. Version protocol
0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
that's also exported in sysfs.

The version is still unchanged and will be increased once we have new
incompatible commands or stream updates.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c            | 22 ++++++++++++++++++++++
 fs/btrfs/send.h            |  7 +++++++
 include/uapi/linux/btrfs.h | 12 ++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index afdcbe7844e0..28a26980245d 100644
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
@@ -7269,6 +7280,17 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
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
index de91488b7cd0..23bcefc84e49 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -48,6 +48,7 @@ struct btrfs_tlv_header {
 enum btrfs_send_cmd {
 	BTRFS_SEND_C_UNSPEC,
 
+	/* Version 1 */
 	BTRFS_SEND_C_SUBVOL,
 	BTRFS_SEND_C_SNAPSHOT,
 
@@ -76,6 +77,12 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+	__BTRFS_SEND_C_MAX_V1,
+
+	/* Version 2 */
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

