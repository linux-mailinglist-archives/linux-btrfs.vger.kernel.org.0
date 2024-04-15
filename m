Return-Path: <linux-btrfs+bounces-4286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A018A5E6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 01:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFD2285792
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 23:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154611598E7;
	Mon, 15 Apr 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A3+0daH4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A3+0daH4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC915746D
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224164; cv=none; b=Ig7g41Wb8qd1qIprNEbsnCCDKrMJ070cm6zNr7oZKYl034+3o4Zt5Ld+KuRSoN/ixtSfFT00P9wN4FD4Pnzx1cV57P363gGmafOVtcnW+oF4sS4v2R1vOhfpwk3WRwqb8OxgJn+SymgwEzcxBfULcUAZwIQnEt7ojRSBRw8Bf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224164; c=relaxed/simple;
	bh=UGzbqaFQinZiDeu0cVhoi1g9o+Zq6MeDuWIGD5k8sw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGHWJclNuUfqNQ2Z9nU7FeVVBr5L0W79wW+HHDE0uuPGxkls53+gBxCiK5RY+PDbIfGfWPiIKPyHEdw7BSNnVOk5tVXSPphDcS086of6E2wE21WCNxi/AoYjA+fxemjbsR1rtyaRJtCS0mJ2LUe2FldOqvn9KP4OAPiEw8WNJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A3+0daH4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A3+0daH4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1F0E5D4F9;
	Mon, 15 Apr 2024 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713224160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS2p7swcTUSCVxSgS9uWQRtYm5SYs7jfOqxQPzWVUag=;
	b=A3+0daH4JANYmP1+Std1F5nk6Ky1lZ5T7XH2leqIAiB+OWbiJA/xSWEnu4V7cT5k1+3oVx
	oTbKtR5Zq7j2wtIFlSG+Du0N1YkcaIiyY0+hevdWsiqWXGuIcauipLN6xlfzeq40ejO2JP
	56u3J4+FNtAy35qd4KKwVaglVE5j2WQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713224160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS2p7swcTUSCVxSgS9uWQRtYm5SYs7jfOqxQPzWVUag=;
	b=A3+0daH4JANYmP1+Std1F5nk6Ky1lZ5T7XH2leqIAiB+OWbiJA/xSWEnu4V7cT5k1+3oVx
	oTbKtR5Zq7j2wtIFlSG+Du0N1YkcaIiyY0+hevdWsiqWXGuIcauipLN6xlfzeq40ejO2JP
	56u3J4+FNtAy35qd4KKwVaglVE5j2WQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CBF61368B;
	Mon, 15 Apr 2024 23:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8HgUFN+5HWZyTQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 15 Apr 2024 23:35:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v5 1/3] btrfs: add extra comments on extent_map members
Date: Tue, 16 Apr 2024 09:05:38 +0930
Message-ID: <ed1048ff595682eaa4900386c7998624ef93815d.1713224013.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713224013.git.wqu@suse.com>
References: <cover.1713224013.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The extent_map structure is very critical to btrfs, as it is involved
for both read and write paths.

Unfortunately the structure is not properly explained, making it pretty
hard to understand nor to do further improvement.

This patch adds extra comments explaining the major members based on
my code reading.
Hopefully we can find more members to cleanup in the future.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.h | 56 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 10e9491865c9..10a60a4b09e5 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -35,19 +35,73 @@ enum {
 };
 
 /*
+ * This structure represents file extents and holes.
+ *
+ * Unlike on-disk file extent items, extent maps can be merged to
+ * save memory.
+ * This means members only match file extent items before any merging.
+ *
  * Keep this structure as compact as possible, as we can have really large
  * amounts of allocated extent maps at any time.
  */
 struct extent_map {
 	struct rb_node rb_node;
 
-	/* all of these are in bytes */
+	/* All of these are in bytes. */
+
+	/* File offset matching the offset of a BTRFS_EXTENT_ITEM_KEY key. */
 	u64 start;
+
+	/*
+	 * Length of the file extent.
+	 *
+	 * For non-inlined file extents it's btrfs_file_extent_item::num_bytes.
+	 * For inline extents it's sectorsize, since inline data starts at
+	 * offsetof(struct btrfs_file_extent_item, disk_bytenr) thus
+	 * btrfs_file_extent_item::num_bytes is not valid.
+	 */
 	u64 len;
+
+	/*
+	 * The file offset of the original file extent before splitting.
+	 *
+	 * This is an in-memory only member, matching
+	 * extent_map::start - btrfs_file_extent_item::offset for
+	 * regular/preallocated extents. EXTENT_MAP_HOLE otherwise.
+	 */
 	u64 orig_start;
+
+	/*
+	 * The full on-disk extent length, matching
+	 * btrfs_file_extent_item::disk_num_bytes.
+	 */
 	u64 orig_block_len;
+
+	/*
+	 * The decompressed size of the whole on-disk extent, matching
+	 * btrfs_file_extent_item::ram_bytes.
+	 */
 	u64 ram_bytes;
+
+	/*
+	 * The on-disk logical bytenr for the file extent.
+	 *
+	 * For compressed extents it matches btrfs_file_extent_item::disk_bytenr.
+	 * For uncompressed extents it matches
+	 * btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset
+	 *
+	 * For holes it is EXTENT_MAP_HOLE and for inline extents it is
+	 * EXTENT_MAP_INLINE.
+	 */
 	u64 block_start;
+
+	/*
+	 * The on-disk length for the file extent.
+	 *
+	 * For compressed extents it matches btrfs_file_extent_item::disk_num_bytes.
+	 * For uncompressed extents it matches extent_map::len.
+	 * For holes and inline extents it's -1 and shouldn't be used.
+	 */
 	u64 block_len;
 
 	/*
-- 
2.44.0


