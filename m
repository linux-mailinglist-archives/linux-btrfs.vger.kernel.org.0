Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6C03D2655
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhGVOTE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 10:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232536AbhGVORi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 10:17:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF5E761221
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jul 2021 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626965893;
        bh=wf0n0RQgrfh7/CVVR45CmW9hpXpcU1+fTzU1975eJ7s=;
        h=From:To:Subject:Date:From;
        b=eKI7Tv6IVVSCZL9mcqZUIQXQ6MH/y6ESnuD4hAx8AD9D/pwe0IQA5iinCWRXp+ZOB
         Odh1xf/gudmqULiWrewEfaEc2NlMjZNZMOcPib3vGkUvdXH3j5La7z95oqsnfUY1Sa
         kAT/gMm1VsQylLmX2Lol/iyctZe5KtFQGdaxip7y4v9HBo/3ayflzZ0YsPKSTo3FdD
         72nlsvwvTEinLi0MRG0so5oHfGaT+YOk09UfDEZ+/dg91YggSQ3/c7wqAmqupsKR9T
         8gDxoKaSOkvKYp0dGJtMCW4Kbi86GFYvg6X8zMSk6Th8kMLv7U9HRG+B8jZWX6LI/c
         AKi7AQT9WZI7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove ignore_offset argument from btrfs_find_all_roots()
Date:   Thu, 22 Jul 2021 15:58:10 +0100
Message-Id: <c36aede8c9c171c1153e3a153c4112222919985a.1626965759.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently all the callers of btrfs_find_all_roots() pass a value of false
for its ignore_offset argument. This makes the argument pointless and we
can remove it and make btrfs_find_all_roots() always pass false as the
ignore_offset argument for btrfs_find_all_roots_safe(). So just do that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c            |  4 ++--
 fs/btrfs/backref.h            |  2 +-
 fs/btrfs/qgroup.c             |  8 ++++----
 fs/btrfs/tests/qgroup-tests.c | 20 ++++++++++----------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 78b202d198b8..4f64c366f369 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1488,14 +1488,14 @@ static int btrfs_find_all_roots_safe(struct btrfs_trans_handle *trans,
 int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 			 struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 time_seq, struct ulist **roots,
-			 bool ignore_offset, bool skip_commit_root_sem)
+			 bool skip_commit_root_sem)
 {
 	int ret;
 
 	if (!trans && !skip_commit_root_sem)
 		down_read(&fs_info->commit_root_sem);
 	ret = btrfs_find_all_roots_safe(trans, fs_info, bytenr,
-					time_seq, roots, ignore_offset);
+					time_seq, roots, false);
 	if (!trans && !skip_commit_root_sem)
 		up_read(&fs_info->commit_root_sem);
 	return ret;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ff5f07f9940b..ba454032dbe2 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -47,7 +47,7 @@ int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
 			 const u64 *extent_item_pos, bool ignore_offset);
 int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 			 struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 time_seq, struct ulist **roots, bool ignore_offset,
+			 u64 time_seq, struct ulist **roots,
 			 bool skip_commit_root_sem);
 char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 			u32 name_len, unsigned long name_off,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 0fa121171ca1..db680f5be745 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1733,7 +1733,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	ASSERT(trans != NULL);
 
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
-				   false, true);
+				   true);
 	if (ret < 0) {
 		trans->fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 		btrfs_warn(trans->fs_info,
@@ -2651,7 +2651,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 				/* Search commit root to find old_roots */
 				ret = btrfs_find_all_roots(NULL, fs_info,
 						record->bytenr, 0,
-						&record->old_roots, false, false);
+						&record->old_roots, false);
 				if (ret < 0)
 					goto cleanup;
 			}
@@ -2667,7 +2667,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 			 * current root. It's safe inside commit_transaction().
 			 */
 			ret = btrfs_find_all_roots(trans, fs_info,
-			   record->bytenr, BTRFS_SEQ_LAST, &new_roots, false, false);
+			   record->bytenr, BTRFS_SEQ_LAST, &new_roots, false);
 			if (ret < 0)
 				goto cleanup;
 			if (qgroup_to_skip) {
@@ -3201,7 +3201,7 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 			num_bytes = found.offset;
 
 		ret = btrfs_find_all_roots(NULL, fs_info, found.objectid, 0,
-					   &roots, false, false);
+					   &roots, false);
 		if (ret < 0)
 			goto out;
 		/* For rescan, just pass old_roots as NULL */
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 98b5aaba46f1..f3137285a9e2 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -224,7 +224,7 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 	 * quota.
 	 */
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
@@ -237,7 +237,7 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 		return ret;
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		ulist_free(new_roots);
@@ -261,7 +261,7 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 	new_roots = NULL;
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
@@ -273,7 +273,7 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 		return -EINVAL;
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		ulist_free(new_roots);
@@ -325,7 +325,7 @@ static int test_multiple_refs(struct btrfs_root *root,
 	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
@@ -338,7 +338,7 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		ulist_free(new_roots);
@@ -360,7 +360,7 @@ static int test_multiple_refs(struct btrfs_root *root,
 	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
@@ -373,7 +373,7 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		ulist_free(new_roots);
@@ -401,7 +401,7 @@ static int test_multiple_refs(struct btrfs_root *root,
 	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
@@ -414,7 +414,7 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
-			false, false);
+			false);
 	if (ret) {
 		ulist_free(old_roots);
 		ulist_free(new_roots);
-- 
2.28.0

