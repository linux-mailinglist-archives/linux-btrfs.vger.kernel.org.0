Return-Path: <linux-btrfs+bounces-13173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A44A94210
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396FE4420EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485DD19F40A;
	Sat, 19 Apr 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XqG9zi1f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XqG9zi1f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5E18C004
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047071; cv=none; b=PMwRF63fqapjtXvFBxT1vyOn9i7XhkvuykO2BPVmeOA8eht+GPZIudSHFpXopG1BlG95OTkbPNsOjO6is6Zc5Mgo2kqU/Y8OqdauGKFYmHOhfeOdEVO5Sj+b2cjD8vXFPIKJojJnySTOhQZe/3cyQw5eW3CZeMZIc+nw0k97LMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047071; c=relaxed/simple;
	bh=vkg9EP+Nsr5OFgBTQC2yCKrfvBWiWQ6RENnLbufjvio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmbQFbazyNkImhz0XGLy4bEfc+x6FUcYoICOCuWG3zBzF1cVKOmYzAVsu2CdlKzoOHv+oiZzaUx3WYge/v6znu0SzfIpPUtWSudSGcQxXSuMdHRW1RoFYiB9nxCX7J5qsdhyxDVdjgvL7cVWNLtPnMrePId88gOqmUSsj3HV2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XqG9zi1f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XqG9zi1f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A6D01F451;
	Sat, 19 Apr 2025 07:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaLqWqPfs3qxuNxZYZrz4Nn9KVr+ZHzLCXmjdIYllXM=;
	b=XqG9zi1fR0FjHamr+PZTyBp+0qoDhgqigI3nfJEa6zOdVW4YHiquuefrs82Y8ZNxGtNlSo
	IHz8Bjz4Xi2dS9dEAsiJTQI6PYx01aTGopbMDAJMiNj9MIJc7b2gt/VjYNALnZ0OxJhrGz
	jTnLo+uaQlZXffwbI4hJ3+0E8mRBb90=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XqG9zi1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaLqWqPfs3qxuNxZYZrz4Nn9KVr+ZHzLCXmjdIYllXM=;
	b=XqG9zi1fR0FjHamr+PZTyBp+0qoDhgqigI3nfJEa6zOdVW4YHiquuefrs82Y8ZNxGtNlSo
	IHz8Bjz4Xi2dS9dEAsiJTQI6PYx01aTGopbMDAJMiNj9MIJc7b2gt/VjYNALnZ0OxJhrGz
	jTnLo+uaQlZXffwbI4hJ3+0E8mRBb90=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 357F813942;
	Sat, 19 Apr 2025 07:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJ2BOhhOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 5/8] btrfs: simplify bvec iteration in index_one_bio
Date: Sat, 19 Apr 2025 16:47:12 +0930
Message-ID: <06b9665a37bf324d250d7601c3b38b786080f22e.1745024799.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 6A6D01F451
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Christoph Hellwig <hch@lst.de>

Flatten the two loops by open coding bio_for_each_segment and advancing
the iterator one sector at a time.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[ Fix a bug that @offset is not increased. ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 28dbded86cc2..b0938eff908e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1195,23 +1195,21 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct bvec_iter iter = bio->bi_iter;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
 		     rbio->bioc->full_stripe_logical;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		u32 bvec_offset;
+	while (iter.bi_size) {
+		int index = offset / sectorsize;
+		struct sector_ptr *sector = &rbio->bio_sectors[index];
+		struct bio_vec bv = bio_iter_iovec(bio, iter);
 
-		for (bvec_offset = 0; bvec_offset < bvec.bv_len;
-		     bvec_offset += sectorsize, offset += sectorsize) {
-			int index = offset / sectorsize;
-			struct sector_ptr *sector = &rbio->bio_sectors[index];
+		sector->page = bv.bv_page;
+		sector->pgoff = bv.bv_offset;
+		ASSERT(sector->pgoff < PAGE_SIZE);
 
-			sector->page = bvec.bv_page;
-			sector->pgoff = bvec.bv_offset + bvec_offset;
-			ASSERT(sector->pgoff < PAGE_SIZE);
-		}
+		bio_advance_iter_single(bio, &iter, sectorsize);
+		offset += sectorsize;
 	}
 }
 
-- 
2.49.0


