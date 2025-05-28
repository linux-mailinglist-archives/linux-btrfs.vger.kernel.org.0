Return-Path: <linux-btrfs+bounces-14280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D9AC7359
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 00:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571A11C031B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 22:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622C22DFAA;
	Wed, 28 May 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmNdJ2eu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20218221F15;
	Wed, 28 May 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469385; cv=none; b=tLXVWT3ib5fuispopkYbY7lpWGdK7v0pkC5ypy2yfK/d79CIgtQAAboWy6tRPVzIoILq1/A4lnvZbr1oZ45Id+0kODT5N5OeMfKgT7/JwGGEzuBrSaBhB3mDzW7IhWtOV+IlGJWClp+lYMsSAMNOwQbbaUX5UU40CMv9Hy79ogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469385; c=relaxed/simple;
	bh=2VThknpY4Vs8QWakS9sWYR2G/1Ip+G8eS/08RVfhu18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aypoqOQjLtZoBUPBo9bA7XZsJR99T7KZgs9g8mU3Lotco7dTx8vIe/UGpxWVat5m0VtuGqZkeIdING37N1vB0EDug0d+7dbThY2iG4bbLL+MDCloy01crQJKequfsDR9G6aozP56XcmtJMpdK8ExOp7JXaeWolMrAnRUNDnphkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmNdJ2eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE4C4CEE7;
	Wed, 28 May 2025 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469384;
	bh=2VThknpY4Vs8QWakS9sWYR2G/1Ip+G8eS/08RVfhu18=;
	h=From:To:Cc:Subject:Date:From;
	b=NmNdJ2euqZXa+5k9B/wJupKGeRlvUEIqYpKtZS0HgCWs/cf6gbLLOa76rKKCFga6Y
	 i5e7OEAisMxu5dSoK6lUwVHdlgKoQPynCEyClWb4Drmby8Yk7eEHGql/45s4kGBj4F
	 nKEbp9bezcm8a6cipzk1OtTD/2vtlaGo3ZZ5dqxCqPK5wS7KOtB5sztvOLOxsm9lj+
	 eUp4yr7KBj5w8u5Zope9bky5ARXx0X+osSvZMFLjScugQVBQGl1Hg1NqiYDKw3+RVY
	 DVxCWDBZ7mqV0tBJAskQw5cirZy4gZFl2Wy4DHCWZd8+Yl/7bMY2iWIG5D9TkVuoeM
	 bJdO7cyjuhuxA==
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
Subject: [PATCH AUTOSEL 6.12 1/7] btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
Date: Wed, 28 May 2025 17:56:16 -0400
Message-Id: <20250528215622.1983622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.30
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 3bf179e36da917c5d9bec71c714573ed1649b7c1 ]

If insert_state() state failed it returns an error pointer and we call
extent_io_tree_panic() which will trigger a BUG() call. However if
CONFIG_BUG is disabled, which is an uncommon and exotic scenario, then
we fallthrough and call cache_state() which will dereference the error
pointer, resulting in an invalid memory access.

So jump to the 'out' label after calling extent_io_tree_panic(), it also
makes the code more clear besides dealing with the exotic scenario where
CONFIG_BUG is disabled.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Detailed Analysis:** **1. Bug Description and Impact:** The commit
fixes a serious potential memory corruption bug in the btrfs filesystem.
When `insert_state()` fails in `btrfs_convert_extent_bit()`, it returns
an error pointer (ERR_PTR). The current code calls
`extent_io_tree_panic()` which triggers `BUG()`, but if `CONFIG_BUG` is
disabled, the code continues executing and calls
`cache_state(inserted_state, cached_state)` with the error pointer,
causing invalid memory access. **2. Code Changes Analysis:** The fix is
minimal and surgical - just adding a single `goto out;` statement after
the `extent_io_tree_panic()` call: ```c if (IS_ERR(inserted_state)) {
ret = PTR_ERR(inserted_state); extent_io_tree_panic(tree, prealloc,
"insert", ret); + goto out; // <-- The fix } ``` This ensures that when
`CONFIG_BUG` is disabled, execution jumps to the cleanup code instead of
continuing with an invalid pointer. **3. Comparison with Similar
Commits:** This commit aligns with the pattern seen in "Similar Commit
#2" (Status: YES), which also: - Removes reliance on `BUG_ON()` behavior
- Provides graceful error handling - Has minimal risk - Fixes a
potential crash/corruption scenario Similar to commit #3 and #5 (both
Status: NO), this touches BUG() handling, but unlike those commits which
make broader architectural changes to error handling patterns, this fix
is much more contained. **4. Stable Tree Criteria Assessment:** ✅
**Fixes important bug**: Prevents potential memory corruption/crashes ✅
**Small and contained**: Single line addition ✅ **Minimal risk**: Only
affects error path when insert_state() fails AND CONFIG_BUG is disabled
✅ **No new features**: Pure bug fix ✅ **No architectural changes**:
Preserves existing error handling, just prevents fallthrough ✅
**Critical subsystem**: btrfs filesystem corruption prevention ✅ **Clear
side effects**: No unintended consequences beyond fixing the bug **5.
Risk Assessment:** - **Very Low Risk**: The change only affects an error
condition that's already problematic - **Exotic scenario**: Only impacts
systems with `CONFIG_BUG` disabled (uncommon but not impossible) - **No
regression potential**: The change only prevents executing invalid code,
doesn't change normal operation - **Well-contained**: Affects only one
function in one file **6. Security Implications:** While `CONFIG_BUG`
disabled is uncommon, this could potentially be exploited if an attacker
can trigger the `insert_state()` failure condition, leading to memory
corruption. The fix prevents this attack vector. This is a clear
candidate for stable backporting - it fixes a real bug with minimal risk
and follows the stable tree rules perfectly.

 fs/btrfs/extent-io-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6d08c100b01de..bb3aaf610652a 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1456,6 +1456,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (IS_ERR(inserted_state)) {
 			ret = PTR_ERR(inserted_state);
 			extent_io_tree_panic(tree, prealloc, "insert", ret);
+			goto out;
 		}
 		cache_state(inserted_state, cached_state);
 		if (inserted_state == prealloc)
-- 
2.39.5


