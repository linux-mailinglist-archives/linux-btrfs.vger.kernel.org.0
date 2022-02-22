Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4F4BF2D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 08:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiBVHmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 02:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiBVHlz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 02:41:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7F129BB4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 23:41:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 318C91F397
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645515689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jl4QTQh6LeYZkX42DJp3zj6tMbUWnBvR8+O+/hgY8nw=;
        b=Qc94BhnKG/UBh87gyc2j3ePc+fOOSt6cDue5OgU832RQCThQcivcvtMvkWN3wpjo3GRyx+
        tZhIqNXvO38mF20y4+c2nQzDxXKyABnWJcxeCGzTIzEQw62DK69hhp3M6bbsVMUPPeJoeh
        q97ozU4VC6Zn5vtjdl0TrEInzH7WL2o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 714C813BA7
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iLJTDaiTFGJxKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: check extent buffer owner against the owner rootid
Date:   Tue, 22 Feb 2022 15:41:21 +0800
Message-Id: <1040e11d4075c8e61158126c5ddc2ee803a86143.1645515599.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645515599.git.wqu@suse.com>
References: <cover.1645515599.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs doesn't really check whether the tree block really respects the
root owner.

This means, if a tree block referred by a parent in extent tree, but has
owner of 5, btrfs can still continue reading the tree block, as long as
it doesn't trigger other sanity checks.

Normally this is fine, but combined with the empty tree check in
check_leaf(), if we hit an empty extent tree, but the root node has
csum tree owner, we can let such extent buffer to sneak in.

Shrink the hole by:

- Do extra eb owner check at tree read time

- Make sure the root owner extent buffer exactly match the root id.

Unfortunately we can't yet completely patch the hole, there are several
call sites can't pass all info we need:

- For reloc/log trees
  Their owner is key::offset, not key::objectid.
  We need the full root key to do that accurate check.

  For now, we just skip the ownership check for those trees.

- For add_data_references() of relocation
  That call site doesn't have any parent/ownership info, as all the
  bytenrs are all from btrfs_find_all_leafs().

  Thankfully, btrfs_find_all_leafs() still do the ownership check,
  and even for the read_tree_block() caller inside
  add_data_references(), we know that all tree blocks there are
  subvolume tree blocks.
  Just manually convert root_owner 0 to FS_TREE to continue the check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c        |  6 +++++
 fs/btrfs/disk-io.c      | 21 +++++++++++++++
 fs/btrfs/tree-checker.c | 57 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.h |  1 +
 4 files changed, 85 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0eecf98d0abb..d904fe0973bd 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -16,6 +16,7 @@
 #include "volumes.h"
 #include "qgroup.h"
 #include "tree-mod-log.h"
+#include "tree-checker.h"
 
 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_path *path, int level);
@@ -1443,6 +1444,11 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			btrfs_release_path(p);
 			return -EIO;
 		}
+		if (btrfs_check_eb_owner(tmp, root->root_key.objectid)) {
+			free_extent_buffer(tmp);
+			btrfs_release_path(p);
+			return -EUCLEAN;
+		}
 		*eb_ret = tmp;
 		return 0;
 	}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8165ee3ae8a5..018a230efca5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1109,6 +1109,10 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		free_extent_buffer_stale(buf);
 		return ERR_PTR(ret);
 	}
+	if (btrfs_check_eb_owner(buf, owner_root)) {
+		free_extent_buffer_stale(buf);
+		return ERR_PTR(-EUCLEAN);
+	}
 	return buf;
 
 }
@@ -1548,6 +1552,23 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 		ret = -EIO;
 		goto fail;
 	}
+
+	/*
+	 * For real fs, and not log/reloc trees, root owner must
+	 * match its root node owner
+	 */
+	if (!test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state) &&
+	    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
+	    root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
+	    root->root_key.objectid != btrfs_header_owner(root->node)) {
+		btrfs_crit(fs_info,
+"root=%llu block=%llu, tree root owner mismatch, have %llu expect %llu",
+			   root->root_key.objectid, root->node->start,
+			   btrfs_header_owner(root->node),
+			   root->root_key.objectid);
+		ret = -EUCLEAN;
+		goto fail;
+	}
 	root->commit_root = btrfs_root_node(root);
 	return root;
 fail:
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 2c1072923590..f50bde52f466 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1855,3 +1855,60 @@ int btrfs_check_node(struct extent_buffer *node)
 	return ret;
 }
 ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);
+
+int btrfs_check_eb_owner(struct extent_buffer *eb, u64 root_owner)
+{
+	bool is_subvol = is_fstree(root_owner);
+	const u64 eb_owner = btrfs_header_owner(eb);
+
+	/*
+	 * Skip dummy fs, as selftest doesn't bother to create unique ebs for
+	 * each dummy root.
+	 */
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &eb->fs_info->fs_state))
+		return 0;
+
+	/*
+	 * Those trees uses key.offset as their owner, our callers don't
+	 * have the extra capacity to pass key.offset here.
+	 * So we just skip those trees.
+	 */
+	if (root_owner == BTRFS_TREE_LOG_OBJECTID ||
+	    root_owner == BTRFS_TREE_RELOC_OBJECTID)
+		return 0;
+
+	/*
+	 * This happens for add_data_references() of balance, at that call site
+	 * we don't have owner info.
+	 * But we know all tree blocks there are subvolume tree blocks.
+	 */
+	if (root_owner == 0)
+		is_subvol = true;
+
+	if (!is_subvol) {
+		/* For non-subvolume trees, the eb owner should match root owner */
+		if (root_owner != eb_owner) {
+			btrfs_crit(eb->fs_info,
+"corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect %llu",
+				btrfs_header_level(eb) == 0 ? "leaf" : "node",
+				root_owner, btrfs_header_bytenr(eb), eb_owner,
+				root_owner);
+			return -EUCLEAN;
+		}
+		return 0;
+	}
+
+	/*
+	 * For subvolume trees, owner can mismatch, but they should all belong
+	 * to subvolume trees.
+	 */
+	if (is_subvol != is_fstree(eb_owner)) {
+		btrfs_crit(eb->fs_info,
+"corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect [%llu, %llu]",
+			btrfs_header_level(eb) == 0 ? "leaf" : "node",
+			root_owner, btrfs_header_bytenr(eb), eb_owner,
+			BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	return 0;
+}
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 32fecc9dc1dd..c48719485687 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -25,5 +25,6 @@ int btrfs_check_node(struct extent_buffer *node);
 
 int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 			    struct btrfs_chunk *chunk, u64 logical);
+int btrfs_check_eb_owner(struct extent_buffer *eb, u64 root_owner);
 
 #endif
-- 
2.35.1

