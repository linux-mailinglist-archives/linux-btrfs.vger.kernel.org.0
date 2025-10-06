Return-Path: <linux-btrfs+bounces-17471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E85BBEE6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9A914EFF07
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49122D948D;
	Mon,  6 Oct 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlZupm3Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBC2D641F;
	Mon,  6 Oct 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774720; cv=none; b=RH+bYR+SAIC2yv2SfAtBVZ/vsYK6IE/dNV2NATfRgVcCqZRQz+1rsEjOuMfgIyi4ysbrO7FEm/fCdPC3d0Qt+MlRNgv4/vZSND/kmt++AKVFeIVtMbq4/Mdgo19LzXqDnKGAxhqQKn73fP6mPNPnK2cab124MLSsSkyNcWUf4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774720; c=relaxed/simple;
	bh=h+WPRqlGXwRU5vZbWPkqRe4TULZubt8y/W+ELBOZUQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiYKItOZCHrvhiznAB481ilyN9XzSXusVA64333gBN0fvfm6eXrYCosgVphwBdKUaGHy0ckSoDIzKAPdH2efbta3zWJDQyik7DbaSymAVQVkoZxJZfyBt88D7D8F+ioEm9Xe6Knw7e8f0XA/9LnvVvwuA9zpM06U37xJeWSEmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlZupm3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA21C4CEF7;
	Mon,  6 Oct 2025 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774719;
	bh=h+WPRqlGXwRU5vZbWPkqRe4TULZubt8y/W+ELBOZUQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlZupm3Z3Q7etTZr3pzzfuAJ5KOOrv8ijUSVk+/lomUokQG1ML50lTXJ8VbZsnzoR
	 /nUMXCHzZz8BuieAheUl8NeiqFbw2Yatlo0I9Lrk72jv8BpmQ61NAJ1ATAhhCItA3t
	 Y3DKLzQ6rznC7WfNwyF0+te3ca1NyO7AYrVemRLIdCJsYs59/thfSf9KG9iTgMpXaz
	 idyFb2nWryA/V0VgxFx0Zjz7iLs6sdSXPJTfY0eEjBIMdRAnibLh64kCIZtZqv7eLw
	 y9KQcl6GZKFvJ0hOUW4ngQ9KakLiusK4i7fkP/fJ1X7YZkrPA3NiwaZsKAuyaMIj1j
	 G50i8eF9JwmpA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] btrfs: zoned: refine extent allocator hint selection
Date: Mon,  6 Oct 2025 14:17:34 -0400
Message-ID: <20251006181835.1919496-2-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit 0d703963d297964451783e1a0688ebdf74cd6151 ]

The hint block group selection in the extent allocator is wrong in the
first place, as it can select the dedicated data relocation block group for
the normal data allocation.

Since we separated the normal data space_info and the data relocation
space_info, we can easily identify a block group is for data relocation or
not. Do not choose it for the normal data allocation.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis, here is my assessment:

## Backport Status: YES

### Summary of Analysis

**What the commit fixes:**
The commit fixes incorrect extent allocator hint selection in btrfs
zoned mode where the allocator could incorrectly select the dedicated
data relocation block group for normal data allocation. This violates
the design principle that relocation block groups should only be used
for data relocation operations (fs/btrfs/extent-tree.c:4322).

**Code change analysis:**
1. Adds `space_info` parameter to `prepare_allocation_zoned()` function
   (lines 4299-4301)
2. Adds a critical check: `block_group->space_info == space_info` before
   selecting a block group as the hint (line 4323)
3. Passes the `space_info` parameter through the call chain (line 4344)

The change is minimal (4 insertions, 2 deletions) and surgically
targeted.

**Why this is a bug affecting users:**

After commit f92ee31e031c7 (v6.16-rc1, May 2025) introduced sub-
space_info separation, btrfs zoned mode maintains separate space_info
structures for:
- Normal data block groups
- Data relocation block groups

Without this fix, `prepare_allocation_zoned()` only checks
`block_group_bits(block_group, ffe_ctl->flags)` which verifies the block
group is DATA type, but doesn't distinguish between normal data and
relocation data since both have the same flags. This can cause:

1. **Incorrect space accounting**: Normal allocations appear to have
   free space when only relocation space is available
2. **ENOSPC errors**: As noted in commit f92ee31e031c7, users could
   experience "strange ENOSPC" errors
3. **Write pointer violations**: On zoned devices, mixing relocation
   extents and regular extents in the same zone can cause WRITE and ZONE
   APPEND commands to be dispatched simultaneously, breaking the write
   pointer (see commit 7b2d588572e75)

**Risk assessment:**
- **Very low risk**: The change is confined to btrfs zoned extent
  allocator hint selection
- **Clear correctness**: The fix ensures block group selection respects
  space_info boundaries
- **Code quality**: Reviewed by Johannes Thumshirn, an expert in btrfs
  zoned support

**Dependencies:**
- **Hard dependency**: Requires sub-space_info infrastructure from
  commit f92ee31e031c7 (merged in v6.16-rc1)
- **Cannot be backported to kernels < v6.16**

**Why it meets stable tree criteria:**
1. ✅ Fixes important bug affecting btrfs zoned mode users
2. ✅ Small, contained change with minimal regression risk
3. ✅ No architectural changes
4. ✅ Clear side effects are intentional (preventing wrong block group
   selection)
5. ✅ Fixes correctness issue introduced by the v6.16 space_info
   separation

**Recommendation:** This commit should be backported to v6.16+ stable
trees to ensure correct extent allocator behavior for btrfs zoned mode
users.

 fs/btrfs/extent-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 97d517cdf2df7..682d21a73a67a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4297,7 +4297,8 @@ static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
 }
 
 static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
-				    struct find_free_extent_ctl *ffe_ctl)
+				    struct find_free_extent_ctl *ffe_ctl,
+				    struct btrfs_space_info *space_info)
 {
 	if (ffe_ctl->for_treelog) {
 		spin_lock(&fs_info->treelog_bg_lock);
@@ -4321,6 +4322,7 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 			u64 avail = block_group->zone_capacity - block_group->alloc_offset;
 
 			if (block_group_bits(block_group, ffe_ctl->flags) &&
+			    block_group->space_info == space_info &&
 			    avail >= ffe_ctl->num_bytes) {
 				ffe_ctl->hint_byte = block_group->start;
 				break;
@@ -4342,7 +4344,7 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
 	case BTRFS_EXTENT_ALLOC_ZONED:
-		return prepare_allocation_zoned(fs_info, ffe_ctl);
+		return prepare_allocation_zoned(fs_info, ffe_ctl, space_info);
 	default:
 		BUG();
 	}
-- 
2.51.0


