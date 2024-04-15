Return-Path: <linux-btrfs+bounces-4284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3308A5E41
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 01:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85686284CBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 23:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C516156F35;
	Mon, 15 Apr 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bEcLKyyQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bEcLKyyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DD158873
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223471; cv=none; b=UrZ4R8YdiQacCNE1N/jHFZ0QeEaMlD/Czbx8kZ5AHR3AeTkeL1Z11Zla9S2pHrP5I0VZK/OF9ruoObL1KaA+xps4fj8LCrWZFEaPbUf7vZ9wB4+lVTjPUzZUqNVoMlhaFtknvQyTap+G2jUAPgRj7T4/63m7XMZ5Ol6Scohwd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223471; c=relaxed/simple;
	bh=DgOK/ODnw+oORLypOGL5v1hnrvk8eJw3Ys83F9a24hk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsTTevE3Nt8pJ/4WT03JlI8ePrEpYiQl5sPQkYvQnqq9yMAxNzrNXutzX76pdC9tLMtydFKRA+LkydWnbsbDvHjLaay2Vz0MHSUZmIjKQhldj9p85BNQLxEyyGUoLSYpWqGhqH3Gipc6dnGgTtiqaDOwDD8QR/K1I+Ie488YONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bEcLKyyQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bEcLKyyQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA3865D4E3
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713223467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zd2CvyeHaMoHUL3Na5VjVnZLEzITJgACAiVorzCUHHA=;
	b=bEcLKyyQGBfYaUYITfukCbyYNAsZ8CCUnYo4BmLPFeapAfpex0PG2CNCVtY1rTzOrxuZCy
	2x+yoi5Y2HbvTjpccJFeWWELgNeYHlHZyZWHou1ZCYXIiYzQiW5wP2S8pBo0H6FkajYfST
	EeA7xOr4ePC8r3CmkRqtWrzgDzQtn7M=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713223467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zd2CvyeHaMoHUL3Na5VjVnZLEzITJgACAiVorzCUHHA=;
	b=bEcLKyyQGBfYaUYITfukCbyYNAsZ8CCUnYo4BmLPFeapAfpex0PG2CNCVtY1rTzOrxuZCy
	2x+yoi5Y2HbvTjpccJFeWWELgNeYHlHZyZWHou1ZCYXIiYzQiW5wP2S8pBo0H6FkajYfST
	EeA7xOr4ePC8r3CmkRqtWrzgDzQtn7M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F15E31368B
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2EYQKyq3HWZzSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: tree-checker: add one extra file extent item ram_bytes check
Date: Tue, 16 Apr 2024 08:54:06 +0930
Message-ID: <52ebe8f2afb1460ef9b5abc814c432b4f4bd0dd4.1713223082.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713223082.git.wqu@suse.com>
References: <cover.1713223082.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

During my development on extent map cleanups, I hit a case where we can
create a file extent item that has ram_bytes double the size of
num_bytes but it's not compressed.

Later it turns out to be a bug in btrfs_split_ordered_extent(), and
thankfully it doesn't cause any real corruption, just a drift from
on-disk format.

Here we add an extra check on ram_bytes for btrfs_file_extent_item to
catch such problem.

However considering the incorrect ram_bytes are already in the wild, and
no real data corruption, we do not want end users to be bothered as their
data is still consistent.

So this patch would only hide the check behind DEBUG builds for us
developers to catch future problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c8fbcae4e88e..8dfbec3e6ba2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -212,6 +212,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
+	u8 compression;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -251,16 +252,15 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
+	compression = btrfs_file_extent_compression(leaf, fi);
 	/*
 	 * Support for new compression/encryption must introduce incompat flag,
 	 * and must be caught in open_ctree().
 	 */
-	if (unlikely(btrfs_file_extent_compression(leaf, fi) >=
-		     BTRFS_NR_COMPRESS_TYPES)) {
+	if (unlikely(compression >= BTRFS_NR_COMPRESS_TYPES)) {
 		file_extent_err(leaf, slot,
 	"invalid compression for file extent, have %u expect range [0, %u]",
-			btrfs_file_extent_compression(leaf, fi),
-			BTRFS_NR_COMPRESS_TYPES - 1);
+			compression, BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
 	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
@@ -279,8 +279,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		}
 
 		/* Compressed inline extent has no on-disk size, skip it */
-		if (btrfs_file_extent_compression(leaf, fi) !=
-		    BTRFS_COMPRESS_NONE)
+		if (compression != BTRFS_COMPRESS_NONE)
 			return 0;
 
 		/* Uncompressed inline extent size must match item size */
@@ -319,6 +318,30 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
+	/*
+	 * If it's a uncompressed regular extents, its ram size should match
+	 * disk_num_bytes. But for now we have several call sites that doesn't
+	 * properly update @ram_bytes, so at least make sure
+	 * @ram_bytes <= @disk_num_bytes.
+	 *
+	 * However we have a recent bug related to @ram_bytes update, causing
+	 * all zoned btrfs and regular btrfs DIO to be affected.
+	 * Thankfully the ram_bytes is not critical for non-compressed file extents.
+	 * So here we hide the check behind DEBUG builds for developers only.
+	 */
+#ifdef CONFIG_BTRFS_DEBUG
+	if (unlikely(compression == BTRFS_COMPRESS_NONE &&
+		     btrfs_file_extent_disk_bytenr(leaf, fi) &&
+		     btrfs_file_extent_ram_bytes(leaf, fi) >
+		     btrfs_file_extent_disk_num_bytes(leaf, fi))) {
+		file_extent_err(leaf, slot,
+				"invalid ram_bytes, have %llu expect <=%llu",
+				btrfs_file_extent_ram_bytes(leaf, fi),
+				btrfs_file_extent_disk_num_bytes(leaf, fi));
+		return -EUCLEAN;
+	}
+#endif
+
 	/*
 	 * Check that no two consecutive file extent items, in the same leaf,
 	 * present ranges that overlap each other.
-- 
2.44.0


