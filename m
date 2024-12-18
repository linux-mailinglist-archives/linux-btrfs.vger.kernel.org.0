Return-Path: <linux-btrfs+bounces-10541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E09469F61FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D19B1895FF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7B19C566;
	Wed, 18 Dec 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="goMgoou6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="goMgoou6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886619882B
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514934; cv=none; b=UkCoaAQjDE25XfVhiJzP56olRxjFcfVsoZUY6A98jh2MDRj4v8W0n/b/e4MFlRjHB0N6lxjExmjVsJ6R+vtvhuM0t8/pCRgd/4/Dvw2Zve+GF+TwY7r7vYLZ8tRFxKpKzAnvtU6jSO8dkNQSFleEbMCMPbspfFB738d8tPsWCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514934; c=relaxed/simple;
	bh=V58cabt4qzSK9LtAklmd7HS7mf4/5f7nZxhTvx/kDac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVdqi8J0Ij+Jjhl70Yn/owISgdE1LlLf15yCIxyKgvkthhm4+gbx/r1ngI0IfjF0yT40Vq+GFKz+7ylAPjfIunGt2amGcjw1SN3m6hnZGNLMrMIVhVSZinUGz8nRW/uGG6RYxZnkgXGPDNmxYUVX6wPPX32Ny0RHrR2yU1QMVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=goMgoou6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=goMgoou6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC0F82116B
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gampsxrfR9f7Q09hTb7MMFyRTVXUpnDisbF47NW+AWs=;
	b=goMgoou6yRagXYbv8S6lULqkeuqwe0CSGfVKCJFMRNCnXup4W/4scwXwN1jMtxr2DScHRi
	IVr1ChcwfAMLIhlD7+1jR4SiuhAiWNyXSIN79puObkcAvxBxBysR6HNENS+ztHWfk/eD6X
	OOO5Q8zp4n4jpFbkg99jjmdOiCHCK2U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=goMgoou6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gampsxrfR9f7Q09hTb7MMFyRTVXUpnDisbF47NW+AWs=;
	b=goMgoou6yRagXYbv8S6lULqkeuqwe0CSGfVKCJFMRNCnXup4W/4scwXwN1jMtxr2DScHRi
	IVr1ChcwfAMLIhlD7+1jR4SiuhAiWNyXSIN79puObkcAvxBxBysR6HNENS+ztHWfk/eD6X
	OOO5Q8zp4n4jpFbkg99jjmdOiCHCK2U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9F62132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGheKfGYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/18] btrfs: migrate bio.[ch] to use block size terminology
Date: Wed, 18 Dec 2024 20:11:29 +1030
Message-ID: <f23c7cff1aabd6a950b610da5edda7000210de25.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC0F82116B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Despite the regular sectorsize rename, also rename
BTRFS_MAX_BIO_SECTORS BTRFS_MAX_BIO_BLOCKS.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c       | 24 ++++++++++++------------
 fs/btrfs/bio.h       |  4 ++--
 fs/btrfs/direct-io.c |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index bc80ee4f95a5..ea327a67a2bc 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -198,7 +198,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	do {
 		mirror = prev_repair_mirror(fbio, mirror);
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
-				  repair_bbio->file_offset, fs_info->sectorsize,
+				  repair_bbio->file_offset, fs_info->blocksize,
 				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
 				  page_folio(bv->bv_page), bv->bv_offset, mirror);
 	} while (mirror != fbio->bbio->mirror_num);
@@ -209,20 +209,20 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 }
 
 /*
- * Try to kick off a repair read to the next available mirror for a bad sector.
+ * Try to kick off a repair read to the next available mirror for a bad block.
  *
  * This primarily tries to recover good data to serve the actual read request,
  * but also tries to write the good data back to the bad mirror(s) when a
  * read succeeded to restore the redundancy.
  */
-static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
+static struct btrfs_failed_bio *repair_one_block(struct btrfs_bio *failed_bbio,
 						  u32 bio_offset,
 						  struct bio_vec *bv,
 						  struct btrfs_failed_bio *fbio)
 {
 	struct btrfs_inode *inode = failed_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	const u64 logical = (failed_bbio->saved_iter.bi_sector << SECTOR_SHIFT);
 	struct btrfs_bio *repair_bbio;
 	struct bio *repair_bio;
@@ -232,7 +232,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	btrfs_debug(fs_info, "repair read error: read error at %llu",
 		    failed_bbio->file_offset + bio_offset);
 
-	num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
+	num_copies = btrfs_num_copies(fs_info, logical, blocksize);
 	if (num_copies == 1) {
 		btrfs_debug(fs_info, "no copy to repair from");
 		failed_bbio->bio.bi_status = BLK_STS_IOERR;
@@ -268,7 +268,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u32 sectorsize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	struct bvec_iter *iter = &bbio->saved_iter;
 	blk_status_t status = bbio->bio.bi_status;
 	struct btrfs_failed_bio *fbio = NULL;
@@ -292,12 +292,12 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	while (iter->bi_size) {
 		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
 
-		bv.bv_len = min(bv.bv_len, sectorsize);
+		bv.bv_len = min(bv.bv_len, blocksize);
 		if (status || !btrfs_data_csum_ok(bbio, dev, offset, &bv))
-			fbio = repair_one_sector(bbio, offset, &bv, fbio);
+			fbio = repair_one_block(bbio, offset, &bv, fbio);
 
-		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
-		offset += sectorsize;
+		bio_advance_iter_single(&bbio->bio, iter, blocksize);
+		offset += blocksize;
 	}
 
 	if (bbio->csum != bbio->csum_inline)
@@ -655,10 +655,10 @@ static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
 	if (sector_offset) {
 		/*
 		 * bio_split_rw_at() could split at a size smaller than our
-		 * sectorsize and thus cause unaligned I/Os.  Fix that by
+		 * blocksize and thus cause unaligned I/Os.  Fix that by
 		 * always rounding down to the nearest boundary.
 		 */
-		return ALIGN_DOWN(sector_offset << SECTOR_SHIFT, bbio->fs_info->sectorsize);
+		return ALIGN_DOWN(sector_offset << SECTOR_SHIFT, bbio->fs_info->blocksize);
 	}
 	return map_length;
 }
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e2fe16074ad6..25a3ba7e0bfb 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -19,11 +19,11 @@ struct btrfs_inode;
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
 
 /*
- * Maximum number of sectors for a single bio to limit the size of the
+ * Maximum number of blocks for a single bio to limit the size of the
  * checksum array.  This matches the number of bio_vecs per bio and thus the
  * I/O size for buffered I/O.
  */
-#define BTRFS_MAX_BIO_SECTORS		(256)
+#define BTRFS_MAX_BIO_BLOCKS		(256)
 
 typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 8567af46e16f..3229f07f5d6d 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -385,7 +385,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * to allocate a contiguous array for the checksums.
 	 */
 	if (!write)
-		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_SECTORS);
+		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_BLOCKS);
 
 	lockstart = start;
 	lockend = start + len - 1;
-- 
2.47.1


