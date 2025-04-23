Return-Path: <linux-btrfs+bounces-13327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F3A9944C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C1A4A269F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7D2283680;
	Wed, 23 Apr 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jXwAMLvC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jXwAMLvC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CA2820B3
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423888; cv=none; b=SWonyGwSP2Pv2jlLSfE1jApGV+cwmT0GsQrqjszN9F+gSu1phhSQWNu83owSY+PsKxmEm5qFDpNnSxtsgTpQ1x2HPW4FC/aWKbsRn3Ys9Fum0+sbabVOioA3VB6DERi593mjZ+KcatCQSW0Kro+4ffxU8eFMVt0vKrvLbKMqEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423888; c=relaxed/simple;
	bh=Z/Vg51y21mqt0mRG25/fZdmqF/OEZPq1/QoCXJu0IAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrZYEd1G3RIu2f81a5Q9IPTqP+M6jl6SQt5yzJVRfLppr4/T/RcTbeIbZr5VzRTJgds6Yyd3g6/FMlvf56TzpWucFp9njLBWGuhadYUezfigxm7l+mfcYcnFwS+7M+gK2b8m9ZliC3Fd9n/51beRI2G5JjDZcrHS884wVwkulhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jXwAMLvC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jXwAMLvC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FC5821190;
	Wed, 23 Apr 2025 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ux0FAlLGzOBX8KK3J4hQAYHF7bFTZ0VHFmfh8l3O5Q=;
	b=jXwAMLvCL7MD7bYVll2EbHC2o/K7cAIzmxnlT9NDcHG1iPTyWoMO8yJywMqvgZsy1ft1h4
	YmUMGbYqdu4jlCuLQVhZDSLBe5i+4u91nqEflzOWqcDEsLLOPKD42oZ5ALkTB+K5nes3MD
	o13f3T42aDPUr7pSrMyDbjrWZ1zO35U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ux0FAlLGzOBX8KK3J4hQAYHF7bFTZ0VHFmfh8l3O5Q=;
	b=jXwAMLvCL7MD7bYVll2EbHC2o/K7cAIzmxnlT9NDcHG1iPTyWoMO8yJywMqvgZsy1ft1h4
	YmUMGbYqdu4jlCuLQVhZDSLBe5i+4u91nqEflzOWqcDEsLLOPKD42oZ5ALkTB+K5nes3MD
	o13f3T42aDPUr7pSrMyDbjrWZ1zO35U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 391AA13691;
	Wed, 23 Apr 2025 15:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yH7tDQAOCWibCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:57:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/12] btrfs: change return type of btree_csum_one_bio() to int
Date: Wed, 23 Apr 2025 17:57:16 +0200
Message-ID: <54cb5ad4d594e7dfddf43ca2e4883105e054ff15.1745422901.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The type blk_status_t is from block layer and not related to checksums
in our context. Use int internally and do the conversions to blk_status_t
as needed in btrfs_bio_csum().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c     |  2 +-
 fs/btrfs/disk-io.c | 16 ++++++++--------
 fs/btrfs/disk-io.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4f622bf130c2aa..4ceb1bd511df1e 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -515,7 +515,7 @@ static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
-		return btree_csum_one_bio(bbio);
+		return errno_to_blk_status(btree_csum_one_bio(bbio));
 	return errno_to_blk_status(btrfs_csum_one_bio(bbio));
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3592300ae3e2e5..20fd0958f18077 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -256,7 +256,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 /*
  * Checksum a dirty tree block before IO.
  */
-blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
+int btree_csum_one_bio(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -267,9 +267,9 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	/* Btree blocks are always contiguous on disk. */
 	if (WARN_ON_ONCE(bbio->file_offset != eb->start))
-		return BLK_STS_IOERR;
+		return -EIO;
 	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
-		return BLK_STS_IOERR;
+		return -EIO;
 
 	/*
 	 * If an extent_buffer is marked as EXTENT_BUFFER_ZONED_ZEROOUT, don't
@@ -278,13 +278,13 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	 */
 	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
 		memzero_extent_buffer(eb, 0, eb->len);
-		return BLK_STS_OK;
+		return 0;
 	}
 
 	if (WARN_ON_ONCE(found_start != eb->start))
-		return BLK_STS_IOERR;
+		return -EIO;
 	if (WARN_ON(!btrfs_meta_folio_test_uptodate(eb->folios[0], eb)))
-		return BLK_STS_IOERR;
+		return -EIO;
 
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
 				    offsetof(struct btrfs_header, fsid),
@@ -312,7 +312,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 		goto error;
 	}
 	write_extent_buffer(eb, result, 0, fs_info->csum_size);
-	return BLK_STS_OK;
+	return 0;
 
 error:
 	btrfs_print_tree(eb, 0);
@@ -326,7 +326,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	 */
 	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
 		btrfs_header_owner(eb) == BTRFS_TREE_LOG_OBJECTID);
-	return errno_to_blk_status(ret);
+	return ret;
 }
 
 static bool check_tree_block_fsid(struct extent_buffer *eb)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 587842991b2442..f87bbb7f8e7e29 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -114,7 +114,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 int btrfs_read_extent_buffer(struct extent_buffer *buf,
 			     const struct btrfs_tree_parent_check *check);
 
-blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio);
+int btree_csum_one_bio(struct btrfs_bio *bbio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
-- 
2.49.0


