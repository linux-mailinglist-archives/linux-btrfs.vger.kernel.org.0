Return-Path: <linux-btrfs+bounces-13176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9FA94213
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D35D3B663B
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC7319F120;
	Sat, 19 Apr 2025 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DX7A+KVX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DX7A+KVX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B952AE66
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047083; cv=none; b=IobHJtAH+fDkwzn0uRvtx1JV6xH6jfmOAkg6s2s1229Ru1cqKplE4z1ZZd0bC6eyrVa+dHtiKIxNSPET2R6mNDYYoQbQ+yD6aCycdvE17n9WgGVXfullrLByjSLA5lNE8UWWw1+o+k+yFtoPSLc6BByeL99EcHmhN031qEd0Kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047083; c=relaxed/simple;
	bh=Q//FHc6j99RgODm4BSvUiHpQV/ksLVudVUC1/+Uv95U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9pBQ+igC/v6jjZMlCUqSvCumFugtDf9P6s/Dh2MjCqw5JbKUxa6kLdNgtmiUNviQCE6iUhGYx389E3NkOhhzG4mF+LjiP/aLP+Y00g4WdIg2NxExaNyrrp1/R6peuIxBS2EFPjHP4EK5zn3l+2nmaZJ2SHJhkT56ExwSUcwXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DX7A+KVX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DX7A+KVX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB21A2120A;
	Sat, 19 Apr 2025 07:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+dFbDSSwnB3Yl2pOM1596TBzTFYQ/X99TpwqxSRh7g=;
	b=DX7A+KVXWYMW/8jljvS+SyZg1r+slKsOy49inJ103sPxKbqYMUdTTLczfBpZkOriRo4jEy
	50LvcwKpMUm4UM44RdvI6DbIB+vjMkA676i5NpZIg6A/jGfbEX3HK3a3AE8WlWWlv3ivUh
	C58D4iHE/F5ywgOwAei+CAoyDaztYtM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+dFbDSSwnB3Yl2pOM1596TBzTFYQ/X99TpwqxSRh7g=;
	b=DX7A+KVXWYMW/8jljvS+SyZg1r+slKsOy49inJ103sPxKbqYMUdTTLczfBpZkOriRo4jEy
	50LvcwKpMUm4UM44RdvI6DbIB+vjMkA676i5NpZIg6A/jGfbEX3HK3a3AE8WlWWlv3ivUh
	C58D4iHE/F5ywgOwAei+CAoyDaztYtM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8636A13942;
	Sat, 19 Apr 2025 07:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CASbEhdOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 4/8] btrfs: move kmapping out of btrfs_check_sector_csum
Date: Sat, 19 Apr 2025 16:47:11 +0930
Message-ID: <24228ac23b86671e7d80f335e203dc2a4fb6d1fd.1745024799.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745024799.git.wqu@suse.com>
References: <cover.1745024799.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

From: Christoph Hellwig <hch@lst.de>

Move kmapping the page out of btrfs_check_sector_csum().

This allows using bvec_kmap_local() where suitable and reduces the number
of kmap*() calls in the raid56 code.

This also means btrfs_check_sector_csum() will only accept a properly
kmapped address.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  4 ++--
 fs/btrfs/inode.c       | 20 ++++++++++----------
 fs/btrfs/raid56.c      | 19 +++++++++++--------
 fs/btrfs/scrub.c       |  5 ++++-
 4 files changed, 27 insertions(+), 21 deletions(-)

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
index ddbddf5d2423..f6600924e775 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3320,20 +3320,16 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 /*
  * Verify the checksum for a single sector without any extra action that depend
  * on the type of I/O.
+ *
+ * @kaddr must be a properly kmapped address.
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
@@ -3362,6 +3358,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 	u64 end = file_offset + bv->bv_len - 1;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
+	char *kaddr;
 
 	ASSERT(bv->bv_len == fs_info->sectorsize);
 
@@ -3379,9 +3376,12 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 
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
2.49.0


