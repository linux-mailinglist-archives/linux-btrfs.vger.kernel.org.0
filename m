Return-Path: <linux-btrfs+bounces-954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AB88135E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A95282363
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B775F1E5;
	Thu, 14 Dec 2023 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s3s7p4/C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48812E8
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/qmrS5BPoMSmeLlMfhJ1H3Qeoqaj2aIAh9UA8EhQCUg=; b=s3s7p4/CNNw8Es44rxB9+kZDO1
	AvZkIbg0s5C1r9fYxaCnnuen7x6Hc6HARI8PhxLb3slNXc+V+74JRGpKFJj+eMuP4/19Wa8U6Hi0L
	JQrmyWeW3jie4CQBxWmf0LkeMekBcfGyBQVq6QUjkjb3OKwLqCQRQXMHucYT9lMiYFy0LUdWTo4C1
	BQlpkbGqqfWluTmA5k0fDj3JZyBmc5N1urajPFx6Ln48Z9N6Kfk/2nSp9bii+QLdW50hOl9ICYLfQ
	bLl+IxKJ6CQxXoM1AkgJMSTmLPoNpi/n7SG7SIQ51PFgTlXo5WpTIEhkdff79waRLFRVHExK138j9
	dygcsz8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDoL6-008U8D-TS; Thu, 14 Dec 2023 16:13:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs; Add set_folio_extent_mapped()
Date: Thu, 14 Dec 2023 16:13:29 +0000
Message-Id: <20231214161331.2022416-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231214161331.2022416-1-willy@infradead.org>
References: <20231214161331.2022416-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn set_page_extent_mapped() into a wrapper around this version.
Saves a call to compound_head() for callers who already have a folio
and removes a couple of users of page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c | 12 ++++++++----
 fs/btrfs/extent_io.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2a883c21c99f..ed75413aa9ae 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -936,17 +936,21 @@ static int attach_extent_buffer_folio(struct extent_buffer *eb,
 
 int set_page_extent_mapped(struct page *page)
 {
-	struct folio *folio = page_folio(page);
+	return set_folio_extent_mapped(page_folio(page));
+}
+
+int set_folio_extent_mapped(struct folio *folio)
+{
 	struct btrfs_fs_info *fs_info;
 
-	ASSERT(page->mapping);
+	ASSERT(folio->mapping);
 
 	if (folio_test_private(folio))
 		return 0;
 
-	fs_info = btrfs_sb(page->mapping->host->i_sb);
+	fs_info = btrfs_sb(folio->mapping->host->i_sb);
 
-	if (btrfs_is_subpage(fs_info, page->mapping))
+	if (btrfs_is_subpage(fs_info, folio->mapping))
 		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 
 	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 46050500529b..2c9d6570b0a3 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -221,6 +221,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 void extent_readahead(struct readahead_control *rac);
 int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len);
+int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);
 void clear_page_extent_mapped(struct page *page);
 
-- 
2.42.0


