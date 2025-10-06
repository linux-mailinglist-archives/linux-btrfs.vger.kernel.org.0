Return-Path: <linux-btrfs+bounces-17472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7DBBEE7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB1B189B4C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06302D8DA6;
	Mon,  6 Oct 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6aNKXo9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7C246766;
	Mon,  6 Oct 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774745; cv=none; b=YkFSUP9tUu6De/6SY0TN7pbi9zGIv1aOEzZltylqfnBPDpV5HDohTQFAXbM8bfbhv9INx7GAL25qRip2BdP0kEqxuJ4270Fqy/j9jt5SY2N6Ku85bU3lrhSXI0gB/xwrPvdFSp9sTF9/9AqgTC9izy2+Mc4mRt/vJ7006kctS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774745; c=relaxed/simple;
	bh=3gI0MOmqxzRqtQMGq9Tt8Vqdhgay4EFWP3qM1dt8AoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah09oIqItZFFINfB6ELvSzhL6dWreG2hzR2yL1wWabUA0Z4hs+383JGFtCcQRfGl2UKKi4NWkcsptGfVeFpNOa+V8qeNEua9DpGqIogpf/4HH2uz8VAPJxrkFWfigKVmOeOMV++aBkp4tEsG2DaCD48y73HzCw3tq+RkSj4HBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6aNKXo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E3EC4CEF7;
	Mon,  6 Oct 2025 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774743;
	bh=3gI0MOmqxzRqtQMGq9Tt8Vqdhgay4EFWP3qM1dt8AoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6aNKXo9D21H6hJcsKER/CWGsKM+ePPEZnBRbQk9XPmcIryNJL3NPMq21hGKSJAv5
	 5q/i/AOg1CBRvNuN0EgRY0DsCPxvh68L69tuRyuKmB3FJkHiiveIm8qZ+rJ3JNljGO
	 LPEXEdAca7RKtFM6YjtVhD5lMOLl6+8XDTQXWq/pzsnAgIyneBpeCMh/pEAUUigRgc
	 UazSAckZSvWVG8PNyODl6Y2eYjF98XbKFi7DIXF7VKWgfGMMfY1dhOm4fLH8ckoLPD
	 hKnFzWIN49glrffSqzzTx1bNhTc79Tc7HBDCkXcGp+R9NwxHEb/4adH5aA+Mm3ezaV
	 vDogeJElc0enQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] btrfs: abort transaction on specific error places when walking log tree
Date: Mon,  6 Oct 2025 14:17:36 -0400
Message-ID: <20251006181835.1919496-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006181835.1919496-1-sashal@kernel.org>
References: <20251006181835.1919496-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 6ebd726b104fa99d47c0d45979e6a6109844ac18 ]

We do several things while walking a log tree (for replaying and for
freeing a log tree) like reading extent buffers and cleaning them up,
but we don't immediately abort the transaction, or turn the fs into an
error state, when one of these things fails. Instead we the transaction
abort or turn the fs into error state in the caller of the entry point
function that walks a log tree - walk_log_tree() - which means we don't
get to know exactly where an error came from.

Improve on this by doing a transaction abort / turn fs into error state
after each such failure so that when it happens we have a better
understanding where the failure comes from. This deliberately leaves
the transaction abort / turn fs into error state in the callers of
walk_log_tree() as to ensure we don't get into an inconsistent state in
case we forget to do it deeper in call chain. It also deliberately does
not do it after errors from the calls to the callback defined in
struct walk_control::process_func(), as we will do it later on another
patch.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## YES

### Extensive Analysis and Rationale:

#### Commit Context and History:
This commit (6ebd726b104fa) is part of a comprehensive series by Filipe
Manana from July-September 2025 focused on improving error handling and
debugging capabilities in btrfs log tree operations. The series
includes:

