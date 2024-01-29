Return-Path: <linux-btrfs+bounces-1919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145784120C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 19:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F741C22C1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7433CE7;
	Mon, 29 Jan 2024 18:33:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0612E7E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553227; cv=none; b=FhRalZoxS+fMycWrtxexhWQP/OkBKU5j2TUKw3RDZXHYddBnKwXievnH77RI/todwzyTSt55oDqGtQezNE9245hU41QpMsaHF2dwdXQSTUHQqSUH4ZGAxOz5v4dhRJAvr8/a74+iffUS9GySwHVOS55YGTglZ39hqknvLrQ1uzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553227; c=relaxed/simple;
	bh=i4EZHXOy4OpBm5Ac1XhsEpcx7VdQN/vwTIMV0uOHEZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQxKMJ4W71J2jnjtVpUMut+BwPslfC5pyPV5uL4S3eex37pX187mBUnPsO6HaxNG3KcHMhULVpUgwWBKhJ83mL1E26XWJlhOoOuaRJZ903mnBG+t98S62lJzilNaWmerPYBSmydqS9j4vXumqMtbjtmlVDL+By7QPNp+KOkPw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F8991F800;
	Mon, 29 Jan 2024 18:33:44 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 685AD132FA;
	Mon, 29 Jan 2024 18:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id a7R3GYjvt2V9RAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 29 Jan 2024 18:33:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: hoist fs_info out of loops in end_bbio_data_write and end_bbio_data_read
Date: Mon, 29 Jan 2024 19:33:20 +0100
Message-ID: <fd6fef62df1f7d3d3da5380fecf1f51a64950286.1706553081.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706553080.git.dsterba@suse.com>
References: <cover.1706553080.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6F8991F800
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The fs_info and sectorsize remain the same during the loops, no need to
set them on each iteration.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9d6d4dab9ae3..d45247e1020a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -464,13 +464,12 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
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


