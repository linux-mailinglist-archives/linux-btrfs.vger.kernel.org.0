Return-Path: <linux-btrfs+bounces-12771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E92A7ABE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5557A45B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 19:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3732676E2;
	Thu,  3 Apr 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiT0xYCa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB6267398;
	Thu,  3 Apr 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707131; cv=none; b=s7WSyyqGoazoKk6Tg5u2LJ0CkDLHDOLxioTNeQ0mbRS+H7+naHI8Z+KtHXnWlDxbO8KXqhkJ1gLdmX6aQyckI2W+kZ4chUsjTQqP07mTtW00iuuPcgwVZlW7cZcyiHnbap1T4GZNSY8qAU0dE30EH1fepYVgO4nDBSkCrhYjIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707131; c=relaxed/simple;
	bh=ePURtSpA1U+2aAC+6iPVCJE4ede696nUnEyd3K/kgvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiuekXV6ejwjko39UsXsYaWFP2MJp8xIZaQ90rUonc82y6lIjILhLY7sCQmweTPSIUqFkD6XOyAUK1GIvpEO4D5kNaa+umFJIqYqtOONqxv7gHTJxxtL4qoqRiUyDggzDTvVIX4/cAmhk66u4Vp7M1koSy1EgxrreYXuP96VV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiT0xYCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1A9C4CEE8;
	Thu,  3 Apr 2025 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707131;
	bh=ePURtSpA1U+2aAC+6iPVCJE4ede696nUnEyd3K/kgvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiT0xYCanZ1GlJQOPsb9OkG2GjBYnZ3M2FAR9NP+h3rx6l8B4xqcXLsupcYYCyyIv
	 an6wZ3cZU3fXZvd6LC7az7yJDofr5WFTIT9GDqbSQ7dyCyH+gUKZh9TCgY6Sx2KbgA
	 3tKw/BJ93FiHmjvwLlBf3hM7DRDN4Wz8f+1mavIZDGY0+RWeyLTzzUMqO0HW5aSDNj
	 IB4ufsGsL7u/YBWBBBX9asrcOOe9WfbdZvLswjf5ON1np/XIWSZfU5mOA+gPF84QE9
	 JlZjCgveSwfiRoQiqIarU78mAAZMx2cXBYSzSpnLeakRMLUnYFUJ83L1w9PBcX8ypH
	 tMN8JbnAEhksQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 36/49] btrfs: reject out-of-band dirty folios during writeback
Date: Thu,  3 Apr 2025 15:03:55 -0400
Message-Id: <20250403190408.2676344-36-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7ca3e84980ef6484a5c6f004aa180b61ce0c37d9 ]

[OUT-OF-BAND DIRTY FOLIOS]
An out-of-band folio means the folio is marked dirty but without
notifying the filesystem.

This can lead to various problems, not limited to:

- No folio::private to track per block status

- No proper space reserved for such a dirty folio

[HISTORY IN BTRFS]
This used to be a problem related to get_user_page(), but with the
introduction of pin_user_pages*(), we should no longer hit such
case anymore.

In btrfs, we have a long history of catching such out-of-band dirty
folios by:

- Mark the folio ordered during delayed allocation

- Check the folio ordered flag during writeback
  If the folio has no ordered flag, it means it doesn't go through
  delayed allocation, thus it's definitely an out-of-band
  one.

  If we got one, we go through COW fixup, which will re-dirty the folio
  with proper handling in another workqueue.

[PROBLEMS OF COW-FIXUP]
Such workaround is a blockage for us to migrate to iomap (it requires
extra flags to trace if a folio is dirtied by the fs or not) and I'd
argue it's not data checksum safe, since if a folio can be marked dirty
without informing the fs, the content can also change at any time.

But with the introduction of pin_user_pages*() during v5.8 merge
window, such out-of-band dirty folio such be treated as a bug.
Ext4 has treated such case by warning and erroring out even before
pin_user_pages*().

Furthermore, there are already proofs that such folio ordered flag
tracking can be screwed up by incorrect error handling, check the commit
messages of the following commits:

 06f364284794 ("btrfs: do proper folio cleanup when cow_file_range() failed")
 c2b47df81c8e ("btrfs: do proper folio cleanup when run_delalloc_nocow() failed")

[FIXES]
Unlike btrfs, ext4 and xfs (iomap) never bother handling such
out-of-band dirty folios.

- Ext4 just warns and errors out
- Iomap always follows the folio/block dirty flags

And there is nothing really COW specific, xfs also supports COW too.

Here we take one step towards ext4 by doing warning and erroring out.
But since the cow fixup thing is introduced from the beginning, we keep
the old behavior for non-experimental builds, and only do the new warning
for experimental builds before we're 100% sure and remove cow fixup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 28 +++++++++++++++++++++++++++-
 fs/btrfs/inode.c     | 15 +++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 95d3cf2e15c84..33998bae09720 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1440,12 +1440,14 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	       start + len <= folio_start + folio_size(folio));
 
 	ret = btrfs_writepage_cow_fixup(folio);
-	if (ret) {
+	if (ret == -EAGAIN) {
 		/* Fixup worker will requeue */
 		folio_redirty_for_writepage(bio_ctrl->wbc, folio);
 		folio_unlock(folio);
 		return 1;
 	}
+	if (ret < 0)
+		return ret;
 
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
@@ -1549,6 +1551,30 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * The proper bitmap can only be initialized until writepage_delalloc().
 	 */
 	bio_ctrl->submit_bitmap = (unsigned long)-1;
+
+	/*
+	 * If the page is dirty but without private set, it's marked dirty
+	 * without informing the fs.
+	 * Nowadays that is a bug, since the introduction of
+	 * pin_user_pages*().
+	 *
+	 * So here we check if the page has private set to rule out such
+	 * case.
+	 * But we also have a long history of relying on the COW fixup,
+	 * so here we only enable this check for experimental builds until
+	 * we're sure it's safe.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) &&
+	    unlikely(!folio_test_private(folio))) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err_rl(fs_info,
+	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
+			     inode->root->root_key.objectid,
+			     btrfs_ino(inode), folio_pos(folio));
+		ret = -EUCLEAN;
+		goto done;
+	}
+
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto done;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d1acae2d6d33d..550dd1d997162 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2916,6 +2916,21 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
 	if (folio_test_ordered(folio))
 		return 0;
 
+	/*
+	 * For experimental build, we error out instead of EAGAIN.
+	 *
+	 * We should not hit such out-of-band dirty folios anymore.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err_rl(fs_info,
+	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
+			     BTRFS_I(inode)->root->root_key.objectid,
+			     btrfs_ino(BTRFS_I(inode)),
+			     folio_pos(folio));
+		return -EUCLEAN;
+	}
+
 	/*
 	 * folio_checked is set below when we create a fixup worker for this
 	 * folio, don't try to create another one if we're already
-- 
2.39.5


