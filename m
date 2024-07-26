Return-Path: <linux-btrfs+bounces-6746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8093D906
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56DB1C22CEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A164AEE9;
	Fri, 26 Jul 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mJGrd3NU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0713C906
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022605; cv=none; b=c58zj2o/DWM19Tb3ZbaNeWov2p2unlG2Cdoz4g8POMEs/eQI3rJ+eEx9nGlqslHzOQHU6OAIoVpauBOZ08/T2e1u6jP4/E2als68pBJnuHZ0ruRm0vrH4xRVZaRT9yk+c73HiNdv/FyfGDqPmAFPGl3NmeH+nXQQ5qZ+bhwQFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022605; c=relaxed/simple;
	bh=EOQPHU7SEgdcqQwwTcZPHsjTcuYBmIAEmkOd9Tn8XTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhdO+YZ0bG8mg0BpFUyvNBEw3GXft09apaEAtNgx1MxwrvVGNJYKaZ4sqc2yGnxzj9D14yBe1ls8yu5nkEIsD+L6PMWyJ6X46OWlKoIjhMiFSmUN0nE8/nq+WUceG+oA8ZBzdycTz+uMxQuTXqlaiCSHU0pnntx+CHW+qBaDnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mJGrd3NU; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so28233276.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022602; x=1722627402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQVE0OXmPQ/x7CQKYR+HYJOGhfTjku+I12S77YyhCyc=;
        b=mJGrd3NUVTypOdiBvO2EYez/iXuZAsQ0IfAqnjfjl1W3PIkEko3dl5ntzoeS80nV3x
         M9mZOMbt7HN4hKxhDapQVVzx9buDH+FqwRmuolHqmye1cvr7WYxjvnzQFyql80cnwe1O
         7PoL0zqmxedvRfkyVCf4mKexbgBgj8Z85iIrEN0/YPX2eyM0LqTN3vPypxDF832/9gBX
         2+wHvewyrAdBszARgJ8TTCkZaH2YZMVQ9LwGUYLyjV/uWjrGGlEv36PCyjmVCXOAAnFW
         TDzifhdFoc4q3vJsjq0ww7JjZU+fdirKqbZOYJ196IKL4zzjJm1I3l/hpXqxKev9X8su
         nBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022602; x=1722627402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQVE0OXmPQ/x7CQKYR+HYJOGhfTjku+I12S77YyhCyc=;
        b=cXupqWU43w8ZWea2cd/osxqteGtSV2iB2GA0GuM2GtNF6pi5y4Ck4gipnNKbxeFuk+
         Xt3lCEQwc9jttReMOIpt6a7mSRemapFFX9rPjYCpc28OXnRmWjMdVfCcjUWhBDizldO1
         B2TVg7AHKox8eGtO/mxHPc8ESfeMjSxu+rqpSMR/Z9Is1jQTZntBgnriMKBD5CcHfrC1
         EkSZQ2FtSLbE4d9Ef4aoxEk5QoNLRz6ezDFrnFhkycP27R5AY/HETpokR7Esce1do7l6
         yNVSRMBpdCG4pVEiiftCIKnxrZd3O8FcKqluKLkvclnR3tIZAaDB3okuyWxBAaUlfrWW
         qX+Q==
X-Gm-Message-State: AOJu0YwmJAIOZo4/+H9eBTf/vmiz83xEQuFCfWG1W1SyUqDbQbv1uSg+
	ukQOn/h/AqTUIsQssrd5O5rj+IlLI7g69auN3Ame2LU/+pfLTSp9KLPEdb3xn+JZLn78uMsnidn
	q
X-Google-Smtp-Source: AGHT+IGwNTHcyc73fVofjO9QTxK0G4jOA6jHrziIU0R4Gh/yfSSfjBFILqQT69ptjsptJA+YmQiGjA==
X-Received: by 2002:a05:6902:18cd:b0:e0b:11c6:cf77 with SMTP id 3f1490d57ef6-e0b5444181fmr1049564276.4.1722022602457;
        Fri, 26 Jul 2024 12:36:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f1c269sm850210276.11.2024.07.26.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 05/46] btrfs: convert submit_extent_page to use a folio
Date: Fri, 26 Jul 2024 15:35:52 -0400
Message-ID: <7e19f07bab70e05871b4dd10be116f6d194f2239.1722022376.git.josef@toxicpanda.com>
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

The callers of this helper are going to be converted to using a folio,
so adjust submit_extent_page to become submit_extent_folio and update it
to use all the relevant folio helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 89938800f37a..612855e17d04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -736,12 +736,13 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
 }
 
 static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
