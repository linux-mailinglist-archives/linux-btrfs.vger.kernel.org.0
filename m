Return-Path: <linux-btrfs+bounces-21139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NKfMpB2eWkSxQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21139-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:38:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DCC9C54D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D880A3014426
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488B29B200;
	Wed, 28 Jan 2026 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YVCrQlda";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YVCrQlda"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28182C027A
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567881; cv=none; b=i6UdLl5IGcuhSiN3eHNCqrbHNaOZNNnyTadflZwCn/8BMSnVGTFVMN8EeAD0z5YnuzHuCjIwBvro48CLHQYgwhh/1J0SBOwOoLID2uKrODT9dosiE7DNfQIk/3OZzJz8U8rfEEFUlLifdHI7SQdEntNVCo8xBvyt3wG5dtIU8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567881; c=relaxed/simple;
	bh=wPdWzLdukjUGnHtDHzdNjobwIWWu9RmhP+fv3tBnWCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVFjjQ2M3A2obFrhUEj64BP4CBIJ5s3Q2YhfIcgPmjrgzz3vml7TZ8dJzJ2v5XfpQ2Gd4sS/ccsWdGi8VcSWXXptQHyMnxf1y0ToHrTdqpyGPbl8qArJrGkzFkbcbBFLAhejVEfjBjw0Oi+mGq2DknkuwPfJo0SnLtQTJlHUSTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YVCrQlda; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YVCrQlda; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CE535BCDF
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OBknixlUIXwsQOiaggfhh4KbJ+88B+6mr+MQNPT84E=;
	b=YVCrQlda9p9WmpsQaDbyVaTS1bWy1LLjL9HE+4aucsgQh62hhE2oUePpMloR/QT/sopVr/
	4tjvuQpxoU9jmiXVuSkvpk02vPNslUUpRUUlUHi+0VAgvNpsz6MG6r9ql4Z788m4DulYro
	vAwAqAV0Oe4vOWdJbpFEBJ5ZI7UOw3M=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YVCrQlda
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OBknixlUIXwsQOiaggfhh4KbJ+88B+6mr+MQNPT84E=;
	b=YVCrQlda9p9WmpsQaDbyVaTS1bWy1LLjL9HE+4aucsgQh62hhE2oUePpMloR/QT/sopVr/
	4tjvuQpxoU9jmiXVuSkvpk02vPNslUUpRUUlUHi+0VAgvNpsz6MG6r9ql4Z788m4DulYro
	vAwAqAV0Oe4vOWdJbpFEBJ5ZI7UOw3M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 683A13EA61
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UDNxBnJ2eWkbZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 7/9] btrfs: get rid of compressed_folios[] usage for compressed read
Date: Wed, 28 Jan 2026 13:07:06 +1030
Message-ID: <428a89e9b79c5f49a0746a92cb5fbfe4f64b91be.1769566870.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769566870.git.wqu@suse.com>
References: <cover.1769566870.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21139-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44DCC9C54D
X-Rspamd-Action: no action

Currently btrfs_submit_compressed_read() still uses
compressed_bio::compressed_folios[] array.

Change it to allocate each folio and queue them into the compressed bio
so that we do not need to allocate that array.

Considering how small each compressed read bio is (less than 128KiB), we
do not benefit that much from btrfs_alloc_folio_array() anyway,
meanwhile we may benefit more from btrfs_alloc_compr_folio() by using
the global folio pool.

So chaning from btrfs_alloc_folio_array() to btrfs_alloc_compr_folio()
in a loop should still be fine.

This removes one error path, and paves the way to completely remove
compressed_folios[] array.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1bf17c269524..c018b3c4554e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -239,7 +239,7 @@ static void end_bbio_compressed_read(struct btrfs_bio *bbio)
 
 	btrfs_bio_end_io(cb->orig_bbio, status);
 	bio_for_each_folio_all(fi, &bbio->bio)
-		folio_put(fi.folio);
+		btrfs_free_compr_folio(fi.folio);
 	bio_put(&bbio->bio);
 }
 
@@ -537,13 +537,13 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	u64 file_offset = bbio->file_offset;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
 	unsigned long pflags;
 	int memstall = 0;
-	blk_status_t status;
 	int ret;
 
 	/* we need the actual starting offset of this extent in the file */
@@ -551,7 +551,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	em = btrfs_lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
 	if (!em) {
-		status = BLK_STS_IOERR;
+		ret = -EIO;
 		goto out;
 	}
 
@@ -573,27 +573,31 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 	btrfs_free_extent_map(em);
 
-	cb->nr_folios = DIV_ROUND_UP(compressed_len, btrfs_min_folio_size(fs_info));
-	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct folio *), GFP_NOFS);
-	if (!cb->compressed_folios) {
-		status = BLK_STS_RESOURCE;
-		goto out_free_bio;
-	}
+	for (int i = 0; i * min_folio_size < compressed_len; i++) {
+		struct folio *folio;
+		u32 cur_len = min(compressed_len - i * min_folio_size,
+				  min_folio_size);
 
-	ret = btrfs_alloc_folio_array(cb->nr_folios, fs_info->block_min_order,
-				      cb->compressed_folios);
-	if (ret) {
-		status = BLK_STS_RESOURCE;
-		goto out_free_compressed_pages;
+		folio = btrfs_alloc_compr_folio(fs_info);
+		if (!folio) {
+			ret = -ENOMEM;
+			goto out_free_bio;
+		}
+
+		ret = bio_add_folio(&cb->bbio.bio, folio, cur_len, 0);
+		if (unlikely(!ret)) {
+			folio_put(folio);
+			ret = -EINVAL;
+			goto out_free_bio;
+		}
 	}
+	ASSERT(cb->bbio.bio.bi_iter.bi_size == compressed_len);
 
 	add_ra_bio_pages(&inode->vfs_inode, em_start + em_len, cb, &memstall,
 			 &pflags);
 
-	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bbio->bio.bi_iter.bi_size;
 	cb->bbio.bio.bi_iter.bi_sector = bbio->bio.bi_iter.bi_sector;
-	btrfs_add_compressed_bio_folios(cb);
 
 	if (memstall)
 		psi_memstall_leave(&pflags);
@@ -601,12 +605,10 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	btrfs_submit_bbio(&cb->bbio, 0);
 	return;
 
-out_free_compressed_pages:
-	kfree(cb->compressed_folios);
 out_free_bio:
-	bio_put(&cb->bbio.bio);
+	cleanup_compressed_bio(cb);
 out:
-	btrfs_bio_end_io(bbio, status);
+	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
 }
 
 /*
-- 
2.52.0


