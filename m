Return-Path: <linux-btrfs+bounces-841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A206880E3C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 06:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F12F1F21F69
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 05:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7827A156DC;
	Tue, 12 Dec 2023 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UE6KHmP8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UE6KHmP8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5609AF4
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 21:24:36 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C21CE1FCF8
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702358674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02RXYgUN4ayWYIWLXAfJOiefwlOvXi773sy7AqV1wTQ=;
	b=UE6KHmP8TOHV+ltdsYh5OjM6aWvSVJn3UVADghtHa81l+r0RkqHOy8UAjL3fceUjsDSFXl
	3quEwEiDsQDSze7dEgvEkssfY87KfxHIkOfpU/041jWwkuiPKTVrxKjtV0ABuEpW+pz2jw
	Sw1DCsnjF7lt2W9dAV0Q8S2gMHjjuhM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702358674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02RXYgUN4ayWYIWLXAfJOiefwlOvXi773sy7AqV1wTQ=;
	b=UE6KHmP8TOHV+ltdsYh5OjM6aWvSVJn3UVADghtHa81l+r0RkqHOy8UAjL3fceUjsDSFXl
	3quEwEiDsQDSze7dEgvEkssfY87KfxHIkOfpU/041jWwkuiPKTVrxKjtV0ABuEpW+pz2jw
	Sw1DCsnjF7lt2W9dAV0Q8S2gMHjjuhM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B0DA4139E9
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uEHqFpHud2VZQQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: migrate btrfs_repair_io_failure() to folio interfaces
Date: Tue, 12 Dec 2023 15:54:10 +1030
Message-ID: <f1fd64edbb2a04db79dd55ee8c5536abd7c60598.1702354716.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702354716.git.wqu@suse.com>
References: <cover.1702354716.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: 0.70
Authentication-Results: smtp-out2.suse.de;
	none

[BUG]
Test case btrfs/124 failed if larger metadata folio is enabled, the
dying message looks like this:

 BTRFS error (device dm-2): bad tree block start, mirror 2 want 31686656 have 0
 BTRFS info (device dm-2): read error corrected: ino 0 off 31686656 (dev /dev/mapper/test-scratch2 sector 20928)
 BUG: kernel NULL pointer dereference, address: 0000000000000020
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 CPU: 6 PID: 350881 Comm: btrfs Tainted: G           OE      6.7.0-rc3-custom+ #128
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
 RIP: 0010:btrfs_read_extent_buffer+0x106/0x180 [btrfs]
 PKRU: 55555554
 Call Trace:
  <TASK>
  read_tree_block+0x33/0xb0 [btrfs]
  read_block_for_search+0x23e/0x340 [btrfs]
  btrfs_search_slot+0x2f9/0xe60 [btrfs]
  btrfs_lookup_csum+0x75/0x160 [btrfs]
  btrfs_lookup_bio_sums+0x21a/0x560 [btrfs]
  btrfs_submit_chunk+0x152/0x680 [btrfs]
  btrfs_submit_bio+0x1c/0x50 [btrfs]
  submit_one_bio+0x40/0x80 [btrfs]
  submit_extent_page+0x158/0x390 [btrfs]
  btrfs_do_readpage+0x330/0x740 [btrfs]
  extent_readahead+0x38d/0x6c0 [btrfs]
  read_pages+0x94/0x2c0
  page_cache_ra_unbounded+0x12d/0x190
  relocate_file_extent_cluster+0x7c1/0x9d0 [btrfs]
  relocate_block_group+0x2d3/0x560 [btrfs]
  btrfs_relocate_block_group+0x2c7/0x4b0 [btrfs]
  btrfs_relocate_chunk+0x4c/0x1a0 [btrfs]
  btrfs_balance+0x925/0x13c0 [btrfs]
  btrfs_ioctl+0x19f1/0x25d0 [btrfs]
  __x64_sys_ioctl+0x90/0xd0
  do_syscall_64+0x3f/0xf0
  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[CAUSE]
The dying line is at btrfs_repair_io_failure() call inside
btrfs_repair_eb_io_failure().

The function is still relying on the extent buffer using page sized
folios.
When the extent buffer is using larger folio, we go into the 2nd slot of
folios[], and triggered the NULL pointer dereference.

[FIX]
Migrate btrfs_repair_io_failure() to folio interfaces.

So that when we hit a larger folio, we just submit the whole folio in
one go.

This also affects data repair path through btrfs_end_repair_bio(),
thankfully data is still fully page based, we can just add an
ASSERT(), and use page_folio() to convert the page to folio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c     | 15 +++++++++++----
 fs/btrfs/bio.h     |  4 ++--
 fs/btrfs/disk-io.c | 13 +++++++------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4f3b693a16b1..c6b4b1ba953f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -194,6 +194,12 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
 	int mirror = repair_bbio->mirror_num;
 
+	/*
+	 * We can only hit here for data bio, which doesn't support
+	 * larger folios yet.
+	 */
+	ASSERT(folio_order(page_folio(bv->bv_page)) == 0);
+
 	if (repair_bbio->bio.bi_status ||
 	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
@@ -215,7 +221,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
 				  repair_bbio->file_offset, fs_info->sectorsize,
 				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
-				  bv->bv_page, bv->bv_offset, mirror);
+				  page_folio(bv->bv_page), bv->bv_offset, mirror);
 	} while (mirror != fbio->bbio->mirror_num);
 
 done:
@@ -767,8 +773,8 @@ void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
  * freeing the bio.
  */
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			    u64 length, u64 logical, struct page *page,
-			    unsigned int pg_offset, int mirror_num)
+			    u64 length, u64 logical, struct folio *folio,
+			    unsigned int folio_offset, int mirror_num)
 {
 	struct btrfs_io_stripe smap = { 0 };
 	struct bio_vec bvec;
@@ -799,7 +805,8 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 
 	bio_init(&bio, smap.dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
 	bio.bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-	__bio_add_page(&bio, page, length, pg_offset);
+	ret = bio_add_folio(&bio, folio, length, folio_offset);
+	ASSERT(ret);
 	ret = submit_bio_wait(&bio);
 	if (ret) {
 		/* try to remap that extent elsewhere? */
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index ca79decee060..bbaed317161a 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -105,7 +105,7 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
 void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_replace);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			    u64 length, u64 logical, struct page *page,
-			    unsigned int pg_offset, int mirror_num);
+			    u64 length, u64 logical, struct folio *folio,
+			    unsigned int folio_offset, int mirror_num);
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a482ba513a18..369e71677adf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -183,21 +183,22 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 				      int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int i, num_pages = num_extent_pages(eb);
+	int num_folios = num_extent_folios(eb);
 	int ret = 0;
 
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
-	for (i = 0; i < num_pages; i++) {
-		u64 start = max_t(u64, eb->start, folio_pos(eb->folios[i]));
+	for (int i = 0; i < num_folios ; i++) {
+		struct folio *folio = eb->folios[i];
+		u64 start = max_t(u64, eb->start, folio_pos(folio));
 		u64 end = min_t(u64, eb->start + eb->len,
-				folio_pos(eb->folios[i]) + PAGE_SIZE);
+				folio_pos(folio) + folio_size(folio));
 		u32 len = end - start;
 
 		ret = btrfs_repair_io_failure(fs_info, 0, start, len,
-				start, folio_page(eb->folios[i], 0),
-				offset_in_page(start), mirror_num);
+				start, folio, offset_in_folio(folio, start),
+				mirror_num);
 		if (ret)
 			break;
 	}
-- 
2.43.0


