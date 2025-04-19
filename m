Return-Path: <linux-btrfs+bounces-13174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C891DA94211
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A75719E26C1
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05319580B;
	Sat, 19 Apr 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iu0hpdVr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iu0hpdVr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23A19ADA4
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047077; cv=none; b=AltDOcBk6Q3WIReRfNPC3Jc/bT9B5bu3YRjBM5ebD//Jpb+vtrf1g+Y8BzOita8qtCPZrSs3hDzZdJfZxL8aax7Qt9J79ggFpjrrwGSp9rAez7Yu7w3cAY89jTVqHQkpSNkU1kdpjggHvpjMDBqVcAS9Un/L6K+Iwx5zEA9obvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047077; c=relaxed/simple;
	bh=/pntGB/XJkJGEAIq6uaks+XlUqIIRY5Xc9F+C7bQITs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryPK3e49mb8qHQTWpQUOYwlfz7zgqCWSzMNKj1U5QP873uOHlfSbWjiuCdFL54BqxVbZ06c+tzbaWRa4VGTqClERA8AchAox1jSaNmZ+vG4Q7ifmlfkY2+DlZekgme4KseIgz+qUQZ4D9PSmql3GpTcSyn5YQTq6vJgsasD3e+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iu0hpdVr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iu0hpdVr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1693E211EA;
	Sat, 19 Apr 2025 07:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3u8DWHaDGoHQkuhEfllKrgx+EVPipAGrARnzNJUHp3o=;
	b=iu0hpdVrXtKyDFSEypWvt3pyRXIlUncoDX40C7Qmaqfi39vJdSlXvAUAltRwS2d4G1pssC
	mx/M9m/IEs68TbLiYjdyQV2FBAUItsRW7spIgWuf3cqxvi1uNPT6AErXHHtTfndKfYjUee
	Ps4G1jdPBfsZvkB6R1BeyDgmLc7V624=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3u8DWHaDGoHQkuhEfllKrgx+EVPipAGrARnzNJUHp3o=;
	b=iu0hpdVrXtKyDFSEypWvt3pyRXIlUncoDX40C7Qmaqfi39vJdSlXvAUAltRwS2d4G1pssC
	mx/M9m/IEs68TbLiYjdyQV2FBAUItsRW7spIgWuf3cqxvi1uNPT6AErXHHtTfndKfYjUee
	Ps4G1jdPBfsZvkB6R1BeyDgmLc7V624=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7C4113942;
	Sat, 19 Apr 2025 07:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iK6OJhVOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/8] btrfs: pass a physical address to btrfs_repair_io_failure
Date: Sat, 19 Apr 2025 16:47:10 +0930
Message-ID: <7972e56cce0e8726ff97ac65fea2153a8393d337.1745024799.git.wqu@suse.com>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

From: Christoph Hellwig <hch@lst.de>

Using physical address has the following advantages:

- All involved callers only need a single pointer
  Instead of the old @folio + @offset pair.

- No complex poking into the bio_vec structure
  As a bio_vec can be single or multiple paged, grabbing the real page
  can be quite complex if the bio_vec is a multi-page one.

  Instead bvec_phys() will always give a single physical address, and it
  cab be easily converted to a page.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
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
index 59da809b7d57..280bc0ee6046 100644
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
2.49.0


