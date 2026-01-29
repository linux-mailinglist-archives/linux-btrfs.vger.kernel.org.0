Return-Path: <linux-btrfs+bounces-21214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGq/MAHTemlX+wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21214-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AC4AB6D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D0373009E27
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8941E34EF0D;
	Thu, 29 Jan 2026 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TMitZUwa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TMitZUwa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CF31618C
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657069; cv=none; b=o1il5oqUmVxqWTFyRpjYrAhXz2mmTYLu3IareqOtLqTMJfrZjeAt/oxY6YNRXWbWmF7LwzmwLIJdZElfZy6JcUfZuDvCTGchfc2qE8HR8BE3/M5kX+r3T5UFdiqISgopYnwION7XQIcB6N2DCVcmJCMFbCNGFsgplKAC6HVwsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657069; c=relaxed/simple;
	bh=1AgKo7itrZ3iyBJzURem4pr8Cn3gDLrOIhaGzmqZ5ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJOOAFcXQ0gehvfkE7jCiJ+Z4HyJ2w9+KcZSVn5TIfZSRrCft8pTGyMQnk8CjwUE0iglRuShPYl7DRatOaxy9vsr02exsUeOJASR/z8PpcHO+X5rhVB92jz1MpN1kK5ECWCbrc910xg9danoP24u1XTdcyCNDbPexpm+wnxSgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TMitZUwa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TMitZUwa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4B445BCDC;
	Thu, 29 Jan 2026 03:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwvVLhgpOU+l7B1Z1UCuBGNOh6l6PQtOoHfRKNrA0r4=;
	b=TMitZUwaYsPqxXMLJD176LdJEY6p2nFgrnJP35wwAYC8yH586voBCTac32P+inoua+INXI
	SGGuY35PRnyQ40sUncGYp7AlVb7iqingprjvFc1ZPWO/PvKFebXU2vkxcZ392k+fjAh1tt
	j80cgMfX3mEUui36MehG0J9EJ0Qwd+Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TMitZUwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwvVLhgpOU+l7B1Z1UCuBGNOh6l6PQtOoHfRKNrA0r4=;
	b=TMitZUwaYsPqxXMLJD176LdJEY6p2nFgrnJP35wwAYC8yH586voBCTac32P+inoua+INXI
	SGGuY35PRnyQ40sUncGYp7AlVb7iqingprjvFc1ZPWO/PvKFebXU2vkxcZ392k+fjAh1tt
	j80cgMfX3mEUui36MehG0J9EJ0Qwd+Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 749C33EA61;
	Thu, 29 Jan 2026 03:24:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBXNCOPSemk+TgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 29 Jan 2026 03:24:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v5 7/9] btrfs: get rid of compressed_folios[] usage for compressed read
Date: Thu, 29 Jan 2026 13:53:44 +1030
Message-ID: <9e64c91cad7c5fd2bc2749b1ddd5e9af96ba7e1d.1769656714.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769656714.git.wqu@suse.com>
References: <cover.1769656714.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21214-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: E2AC4AB6D4
X-Rspamd-Action: no action

Currently btrfs_submit_compressed_read() still uses
compressed_bio::compressed_folios[] array.

Change it to allocate each folio and queue them into the compressed bio
so that we do not need to allocate that array.

Considering how small each compressed read bio is (less than 128KiB), we
do not benefit that much from btrfs_alloc_folio_array() anyway,
meanwhile we may benefit more from btrfs_alloc_compr_folio() by using
the global folio pool.

So changing from btrfs_alloc_folio_array() to btrfs_alloc_compr_folio()
in a loop should still be fine.

This removes one error path, and paves the way to completely remove
compressed_folios[] array.

Reviewed-by: Boris Burkov <boris@bur.io>
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


