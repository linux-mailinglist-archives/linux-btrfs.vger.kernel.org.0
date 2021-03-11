Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B474A3375C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhCKOb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233906AbhCKOb3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CE1E64FD6;
        Thu, 11 Mar 2021 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473089;
        bh=qz1ZVBbatiRI2o/5VInRcVgXpTEjFJ8/El+flUY9fTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUSu8Mbo9x8+1mceh3fl22OMjKxhs6lAFYwhhVxqPjenrVM7CHgba7y+QIMQ+YIun
         NCLPAJcCtfNcFjRigs0TuH2FnP8sJNEozYOl3qRqsqi9CWeCuY6u8LcmdwmNNYcIxe
         SdwjrlAecKJQkARxcEqjL2kneaicLW9Ar9U5PNg6BVmkP1p10m36ZuAdVCooG2Jyuy
         6tkmfF4UtG92CmlvSpV7PmTl53SX1cB2GbUc8ApDfQ1HlbZ2AVSwhOS7PV3dKDYMcn
         1HcAhqtxFThYRKSXT9Yb+NwhQ6+YryLP7hmqEDPRoAuXNh2aFdsiO/WTVf/raDzGU/
         fX3GZPrW8DnDw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 5/9] btrfs: use a bit to track the existence of tree mod log users
Date:   Thu, 11 Mar 2021 14:31:09 +0000
Message-Id: <08ccdf842ceb0e05bccbdd087b9ef48efc4144db.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The tree modification log functions are called very frequently, basically
they are called everytime a btree is modified (a pointer added or removed
to a node, a new root for a btree is set, etc). Because of that, to avoid
heavy lock contention on the lock that protects the list of tree mod log
users, we have checks that test the emptiness of the list with a full
memory barrier before the checks, so that when there are no tree mod log
users we avoid taking the lock.

Replace the memory barrier and list emptiness check with a test for a new
bit set at fs_info->flags. This bit is used to indicate when there are
tree mod log users, set whenever a user is added to the list and cleared
when the last user is removed from the list. This makes the intention a
bit more obvious and possibly more efficient (assuming test_bit() may be
cheaper than a full memory barrier on some architectures).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h        |  3 +++
 fs/btrfs/tree-mod-log.c | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 50208673bd55..90184ee2f832 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -580,6 +580,9 @@ enum {
 
 	/* Indicate that we can't trust the free space tree for caching yet */
 	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
+
+	/* Indicate whether there are any tree modification log users. */
+	BTRFS_FS_TREE_MOD_LOG_USERS,
 };
 
 /*
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index f2a6da1b2903..b912b82c36c9 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -60,6 +60,7 @@ u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
 	if (!elem->seq) {
 		elem->seq = btrfs_inc_tree_mod_seq(fs_info);
 		list_add_tail(&elem->list, &fs_info->tree_mod_seq_list);
+		set_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags);
 	}
 	write_unlock(&fs_info->tree_mod_log_lock);
 
@@ -83,7 +84,9 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
 	list_del(&elem->list);
 	elem->seq = 0;
 
-	if (!list_empty(&fs_info->tree_mod_seq_list)) {
+	if (list_empty(&fs_info->tree_mod_seq_list)) {
+		clear_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags);
+	} else {
 		struct btrfs_seq_list *first;
 
 		first = list_first_entry(&fs_info->tree_mod_seq_list,
@@ -166,8 +169,7 @@ static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
 static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb)
 {
-	smp_mb();
-	if (list_empty(&(fs_info)->tree_mod_seq_list))
+	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return true;
 	if (eb && btrfs_header_level(eb) == 0)
 		return true;
@@ -185,8 +187,7 @@ static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
 static inline bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb)
 {
-	smp_mb();
-	if (list_empty(&(fs_info)->tree_mod_seq_list))
+	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return false;
 	if (eb && btrfs_header_level(eb) == 0)
 		return false;
-- 
2.28.0

