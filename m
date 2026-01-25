Return-Path: <linux-btrfs+bounces-21008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PdvDr2gdmmOTAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21008-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:01:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE541830AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7033E3058E50
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75E312803;
	Sun, 25 Jan 2026 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e3bFORfb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e3bFORfb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BD30DD1A
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381386; cv=none; b=fpaIQ7/QdTIUo6UvJZ57H2ekm23hFLMUsd9N2FKAQ7OoRgbG1cvbPIGG/BbFcaVF9tUyHOG0bIN+GlnTZF5OlBNHD7EDtiICF3TeBF1t9kQZeTjPsJSvtHmZYss7yvrktkgABTuzKO63NAxSa1pOUZuHl2hZ3P+QuuWQ0Jb6JHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381386; c=relaxed/simple;
	bh=7nGDA3q9YwUJ/JHqMVBvuLESpWlEouY9UF8AWOXO770=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKkuzmDMK9rCHCPAJ84l4Ehc4WDOdyDxOYKniKH+oWtHMXh6pXrfK/3+VjI+bvAui30oQXkNOlcVbcHDqjPlncJECF4sxNwfEx5NwPgMKdkJu0nEy1p7f8wZq7MZP/8LylnwXYR1uDIaFh5nxn9Of3e3o938CpB6PLFIhbOsHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e3bFORfb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e3bFORfb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E99F336D1
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcX8cvcy++T66BMYCVqgJmAxMXzMrJdLcEvtYBILg3w=;
	b=e3bFORfbe4RIwX1qhdxfJ7eBUZUTR0SDhqQxiF1HB8MeqBt6Cqnmt5/MYodrQG6HbTgUne
	U3+vq4CQ3/nXPMR/ZubGd7oGnrftJMYuemapaLL0Hu5BW0E5Bslb5MRW0FJ9WF0Ly2ZX/H
	QFVVA5mvRBlu2/ygZ9/ZLB0wzVZcQos=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcX8cvcy++T66BMYCVqgJmAxMXzMrJdLcEvtYBILg3w=;
	b=e3bFORfbe4RIwX1qhdxfJ7eBUZUTR0SDhqQxiF1HB8MeqBt6Cqnmt5/MYodrQG6HbTgUne
	U3+vq4CQ3/nXPMR/ZubGd7oGnrftJMYuemapaLL0Hu5BW0E5Bslb5MRW0FJ9WF0Ly2ZX/H
	QFVVA5mvRBlu2/ygZ9/ZLB0wzVZcQos=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C13139E9
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0OTQLu6ddmnSTAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: get rid of compressed_folios[] usage for compressed read
Date: Mon, 26 Jan 2026 09:18:46 +1030
Message-ID: <50ef30abed0350203f4f91478e54c2fd0f963738.1769381237.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769381237.git.wqu@suse.com>
References: <cover.1769381237.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21008-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: AE541830AD
X-Rspamd-Action: no action

Currently btrfs_submit_compressed_read() still uses
compressed_bio::compressed_folios[] array.

Change it to allocate each folio and queue them into the compressed bio
so that we do not need to allocate that array.

This removes one error path, and paves the way to completely remove
compressed_folios[] array.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 83253803e2c9..037da3a17c71 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -538,13 +538,13 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
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
@@ -552,7 +552,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	em = btrfs_lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
 	if (!em) {
-		status = BLK_STS_IOERR;
+		ret = -EIO;
 		goto out;
 	}
 
@@ -574,27 +574,31 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
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
@@ -602,12 +606,10 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
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


