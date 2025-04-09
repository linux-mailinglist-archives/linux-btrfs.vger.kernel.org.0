Return-Path: <linux-btrfs+bounces-12916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCEA82326
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D891BA647B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01DE25D53C;
	Wed,  9 Apr 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WETctSuM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C625D53F
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197068; cv=none; b=R93TBJZn5TxQdsQKZWU9g9wG0FGIYBNbRhXyEgEw1EVDcrE0m8gQNYcMkhyxtNv+T8C5zhO+P4r+BzhRUuk/q75LGGWK/hTT+CNnk6dr/Nn7W0Ho/0TWHY6ID8+oBbYjUxHT7+LfkBn582UQYa+yCLl10BvzuGqh+aS2rHFMX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197068; c=relaxed/simple;
	bh=pqJJ+r/ZiVLTPLkpqDhVxSzIlepvPMoKGmykym/O8vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8knWO2n8PpFWvbMtAsQSRcTuWGYv/sEVCxDxb7JydgqDdsok9wT50oc3DU5mgmTQlImO6VREqwYjUEkt3dqSJzGNLL6fOhSiUCVxOpp84VIrZqsVkyaToTa1qumfbUkZg/DEgA0GLLBRHhV/LIq+0OApd38W3uhtDufdMA4ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WETctSuM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kEUuj+OtHCfTkoZ3g5qvqntUY4zXty4hm79iNIM53Sw=; b=WETctSuMAbORDTvOYWncFcVDtJ
	rOwWC/AK48r00hmivivgovZokgT9osZZSgu61npjXbGo5T1xeFzhOgWUV6LrteHOAW3d+F3YMsZOE
	zgMRJtaMFdCRLRRzuUrQ0T/Re1i3VWQdqJQWiEblcz39qAIZ7XmCyakuMEyRLQU46I72Edz64PjTf
	7FppYR76rOgjLqFr1t9usit4+KrYE09j+1qi0usKLm0COitISC2/lcPj7k4ftUvfKIRlwa9UMdyeD
	StoRrUHye/EN+GmG0fBrCpr/VeDhycjOqAw+liMY9SreBCAp4pH3si1xBBjHywEtB3JVzUcfJtEYH
	qgRQscUQ==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKj-00000006x2x-3FiB;
	Wed, 09 Apr 2025 11:11:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: pass a physical address to btrfs_repair_io_failure
Date: Wed,  9 Apr 2025 13:10:37 +0200
Message-ID: <20250409111055.3640328-4-hch@lst.de>
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

This avoid stepping into bvec internals or complicated folio to
page offset calculations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c     | 9 ++++-----
 fs/btrfs/bio.h     | 3 +--
 fs/btrfs/disk-io.c | 7 ++++---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8c2eee1f1878..10f31ee1e8c0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -192,7 +192,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
 				  repair_bbio->file_offset, fs_info->sectorsize,
 				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
-				  page_folio(bv->bv_page), bv->bv_offset, mirror);
+				  bvec_phys(bv), mirror);
 	} while (mirror != fbio->bbio->mirror_num);
 
 done:
@@ -803,8 +803,8 @@ void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
  * freeing the bio.
  */
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			    u64 length, u64 logical, struct folio *folio,
-			    unsigned int folio_offset, int mirror_num)
+			    u64 length, u64 logical, phys_addr_t paddr,
+			    int mirror_num)
 {
 	struct btrfs_io_stripe smap = { 0 };
 	struct bio_vec bvec;
@@ -835,8 +835,7 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 
 	bio_init(&bio, smap.dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
 	bio.bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-	ret = bio_add_folio(&bio, folio, length, folio_offset);
-	ASSERT(ret);
+	__bio_add_page(&bio, phys_to_page(paddr), length, offset_in_page(paddr));
 	ret = submit_bio_wait(&bio);
 	if (ret) {
 		/* try to remap that extent elsewhere? */
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e2fe16074ad6..dc2eb43b7097 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -110,7 +110,6 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num);
 void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_replace);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			    u64 length, u64 logical, struct folio *folio,
-			    unsigned int folio_offset, int mirror_num);
+			    u64 length, u64 logical, phys_addr_t paddr, int mirror_num);
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3dd555db3d32..7cd1a7a775ed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -193,10 +193,11 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 		u64 end = min_t(u64, eb->start + eb->len,
 				folio_pos(folio) + eb->folio_size);
 		u32 len = end - start;
+		phys_addr_t paddr = PFN_PHYS(folio_pfn(folio)) +
+				    offset_in_folio(folio, start);
 
-		ret = btrfs_repair_io_failure(fs_info, 0, start, len,
-					      start, folio, offset_in_folio(folio, start),
-					      mirror_num);
+		ret = btrfs_repair_io_failure(fs_info, 0, start, len, start,
+					      paddr, mirror_num);
 		if (ret)
 			break;
 	}
-- 
2.47.2


