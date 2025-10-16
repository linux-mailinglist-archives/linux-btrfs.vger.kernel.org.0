Return-Path: <linux-btrfs+bounces-17873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D396FBE2099
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B023B0AD9
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 07:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DB2FB989;
	Thu, 16 Oct 2025 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="EX4J+kuo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46A2D6E72
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601244; cv=none; b=JwMpn2x5N+7DpR0SL0XJ6qDPGwTtDTRv2MclLahcQXxGpOsNmEK527+ZG1W6cL+H/565AvrEX8giNl/4596HnFDSjV1O+WDTgRT1ggr6sr9y7baDBwRC/e3c6ekHObp9SRTU6Y3UcmO85Y1GVJp67nLn+g3xAyG7XSQYizy2jPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601244; c=relaxed/simple;
	bh=H7Gt9u/cz6JjpXigPoFV4Nw8pcJ6kPk/hPJ5nz0T3Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZCqQ9topB1ysQjvHQQEIw3GkKfqKZm90IUtBrKdL2KOyht03uVfY7JStOuOi46dFXVYClxOXEvTTJLuIBILybY4QTE380IUg0syDje2gshniYC2AUG5uEq0mKRm/AtIVta2/oxlxSE4bttBFu+KojKV/0sET4Ub3S33UUC2JiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=EX4J+kuo; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from 10511-DT-003.. (unknown [10.17.46.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.synology.com (Postfix) with ESMTPSA id 4cnKw25LyHzDRrFW7;
	Thu, 16 Oct 2025 15:53:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1760601234; bh=H7Gt9u/cz6JjpXigPoFV4Nw8pcJ6kPk/hPJ5nz0T3Yo=;
	h=From:To:Cc:Subject:Date;
	b=EX4J+kuo5iKtblTMkMg6v7Te20ihYFAMl+V4dTpsxKYet8eWzZW35vwT/ayKm1XT/
	 4Q+rRph2l8D6gtJFZb5uMgiOHlI9NLutpA5RBNAbn9iPhhaRppVcvfAaDwnh/SoRpp
	 zvNAukkOWpqW7ySVBL13Cv2l2QuXkgVpyg4SY9A8=
From: tchou <tchou@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: Ting-Chang Hou <tchou@synology.com>
Subject: [PATCH] btrfs: send: don't send rmdir for same target multiple times with multi hardlink situation
Date: Thu, 16 Oct 2025 15:53:51 +0800
Message-Id: <20251016075351.3369720-1-tchou@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
Content-Type: text/plain

From: Ting-Chang Hou <tchou@synology.com>

In commit 29d6d30f5c8a("Btrfs: send, don't send rmdir for same target
multiple times") has fixed the issue that btrfs send rmdir for same
target multiple times by keep the last_dir_ino_rm and compare with
it before sending rmdir. But there have a corner case that if the
instructions that rm same dir not in a row, the fix will not work.

Hardlinks of file are store in the same INODE_REF item, and if the
number of hardlinks is too large and exceed the size of one metadata
node can store, it will use INODE_EXTREF to store. The key of
INODE_EXTREF is (inode_id, INODE_EXTREF, hash of name), so if there are
two dir have hardlinks to the same file, the INODE_EXTREF items will
have cross sequence with two dir like below:
    item 0 key (404 INODE_EXTREF 111512) itemoff 16239 itemsize 44
        inode extref index 4825 parent 403 namelen 4 name: 4824
        inode extref index 5825 parent 402 namelen 4 name: 5824
    item 1 key (404 INODE_EXTREF 398645) itemoff 16195 itemsize 44
        inode extref index 4569 parent 403 namelen 4 name: 4568
        inode extref index 5569 parent 402 namelen 4 name: 5568

So when doing btrfs send, the instructions that rmdir for the two dir
are not in a row, and the previous fix will not work.

We use rbtree to keep all the dirs that already add into `check_dirs`,
and compare with it before add a new dir into it.

The reproduce steps are as below:
    $ mkfs.btrfs -f /dev/sdb3
    $ mount /dev/sdb3 /mnt/
    $ mkdir /mnt/a /mnt/b
    $ echo 123 > /mnt/a/foo
    $ for i in $(seq 1 10000); do ln /mnt/a/foo /mnt/a/foo.$i; ln /mnt/a/foo /mnt/b/foo.$i; done
    $ btrfs subvolume snapshot -r /mnt/ /mnt/snap1
    $ btrfs send /mnt/snap1 -f /tmp/base.send
    $ rm -r /mnt/a /mnt/b
    $ btrfs subvolume snapshot -r /mnt/ /mnt/snap2
    $ btrfs send -p /mnt/snap1 /mnt/snap2 -f /tmp/incremental.send

    $ umount /mnt
    $ mkfs.btrfs -f /dev/sdb3
    $ mount /dev/sdb3 /mnt
    $ btrfs receive /mnt -f /tmp/base.send
    $ btrfs receive /mnt -f /tmp/incremental.send

The second btrfs receive command failed with:
    ERROR: rmdir o4205145-4190-0 failed: No such file or directory

Fixes: 29d6d30f5c8a("Btrfs: send, don't send rmdir for same target multiple times")
Signed-off-by: Ting-Chang Hou <tchou@synology.com>
---
 fs/btrfs/send.c | 56 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9230e5066fc6..c1b596e5f145 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4100,6 +4100,48 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 	return ret;
 }
 
+static int rbtree_check_dir_ref_comp(const void *k, const struct rb_node *node)
+{
+	const struct recorded_ref *data = k;
+	const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
+
+	if (data->dir > ref->dir)
+		return 1;
+	if (data->dir < ref->dir)
+		return -1;
+	if (data->dir_gen > ref->dir_gen)
+		return 1;
+	if (data->dir_gen < ref->dir_gen)
+		return -1;
+	return 0;
+}
+
+static bool rbtree_check_dir_ref_less(struct rb_node *node, const struct rb_node *parent)
+{
+	const struct recorded_ref *entry = rb_entry(node, struct recorded_ref, node);
+
+	return rbtree_check_dir_ref_comp(entry, parent) < 0;
+}
+
+static int record_check_dir_ref_in_tree(struct rb_root *root,
+			struct recorded_ref *ref, struct list_head *list)
+{
+	int ret = 0;
+	struct recorded_ref *tmp_ref = NULL;
+
+	if (rb_find(ref, root, rbtree_check_dir_ref_comp))
+		return 0;
+
+	ret = dup_ref(ref, list);
+	if (ret < 0)
+		return ret;
+
+	tmp_ref = list_last_entry(list, struct recorded_ref, list);
+	rb_add(&tmp_ref->node, root, rbtree_check_dir_ref_less);
+	tmp_ref->root = root;
+	return 0;
+}
+
 static int rename_current_inode(struct send_ctx *sctx,
 				struct fs_path *current_path,
 				struct fs_path *new_path)
@@ -4131,7 +4173,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	u64 ow_inode = 0;
 	u64 ow_gen;
 	u64 ow_mode;
-	u64 last_dir_ino_rm = 0;
+	struct rb_root rbtree_check_dirs = RB_ROOT;
 	bool did_overwrite = false;
 	bool is_orphan = false;
 	bool can_rename = true;
@@ -4435,7 +4477,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 					goto out;
 			}
 		}
