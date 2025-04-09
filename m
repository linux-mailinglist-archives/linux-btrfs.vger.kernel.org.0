Return-Path: <linux-btrfs+bounces-12915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF8A82325
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE7F1BA629C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5FA25DB13;
	Wed,  9 Apr 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTV/5wBU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D925D53F
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197065; cv=none; b=m8fjeptSq97WvpewNXs/oa4CltsiUdP53uVtdn9w0QOMEHWrG8Cx5hnrc3O8uVQfXSlaKosPb/3oeB7VQW16pH/ZBVdoti0R8GSZshC0hliI/TwUw0AKEOOLX+6rubustg3xCyosgM/jS+KrpQZjQc2t04u0PaA0zOk/KzFV/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197065; c=relaxed/simple;
	bh=v1gYgagkCPcDqpaHsyJP43fQyWpmD8ll4D9vaR/0TK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoFGOprwZIngjtb55e8Zv6VpyvZy4RdIAOw5jSMCkyF7MAnygIPgByFj0wowV9oCCBJETIKHKLSJLY+6s2P7sA87S2S4SLJaM4wh7rP0g4z0ok18BjLMCQuUldU0Zpd7czUpfe+ODmN0gvc3B3vK3O8iu3ejZXdlIB6nGqAurns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZTV/5wBU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GFZyyeuiTlSJ00Ar9J+XxphqmRT4l1uhBCS9xQ8Tho4=; b=ZTV/5wBURH3PPWF/bdCNR/dvMZ
	qEj/dFG29FxkkKvSCXPUt6BuDMpDhilG8OMyf7DQcwyq+Hd9B3BPrKXBDKXASgZGqvpObK3gSef0M
	AhZODRGcONYEstdFekURGePzx9br6KWiUHUTyCYLep4ePROAK7P3DacG4+/R9eE8fspH1mQMpz5T5
	Q7M+rgNGwLErELpAdYePqDpB3vZHNgJBqg5Xi5WgxsW8P6HA94LdkewnTdbsO2CZ9QFextijtxnCr
	nmaqBvvhvQfC1LiR5cxbMJBz8F/p/8dd3HJn8tDfJtlC2rUSRJwPpzk1j8wAtzUv5icNd7dun24TG
	ismMXmoA==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKh-00000006x2Y-206e;
	Wed, 09 Apr 2025 11:11:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: track the next file offset in struct btrfs_bio_ctrl
Date: Wed,  9 Apr 2025 13:10:36 +0200
Message-ID: <20250409111055.3640328-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409111055.3640328-1-hch@lst.de>
References: <20250409111055.3640328-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Stop poking into bio implementation details and recalculating the pos
from the folio over and over and instead just track then end of the
current bio in logical file offsets in the btrfs_bio_ctrl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 193736b07a0b..36db23f7a6bb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -96,6 +96,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
  */
 struct btrfs_bio_ctrl {
 	struct btrfs_bio *bbio;
+	loff_t next_file_offset; /* last byte contained in bbio + 1 */
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
 	blk_opf_t opf;
@@ -643,13 +644,10 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
 }
 
 static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
-				struct folio *folio, u64 disk_bytenr,
-				unsigned int pg_offset)
+				u64 disk_bytenr, loff_t file_offset)
 {
 	struct bio *bio = &bio_ctrl->bbio->bio;
-	struct bio_vec *bvec = bio_last_bvec_all(bio);
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
-	struct folio *bv_folio = page_folio(bvec->bv_page);
 
 	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
 		/*
@@ -660,19 +658,11 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 	}
 
 	/*
-	 * The contig check requires the following conditions to be met:
-	 *
-	 * 1) The folios are belonging to the same inode
-	 *    This is implied by the call chain.
-	 *
-	 * 2) The range has adjacent logical bytenr
-	 *
-	 * 3) The range has adjacent file offset
-	 *    This is required for the usage of btrfs_bio->file_offset.
+	 * To merge into a bio both the disk sector and the logical offset in
+	 * the file need to be contiguous.
 	 */
-	return bio_end_sector(bio) == sector &&
-		folio_pos(bv_folio) + bvec->bv_offset + bvec->bv_len ==
-		folio_pos(folio) + pg_offset;
+	return bio_ctrl->next_file_offset == file_offset &&
+		bio_end_sector(bio) == sector;
 }
 
 static void alloc_new_bio(struct btrfs_inode *inode,
@@ -690,6 +680,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	bbio->file_offset = file_offset;
 	bio_ctrl->bbio = bbio;
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
+	bio_ctrl->next_file_offset = file_offset;
 
 	/* Limit data write bios to the ordered boundary. */
 	if (bio_ctrl->wbc) {
@@ -731,12 +722,13 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 			       size_t size, unsigned long pg_offset)
 {
 	struct btrfs_inode *inode = folio_to_inode(folio);
+	loff_t file_offset = folio_pos(folio) + pg_offset;
 
 	ASSERT(pg_offset + size <= folio_size(folio));
 	ASSERT(bio_ctrl->end_io_func);
 
 	if (bio_ctrl->bbio &&
-	    !btrfs_bio_is_contig(bio_ctrl, folio, disk_bytenr, pg_offset))
+	    !btrfs_bio_is_contig(bio_ctrl, disk_bytenr, file_offset))
 		submit_one_bio(bio_ctrl);
 
 	do {
@@ -745,7 +737,7 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bbio) {
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
-				      folio_pos(folio) + pg_offset);
+				      file_offset);
 		}
 
 		/* Cap to the current ordered extent boundary if there is one. */
@@ -760,14 +752,15 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 			submit_one_bio(bio_ctrl);
 			continue;
 		}
+		bio_ctrl->next_file_offset += len;
 
 		if (bio_ctrl->wbc)
-			wbc_account_cgroup_owner(bio_ctrl->wbc, folio,
-						 len);
+			wbc_account_cgroup_owner(bio_ctrl->wbc, folio, len);
 
 		size -= len;
 		pg_offset += len;
 		disk_bytenr += len;
+		file_offset += len;
 
 		/*
 		 * len_to_oe_boundary defaults to U32_MAX, which isn't folio or
-- 
2.47.2


