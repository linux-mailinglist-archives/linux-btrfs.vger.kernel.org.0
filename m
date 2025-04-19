Return-Path: <linux-btrfs+bounces-13171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174DEA9420E
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129EF3A6F1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143E19CC20;
	Sat, 19 Apr 2025 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ts57SjFi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ts57SjFi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3935893
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047065; cv=none; b=ref8pE+VfYImogp15cm/mjiEAlOkweSZatkrSgupC8mvYrpWvw847VpJpe9z3+wPpkbHylznkZTFBZrVfiWO8hr3H7MwyJbBwvhYWS0AUxbmfqt/iK6UfLyMilOk8KaTrzh9KoeJtykSycdKGYrGLIAdlhnJKPjM0zdLNZSPI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047065; c=relaxed/simple;
	bh=gqE6iJ6Eq/TLWL/inO2zdu8EaOu2oSePhe0tKOd7jqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onjT/TsNY7dBviBT4uT/k4s9hXh6KtbZy/RUOANJPQYOFiHEmwLlgFkecxVT858vr8DMLrCjul60aO9UOuaCFWMsWkf2O1zTAqEOqQxa7luZcGSF88Nm8VaZxHYgs+m3TkZDOJizXygxKVrV7wsM5sCeof9wg5A9SBXlTR6FkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ts57SjFi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ts57SjFi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 682B61F443;
	Sat, 19 Apr 2025 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOd+q0OQ0JOr9tre22d0wgrYIxQ+9Sod0ojjUzN0xb4=;
	b=ts57SjFits2F3VTJvOn2HfV0XeNnTSjHQsd1J6eTtmKChL/48q7DOCeXvv7uKQoZaTe2B/
	VoH87V/kQ6ADyF08sKgwTBI6aVS9hxvmwE0P5YLN6QYZwEd6e9uf3jNJrZxDuRGsZrX1mc
	wnk4zbUrlZz2d3RjtbYWMTK5GT1Dtvk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOd+q0OQ0JOr9tre22d0wgrYIxQ+9Sod0ojjUzN0xb4=;
	b=ts57SjFits2F3VTJvOn2HfV0XeNnTSjHQsd1J6eTtmKChL/48q7DOCeXvv7uKQoZaTe2B/
	VoH87V/kQ6ADyF08sKgwTBI6aVS9hxvmwE0P5YLN6QYZwEd6e9uf3jNJrZxDuRGsZrX1mc
	wnk4zbUrlZz2d3RjtbYWMTK5GT1Dtvk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35A3113A79;
	Sat, 19 Apr 2025 07:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uBGXOhNOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/8] btrfs: track the next file offset in struct btrfs_bio_ctrl
Date: Sat, 19 Apr 2025 16:47:09 +0930
Message-ID: <a5af84f935d4d9cc2a929cb823ef761629ad793d.1745024799.git.wqu@suse.com>
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

The bio implementation is not something we should really mess around,
and we shouldn't recalculate the pos from the folio over and over.
Instead just track then end of the current bio in logical file offsets
in the btrfs_bio_ctrl, which is much simpler and easier to read.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f2fafad1add0..51b6f25e94aa 100644
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
@@ -630,13 +631,10 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
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
@@ -647,19 +645,11 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
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
@@ -677,6 +667,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	bbio->file_offset = file_offset;
 	bio_ctrl->bbio = bbio;
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
+	bio_ctrl->next_file_offset = file_offset;
 
 	/* Limit data write bios to the ordered boundary. */
 	if (bio_ctrl->wbc) {
@@ -718,12 +709,13 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
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
@@ -732,7 +724,7 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bbio) {
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
-				      folio_pos(folio) + pg_offset);
+				      file_offset);
 		}
 
 		/* Cap to the current ordered extent boundary if there is one. */
@@ -747,14 +739,15 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
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
2.49.0