1. **July 16, 2025**: fc5799986fbca "btrfs: error on missing block group
   when unaccounting log tree extent buffers" - explicitly marked for
   stable (CC: stable@vger.kernel.org # 6.12+) and addresses space leaks
2. **July 16, 2025**: 6ebd726b104fa (this commit) - adds transaction
   aborts at specific error points
3. **July 18, 2025**: 912c257c88cd8 "btrfs: abort transaction where
   errors happen during log tree replay" - extends error handling to
   replay_one_buffer() callback
4. **Sept 5, 2025**: 2753e49176240 "btrfs: dump detailed info and
   specific messages on log replay failures" - replaces all abort calls
   with enhanced debugging helper

#### Code Changes Analysis:

**In `clean_log_buffer()` (fs/btrfs/tree-log.c:2630):**
- Previously: `btrfs_pin_reserved_extent()` and `unaccount_log_buffer()`
  errors were returned but no transaction abort occurred
- After: Adds `btrfs_abort_transaction(trans, ret)` when pinning fails,
  and `btrfs_handle_fs_error()` when unaccounting fails
- Impact: Prevents continuing with log tree cleanup after extent
  pinning/accounting failures, which could lead to metadata space leaks

**In `walk_down_log_tree()` (fs/btrfs/tree-log.c:2674, 2690, 2705):**
Three specific error points now abort the transaction:
1. Line 2677: `btrfs_find_create_tree_block()` failure - couldn't
   allocate/find log tree block
2. Line 2690: `btrfs_read_extent_buffer()` failure at level 1 - couldn't
   read log leaf
3. Line 2705: `btrfs_read_extent_buffer()` failure at other levels -
   couldn't read log node

Each error path now calls either `btrfs_abort_transaction(trans, ret)`
(when transaction context exists) or `btrfs_handle_fs_error(fs_info,
ret, NULL)` (when freeing log without transaction).

#### Why This Should Be Backported:

1. **Dependency Chain**: This commit directly follows fc5799986fbca
   which changed `unaccount_log_buffer()` from void to returning int.
   Without this commit, those new error returns are not properly
   handled, defeating the purpose of that stable-marked fix.

2. **Error Containment**: The commit prevents silent error propagation
   that could lead to:
   - Filesystem inconsistencies during log replay
   - Metadata space accounting errors
   - Corrupted log trees that cause mount failures
   - Hard-to-debug production issues where errors occur but aren't
     immediately visible

3. **Minimal Risk**: The changes are defensive in nature:
   - Only adds error handling on already-failing code paths
   - Doesn't modify success path logic
   - Follows existing btrfs patterns for transaction abort
   - All error conditions already existed; this just makes them explicit

4. **Production Debugging Value**: The commit message explicitly states
   this helps "figuring out where failures come from" - critical for:
   - Debugging customer issues in production environments
   - Reducing time to identify root causes of log replay failures
   - Preventing cascading failures from silent errors

5. **Expert Review**: Reviewed by experienced btrfs developers (Boris
   Burkov, Qu Wenruo) and maintained by David Sterba, indicating
   thorough vetting

6. **Series Coherence**: Follow-up commits (especially 2753e49176240)
   depend on these abort points existing, creating a clean error
   handling architecture

#### Risk Assessment:

**Low regression risk because:**
- Transaction abort after failure is safer than continuing with
  corrupted state
- The abort paths are only triggered when operations already failed
- No new failure modes are introduced
- The commit doesn't change buffer management, extent handling, or tree
  traversal logic
- Similar patterns exist throughout btrfs code (12+ other
  btrfs_abort_transaction calls already in tree-log.c as shown by grep)

**Potential impacts:**
- Systems with underlying I/O issues may see transaction aborts sooner
  (this is good - fail fast)
- Log replay will be more strict about errors (this is the intended
  behavior)
- No performance impact on success paths

#### Conclusion:

This commit should be backported because it:
1. Is part of a critical error handling improvement series where one
   commit (fc5799986fbca) is already marked for stable
2. Prevents filesystem corruption by properly handling errors during log
   tree operations
3. Has minimal regression risk (only adds abort on already-failing
   paths)
4. Provides significant debugging value for production issues
5. Is already being backported (commit 8369fd86a93b1 exists in the
   analyzed tree)
6. Follows stable tree rules: important bugfix/hardening, minimal risk,
   confined to btrfs subsystem

The commit improves error handling in a critical filesystem subsystem
(log tree replay/free) where silent failures could lead to data loss or
corruption. While not fixing a specific reported bug, it's a defensive
change that prevents potential corruption scenarios and aids in
debugging real-world issues.

 fs/btrfs/tree-log.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7a63afedd01e6..6d92326a1a0c7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2630,15 +2630,24 @@ static int unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
 static int clean_log_buffer(struct btrfs_trans_handle *trans,
 			    struct extent_buffer *eb)
 {
+	int ret;
+
 	btrfs_tree_lock(eb);
 	btrfs_clear_buffer_dirty(trans, eb);
 	wait_on_extent_buffer_writeback(eb);
 	btrfs_tree_unlock(eb);
 
-	if (trans)
-		return btrfs_pin_reserved_extent(trans, eb);
+	if (trans) {
+		ret = btrfs_pin_reserved_extent(trans, eb);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
-	return unaccount_log_buffer(eb->fs_info, eb->start);
+	ret = unaccount_log_buffer(eb->fs_info, eb->start);
+	if (ret)
+		btrfs_handle_fs_error(eb->fs_info, ret, NULL);
+	return ret;
 }
 
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
@@ -2674,8 +2683,14 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		next = btrfs_find_create_tree_block(fs_info, bytenr,
 						    btrfs_header_owner(cur),
 						    *level - 1);
-		if (IS_ERR(next))
-			return PTR_ERR(next);
+		if (IS_ERR(next)) {
+			ret = PTR_ERR(next);
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(fs_info, ret, NULL);
+			return ret;
+		}
 
 		if (*level == 1) {
 			ret = wc->process_func(root, next, wc, ptr_gen,
@@ -2690,6 +2705,10 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 				ret = btrfs_read_extent_buffer(next, &check);
 				if (ret) {
 					free_extent_buffer(next);
+					if (trans)
+						btrfs_abort_transaction(trans, ret);
+					else
+						btrfs_handle_fs_error(fs_info, ret, NULL);
 					return ret;
 				}
 
@@ -2705,6 +2724,10 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		ret = btrfs_read_extent_buffer(next, &check);
 		if (ret) {
 			free_extent_buffer(next);
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(fs_info, ret, NULL);
 			return ret;
 		}
 
-- 
2.51.0