-				struct page *page, u64 disk_bytenr,
+				struct folio *folio, u64 disk_bytenr,
 				unsigned int pg_offset)
 {
 	struct bio *bio = &bio_ctrl->bbio->bio;
 	struct bio_vec *bvec = bio_last_bvec_all(bio);
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
+	struct folio *bv_folio = page_folio(bvec->bv_page);
 
 	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
 		/*
@@ -754,7 +755,7 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 	/*
 	 * The contig check requires the following conditions to be met:
 	 *
-	 * 1) The pages are belonging to the same inode
+	 * 1) The folios are belonging to the same inode
 	 *    This is implied by the call chain.
 	 *
 	 * 2) The range has adjacent logical bytenr
@@ -763,8 +764,8 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 	 *    This is required for the usage of btrfs_bio->file_offset.
 	 */
 	return bio_end_sector(bio) == sector &&
-		page_offset(bvec->bv_page) + bvec->bv_offset + bvec->bv_len ==
-		page_offset(page) + pg_offset;
+		folio_pos(bv_folio) + bvec->bv_offset + bvec->bv_len ==
+		folio_pos(folio) + pg_offset;
 }
 
 static void alloc_new_bio(struct btrfs_inode *inode,
@@ -817,17 +818,17 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  * The mirror number for this IO should already be initizlied in
  * @bio_ctrl->mirror_num.
  */
-static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
-			       u64 disk_bytenr, struct page *page,
+static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
+			       u64 disk_bytenr, struct folio *folio,
 			       size_t size, unsigned long pg_offset)
 {
-	struct btrfs_inode *inode = page_to_inode(page);
+	struct btrfs_inode *inode = folio_to_inode(folio);
 
 	ASSERT(pg_offset + size <= PAGE_SIZE);
 	ASSERT(bio_ctrl->end_io_func);
 
 	if (bio_ctrl->bbio &&
-	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
+	    !btrfs_bio_is_contig(bio_ctrl, folio, disk_bytenr, pg_offset))
 		submit_one_bio(bio_ctrl);
 
 	do {
@@ -836,7 +837,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bbio) {
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
-				      page_offset(page) + pg_offset);
+				      folio_pos(folio) + pg_offset);
 		}
 
 		/* Cap to the current ordered extent boundary if there is one. */
@@ -846,21 +847,22 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			len = bio_ctrl->len_to_oe_boundary;
 		}
 
-		if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) != len) {
+		if (!bio_add_folio(&bio_ctrl->bbio->bio, folio, len, pg_offset)) {
 			/* bio full: move on to a new one */
 			submit_one_bio(bio_ctrl);
 			continue;
 		}
 
 		if (bio_ctrl->wbc)
-			wbc_account_cgroup_owner(bio_ctrl->wbc, page, len);
+			wbc_account_cgroup_owner(bio_ctrl->wbc, &folio->page,
+						 len);
 
 		size -= len;
 		pg_offset += len;
 		disk_bytenr += len;
 
 		/*
-		 * len_to_oe_boundary defaults to U32_MAX, which isn't page or
+		 * len_to_oe_boundary defaults to U32_MAX, which isn't folio or
 		 * sector aligned.  alloc_new_bio() then sets it to the end of
 		 * our ordered extent for writes into zoned devices.
 		 *
@@ -870,15 +872,15 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 		 * boundary is correct.
 		 *
 		 * When len_to_oe_boundary is U32_MAX, the cap above would
-		 * result in a 4095 byte IO for the last page right before
-		 * we hit the bio limit of UINT_MAX.  bio_add_page() has all
+		 * result in a 4095 byte IO for the last folio right before
+		 * we hit the bio limit of UINT_MAX.  bio_add_folio() has all
 		 * the checks required to make sure we don't overflow the bio,
 		 * and we should just ignore len_to_oe_boundary completely
 		 * unless we're using it to track an ordered extent.
 		 *
 		 * It's pretty hard to make a bio sized U32_MAX, but it can
 		 * happen when the page cache is able to feed us contiguous
-		 * pages for large extents.
+		 * folios for large extents.
 		 */
 		if (bio_ctrl->len_to_oe_boundary != U32_MAX)
 			bio_ctrl->len_to_oe_boundary -= len;
@@ -1143,8 +1145,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
-		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
-				   pg_offset);
+		submit_extent_folio(bio_ctrl, disk_bytenr, page_folio(page),
+				    iosize, pg_offset);
 		cur = cur + iosize;
 		pg_offset += iosize;
 	}
@@ -1489,8 +1491,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 */
 		btrfs_folio_clear_dirty(fs_info, page_folio(page), cur, iosize);
 
-		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
-				   cur - page_offset(page));
+		submit_extent_folio(bio_ctrl, disk_bytenr, page_folio(page),
+				    iosize, cur - page_offset(page));
 		cur += iosize;
 		nr++;
 	}
@@ -2087,7 +2089,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	 *   extent io tree. Thus we don't want to submit such wild eb
 	 *   if the fs already has error.
 	 *
-	 * We can get ret > 0 from submit_extent_page() indicating how many ebs
+	 * We can get ret > 0 from submit_extent_folio() indicating how many ebs
 	 * were submitted. Reset it to 0 to avoid false alerts for the caller.
 	 */
 	if (ret > 0)
-- 
2.43.0


