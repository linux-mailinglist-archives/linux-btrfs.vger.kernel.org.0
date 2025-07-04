Return-Path: <linux-btrfs+bounces-15262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1480AAF9791
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E95D1CA3C0C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58C32625B;
	Fri,  4 Jul 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XxDGtIQG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VAxl4xms"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A360315526
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Jul 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645266; cv=none; b=q4aBO8AU3aGRw3i9X5abBZ/r7TY3EIgDycjUNwPbZFyX+nW93frAbq4RLBi7YXDkt07gJQGVFjWiwPkD3HX7WbVW7yXUiY3lgSbxghQuQ4XEiFu4GjLkvjd3D6FWA2b1X1ZGwDL6Lag8g+ljMYk8rKI+rIeIdNURWLWySOcWICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645266; c=relaxed/simple;
	bh=DtwqSzl7Cet+BKhftgReD8azwuihp4fPJljIszG9QKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTJzFqYp6VzLhJnvAORR4F+PJuiNaC1fE2YgceBIXf2TQKmqxUBSxCwc3DpBh6eXQ1CiShkgAsxHAKZEuQkV9uAwWWBGRHDdCVV8coUiKfpxM+h42ZjSvkeOY4ay9NZA63zU/08flmaOjcPAMGbbc4084rR1jla7+LNTLQoYIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XxDGtIQG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VAxl4xms; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74B7A1F394;
	Fri,  4 Jul 2025 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751645262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4u2BeJ7xzEOn7uMo8SXkOT0wD/cTGT5eK55JCvqW8rM=;
	b=XxDGtIQGtVBlWb93MF87YKu9Ga0VFjKae/kWh9Nr5sg8VWKrAaxW3bonw6UBj6PQmVEg75
	VF1urj20NnmjAe3LMkFVWYqeHH1c+AntwEbM3cjXtRqLZzB8c8cplDkcB91VvL2kf5tIVp
	bjua4+SqpyfjJiGRivIPuIZwy0/VkWA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VAxl4xms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751645261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4u2BeJ7xzEOn7uMo8SXkOT0wD/cTGT5eK55JCvqW8rM=;
	b=VAxl4xms6kaDFNy84NskAIStgi9Owvn19Wqoxk6iU+tV2Iz5b0K3ctKmr+Tn8JZA9I5hk9
	HlFv2CEZ4keaABExdeKJy4roI12kIbAVd/82sJeV5gWBIRWyeWig30DCNO2h/YkBwaWdBC
	jd70NX4Yq3UoEuTQHlnCZTyg/EKAnoQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59D5313A71;
	Fri,  4 Jul 2025 16:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 771lFU38Z2jvFQAAD6G6ig
	(envelope-from <neelx@suse.com>); Fri, 04 Jul 2025 16:07:41 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] btrfs: index buffer_tree using node size
Date: Fri,  4 Jul 2025 18:07:02 +0200
Message-ID: <20250704160704.3353446-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 74B7A1F394
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

So far we are deriving the buffer tree index using the sector size. But each
extent buffer covers multiple sectors. This makes the buffer tree rather sparse.

For example the typical and quite common configuration uses sector size of 4KiB
and node size of 16KiB. In this case it means the buffer tree is using up to
the maximum of 25% of it's slots. Or in other words at least 75% of the tree
slots are wasted as never used.

We can score significant memory savings on the required tree nodes by indexing
the tree using the node size instead. As a result far less slots are wasted
and the tree can now use up to all 100% of it's slots this way.

Note: This works even with unaligned tree blocks as we can still get unique
      index by doing eb->start >> nodesize_shift.

Getting some stats from running fio write test, there is a bit of variance.
The values presented in the table below are medians from 5 test runs.
The numbers are (# of allocated ebs in the tree / # of leaf tree nodes /
/ highest index in the tree (radix tree width)):

ebs / leaves / Index |   bare for-next    |      with fix
---------------------+--------------------+-------------------
	post mount   |   16 /  11 / 10e5c |   16 /  10 / 4240
	post test    | 5810 / 891 / 11cfc | 4420 / 252 / 473a
	post rm	     |  574 / 300 / 10ef0 |  540 / 163 / 46e9

In this case (10 gig FS) the height of the tree is still 3 levels but the
4x width reduction is clearly visible as expected. But since the tree is
more dense we can see the 54-72% reduction of leaf nodes. That's very
close to ideal with this test. It means the tree is getting really dense
with this kind of workload.

Also, the fio results show no performance change.

Signed-off-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
V3 changes: Mentioned stats diff in the commit message and rebased.

---
 fs/btrfs/disk-io.c   |  1 +
 fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
 fs/btrfs/fs.h        |  3 ++-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6bc7f7ac381ce..44e7ae4a2e0b6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3397,6 +3397,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
 
 	fs_info->nodesize = nodesize;
+	fs_info->nodesize_bits = ilog2(nodesize);
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7ad4f10bb55a6..685ee685ce92f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1803,7 +1803,7 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 	 */
 	spin_lock(&eb->refs_lock);
 	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
