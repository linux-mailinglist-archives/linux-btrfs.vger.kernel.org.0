Return-Path: <linux-btrfs+bounces-13324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CFA9944F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C33E164B26
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1902820A7;
	Wed, 23 Apr 2025 15:57:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E261279345
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423873; cv=none; b=XVL7+n/ts2HwQanC+SVZpjtRFv2IHfkpVga9u/9qVYFOQ3pJdUYKuu7tdIhXFmVVZk/3BRAonH6krmThsCowoAz7xwafpmbJcxlaBfmiD8EzOUIlZp3a6OcBfaTlbYIjemWChq0DgR5QwIjtq+3CE+CcjQjCWF72hj0NRURBw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423873; c=relaxed/simple;
	bh=vf9OnJ92Nbu9o8GXuvDyh6WjI6kATMvJU0sq2ljWjbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urtHhv83h+7KesqEhxq5SSwXNn8ctJNjlWmlkR+iqq7phMEjAnmB34jns1NHOflgIPh/0Ikp4cvM2q4QlW3adHeKCHtL35+PW3tshZTjlJApp/EnN1mbOgeLqWsFWFszbFhw7mBXyPBTx8QjeuZHyBZ7mWWvNMAOgLd9RDi0Hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC99C1F441;
	Wed, 23 Apr 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5F0313691;
	Wed, 23 Apr 2025 15:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VxtpLPcNCWiNCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:57:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/12] btrfs: change return type of btrfs_lookup_bio_sums() to int
Date: Wed, 23 Apr 2025 17:57:14 +0200
Message-ID: <8b466c922528fc1df5bea8d998b2b8ba501a8cee.1745422901.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745422901.git.dsterba@suse.com>
References: <cover.1745422901.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BC99C1F441
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The type blk_status_t is from block layer and not related to checksums
in our context. Use int internally and do the conversions to blk_status_t
as needed in btrfs_submit_chunk().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c       |  3 ++-
 fs/btrfs/file-item.c | 12 ++++++------
 fs/btrfs/file-item.h |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a3ee9a976f6fa5..5c40035e493d92 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -714,7 +714,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	 */
 	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
 		bbio->saved_iter = bio->bi_iter;
-		ret = btrfs_lookup_bio_sums(bbio);
+		error = btrfs_lookup_bio_sums(bbio);
+		ret = errno_to_blk_status(error);
 		if (ret)
 			goto fail;
 	}
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 827d156a7bd7a8..895c435314f580 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -336,7 +336,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
  *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
-blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
+int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -347,12 +347,12 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	u32 orig_len = bio->bi_iter.bi_size;
 	u64 orig_disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
-	blk_status_t ret = BLK_STS_OK;
+	int ret = 0;
 	u32 bio_offset = 0;
 
 	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
 	    test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state))
-		return BLK_STS_OK;
+		return 0;
 
 	/*
 	 * This function is only called for read bio.
@@ -369,12 +369,12 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	ASSERT(bio_op(bio) == REQ_OP_READ);
 	path = btrfs_alloc_path();
 	if (!path)
-		return BLK_STS_RESOURCE;
+		return -ENOMEM;
 
 	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 		bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
 		if (!bbio->csum)
-			return BLK_STS_RESOURCE;
+			return -ENOMEM;
 	} else {
 		bbio->csum = bbio->csum_inline;
 	}
@@ -406,7 +406,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
 					 orig_len - bio_offset, csum_dst);
 		if (count < 0) {
-			ret = errno_to_blk_status(count);
+			ret = count;
 			if (bbio->csum != bbio->csum_inline)
 				kfree(bbio->csum);
 			bbio->csum = NULL;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 6181a70ec3efb4..995539a68df8be 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -53,7 +53,7 @@ static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
 
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len);
-blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio);
+int btrfs_lookup_bio_sums(struct btrfs_bio *bbio);
 int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 objectid, u64 pos,
 			     u64 num_bytes);
-- 
2.49.0


