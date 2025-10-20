Return-Path: <linux-btrfs+bounces-18022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCCBEF611
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BD474E1876
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 05:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566FE2C374B;
	Mon, 20 Oct 2025 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rZ0pg3Ha";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RGzzV/Z8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177B2C3260
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760939891; cv=none; b=l/fgak3b0JqNxXdzrv8EUNpRoz6F04aw07tgG353YpUJhRVtrCEfPwJU9+iZSU/RgmdChQ8cETkewq6EeGcgL17XYVfIgNGATTGEckvEnbslTjWVZ2s6TNZESZnH+bvmYShnQCOwkmtc2nac+GMc2r+XAksu4any63JATUwYGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760939891; c=relaxed/simple;
	bh=lO84I7fy9+5PHf+l4X/rDmDtc7S8qWnMCPdWM7bB/8I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JFLlfbKy8ZejXQ+mBqGu5QR6saJizmBkwiej9WirGfXJL5mQ5owa4cZd9eBbWmfLztIij0Zpl0Y/0sryPR2C1LoVxauNPch/aRCmhGXJQg2CEP+VnqT3a+eHR3VrUEpMG5Mr3WB7jXmYsNgvQDw+EEmohENw2Gl14uJUeR8NG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rZ0pg3Ha; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RGzzV/Z8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80EF91F387
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760939876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WUyArydbWYZF+17q4KvBVRwh7bWDiUqZcT90PaHc53M=;
	b=rZ0pg3HaTYRnjq4+e3NDN69yaaG+6pX5a3zOWfALOOqeAfW8LoK3FRHYruVlOUGyX4c8cu
	xMYicrB0btMkXwV2/Kn2BLoF9KqfWRKGNqwe6enUa69n0ewHNfC/tcUsLIjkv70JFEORMZ
	UUfrUaqkMfQwZ9Z2XaQOjSu1Q1qusKc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="RGzzV/Z8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760939872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WUyArydbWYZF+17q4KvBVRwh7bWDiUqZcT90PaHc53M=;
	b=RGzzV/Z8QuQ//PtKjzpKWdh8I+uSkZ8kLsGbTKEvawguTGpWnmXqZ2NmGDGk33OlOj6O85
	ltkQ4lzqH9mN+lbVvFsQE34EJSubasfNVw4JYHez/I1NcrL/zG2NIG5ZiZgPPxsMaHJ+b4
	cx4KvCsFvDjYVoZR5Lhn7vyHkcBc3zM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB0B313AAC
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 05:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JnevHl/P9WhvPwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 05:57:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: get rid of btrfs_dio_private
Date: Mon, 20 Oct 2025 16:27:34 +1030
Message-ID: <c5f3f2c9e1d5a3754ff61b3569191b31d13b9bda.1760939793.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80EF91F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

For direct IO we need to record the file offset and size of the IO, thus
we have btrfs_dio_private structure and a dedicated bioset for it.

However for the file offset, we already btrfs_bio::file_offset, thus we
really only need a size.

Thankfully there is a hole inside btrfs_bio, between @fs_info and @bio, as
both members requires 8 bytes alignment (for 64bit systems).

The member @status and @csum_search_commit_root are both in single byte size,
leaving us 6 bytes to use.

So here we use a u32 to store the bio size, which should be more than
enough, and put the new @size member into that hole, so we can store a
new member without increasing the size of btrfs_bio.

Then we can safely remove btrfs_dio_private, the only exception is we
can not get rid of btrfs_dio_bioset, but this time we can just reuse the
existing btrfs_bio to handle everything.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c       |  4 ++++
 fs/btrfs/bio.h       |  2 ++
 fs/btrfs/direct-io.c | 34 +++++++++++-----------------------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 21df48e6c4fa..fc7182b5a8e3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -809,7 +809,11 @@ void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
 	/* If bbio->inode is not populated, its file_offset must be 0. */
 	ASSERT(bbio->inode || bbio->file_offset == 0);
 
+	/* The bio should not exceed U32 size limit. */
+	ASSERT(bbio->bio.bi_iter.bi_size < U32_MAX);
+
 	assert_bbio_alignment(bbio);
+	bbio->size = bbio->bio.bi_iter.bi_size;
 
 	while (!btrfs_submit_chunk(bbio, mirror_num))
 		;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 00883aea55d7..e675937c356a 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -79,6 +79,8 @@ struct btrfs_bio {
 	/* File system that this I/O operates on. */
 	struct btrfs_fs_info *fs_info;
 
+	u32 size;
+
 	/* Save the first error status of split bio. */
 	blk_status_t status;
 
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..4dd901dc4abc 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -19,15 +19,6 @@ struct btrfs_dio_data {
 	bool nocow_done;
 };
 
-struct btrfs_dio_private {
-	/* Range of I/O */
-	u64 file_offset;
-	u32 bytes;
-
-	/* This must be last */
-	struct btrfs_bio bbio;
-};
-
 static struct bio_set btrfs_dio_bioset;
 
 static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
@@ -642,25 +633,26 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 {
-	struct btrfs_dio_private *dip =
-		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_inode *inode = bbio->inode;
 	struct bio *bio = &bbio->bio;
 
+	/* We should have bbio->bytes populated. */
+	ASSERT(bbio->size);
+
 	if (bio->bi_status) {
 		btrfs_warn(inode->root->fs_info,
 		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
 			   btrfs_ino(inode), bio->bi_opf,
-			   dip->file_offset, dip->bytes, bio->bi_status);
+			   bbio->file_offset, bbio->size, bio->bi_status);
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		btrfs_finish_ordered_extent(bbio->ordered, NULL,
-					    dip->file_offset, dip->bytes,
+					    bbio->file_offset, bbio->size,
 					    !bio->bi_status);
 	} else {
-		btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset,
-					dip->file_offset + dip->bytes - 1, NULL);
+		btrfs_unlock_dio_extent(&inode->io_tree, bbio->file_offset,
+					bbio->file_offset + bbio->size - 1, NULL);
 	}
 
 	bbio->bio.bi_private = bbio->private;
@@ -709,19 +701,15 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 				loff_t file_offset)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
-	struct btrfs_dio_private *dip =
-		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
+	const u32 bio_size = bio->bi_iter.bi_size;
 
 	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
 		       btrfs_dio_end_io, bio->bi_private);
 	bbio->inode = BTRFS_I(iter->inode);
 	bbio->file_offset = file_offset;
 
-	dip->file_offset = file_offset;
-	dip->bytes = bio->bi_iter.bi_size;
-
-	dio_data->submitted += bio->bi_iter.bi_size;
+	dio_data->submitted += bio_size;
 
 	/*
 	 * Check if we are doing a partial write.  If we are, we need to split
@@ -736,7 +724,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
 		if (ret) {
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
-						    file_offset, dip->bytes,
+						    file_offset, bio_size,
 						    !ret);
 			bio->bi_status = errno_to_blk_status(ret);
 			iomap_dio_bio_end_io(bio);
@@ -1093,7 +1081,7 @@ ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 int __init btrfs_init_dio(void)
 {
 	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_dio_private, bbio.bio),
+			offsetof(struct btrfs_bio, bio),
 			BIOSET_NEED_BVECS))
 		return -ENOMEM;
 
-- 
2.51.0


