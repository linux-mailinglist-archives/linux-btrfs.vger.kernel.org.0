Return-Path: <linux-btrfs+bounces-19060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2525C62BAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EC53B1CE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5735CBB7;
	Mon, 17 Nov 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TbSz8L9/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TbSz8L9/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525F318143
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364710; cv=none; b=qCWi+DfuLP8vxonSpBJzYYQs9Jl6iwS9hHucduROoxcAeC1iPFjGadhGVGIIaUzDCmWiJpqotlgm6FuTePN5s66FfEXzCOF3OO1FZOwrVgsCTd51YxlwGfccxWlz0kNPd4Pc7Qdl3znRsrh3P1MY/u9lXrZ53C1fMb1gN0LZgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364710; c=relaxed/simple;
	bh=aXMjQjkaGGrw8oI/WV207Tk3B1l93VRBOceLgo7CEEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIA5ptQ1Jr4+o85dVB6gbw+QmrEjBt/KVqhnpEONQJ6uIJqD+yA65GnHDxxkPxhwalT8lCsY/G27MNTqtJ1Zwu8xWhSWsjik72Z1fQl5g+wNx7CSMweRlbn/cjvVPfHKMDdpmXha94LtzrdO/8VGAJbpKdeVt1I7s5B19CV8JYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TbSz8L9/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TbSz8L9/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79D0C1F798
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ6QrXgxbKxpcjtvnpa7XMpl/XHuexGd+5eMs6FBIbE=;
	b=TbSz8L9/TG/vRurwN61gVTYIC15ulQVVi+P4VntRegSbET9rzf65VILTcy/XLXCTIfGvat
	sDI9L1JHEgEIh1I5i49UtPZMchkbykNdz42IGs4XwdxGacHPErKX6trhHokMj13nsPWGN6
	AU661cGNcCrn9GDt7bKI1q8zg0bDuyc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ6QrXgxbKxpcjtvnpa7XMpl/XHuexGd+5eMs6FBIbE=;
	b=TbSz8L9/TG/vRurwN61gVTYIC15ulQVVi+P4VntRegSbET9rzf65VILTcy/XLXCTIfGvat
	sDI9L1JHEgEIh1I5i49UtPZMchkbykNdz42IGs4XwdxGacHPErKX6trhHokMj13nsPWGN6
	AU661cGNcCrn9GDt7bKI1q8zg0bDuyc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B34773EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EIr9HEjPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/12] btrfs: prepare steal_rbio() to support bs > ps cases
Date: Mon, 17 Nov 2025 18:00:48 +1030
Message-ID: <c6b6695f1752ef2cebe8f0e1e958aa07b29448b1.1763361991.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763361991.git.wqu@suse.com>
References: <cover.1763361991.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The function steal_rbio() assume each fs block can be mapped by
one page, blocking bs > ps support for raid56.

Prepare it for bs > ps cases by:

- Introduce two helpers to calculate the sector number
  Previously we assume one page will contain at least one fs block, thus
  can use something like "sectors_per_page = PAGE_SIZE / secotrsize;",
  but with bs > ps support that above number will be 0.

  Instead introduce two helpers:

  * page_nr_to_sector_nr()
    Returns the sector number of the first sector covered by the page.

  * page_nr_to_num_sectors()
    Return how many sectors are covered by the page.

  And use the returned values for bitmap operations other than
  open-coded "PAGE_SIZE / sectorsize".
  Those helpers also have extra ASSERT()s to catch weird numbers.

- Use above helpers
  The involved functions are:
  * steal_rbio_page()
  * is_data_stripe_page()
  * full_page_sectors_uptodate()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 57 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 820bdc7f6dbe..7cb3b3eccda6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -300,18 +300,47 @@ static int rbio_bucket(struct btrfs_raid_bio *rbio)
 	return hash_64(num >> 16, BTRFS_STRIPE_HASH_TABLE_BITS);
 }
 
-static __maybe_unused bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
-						      unsigned int page_nr)
+/* Get the sector number of the first sector covered by @page_nr. */
+static u32 page_nr_to_sector_nr(struct btrfs_raid_bio *rbio, unsigned int page_nr)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
-	int i;
+	u32 sector_nr;
 
 	ASSERT(page_nr < rbio->nr_pages);
 
-	for (i = sectors_per_page * page_nr;
-	     i < sectors_per_page * page_nr + sectors_per_page;
-	     i++) {
+	sector_nr = page_nr << PAGE_SHIFT >> rbio->bioc->fs_info->sectorsize_bits;
+	ASSERT(sector_nr < rbio->nr_sectors);
+	return sector_nr;
+}
+
+/*
+ * Get the number of sectors covered by @page_nr.
+ *
+ * For bs > ps cases, the result will always be 1.
+ * For bs <= ps cases, the result will be ps / bs.
+ */
+static u32 page_nr_to_num_sectors(struct btrfs_raid_bio *rbio, unsigned int page_nr)
+{
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	u32 nr_sectors;
+
+	ASSERT(page_nr < rbio->nr_pages);
+
+	nr_sectors = round_up(PAGE_SIZE, fs_info->sectorsize) >> fs_info->sectorsize_bits;
+	ASSERT(nr_sectors > 0);
+	return nr_sectors;
+}
+
+static __maybe_unused bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
+						      unsigned int page_nr)
+{
+	const u32 sector_nr = page_nr_to_sector_nr(rbio, page_nr);
+	const u32 nr_bits = page_nr_to_num_sectors(rbio, page_nr);
+	int i;
+
+	ASSERT(page_nr < rbio->nr_pages);
+	ASSERT(sector_nr + nr_bits < rbio->nr_sectors);
+
+	for (i = sector_nr; i < sector_nr + nr_bits; i++) {
 		if (!test_bit(i, rbio->stripe_uptodate_bitmap))
 			return false;
 	}
@@ -345,8 +374,11 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 static void steal_rbio_page(struct btrfs_raid_bio *src,
 			    struct btrfs_raid_bio *dest, int page_nr)
 {
-	const u32 sectorsize = src->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	const u32 sector_nr = page_nr_to_sector_nr(src, page_nr);
+	const u32 nr_bits = page_nr_to_num_sectors(src, page_nr);
+
+	ASSERT(page_nr < src->nr_pages);
+	ASSERT(sector_nr + nr_bits < src->nr_sectors);
 
 	if (dest->stripe_pages[page_nr])
 		__free_page(dest->stripe_pages[page_nr]);
@@ -354,13 +386,12 @@ static void steal_rbio_page(struct btrfs_raid_bio *src,
 	src->stripe_pages[page_nr] = NULL;
 
 	/* Also update the stripe_uptodate_bitmap bits. */
-	bitmap_set(dest->stripe_uptodate_bitmap, sectors_per_page * page_nr, sectors_per_page);
+	bitmap_set(dest->stripe_uptodate_bitmap, sector_nr, nr_bits);
 }
 
 static bool is_data_stripe_page(struct btrfs_raid_bio *rbio, int page_nr)
 {
-	const int sector_nr = (page_nr << PAGE_SHIFT) >>
-			      rbio->bioc->fs_info->sectorsize_bits;
+	const int sector_nr = page_nr_to_sector_nr(rbio, page_nr);
 
 	/*
 	 * We have ensured PAGE_SIZE is aligned with sectorsize, thus
-- 
2.51.2