-		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
+		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
 		unsigned long flags;
 
 		set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
@@ -1903,7 +1903,7 @@ static void set_btree_ioerr(struct extent_buffer *eb)
 static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
+	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
 	unsigned long flags;
 
 	xas_lock_irqsave(&xas, flags);
@@ -1915,7 +1915,7 @@ static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
 static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_mark_t mark)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
+	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
 	unsigned long flags;
 
 	xas_lock_irqsave(&xas, flags);
@@ -2015,7 +2015,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_info,
 	rcu_read_lock();
 	while ((eb = find_get_eb(&xas, end, tag)) != NULL) {
 		if (!eb_batch_add(batch, eb)) {
-			*start = ((eb->start + eb->len) >> fs_info->sectorsize_bits);
+			*start = ((eb->start + eb->len) >> fs_info->nodesize_bits);
 			goto out;
 		}
 	}
@@ -2037,7 +2037,7 @@ static struct extent_buffer *find_extent_buffer_nolock(
 		struct btrfs_fs_info *fs_info, u64 start)
 {
 	struct extent_buffer *eb;
-	unsigned long index = (start >> fs_info->sectorsize_bits);
+	unsigned long index = (start >> fs_info->nodesize_bits);
 
 	rcu_read_lock();
 	eb = xa_load(&fs_info->buffer_tree, index);
@@ -2143,8 +2143,8 @@ void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start,
 				      u64 end)
 {
 	struct eb_batch batch;
-	unsigned long start_index = (start >> fs_info->sectorsize_bits);
-	unsigned long end_index = (end >> fs_info->sectorsize_bits);
+	unsigned long start_index = (start >> fs_info->nodesize_bits);
+	unsigned long end_index = (end >> fs_info->nodesize_bits);
 
 	eb_batch_init(&batch);
 	while (start_index <= end_index) {
@@ -2180,7 +2180,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 
 	eb_batch_init(&batch);
 	if (wbc->range_cyclic) {
-		index = ((mapping->writeback_index << PAGE_SHIFT) >> fs_info->sectorsize_bits);
+		index = ((mapping->writeback_index << PAGE_SHIFT) >> fs_info->nodesize_bits);
 		end = -1;
 
 		/*
@@ -2189,8 +2189,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		 */
 		scanned = (index == 0);
 	} else {
-		index = (wbc->range_start >> fs_info->sectorsize_bits);
-		end = (wbc->range_end >> fs_info->sectorsize_bits);
+		index = (wbc->range_start >> fs_info->nodesize_bits);
+		end = (wbc->range_end >> fs_info->nodesize_bits);
 
 		scanned = 1;
 	}
@@ -3070,7 +3070,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 	eb->fs_info = fs_info;
 again:
 	xa_lock_irq(&fs_info->buffer_tree);
-	exists = __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->sectorsize_bits,
+	exists = __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->nodesize_bits,
 			      NULL, eb, GFP_NOFS);
 	if (xa_is_err(exists)) {
 		ret = xa_err(exists);
@@ -3387,7 +3387,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 again:
 	xa_lock_irq(&fs_info->buffer_tree);
 	existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
-				   start >> fs_info->sectorsize_bits, NULL, eb,
+				   start >> fs_info->nodesize_bits, NULL, eb,
 				   GFP_NOFS);
 	if (xa_is_err(existing_eb)) {
 		ret = xa_err(existing_eb);
@@ -3490,7 +3490,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 		 * in this case.
 		 */
 		xa_cmpxchg_irq(&fs_info->buffer_tree,
-			       eb->start >> fs_info->sectorsize_bits, eb, NULL,
+			       eb->start >> fs_info->nodesize_bits, eb, NULL,
 			       GFP_ATOMIC);
 
 		btrfs_leak_debug_del_eb(eb);
@@ -4332,9 +4332,9 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 	struct extent_buffer *eb;
-	unsigned long start = (folio_pos(folio) >> fs_info->sectorsize_bits);
+	unsigned long start = (folio_pos(folio) >> fs_info->nodesize_bits);
 	unsigned long index = start;
-	unsigned long end = index + (PAGE_SIZE >> fs_info->sectorsize_bits) - 1;
+	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
 	int ret;
 
 	xa_lock_irq(&fs_info->buffer_tree);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5154ad390f319..8cc07cc70b128 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -773,7 +773,7 @@ struct btrfs_fs_info {
 
 	struct btrfs_delayed_root *delayed_root;
 
-	/* Entries are eb->start / sectorsize */
+	/* Entries are eb->start >> nodesize_bits */
 	struct xarray buffer_tree;
 
 	/* Next backup root to be overwritten */
@@ -805,6 +805,7 @@ struct btrfs_fs_info {
 
 	/* Cached block sizes */
 	u32 nodesize;
+	u32 nodesize_bits;
 	u32 sectorsize;
 	/* ilog2 of sectorsize, use to avoid 64bit division */
 	u32 sectorsize_bits;
-- 
2.47.2


