Return-Path: <linux-btrfs+bounces-16345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747AB33F12
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 14:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE0D1A8204C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1597B1AAE28;
	Mon, 25 Aug 2025 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUNmbzJK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42455EEBD;
	Mon, 25 Aug 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124112; cv=none; b=Qkfmgc5g59Jr0PJlLaJZyCAQ9pAkQbnwZM0Su6bzLckkoxOad0WBFFNi2a5+jOosCVgLF4EsB4budT3rXRLpVCgB8DmoXVEKj46JgEPX7NoACAiYl4Dg+N7KlZcFSnilDVuNjhToiR8m+gjLqgpATPyvDyIjWjNA7UybV0l102c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124112; c=relaxed/simple;
	bh=FOPhcItXJXoIRSdZWM9NGaXg4K4SbgkZNq831SpdPc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5m35bYZaGKdOv4L5S5ZCtb/Ha1kjBCGXgUage2wVda3gKfc84UxO7/QGEfZNz0lEDzkILWCliYD1sfAJI52CeNelsouiGBilqrTBGNei5+moau43K9McKSmmgCo2Eo+J+BBlgzsMgkixCgi9VzKRG7Wm77MAQcOPAcK6rtYrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUNmbzJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E02C4CEED;
	Mon, 25 Aug 2025 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756124111;
	bh=FOPhcItXJXoIRSdZWM9NGaXg4K4SbgkZNq831SpdPc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUNmbzJK1RlUoNQXnLSyRFMVgNINBmD/sqkMd8AkyeDSS7shu/SFCWTNRAichYYDI
	 TF+zzwJDX++TYSm83HXJIDvE/nu6A4JymM8Nba+L2ikQbDcGFfkgRsQ6JJVmu8Elcu
	 iVdQD0a8uNl9Xe1k1UPY1F25IFUqn7HKLP1j1CU4MEjAWyEjsKmcI/rH9Txw2xXm/U
	 sRz1O0px6j+j0d1DuTBEULbnyCNqtKlIBwrTkEz291dAcIek5YEqvN6VK7pGsC66/Z
	 M/BxOelJvBPuXGgh6qZGFiGjKMDS5e1PezpcYLOPX2retYR1C2T5pMGk2ojiNQ0ixQ
	 XoxbKK7PA4wBw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16] btrfs: clear block dirty if submit_one_sector() failed
Date: Mon, 25 Aug 2025 08:14:53 -0400
Message-ID: <20250825121505.2983941-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825121505.2983941-1-sashal@kernel.org>
References: <20250825121505.2983941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.3
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 4bcd3061e8154606af7f721cb75ca04ffe191a12 ]

[BUG]
If submit_one_sector() failed, the block will be kept dirty, but with
their corresponding range finished in the ordered extent.

This means if a writeback happens later again, we can hit the following
problems:

- ASSERT(block_start != EXTENT_MAP_HOLE) in submit_one_sector()
  If the original extent map is a hole, then we can hit this case, as
  the new ordered extent failed, we will drop the new extent map and
  re-read one from the disk.

- DEBUG_WARN() in btrfs_writepage_cow_fixup()
  This is because we no longer have an ordered extent for those dirty
  blocks. The original for them is already finished with error.

[CAUSE]
The function submit_one_sector() is not following the regular error
handling of writeback.  The common practice is to clear the folio dirty,
start and finish the writeback for the block.

This is normally done by extent_clear_unlock_delalloc() with
PAGE_START_WRITEBACK | PAGE_END_WRITEBACK flags during
run_delalloc_range().

So if we keep those failed blocks dirty, they will stay in the page
cache and wait for the next writeback.

And since the original ordered extent is already finished and removed,
depending on the original extent map, we either hit the ASSERT() inside
submit_one_sector(), or hit the DEBUG_WARN() in
btrfs_writepage_cow_fixup().

[FIX]
Follow the regular error handling to clear the dirty flag for the block,
start and finish writeback for that block instead.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and the kernel repository context,
here's my assessment:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Bug Fix Analysis

1. **Critical Bug Being Fixed**: The commit fixes a serious error
   handling bug in btrfs writeback that can lead to two different
   assertion failures:
   - `ASSERT(block_start != EXTENT_MAP_HOLE)` in submit_one_sector()
   - `DEBUG_WARN()` in btrfs_writepage_cow_fixup()

2. **Data Integrity Issue**: The bug causes dirty blocks to remain dirty
   after a failed submission, but their corresponding ordered extent is
   already finished with error. This creates an inconsistent state
   where:
   - Dirty blocks exist without proper ordered extent tracking
   - Subsequent writeback attempts will fail with assertions/warnings
   - The filesystem enters an undefined state that could affect data
     integrity

3. **Clear Root Cause**: The commit message clearly identifies the
   problem - submit_one_sector() was not following standard writeback
   error handling practices. The fix aligns the error handling with the
   rest of the btrfs writeback code.

## Code Change Analysis

The fix is minimal and contained:
```c
if (IS_ERR(em)) {
+    /*
+     * When submission failed, we should still clear the folio dirty.
+     * Or the folio will be written back again but without any
+     * ordered extent.
+     */
+    btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
+    btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
+    btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
    return PTR_ERR(em);
}
```

The changes:
- Add proper error handling to clear dirty flag
- Set and clear writeback status to properly finish the failed writeback
- Update comments to clarify the behavior

## Stable Tree Criteria Met

1. **Fixes a real bug**: Yes - prevents assertion failures and potential
   filesystem corruption
2. **Small and contained**: Yes - only ~10 lines of actual code change
   in one function
3. **No new features**: Correct - purely bug fix
4. **Low regression risk**: The change follows established patterns used
   elsewhere in btrfs (extent_clear_unlock_delalloc)
5. **Important enough**: Yes - prevents filesystem errors and potential
   data integrity issues

The fix is straightforward, follows existing btrfs patterns, and
addresses a clear bug that could affect users running btrfs filesystems,
especially under I/O error conditions. This makes it an excellent
candidate for stable backporting.

 fs/btrfs/extent_io.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1dc931c4937f..2e127c109e5b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1483,7 +1483,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 /*
  * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors.
+ * Return <0 for critical errors, and the sector will have its dirty flag cleared.
  *
  * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
@@ -1506,8 +1506,17 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	ASSERT(filepos < i_size);
 
 	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
-	if (IS_ERR(em))
+	if (IS_ERR(em)) {
+		/*
+		 * When submission failed, we should still clear the folio dirty.
+		 * Or the folio will be written back again but without any
+		 * ordered extent.
+		 */
+		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
 		return PTR_ERR(em);
+	}
 
 	extent_offset = filepos - em->start;
 	em_end = btrfs_extent_map_end(em);
@@ -1637,8 +1646,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 * Here we set writeback and clear for the range. If the full folio
 	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
 	 *
-	 * If we hit any error, the corresponding sector will still be dirty
-	 * thus no need to clear PAGECACHE_TAG_DIRTY.
+	 * If we hit any error, the corresponding sector will have its dirty
+	 * flag cleared and writeback finished, thus no need to handle the error case.
 	 */
 	if (!submitted_io && !error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
-- 
2.50.1


