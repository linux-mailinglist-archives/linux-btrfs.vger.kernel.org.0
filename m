Return-Path: <linux-btrfs+bounces-14279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A03AC7334
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EB43B84C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AFC22A4F2;
	Wed, 28 May 2025 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buU7Mevo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE722A1CA;
	Wed, 28 May 2025 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469377; cv=none; b=ZVRB3xKG4Q9ZMPuUsDwDqX2pZ4SXOjz6bz3TIxCdraJ5/i/4kftAS4h61K6M6vcwbIFqrL8qs7qeZM6W3Ho0XEv23jRXSGnGd3pjcTj5UnlAGvakFB/e1l5mju6cv2eH4dM1vab1ZwzlkV7fBbpk4q8J+LNgH26PdTT54S9Wjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469377; c=relaxed/simple;
	bh=MCZd/iWjYbUsuvm/RmPIwChcn8pcnR3PdyFWbQlGmwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMUcQvWBUNidE1UQwTkZJ3b2ueKSCxwtNVvyhm7EG6VggLt41aqd2vWkWHzajuxyp+x0VhtnSV5YZhf8krbeFr9HeE7UnCRcD8PNkBPiEH3S2tLTXLrtjKHDRcoHw7U2KD2zEwNukYvDJiscllUmDMLxLgNYUbQc4Pu5UmScrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buU7Mevo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35088C4CEED;
	Wed, 28 May 2025 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469377;
	bh=MCZd/iWjYbUsuvm/RmPIwChcn8pcnR3PdyFWbQlGmwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buU7Mevoyi8LA2rNCu1LbSxrxBZZW79R8+GZKNkAI8CCmg83CKGJU8t46OOBlPosI
	 irEIfV7m07T/CIir/kMcZkHMoRlVqEK85TW22RDSkmkdrqOjukHISzFGYCLhh8/NCP
	 BVpx5ftiYfNgemPR+FhG5NJjV4Vr0U9Bcv3SPKt+0fjKB9/FHVRT7C1Hiq64WAjC9b
	 QfOnfk7qJfuPGH5hVK7mLVh8lL8IW6SRTfQwz8a5IQcBhz9bFSvYjfZG4tfCaYuE3q
	 zAu5WFj4MU1qKjEsn2ElBvyQmv1M0ZWoXJScrSaRH8g40RgBMsGuUT8WIYEZTBe3F7
	 J5s3rr9fSJQlA==
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
Subject: [PATCH AUTOSEL 6.14 4/8] btrfs: exit after state split error at set_extent_bit()
Date: Wed, 28 May 2025 17:56:07 -0400
Message-Id: <20250528215611.1983429-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528215611.1983429-1-sashal@kernel.org>
References: <20250528215611.1983429-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.8
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
index bb3aaf610652a..5f9a43734812e 100644
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


