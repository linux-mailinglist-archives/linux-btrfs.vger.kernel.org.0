Return-Path: <linux-btrfs+bounces-14275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C902AAC7313
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE0D3AD686
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23D221DA5;
	Wed, 28 May 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvKhmLl4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0619B3CB;
	Wed, 28 May 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469362; cv=none; b=YlDgux3PIxHdCB6V/vdgm6FvyHtwJofgxyKAOq2sBUrl94VwtCPVT1oZuC4mScHuiZ6muocsa0c3330VKL7+dc2rrilzQb4meVUS91Yzq4FnO6txk5Wqxl9ClR+3mv394I4BHfQZFwzrNZB6eZx7Km6ATfJzIMoDsSvOd3ukRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469362; c=relaxed/simple;
	bh=uw3tEeeMk5Bc24CVW+ncU6a0qB2pCTBmCm7AtTlyOQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mvj1Z8tJKmaV5cVpGZinNRLq/F9tsb9YVZjJkRaNOLEGafrEcVAsI2bfT6H0KfjoCgLUI+uP5eY3pFy6gZO1XCvDzHJ6hUMe3wsWTchL3eiPxLLh+H30UC6etoZAffaoFgu6GCFrDI8zjNUJ0fv6bG1CbZ+wyksinN76SnROdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvKhmLl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78239C4CEE3;
	Wed, 28 May 2025 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469361;
	bh=uw3tEeeMk5Bc24CVW+ncU6a0qB2pCTBmCm7AtTlyOQk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZvKhmLl4F9KukOIYGziMfksPaiQfS1yqltdMwGv9hJwiv3uXHIWEESsoEsF18ig3P
	 XV+W8dPDVVqVTisVfGaQI3ko45r/TnNjkuvWBlKvIQl9vVlWmCxtUUvlGq1VKTVRaE
	 bZWBV++O/66DP/uvi0I53pBis7I7LSO5EEhGQfErGKkxI1Z7OTnXHLLceveDCaZd23
	 Mp+wWxrfsYso45j8CX9uJUHW2Tb3O6bSU7Cxaa/AVdjlMzR8bV14xah2JWGTu8/U50
	 tCX7FFPaJWr0fdYh9Rg15B4fuuU/DebHBejGDAOyE/6MoO55egA0kjl6U2vqrFvnbT
	 rOvvaylPk/aMA==
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
Subject: [PATCH AUTOSEL 6.15 1/9] btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
Date: Wed, 28 May 2025 17:55:51 -0400
Message-Id: <20250528215559.1983214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
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
index 13de6af279e52..92cfde37b1d33 100644
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


