Return-Path: <linux-btrfs+bounces-6752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B4393D90C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32136B23572
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC01494DA;
	Fri, 26 Jul 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QelRh/nz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318414830D
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022611; cv=none; b=ZansR4brEbs+4LxfALJ4l0qFNMD097jv6cDcJpJKOurzTubw4pZXAG/7K4MZoREgb/g8K+4qypMQ6fFyn4zI9AyLiyuyjC0y7m0sce0237TJGJ9/6hAMliwQfxEewqTLnA2Y5Fje8vmIfhLk0j9GrCkZuC2B94tn6EYhllQBqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022611; c=relaxed/simple;
	bh=jpzqse+sJwITVScHg11kpahLKpVH6EhTUgUvkvScyPc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN/a/EuI36TgQjxm1upFSavbVRPC04h7UkafM8iGNvlwtPtMQwafR9yfvTiir+ewtnVaUN1UxIIQD4O5RYJiIOZoMdV3BCuyA1sweHuiaGWwOV/79k1mC/qIh/yo83yyCV+jXJ2Y9rbrzTbguCbTyo3CFChnH+Xof9bt4yBQDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QelRh/nz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-661369ff30aso250287b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022609; x=1722627409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpVclNxiHsXPViPqbtHO98PVPv965lezjoyg5+4dMsg=;
        b=QelRh/nzZuP3BGQ3C8f3bWmQ2QykSURFupo3TxTOCvIml5D7NGHofsRSPTcOOL64Q8
         HcZ3fwIfxdk6WFqwoHOkIz++nWP7IhaL3aiO8b1nZJnn2tT3nX4ZeDoQ5syFO2YRrhhJ
         rbbL/p+l/PnpnmPboAdkazDk2nsFarXjOpd4R/BB6u2zGT1MgkHLB5efI3cyFtAtxFuf
         68DqSmiUUCuques0HnAfWpU5FkmJA8IcfVBZGQO9xaC4GhSe0KQFCTvF/oSQftTNj7PK
         hw7bRJVKPX6ozE+y0cm8ZSyeFhD1Fxexg7eaFiAzBmE0OFjnY1V8vHYqa7bJXUiXRHcL
         k0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022609; x=1722627409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpVclNxiHsXPViPqbtHO98PVPv965lezjoyg5+4dMsg=;
        b=eX2fU7mhxySaHn4jrRw/iEzdsiTUeUkPhv7WZobjrrQMC31UL483DOKbz23r35i0w0
         NCns+zm8SoNrBUS77F88roznJJjt0eEJKBXSSBGjALZpAHBwd3Q2nj8Q/hHn2UJ5ay25
         3zLXRxgWwTDlXwb/0RLyeVE1AlrbJBvYmt59D73oS0Ezjxd80+HuJU/oTzSfApvvVeKG
         pS6ELCiciMo/rgL7LUe7Nl34Vs4oeMYox5dsWFVz3J+KZIgIUFHSuaq16c9gS+8Rm1yr
         P1O+h9KL/LE4kq3MXsFnFj36AmeXZ46ZTVV8kdUh9p/KSCZlGmOD94FTvXtQmq8SKKyG
         YXJQ==
X-Gm-Message-State: AOJu0Yy1jJVJY5KytAd/Zn06iFXFrPibO48IUzk4/oVVzkJBldjyhK/U
	b2wOYz9BtvkSLozTOjIMwCmjA+R58E1UUnmtCxQIqZAG0cDQoUgSHV1rIUSRzmZnFOAMiDZVGBi
	B
X-Google-Smtp-Source: AGHT+IGDO8w7NUq4vVxu89cHS1ZCir0PEL+TyYrjXZrTdTE9Gx8szrNDKELSQGJvzXsUdU1ECwTtJQ==
X-Received: by 2002:a0d:e542:0:b0:64a:d5fd:f198 with SMTP id 00721157ae682-67a053e0cb3mr9741087b3.6.1722022608684;
        Fri, 26 Jul 2024 12:36:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756be88de8sm10025827b3.131.2024.07.26.12.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 11/46] btrfs: convert add_ra_bio_pages to use only folios
