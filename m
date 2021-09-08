Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F529403274
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 04:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbhIHCG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 22:06:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhIHCG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 22:06:56 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD0AF220D8
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 02:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631066748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NJrkX63sbMyknzW618QiVKO9glJMI/eam2Yj8n7hiE=;
        b=tKok/MdU5W+Y3yg4UR1i8ydAEKr8wdUOfCS/cRBpFBF/+ORjuFZTEir4FrNoeDkTom/Bbb
        owIsE2n6+pummuRcJ16HfKCEWPS8KWunjqxOsDSgg2D5zsfbZfYfaLTGTOYD5fRlTSePDz
        I8pVy6Occ842EG6xIYjO51bu3ydBaVg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0D37713721
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 02:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id uCrAL3saOGHDDgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 02:05:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: introduce OPEN_CTREE_ALLOW_TRANSID_MISMATCH flag
Date:   Wed,  8 Sep 2021 10:05:42 +0800
Message-Id: <20210908020543.54087-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908020543.54087-1-wqu@suse.com>
References: <20210908020543.54087-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a report that, btrfstune can even work while the fs has transid
mismatch problems.

  $ btrfstune -f -u /dev/sdb1
  Current fsid: b2b5ae8d-4c49-45f0-b42e-46fe7dcfcb07
  New fsid: b2b5ae8d-4c49-45f0-b42e-46fe7dcfcb07
  Set superblock flag CHANGING_FSID
  Change fsid in extents
  parent transid verify failed on 792854528 wanted 20103 found 20091
  parent transid verify failed on 792854528 wanted 20103 found 20091
  parent transid verify failed on 792854528 wanted 20103 found 20091
  Ignoring transid failure
  parent transid verify failed on 792870912 wanted 20103 found 20091
  parent transid verify failed on 792870912 wanted 20103 found 20091
  parent transid verify failed on 792870912 wanted 20103 found 20091
  Ignoring transid failure
  parent transid verify failed on 792887296 wanted 20103 found 20091
  parent transid verify failed on 792887296 wanted 20103 found 20091
  parent transid verify failed on 792887296 wanted 20103 found 20091
  Ignoring transid failure
  ERROR: child eb corrupted: parent bytenr=38010880 item=69 parent level=1 child level=1
  ERROR: failed to change UUID of metadata: -5
  ERROR: btrfstune failed

This leaves a corrupted fs even more corrupted, and due to the extra
CHANGING_FSID flag, btrfs check will not even try to run on it:

  Opening filesystem to check...
  ERROR: Filesystem UUID change in progress
  ERROR: cannot open file system

[CAUSE]
Unlike kernel, btrfs-progs has a less strict check on transid mismatch.

In read_tree_block() we will fall back to use the tree block even its
transid mismatch if we can't find any better copy.

However not all commands in btrfs-progs needs this feature, only
btrfs-check (which may fix the problem) and btrfs-restore (it just tries
to ignore any problems) really utilize this feature.

[FIX]
Introduce a new open ctree flag, OPEN_CTREE_ALLOW_TRANSID_MISMATCH, to
be explicit about whether we really want to ignore transid error.

Currently only btrfs-check and btrfs-restore will utilize this new flag.

Also add btrfs-image to allow opening such fs with transid error.

Link: https://www.reddit.com/r/btrfs/comments/pivpqk/failure_during_btrfstune_u/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c            |  3 ++-
 cmds/restore.c          |  3 ++-
 image/main.c            | 11 +++++++----
 kernel-shared/ctree.h   |  1 +
 kernel-shared/disk-io.c | 11 +++++++++--
 kernel-shared/disk-io.h |  6 ++++++
 6 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/check/main.c b/check/main.c
index 661c996a2cb1..970ad6a259b8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10384,7 +10384,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	int qgroup_report = 0;
 	int qgroups_repaired = 0;
 	int qgroup_verify_ret;
