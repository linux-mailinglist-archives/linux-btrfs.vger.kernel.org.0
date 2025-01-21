Return-Path: <linux-btrfs+bounces-11020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6BFA1770C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 06:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D9616A719
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 05:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EB186E2D;
	Tue, 21 Jan 2025 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WptGDNoI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFE383
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737438061; cv=none; b=mxrnJ5r7kBbq/jw1wU/U8wzKl0dfIX4IrU+jbMLTiMDnJZhPHaSe4l0AHmOk9sqsoAQ5mYke8u1bzHLe1DCHOT3jC6WmG5jbijvIS/AEBeUavwGQ2fDl2xgTCe/KcQSFMoAhX//agTbd5+afk4TPoexEgU40eWJxxp4WwPvnq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737438061; c=relaxed/simple;
	bh=G4h7wsaf1vbHChA8TMND0v8wv3ioNYMZXIEaJNqfR0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvylSr96swqA90tpCAeMcLdo47JL6TrUZUPfdDPKLfPQk86Zm2+e0eoc6KwMiljxvbUSYBMPUjiaCX6c63X+Tmqq6r8ufTCKW8oF9aqnBB/nxgyqgNUzVpbsf2Sj3gdiaSu0RagwubAKcO+0qbI9FmowGN6L68+CaP82LD+WGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WptGDNoI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hFKBKu9dBNcaqcVIBeJc6x5eex0H5M15e74DHK9fFQ4=; b=WptGDNoI3AEThfdNsTZJnVaFWG
	T4aK+vXFO2S6KDmO6vxBBW52Bajd2+AIFCHS1hxu9JeJRaNfaYtTJpclGvO0IKe4LV2rWeVaLXb5a
	wcj2xVdEeT+9Nr7uoKYBvPqaLnV065nq3XwqXSjIdZvF6hdKHZ537rE2uHNKSFIqvswDdXpUA4jpn
	cgKgWg07axgzNWNWIC2gJOMPRkifDL55u8aGdojJO13Dscw/Ju9RIXi0BuhlReUZ4TanFqZdornqk
	GgPYMNUobw0iPFIBFbqua5LBTW/qyeffguyVXecHhLbDoozAFYMpWBcusPC4mHXwYj2hfxIDFVT7G
	+4viNq+g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ta70S-0000000GoqB-3zzO;
	Tue, 21 Jan 2025 05:40:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: Fix some folio-related comments
Date: Tue, 21 Jan 2025 05:40:50 +0000
Message-ID: <20250121054054.4008049-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove references to the page lock and page->mapping.  Also
btrfs folios can never be swizzled into swap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c | 8 +++-----
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/subpage.c   | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d9f856358704..289ecb8ce217 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2189,10 +2189,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			done_index = folio_next_index(folio);
 			/*
 			 * At this point we hold neither the i_pages lock nor
-			 * the page lock: the page may be truncated or
-			 * invalidated (changing page->mapping to NULL),
-			 * or even swizzled back from swapper_space to
-			 * tmpfs file mapping
+			 * the folio lock: the folio may be truncated or
+			 * invalidated (changing folio->mapping to NULL)
 			 */
 			if (!folio_trylock(folio)) {
 				submit_write_bio(bio_ctrl, 0);
@@ -3222,7 +3220,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	/*
 	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
-	 * so it can be cleaned up without utilizing page->mapping.
+	 * so it can be cleaned up without utilizing folio->mapping.
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fe2c810335ff..e6ea4f172b50 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2891,7 +2891,7 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
 	 * We are already holding a reference to this inode from
 	 * write_cache_pages.  We need to hold it because the space reservation
 	 * takes place outside of the folio lock, and we can't trust
-	 * page->mapping outside of the folio lock.
+	 * folio->mapping outside of the folio lock.
 	 */
 	ihold(inode);
 	btrfs_folio_set_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 722acf768396..6a8636c0ffed 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -72,7 +72,7 @@ bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space
 
 	/*
 	 * Only data pages (either through DIO or compression) can have no
-	 * mapping. And if page->mapping->host is data inode, it's subpage.
+	 * mapping. And if mapping->host is data inode, it's subpage.
 	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
 	 */
 	if (!mapping || !mapping->host || is_data_inode(BTRFS_I(mapping->host)))
-- 
2.45.2