-		ret = dup_ref(cur, &check_dirs);
+		ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 		if (ret < 0)
 			goto out;
 	}
@@ -4463,7 +4505,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		}
 
 		list_for_each_entry(cur, &sctx->deleted_refs, list) {
-			ret = dup_ref(cur, &check_dirs);
+			ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 			if (ret < 0)
 				goto out;
 		}
@@ -4473,7 +4515,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * We have a moved dir. Add the old parent to check_dirs
 		 */
 		cur = list_first_entry(&sctx->deleted_refs, struct recorded_ref, list);
-		ret = dup_ref(cur, &check_dirs);
+		ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 		if (ret < 0)
 			goto out;
 	} else if (!S_ISDIR(sctx->cur_inode_mode)) {
@@ -4507,7 +4549,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				if (is_current_inode_path(sctx, cur->full_path))
 					fs_path_reset(&sctx->cur_inode_path);
 			}
-			ret = dup_ref(cur, &check_dirs);
+			ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 			if (ret < 0)
 				goto out;
 		}
@@ -4550,8 +4592,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 			ret = cache_dir_utimes(sctx, cur->dir, cur->dir_gen);
 			if (ret < 0)
 				goto out;
-		} else if (ret == inode_state_did_delete &&
-			   cur->dir != last_dir_ino_rm) {
+		} else if (ret == inode_state_did_delete) {
 			ret = can_rmdir(sctx, cur->dir, cur->dir_gen);
 			if (ret < 0)
 				goto out;
@@ -4563,7 +4604,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				ret = send_rmdir(sctx, valid_path);
 				if (ret < 0)
 					goto out;
-				last_dir_ino_rm = cur->dir;
 			}
 		}
 	}
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

