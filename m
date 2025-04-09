Return-Path: <linux-btrfs+bounces-12917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A7A8232A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BA84A52D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1C25D914;
	Wed,  9 Apr 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Acwc1h0k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7425DCE0
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197070; cv=none; b=i4Y5i2XDpdYqxG2bmQIK3BgpcFaLNWbO+zWZIHqWC42DLUFleFVallSTnapxgIDpHMijiSub+P4gcZ1KmCV+eXi0OAiElyO/6JucNSJQeDHNdajqGpGUGbyU+309JTdyEBdmKxzZ07h0YgzyJA28YCnwORx8REYb2gktveR21dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197070; c=relaxed/simple;
	bh=E6w/M7PvT1O6OihdyqLHK5Apgsv6iCIvOm2SW7VPE4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do8SeCzmQVLg/0RMb6ceRw5Kz8sbniZEAoVllgQ34XUvr2+ETyRQW5BY6WfSCCtPx/RdIsC484Dy9zSrn7GI3lqaAP5+9nb769OCNrCOocwC85k3b0qup/VX6jxJ/VK9JAsEcjFH9luOfZWYu3U1Shvy8576nXuvUKgC4+rIcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Acwc1h0k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C8HXceTTYZJpmuGgmJa2BLjJiIZMB1IkRB9M1dAXZ2g=; b=Acwc1h0kgrq1B0HC8yfwX3ssuc
	lpGUzXI02REP6Nt+q5HQd2CgiKLGoJG1xY1RfFy2PrqmND9SWscwTdmnfl96z3lDfBSTg3z9zURk5
	8SYp45PRk9Jki3PvJT8iUaf/uLgYTSiMt+ghnq0JlOA64W8RegemFEBJxUTaP1JXFQ1jAiN6uPlC5
	OBmLP1sk/NRxqyR/+KYTuhyejF5C72VD2K/1Cy+8hdKCeGQBE5tusdFZ3DFnpA7FMrCCx2bbXR6rK
	qDqv0sLxcaS9Hgjw8kjqUbnUcJ9n1xobLP/iu6C3ASe15VgZLg0+jxfttz8xQp2CRWtzHc4UZd62d
	3LA2OqYg==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKm-00000006x36-0i7I;
	Wed, 09 Apr 2025 11:11:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: move kmapping out of btrfs_check_sector_csum
Date: Wed,  9 Apr 2025 13:10:38 +0200
Message-ID: <20250409111055.3640328-5-hch@lst.de>
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

Move kmapping the page out of btrfs_check_sector_csum.  This allows
using bvec_kmap_local where suitable and reduces the number of kmap
calls in the raid56 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h |  4 ++--
 fs/btrfs/inode.c       | 18 ++++++++----------
 fs/btrfs/raid56.c      | 19 +++++++++++--------
 fs/btrfs/scrub.c       |  5 ++++-
 4 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4e2952cf5766..d48438332c7c 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -529,8 +529,8 @@ static inline void btrfs_update_inode_mapping_flags(struct btrfs_inode *inode)
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
-int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
-			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
+int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, void *kaddr,
+		u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cc67d1a2d611..665df96af134 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3337,19 +3337,13 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
  * Verify the checksum for a single sector without any extra action that depend
  * on the type of I/O.
  */
-int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
-			    u32 pgoff, u8 *csum, const u8 * const csum_expected)
+int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, void *kaddr,
+			    u8 *csum, const u8 * const csum_expected)
 {
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	char *kaddr;
-
-	ASSERT(pgoff + fs_info->sectorsize <= PAGE_SIZE);
 
 	shash->tfm = fs_info->csum_shash;
-
-	kaddr = kmap_local_page(page) + pgoff;
 	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
-	kunmap_local(kaddr);
 
 	if (memcmp(csum, csum_expected, fs_info->csum_size))
 		return -EIO;
@@ -3378,6 +3372,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 	u64 end = file_offset + bv->bv_len - 1;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
+	char *kaddr;
 
 	ASSERT(bv->bv_len == fs_info->sectorsize);
 
@@ -3395,9 +3390,12 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 
 	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
 				fs_info->csum_size;
-	if (btrfs_check_sector_csum(fs_info, bv->bv_page, bv->bv_offset, csum,
-				    csum_expected))
+	kaddr = bvec_kmap_local(bv);
+	if (btrfs_check_sector_csum(fs_info, kaddr, csum, csum_expected)) {
+		kunmap_local(kaddr);
 		goto zeroit;
+	}
+	kunmap_local(kaddr);
 	return true;
 
 zeroit:
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index cdd373c27784..28dbded86cc2 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1575,11 +1575,11 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 		return;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		int bv_offset;
+		void *kaddr = bvec_kmap_local(bvec);
+		unsigned int off;
 
-		for (bv_offset = bvec->bv_offset;
-		     bv_offset < bvec->bv_offset + bvec->bv_len;
-		     bv_offset += fs_info->sectorsize, total_sector_nr++) {
+		for (off = 0; off < bvec->bv_len;
+		     off += fs_info->sectorsize, total_sector_nr++) {
 			u8 csum_buf[BTRFS_CSUM_SIZE];
 			u8 *expected_csum = rbio->csum_buf +
 					    total_sector_nr * fs_info->csum_size;
@@ -1589,11 +1589,12 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
 				continue;
 
-			ret = btrfs_check_sector_csum(fs_info, bvec->bv_page,
-				bv_offset, csum_buf, expected_csum);
+			ret = btrfs_check_sector_csum(fs_info, kaddr + off,
+					csum_buf, expected_csum);
 			if (ret < 0)
 				set_bit(total_sector_nr, rbio->error_bitmap);
 		}
+		kunmap_local(kaddr);
 	}
 }
 
@@ -1791,6 +1792,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	struct sector_ptr *sector;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
+	void *kaddr;
 	int ret;
 
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
@@ -1811,11 +1813,12 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 
 	ASSERT(sector->page);
 
+	kaddr = kmap_local_page(sector->page) + sector->pgoff;
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
-	ret = btrfs_check_sector_csum(fs_info, sector->page, sector->pgoff,
-				      csum_buf, csum_expected);
+	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, csum_expected);
+	kunmap_local(kaddr);
 	return ret;
 }
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c5edcee9450..49021765c17b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -694,6 +694,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 	struct page *page = scrub_stripe_get_page(stripe, sector_nr);
 	unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
 	u8 csum_buf[BTRFS_CSUM_SIZE];
+	void *kaddr;
 	int ret;
 
 	ASSERT(sector_nr >= 0 && sector_nr < stripe->nr_sectors);
@@ -737,7 +738,9 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		return;
 	}
 
-	ret = btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf, sector->csum);
+	kaddr = kmap_local_page(page) + pgoff;
+	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, sector->csum);
+	kunmap_local(kaddr);
 	if (ret < 0) {
 		set_bit(sector_nr, &stripe->csum_error_bitmap);
 		set_bit(sector_nr, &stripe->error_bitmap);
-- 
2.47.2


