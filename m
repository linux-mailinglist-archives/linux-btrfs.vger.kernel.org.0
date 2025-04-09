Return-Path: <linux-btrfs+bounces-12914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9AA82328
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD64C2957
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB425DAF3;
	Wed,  9 Apr 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIldwXUP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13725B67C
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197065; cv=none; b=haa01Ala0BA5aqjI/woq0UN1H2MKrp/otDLEf8BFMf4oVGMbQNlv/+9xnsJL1Uctt72rZaYqqCzHlxQlEY4K9M60gqqsZR262+TAnQb7XhuctIBlLsNqBQsBa3AQ+UwnaJppxrKsIk7fzS9hoOt6/zs/1YGR7Fa/B5i1gVB1JGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197065; c=relaxed/simple;
	bh=Dz26E0WzbIAjPNErTKtmSAPQAidODro9C6MFPA0wHEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXeQzEUdcgJnKQaDJZs8rF7fGz31Pkx19VQL0D3qO3q3laMM77JPRYOz/ZlPJfm8iZYDxeWI2n2hXPRbcF0UWyjUK/Jhg8J8EtavsGMxuoZywsLc8cUmDZxPIDJhoxb+28gHWoiK01r19fAN4uyj3lYOjT6cYUn7mSJVYO2dSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RIldwXUP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rhsNz4ZFU9bhoMMMS6I67mBtgtJiYaT8MpDV/ZR574k=; b=RIldwXUPgqImOwJK5Qmq4gvukf
	GuKC0rYZMfagibz+aA5OYIQLtbUDcHDCjqrXxpWQvfUFlyT40AgvKTLsIaR8fJx21Q62wYJL5fht8
	07FtmZUvJmK3+2DR6IKbGkQU9HcwJoWlvdsWY5wfsFvOV+z6x78r7h2QM0g2qzkYT3o4Ki+evTcm3
	wp9JHYwzgWfZp0IJZsdQQBA5PoWUlW4ZNY0pCHeUWbSqvb4khC9H2LvcoKAC96zwVqXbcBmjHXMmI
	AjukFgh7y6CX33KMt1KXkBV/uMZw4HgpOu3w/5MLP1V3nLBT70bcu6Zb2fq1Lv9BFaWaJ2B1rk7Zo
	8XKVLzIA==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKf-00000006x2P-0h2D;
	Wed, 09 Apr 2025 11:11:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: remove the alignment checks in end_bbio_data_read
Date: Wed,  9 Apr 2025 13:10:35 +0200
Message-ID: <20250409111055.3640328-2-hch@lst.de>
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

end_bbio_data_read checks that each iterated folio fragment is aligned
and justifies that with block drivers advancing the bio.  But block
driver only advance bi_iter, while end_bbio_data_read uses
bio_for_each_folio_all to iterate the immutable bi_io_vec array that
can't be changed by drivers at all.

Remove the alignment checking and the misleading comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 197f5e51c474..193736b07a0b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -512,43 +512,22 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct bio *bio = &bbio->bio;
 	struct folio_iter fi;
-	const u32 sectorsize = fs_info->sectorsize;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, &bbio->bio) {
 		bool uptodate = !bio->bi_status;
 		struct folio *folio = fi.folio;
 		struct inode *inode = folio->mapping->host;
-		u64 start;
-		u64 end;
-		u32 len;
+		u64 start = folio_pos(folio) + fi.offset;
 
 		btrfs_debug(fs_info,
 			"%s: bi_sector=%llu, err=%d, mirror=%u",
 			__func__, bio->bi_iter.bi_sector, bio->bi_status,
 			bbio->mirror_num);
 
-		/*
-		 * We always issue full-sector reads, but if some block in a
-		 * folio fails to read, blk_update_request() will advance
-		 * bv_offset and adjust bv_len to compensate.  Print a warning
-		 * for unaligned offsets, and an error if they don't add up to
-		 * a full sector.
-		 */
-		if (!IS_ALIGNED(fi.offset, sectorsize))
-			btrfs_err(fs_info,
-		"partial page read in btrfs with offset %zu and length %zu",
-				  fi.offset, fi.length);
-		else if (!IS_ALIGNED(fi.offset + fi.length, sectorsize))
-			btrfs_info(fs_info,
-		"incomplete page read with offset %zu and length %zu",
-				   fi.offset, fi.length);
-
-		start = folio_pos(folio) + fi.offset;
-		end = start + fi.length - 1;
-		len = fi.length;
 
 		if (likely(uptodate)) {
+			u64 end = start + fi.length - 1;
 			loff_t i_size = i_size_read(inode);
 
 			/*
@@ -573,7 +552,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		}
 
 		/* Update page status and unlock. */
-		end_folio_read(folio, uptodate, start, len);
+		end_folio_read(folio, uptodate, start, fi.length);
 	}
 	bio_put(bio);
 }
-- 
2.47.2


