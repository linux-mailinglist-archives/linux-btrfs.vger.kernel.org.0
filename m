Return-Path: <linux-btrfs+bounces-2033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA4845F55
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE0F1F246D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308C585626;
	Thu,  1 Feb 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cUux3Ia9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cUux3Ia9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B412FB23
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810582; cv=none; b=ijLgEDMgpnqMCUS/VQlFnLSXuQ4a5heYJ8HQmGbWy9wS/2hdukPCJOeHtDtiUV9L1lX/mHoWqz19+3jYPjNFv83ktmnRCQOnvHO4MWlYVTiVQKaBG3id+8FBuZrPJpFVHOY+tKIUlUtHdrA/C6wv2R/Fh6KCq5Srxe6jmavIY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810582; c=relaxed/simple;
	bh=agGDDu90nAj0U/kOXz28KNeFZXnZTSc7aC1u+/tVFos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/2eJ9R+jYhntzf0ShkkkU/XWCIYDlaJ/A2/aDqztyujJHUEm2TYXu9+2CavOR32fa3Uk6XZl6ZpMqwwuXKvNtMxjQFruxp2dzvf3xaFnx9Qz3wqPmDpcuiwdnHzhP+jl/578gG6QBBblQy9BmCRUWzxZ53/WIPVZ/L1C31eAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cUux3Ia9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cUux3Ia9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEEA41FBFA;
	Thu,  1 Feb 2024 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYI9fevYvbkWOwbSKA7VH3S4rcsVWEfs9B6IUODxXqs=;
	b=cUux3Ia9WgsyOTH4ufzc73uu4I6MRLSFVTyhAzTcFFZJsiUlyPQ1TBgJdhECbSS38YyG2J
	zZheomFTuh4BkkmkNa4YcJf/u+2iAVtXS5zIVOzWDTyfxRpPIjT7PohzoxO22vIccaOoVu
	Dz2WAzxhP4B1hxyrQZf2EsESQgBgAbE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYI9fevYvbkWOwbSKA7VH3S4rcsVWEfs9B6IUODxXqs=;
	b=cUux3Ia9WgsyOTH4ufzc73uu4I6MRLSFVTyhAzTcFFZJsiUlyPQ1TBgJdhECbSS38YyG2J
	zZheomFTuh4BkkmkNa4YcJf/u+2iAVtXS5zIVOzWDTyfxRpPIjT7PohzoxO22vIccaOoVu
	Dz2WAzxhP4B1hxyrQZf2EsESQgBgAbE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B6D13594;
	Thu,  1 Feb 2024 18:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4qsYLdLcu2WxTwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 18:02:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: hoist fs_info out of loops in end_bbio_data_write and end_bbio_data_read
Date: Thu,  1 Feb 2024 19:02:33 +0100
Message-ID: <5067b431c05c318a15f0902a4005c55ac614bd4e.1706810422.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706810422.git.dsterba@suse.com>
References: <cover.1706810422.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cUux3Ia9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: BEEA41FBFA
X-Spam-Flag: NO

The fs_info and sectorsize remain the same during the loops, no need to
set them on each iteration.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac6b5d8895aa..197b9f50e75c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -461,16 +461,15 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
  */
 static void end_bbio_data_write(struct btrfs_bio *bbio)
 {
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
+	const u32 sectorsize = fs_info->sectorsize;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
-		struct inode *inode = folio->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u32 sectorsize = fs_info->sectorsize;
 		u64 start = folio_pos(folio) + fi.offset;
 		u32 len = fi.length;
 
@@ -592,17 +591,17 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
  */
 static void end_bbio_data_read(struct btrfs_bio *bbio)
 {
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct bio *bio = &bbio->bio;
 	struct processed_extent processed = { 0 };
 	struct folio_iter fi;
+	const u32 sectorsize = fs_info->sectorsize;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, &bbio->bio) {
 		bool uptodate = !bio->bi_status;
 		struct folio *folio = fi.folio;
 		struct inode *inode = folio->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u32 sectorsize = fs_info->sectorsize;
 		u64 start;
 		u64 end;
 		u32 len;
-- 
2.42.1