Date: Fri, 26 Jul 2024 15:35:58 -0400
Message-ID: <929b6a9f0bc30212f5633a9f9a75aabb94b61cf5.1722022376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Willy is going to get rid of page->index, and add_ra_bio_pages uses
page->index.  Make his life easier by converting add_ra_bio_pages to use
folios so that we are no longer using page->index.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 62 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a8e2c461aff7..832ab8984c41 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -420,7 +420,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	u64 cur = cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
 	u64 isize = i_size_read(inode);
 	int ret;
-	struct page *page;
+	struct folio *folio;
 	struct extent_map *em;
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
@@ -453,9 +453,13 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (pg_index > end_index)
 			break;
 
-		page = xa_load(&mapping->i_pages, pg_index);
-		if (page && !xa_is_value(page)) {
-			sectors_missed += (PAGE_SIZE - offset_in_page(cur)) >>
+		folio = __filemap_get_folio(mapping, pg_index, 0, 0);
+		if (!IS_ERR(folio)) {
+			u64 folio_sz = folio_size(folio);
+			u64 offset = offset_in_folio(folio, cur);
+
+			folio_put(folio);
+			sectors_missed += (folio_sz - offset) >>
 					  fs_info->sectorsize_bits;
 
 			/* Beyond threshold, no need to continue */
@@ -466,35 +470,35 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			 * Jump to next page start as we already have page for
 			 * current offset.
 			 */
-			cur = (pg_index << PAGE_SHIFT) + PAGE_SIZE;
+			cur += (folio_sz - offset);
 			continue;
 		}
 
-		page = __page_cache_alloc(mapping_gfp_constraint(mapping,
-								 ~__GFP_FS));
-		if (!page)
+		folio = filemap_alloc_folio(mapping_gfp_constraint(mapping,
+								   ~__GFP_FS), 0);
+		if (!folio)
 			break;
 
-		if (add_to_page_cache_lru(page, mapping, pg_index, GFP_NOFS)) {
-			put_page(page);
+		if (filemap_add_folio(mapping, folio, pg_index, GFP_NOFS)) {
 			/* There is already a page, skip to page end */
-			cur = (pg_index << PAGE_SHIFT) + PAGE_SIZE;
+			cur += folio_size(folio);
+			folio_put(folio);
 			continue;
 		}
 
-		if (!*memstall && PageWorkingset(page)) {
+		if (!*memstall && folio_test_workingset(folio)) {
 			psi_memstall_enter(pflags);
 			*memstall = 1;
 		}
 
-		ret = set_page_extent_mapped(page);
+		ret = set_folio_extent_mapped(folio);
 		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			break;
 		}
 
-		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
+		page_end = (pg_index << PAGE_SHIFT) + folio_size(folio) - 1;
 		lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
@@ -511,28 +515,28 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, cur, page_end, NULL);
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			break;
 		}
 		add_size = min(em->start + em->len, page_end + 1) - cur;
 		free_extent_map(em);
 
-		if (page->index == end_index) {
-			size_t zero_offset = offset_in_page(isize);
+		if (folio->index == end_index) {
+			size_t zero_offset = offset_in_folio(folio, isize);
 
 			if (zero_offset) {
 				int zeros;
-				zeros = PAGE_SIZE - zero_offset;
-				memzero_page(page, zero_offset, zeros);
+				zeros = folio_size(folio) - zero_offset;
+				folio_zero_range(folio, zero_offset, zeros);
 			}
 		}
 
-		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
-		if (ret != add_size) {
+		if (!bio_add_folio(orig_bio, folio, add_size,
+				   offset_in_folio(folio, cur))) {
 			unlock_extent(tree, cur, page_end, NULL);
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			break;
 		}
 		/*
@@ -541,9 +545,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers and to unlock the page.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE)
-			btrfs_subpage_start_reader(fs_info, page_folio(page),
-						   cur, add_size);
-		put_page(page);
+			btrfs_subpage_start_reader(fs_info, folio, cur,
+						   add_size);
+		folio_put(folio);
 		cur += add_size;
 	}
 	return 0;
-- 
2.43.0