-	unsigned ctree_flags = OPEN_CTREE_EXCLUSIVE;
+	unsigned ctree_flags = OPEN_CTREE_EXCLUSIVE |
+			       OPEN_CTREE_ALLOW_TRANSID_MISMATCH;
 	int force = 0;
 
 	while(1) {
diff --git a/cmds/restore.c b/cmds/restore.c
index dd75508aabd6..8f71d6f8e11d 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1213,7 +1213,8 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 		ocf.filename = dev;
 		ocf.sb_bytenr = bytenr;
 		ocf.root_tree_bytenr = root_location;
-		ocf.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS;
+		ocf.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
+			    OPEN_CTREE_ALLOW_TRANSID_MISMATCH;
 		fs_info = open_ctree_fs_info(&ocf);
 		if (fs_info)
 			break;
diff --git a/image/main.c b/image/main.c
index 6595ca93cd69..b40e0e5550f8 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1004,7 +1004,7 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 	int ret;
 	int err = 0;
 
-	root = open_ctree(input, 0, 0);
+	root = open_ctree(input, 0, OPEN_CTREE_ALLOW_TRANSID_MISMATCH);
 	if (!root) {
 		error("open ctree failed");
 		return -EIO;
@@ -2781,7 +2781,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		struct open_ctree_flags ocf = { 0 };
 
 		ocf.filename = target;
-		ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE | OPEN_CTREE_PARTIAL;
+		ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
+			    OPEN_CTREE_PARTIAL;
 		info = open_ctree_fs_info(&ocf);
 		if (!info) {
 			error("open ctree failed");
@@ -2846,7 +2847,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		root = open_ctree_fd(fileno(out), target, 0,
 					  OPEN_CTREE_PARTIAL |
 					  OPEN_CTREE_WRITES |
-					  OPEN_CTREE_NO_DEVICES);
+					  OPEN_CTREE_NO_DEVICES |
+					  OPEN_CTREE_ALLOW_TRANSID_MISMATCH);
 		if (!root) {
 			error("open ctree failed in %s", target);
 			ret = -EIO;
@@ -2864,7 +2866,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		u64 dev_size;
 
 		if (!info) {
-			root = open_ctree_fd(fileno(out), target, 0, 0);
+			root = open_ctree_fd(fileno(out), target, 0,
+					     OPEN_CTREE_ALLOW_TRANSID_MISMATCH);
 			if (!root) {
 				error("open ctree failed in %s", target);
 				ret = -EIO;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index e79b1e4ced60..c0e86b708fe2 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1216,6 +1216,7 @@ struct btrfs_fs_info {
 	unsigned int avoid_sys_chunk_alloc:1;
 	unsigned int finalize_on_close:1;
 	unsigned int hide_names:1;
+	unsigned int allow_transid_mismatch:1;
 
 	int transaction_aborted;
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 0dc31c364317..1cda6f3a98af 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -421,7 +421,7 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 			ret = -EIO;
 			break;
 		}
-		if (num_copies == 1) {
+		if (num_copies == 1 && fs_info->allow_transid_mismatch) {
 			ignore = 1;
 			continue;
 		}
@@ -431,6 +431,10 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		}
 		mirror_num++;
 		if (mirror_num > num_copies) {
+			if (!fs_info->allow_transid_mismatch) {
+				ret = -EIO;
+				break;
+			}
 			if (candidate_mirror > 0)
 				mirror_num = candidate_mirror;
 			else
@@ -1231,6 +1235,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 		fs_info->ignore_chunk_tree_error = 1;
 	if (flags & OPEN_CTREE_HIDE_NAMES)
 		fs_info->hide_names = 1;
+	if (flags & OPEN_CTREE_ALLOW_TRANSID_MISMATCH)
+		fs_info->allow_transid_mismatch = 1;
 
 	if ((flags & OPEN_CTREE_RECOVER_SUPER)
 	     && (flags & OPEN_CTREE_TEMPORARY_SUPER)) {
@@ -1988,7 +1994,8 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
 		return ret;
 
 	ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
-				    parent_transid, 1);
+				    parent_transid,
+				    buf->fs_info->allow_transid_mismatch);
 	return !ret;
 }
 
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 603ff8a3f945..265b3e01297a 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -88,6 +88,12 @@ enum btrfs_open_ctree_flags {
 
 	/* For print-tree, print HIDDEN instead of filenames/xattrs/refs */
 	OPEN_CTREE_HIDE_NAMES = (1U << 14),
+
+	/*
+	 * Allow certain command like btrfs-check/btrfs-restore to ignore
+	 * transid mismatch.
+	 */
+	OPEN_CTREE_ALLOW_TRANSID_MISMATCH = (1U << 15),
 };
 
 /*
-- 
2.33.0

