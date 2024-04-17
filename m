Return-Path: <linux-btrfs+bounces-4324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B67C8A7B9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 06:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A061F22DC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 04:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9847F4A;
	Wed, 17 Apr 2024 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NmpaVi4F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DhDOXvRE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608641C7C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329709; cv=none; b=XZY73hmLXT03FKF+AygxJuLpejGnlLWWO2NVBnkJCxdb5ScHBbuENw4fsbXWF/PEkWfrOA74wwzosa/jQLoiQVJ4uRrj1fLXezyExMiCWCZgfcuRRduj4SmuJXbZCzo81HSSIe1FwEXUOlBU8ij/JgPP4twUmwy0IFroKxFQPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329709; c=relaxed/simple;
	bh=CPz8N+rGQ82Cp5cm/+HsrDHNFOyPJuE51kKjV/LDZAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nED7SgSBdb1oh1y6vWeVFpB1V6vBmSfWhMiojLqNVGvqG9X6byhVs1BtCvu8wIPsl8DxVSMspMc9Yg3NXQvZgJuLfH91ddQq3wigYpyc8p7ux6UtiiNYxOPDhyuy5ds5Wru2GipUNk9KS/IG2p4mn5r5Db13VQxvdT7L0yaHtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NmpaVi4F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DhDOXvRE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0E4E22B8F;
	Wed, 17 Apr 2024 04:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713329706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iO+rxhwQORihmOX2XX/ma7PTV2ydAT3ZHExFcwr7KrU=;
	b=NmpaVi4Ft/n8LgkVAMOZzp0OWLnGGHZmovahYighZl31dP/B8fEF4v758trTp4kGAO8cAI
	/oS6+lVaWiU5PGqL5gj6NkmrTvThe8FggYfrvWQDxYd/PRQUKOKvuM9IyZqy7xDU104JLz
	RilOcQCkzbJ0t1tW4yrVALIsQ65txQc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DhDOXvRE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713329705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iO+rxhwQORihmOX2XX/ma7PTV2ydAT3ZHExFcwr7KrU=;
	b=DhDOXvRE6POXwuii/7oSp7X0fuerQE+DLjbZZrV8tcOnInBUT0S6JraDCiNT5yZvwVM7+F
	IPhrV67eE00QRFJJcjL5ZmKfvVx4xvuQFHRsX5LmbCVyLDytl7wGIRRcI3zU6tKDcZrOPg
	Mu3qpusqHaVGnhcKnZQAoi3r2ZILkvw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B42941384C;
	Wed, 17 Apr 2024 04:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAJIGyhWH2YkeQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 17 Apr 2024 04:55:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/2] btrfs: tree-checker: add one extra file extent item ram_bytes check
Date: Wed, 17 Apr 2024 14:24:39 +0930
Message-ID: <1860b41b9aa1e1522bd480d748bbba3a70b6d4e0.1713329516.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713329516.git.wqu@suse.com>
References: <cover.1713329516.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F0E4E22B8F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]

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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c8fbcae4e88e..9f1597fe40e7 100644
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
+	 * However we had a bug related to @ram_bytes update, causing
+	 * all zoned and regular DIO to be affected.
+	 * Thankfully the ram_bytes is not critical for non-compressed file extents.
+	 * So here we hide the check behind DEBUG builds for developers only.
+	 */
+#ifdef CONFIG_BTRFS_DEBUG
+	if (unlikely(compression == BTRFS_COMPRESS_NONE &&
+		     btrfs_file_extent_disk_bytenr(leaf, fi) &&
+		     btrfs_file_extent_ram_bytes(leaf, fi) >
+		     btrfs_file_extent_disk_num_bytes(leaf, fi))) {
+		file_extent_err(leaf, slot,
+				"invalid ram_bytes, have %llu expect <= %llu",
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


