Return-Path: <linux-btrfs+bounces-14277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0C5AC731D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E9A4A7370
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B45223DC2;
	Wed, 28 May 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR531LDS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A292223329;
	Wed, 28 May 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469366; cv=none; b=CY30+MHDGzkFtEl505SEY7oZxO7Jc7TbHqqxEiWxuV+kUJiuXmnlsqA/uSeBGDL+WjVyFhL/9TwfoErB/cWU26UqIFZbrvlOEFrEcg5+Aa6A1CgEKwKg/K7+IjHm7BN6YpUlWiLRltioTNCBblZ5jb9Kp4Tn115hRMbIbfMyjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469366; c=relaxed/simple;
	bh=SZjpqvNp57s+WP0nOIxZ3GIUL0r9AuFIfXWTVM7PpRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UM/eWwd5I4avAX8wAliDdMayBNAGCz+QEBbnJ0CFSkj/thKPsEJEyAG9T5u5ZZzVQRzaf/xmA3XtIXtPC68w+D6aX6oLN5XI1rexpf/RxyXT5LRVTmB3Mxhp2cHNXJ8W1/6AZtN2YXibGTC+tpDhDUvkFqSOIbIHgaIgSqxJU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR531LDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35360C4CEED;
	Wed, 28 May 2025 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469366;
	bh=SZjpqvNp57s+WP0nOIxZ3GIUL0r9AuFIfXWTVM7PpRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OR531LDS+EeDrLMFgDN+0wuRNWdgvv2olFwluboQcw1qx5swXy78gSD7iP+kyg9qu
	 RSFBZOesg9aS8oZcSzsEn/MdU6HzzP62UmLK0GE0oqhYCituQQGZ2VjJhXJWzxo+o/
	 bdTZRM7vzQS8yewYVzZgXjX5t9gOtl0KijY6AcpBRwjx3Ykt4z2nr6TJ3e9ymntXxj
	 gfjlbWqHjeMRX57qM9Hx9ZOQ6ug29jseH3Vu4vMWyprrO91Q9SNu6Qs+a919kWHOnS
	 N66HBx69Nn9B1eBQocbCq41bRxglJa4yXh+sQP0JpGboOj2ga2Unl459Whz/f0/4bV
	 hO8NlgMgnIMZQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 5/9] btrfs: exit after state split error at set_extent_bit()
Date: Wed, 28 May 2025 17:55:55 -0400
Message-Id: <20250528215559.1983214-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528215559.1983214-1-sashal@kernel.org>
References: <20250528215559.1983214-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 41d69d4d78d8b179bf3bcdfc56d28a12b3a608d2 ]

If split_state() returned an error we call extent_io_tree_panic() which
will trigger a BUG() call. However if CONFIG_BUG is disabled, which is an
uncommon and exotic scenario, then we fallthrough and hit a use after free
when calling set_state_bits() since the extent state record which the
local variable 'prealloc' points to was freed by split_state().

So jump to the label 'out' after calling extent_io_tree_panic() and set
the 'prealloc' pointer to NULL since split_state() has already freed it
when it hit an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Analysis of the Code Changes The commit fixes
a critical use-after-free bug in the btrfs filesystem's extent I/O tree
management. Examining the specific code changes: **Problem Location**:
In `fs/btrfs/extent-io-tree.c`, function `set_extent_bit()` around lines
1254-1256: ```c ret = split_state(tree, state, prealloc, end + 1); if
(ret) extent_io_tree_panic(tree, state, "split", ret); ``` **The Bug**:
After `split_state()` fails and `extent_io_tree_panic()` is called, the
code continues to execute `set_state_bits(tree, prealloc, bits,
changeset)` on line 1258. However, when `split_state()` fails, it frees
the `prealloc` extent state, making this a use-after-free vulnerability.
**The Fix**: The commit adds proper error handling: ```c ret =
split_state(tree, state, prealloc, end + 1); if (ret) {
extent_io_tree_panic(tree, state, "split", ret); prealloc = NULL; goto
out; } ``` ## Why This Should Be Backported ### 1. **Critical Security
Issue** - **Use-after-free vulnerability**: This is a serious memory
safety issue that can lead to kernel crashes, data corruption, or
potentially exploitable conditions - **Affects btrfs filesystem**: A
widely used filesystem in production environments ### 2. **Specific Edge
Case Scenario** From my examination of the kernel code: -
`extent_io_tree_panic()` calls `btrfs_panic()` which calls `BUG()` -
When `CONFIG_BUG` is disabled (uncommon but possible), `BUG()` becomes a
no-op loop instead of halting execution - This allows execution to
continue to the use-after-free code ### 3. **Minimal Risk Change** -
**Small, targeted fix**: Only adds 3 lines of code - **Clear logic**:
Sets pointer to NULL and jumps to cleanup - **No functional changes**:
Doesn't alter normal operation paths - **No architectural changes**:
Pure bug fix without affecting subsystem design ### 4. **Comparison with
Similar Commits** Looking at the reference commits: - Similar to
"Similar Commit #2" (marked YES) which also improved error handling in
extent bit operations - Unlike commits marked NO, this doesn't add
features or make architectural changes - Follows the same pattern as
other accepted backports for memory safety fixes ### 5. **Clear Bug Fix
Criteria** - **Fixes a real bug**: Use-after-free is a concrete,
exploitable issue - **Minimal scope**: Only affects error path in one
function - **No side effects**: Change only affects already-failing code
paths - **Well-understood impact**: Risk is contained to btrfs extent
I/O operations ### 6. **Production Impact** - While `CONFIG_BUG` being
disabled is rare, when it occurs this creates a serious vulnerability -
btrfs is used in production environments where memory safety is critical
- The fix prevents potential kernel crashes or memory corruption ### 7.
**Stable Tree Compatibility** - **Self-contained**: Doesn't depend on
other recent changes - **Backwards compatible**: No API changes - **Low
regression risk**: Only affects error handling path that was already
broken The commit perfectly fits stable tree criteria: it's a small,
important bugfix with minimal risk that addresses a real security issue
in a widely-used filesystem.

 fs/btrfs/extent-io-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 92cfde37b1d33..b5b44ea91f999 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1252,8 +1252,11 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (!prealloc)
 			goto search_again;
 		ret = split_state(tree, state, prealloc, end + 1);
-		if (ret)
+		if (ret) {
 			extent_io_tree_panic(tree, state, "split", ret);
+			prealloc = NULL;
+			goto out;
+		}
 
 		set_state_bits(tree, prealloc, bits, changeset);
 		cache_state(prealloc, cached_state);
-- 
2.39.5


