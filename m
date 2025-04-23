Return-Path: <linux-btrfs+bounces-13325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602FDA994DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6D41BC5C35
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5212820A8;
	Wed, 23 Apr 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CpIOV3S9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CpIOV3S9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FE27FD42
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423880; cv=none; b=tsZ+dCo+YDKtX5hokVtwaj0uOHwr5cLRQ2efCNnfWxrHbxYtKetwSv4nWaOBvDwJVSZaHNgdPMYOtxyRai5R9cHnl0cVx/+Pr29PEfVrvtyjKUZ+YfNYKfOjxy5NR/5A862Oum5kjSP9/nHP/B+YIp+34P3OPYcNAyyepZrV3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423880; c=relaxed/simple;
	bh=bmSu0PQmZJ5+P9gpdMqqEGCBxqrfQsOYQVs+vSakE9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNhFZWHZ9nU7p9hBZQEM0JXVbioWm8oEg4If/HW2s8ekRGBZNQ5A9KVrOABoShoDKlzBu8sqGupCAU9UzBHRghFspnJs6MrMXkIkEIvXFe6ROWgQlUMjI0PfD0q/IC+qD1MQ93bwVUS+vnQOAUEP2AHMklgvVNMgrzVpclYGZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CpIOV3S9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CpIOV3S9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 081B82118F;
	Wed, 23 Apr 2025 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGcmzPJ9SigccI94rzIX+zbQj21znHUQY+9/LRsu6jk=;
	b=CpIOV3S9l9heHBQB+EkjQjsJU6m5E7CJErKuiHBZxZgJchGtApLl9oa88yT3OfsYS9h3G7
	zGHuqzDbkaAz0oaVah+ih7BEbo41hD6EKTWjpHmpSbXAewZPd1c8Db2SZO1Knc5kABLoDP
	353Cfsiym9Ua7J9NfiFDP2JJwy2/85U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGcmzPJ9SigccI94rzIX+zbQj21znHUQY+9/LRsu6jk=;
	b=CpIOV3S9l9heHBQB+EkjQjsJU6m5E7CJErKuiHBZxZgJchGtApLl9oa88yT3OfsYS9h3G7
	zGHuqzDbkaAz0oaVah+ih7BEbo41hD6EKTWjpHmpSbXAewZPd1c8Db2SZO1Knc5kABLoDP
	353Cfsiym9Ua7J9NfiFDP2JJwy2/85U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 005BB13691;
	Wed, 23 Apr 2025 15:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wzYUAP4NCWiXCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:57:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/12] btrfs: change return type of btrfs_csum_one_bio() to int
Date: Wed, 23 Apr 2025 17:57:15 +0200
Message-ID: <bfcc4aba04c63510a4d9555b6acaeef1a452364a.1745422901.git.dsterba@suse.com>
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
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The type blk_status_t is from block layer and not related to checksums
in our context. Use int internally and do the conversions to blk_status_t
as needed in btrfs_bio_csum().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/file-item.c | 4 ++--
 fs/btrfs/file-item.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5c40035e493d92..4f622bf130c2aa 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -516,7 +516,7 @@ static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
 		return btree_csum_one_bio(bbio);
-	return btrfs_csum_one_bio(bbio);
+	return errno_to_blk_status(btrfs_csum_one_bio(bbio));
 }
 
 /*
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 895c435314f580..293dd3298b98bb 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -735,7 +735,7 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 /*
  * Calculate checksums of the data contained inside a bio.
  */
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
+int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 {
 	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
@@ -757,7 +757,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	memalloc_nofs_restore(nofs_flag);
 
 	if (!sums)
-		return BLK_STS_RESOURCE;
+		return -ENOMEM;
 
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 995539a68df8be..323dfb84f16c1d 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+int btrfs_csum_one_bio(struct btrfs_bio *bbio);
 blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
-- 
2.49.0


