Return-Path: <linux-btrfs+bounces-13172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F5A9420F
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3212319E271E
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22819E96D;
	Sat, 19 Apr 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eCBWEZUG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bggNDrpi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A218DF62
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047070; cv=none; b=OpNw68aZ+KYvn41OtD2hbJcXeHLMdZoHuQqWkcCvW20x8ffTKOojz4Vt24a6K4XHp7OoTxGfabHrIlhMtxATThLgcvNbyqUDQYoXspJpi0+T22GW9BtjLEyI0GTMZw0LwyJMXo3kW71K0J8skNl48e7UWnSpAbqVk4XnsHUaW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047070; c=relaxed/simple;
	bh=atOfbzFtVx+fw5ZGnwy+exyjDXLutuUD8/S9a702W0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTmluE7NXEZcJnolnH3SXA9K5dgm/NQi4F40pwZ78Ec4vlUPcaOBSkPjQDUbUPCOZHoI3aJl2wFtXUdHX92v08+ZU0ZIsasWUut960PDhyj+RWZqL+H0ILVGUgnRb4OtNBeWBXJ9AzS3YdGdCjnjVt3coluVtcVphTSwIbh431s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eCBWEZUG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bggNDrpi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9F7A2120B;
	Sat, 19 Apr 2025 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjEsHd0xTDn6EJ/oxfEzKKknqWyJb7jUXhAa7ut3pz4=;
	b=eCBWEZUGpNmP6mndfJkjDW+DNqMV2GWjT+ccK68BznZD42S37H4Qshr65+A6OH1oifG1OO
	L3wwDRceqPSN+ub2zOlFwEpH3BlmU5crLL24D1qZVV6sDEMZAt/Z81wDrEi+7eWYYBLImi
	pdOyXhxj0inkkPXiFQANBrUmXNripG4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjEsHd0xTDn6EJ/oxfEzKKknqWyJb7jUXhAa7ut3pz4=;
	b=bggNDrpi6TAjFgo1u2lHdR5hXhvCoz4SGfxoeGEksMmOVK4DPd9zHS/1M3suZ4CMjVBrtJ
	Ula7dV0mrEXAdmVqV8uQtx0gC/H3O0v5vlcmgpX4NAVesiqMVBGBw8hg06p0n1pAh+vCK7
	QkrmV2El7yt/eOWKUHwV6FWa7SOx5a4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 865C513942;
	Sat, 19 Apr 2025 07:17:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oNmWEhJOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/8] btrfs: remove the alignment checks in end_bbio_data_read
Date: Sat, 19 Apr 2025 16:47:08 +0930
Message-ID: <efc486296cb74d9880acdfa6962fef4e7c8ef7b3.1745024799.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

From: Christoph Hellwig <hch@lst.de>

end_bbio_data_read() checks that each iterated folio fragment is aligned
and justifies that with block drivers advancing the bio.  But block
driver only advance bi_iter, while end_bbio_data_read() uses
bio_for_each_folio_all() to iterate the immutable bi_io_vec array that
can't be changed by drivers at all.

Furthermore btrfs has already did the alignment check of the file
offset inside submit_one_sector(), and the size is fixed to fs block
size, there is no need to re-do the alignment check again inside the
endio function.

So just remove the unnecessary alignment check along with the incorrect
comment.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f08615b334f..f2fafad1add0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -499,43 +499,22 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
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
@@ -560,7 +539,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		}
 
 		/* Update page status and unlock. */
-		end_folio_read(folio, uptodate, start, len);
+		end_folio_read(folio, uptodate, start, fi.length);
 	}
 	bio_put(bio);
 }
-- 
2.49.0


