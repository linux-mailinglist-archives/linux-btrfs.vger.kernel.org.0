Return-Path: <linux-btrfs+bounces-11022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174AA1770D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 06:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8022F16A82A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB941A83FF;
	Tue, 21 Jan 2025 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9wPppq4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A7186294
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737438068; cv=none; b=LALb6SKbmxTrBp5R8SIfZ0sICpY72u7inVbRBOqNvU23AxF15Q0cBXXceNa0N2Nxnx23Q1kesWO99W9bIdc0ls5SitGkPFEF9Wh5Ass1sw6lnDczF8x0kDR46QNOdZgyVMmg00VjrF+cCRAZBVnK1xx/BlX4liLrVO9oAw4SdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737438068; c=relaxed/simple;
	bh=u9iqc57eA2zxMxH1mCMDuDHH4BeYNO+vIX0n+wdwjDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXrHsye7t8DDvu9U+M2C6GswD7sXHRaL+A8wwZz5SNsEdMSzFHzWGmNUI27/+/Kei9EQICtCQYtxNeJRe2+pi5vNc+pJWbG9UdHIErOhkRJM0+vq4KatggYqE7tbKSxG8gYFUnKQGqzz7X/GblvKJqjkjCmRGsW++R3IRUQWVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O9wPppq4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DAh0k2mJ/GS9vAqxrcKTv4tbOvrp8qhgNNZHB3KsRC0=; b=O9wPppq44u6c6/Lpd1VA0hWSiR
	iYOqT64srPrlrbbvkamGedvNjrogYiYPVIaO2sKE/jhSZdc/ZH7+6ZHNsd9cu+qe0bx49fn+mXgam
	eCzzGyjN9UWeCvJxK9EnZfwnlBuJ8sTATlGYpXmBx2nW++tnxis7Voygx7ggvxj+WGHTCd23zMybS
	7raFrSR5RpCPM3hhM6KY4DFPKQdvMLXbmZhk5AtXl3mz4f8seqHWmZ+kaG6AAe8HeeHtCK3vyV9ms
	ON8PqxasKZdFsLSYYaNaBehj7hjdFj/2i02FqsdCF6NqEviRUtpY9vv13olsk49TcKAIGgDNiYG7b
	herC5x3w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ta70T-0000000Goqo-0a2x;
	Tue, 21 Jan 2025 05:40:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: Convert io_ctl_prepare_pages() to work on folios
Date: Tue, 21 Jan 2025 05:40:52 +0000
Message-ID: <20250121054054.4008049-3-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121054054.4008049-1-willy@infradead.org>
References: <20250121054054.4008049-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve folios instead of pages and work on them throughout.  Removes
a few calls to compound_head() and a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/free-space-cache.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d42b6f882f57..93b3b7c23d9b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -447,7 +447,7 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
 
 static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 {
-	struct page *page;
+	struct folio *folio;
 	struct inode *inode = io_ctl->inode;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
 	int i;
@@ -455,31 +455,32 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 	for (i = 0; i < io_ctl->num_pages; i++) {
 		int ret;
 
-		page = find_or_create_page(inode->i_mapping, i, mask);
-		if (!page) {
+		folio = __filemap_get_folio(inode->i_mapping, i,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+		if (IS_ERR(folio)) {
 			io_ctl_drop_pages(io_ctl);
 			return -ENOMEM;
 		}
 
-		ret = set_folio_extent_mapped(page_folio(page));
+		ret = set_folio_extent_mapped(folio);
 		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			io_ctl_drop_pages(io_ctl);
 			return ret;
 		}
 
-		io_ctl->pages[i] = page;
-		if (uptodate && !PageUptodate(page)) {
-			btrfs_read_folio(NULL, page_folio(page));
-			lock_page(page);
-			if (page->mapping != inode->i_mapping) {
+		io_ctl->pages[i] = &folio->page;
+		if (uptodate && !folio_test_uptodate(folio)) {
+			btrfs_read_folio(NULL, folio);
+			folio_lock(folio);
+			if (folio->mapping != inode->i_mapping) {
 				btrfs_err(BTRFS_I(inode)->root->fs_info,
 					  "free space cache page truncated");
 				io_ctl_drop_pages(io_ctl);
 				return -EIO;
 			}
-			if (!PageUptodate(page)) {
+			if (!folio_test_uptodate(folio)) {
 				btrfs_err(BTRFS_I(inode)->root->fs_info,
 					   "error reading free space cache");
 				io_ctl_drop_pages(io_ctl);
-- 
2.45.2


