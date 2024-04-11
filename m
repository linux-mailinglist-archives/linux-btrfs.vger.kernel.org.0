Return-Path: <linux-btrfs+bounces-4167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67398A21E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 00:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA398B22168
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524024776F;
	Thu, 11 Apr 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eobYKId5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eobYKId5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6241A91
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875688; cv=none; b=LiY+dIftT4w9HaUB2Mjmg+sh+MFeuIOfqXjarNBT/kwgC0qPIo3CDJMZ/MIh8kYxYo5O2dlaMs1k7GBGFrmY7ccgdYyqJ9dLIV1g7HIzD9qD+HWtjh3JhdF0WpKWbw9yF4M6QJXIgHn7JNXs/CO7vieRo6NmXP0idgFbiDwHCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875688; c=relaxed/simple;
	bh=JYeBHj6DbwR5HFphJQoErTu8m6ZeeF7iNWDX0Pf2Uag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZPR8ONfS4TynzzhToNs6pZCR+KlKL4BOBjSsqG35cq4qof/VhPdvlZEgxunwChRiUn7PIK5gC5St7ZsXYkjTtqdcnvZoi4FrkgoAO0c66ka83Mt1UwlcIAA+jf7tuWocp4UsEXZrW2ONDhvIHGbwAqK8ZaU3a/IMkHF7C0ML9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eobYKId5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eobYKId5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D6FF5D692
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712875684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP31jA7UihpuL9PsMGsB6h0lPKAKreQcXAB+tJGYa+A=;
	b=eobYKId5uJnaafOWG+i6mso6wqayc3XulfEINfrnBTxru2QZs7wilPC5r/05riHDJOFxZ+
	ykbbkNFW0gVaVBSwrs9BZfN0iHTN4TbV0HvxKLA3rA8MB656CHdbqxCVI+9Zb/3tKuf/UW
	erlMhe8SU5Rq7invvPqJYhj7BN4/Phs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eobYKId5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712875684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP31jA7UihpuL9PsMGsB6h0lPKAKreQcXAB+tJGYa+A=;
	b=eobYKId5uJnaafOWG+i6mso6wqayc3XulfEINfrnBTxru2QZs7wilPC5r/05riHDJOFxZ+
	ykbbkNFW0gVaVBSwrs9BZfN0iHTN4TbV0HvxKLA3rA8MB656CHdbqxCVI+9Zb/3tKuf/UW
	erlMhe8SU5Rq7invvPqJYhj7BN4/Phs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89E3B1368B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CNb7EaNoGGbbXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/3] btrfs: add extra comments on extent_map members
Date: Fri, 12 Apr 2024 08:17:42 +0930
Message-ID: <00d249a2c9bfec06516c6fb84a053104b6f12095.1712875458.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712875458.git.wqu@suse.com>
References: <cover.1712875458.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5D6FF5D692
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

The extent_map structure is very critical to btrfs, as it is involved
for both read and write paths.

Unfortunately the structure is not properly explained, making it pretty
hard to understand nor to do further improvement.

This patch adds extra comments explaining the major members based on
my code reading.
Hopefully we can find more members to cleanup in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.h | 58 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 10e9491865c9..1b8a55e4b678 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -35,19 +35,75 @@ enum {
 };
 
 /*
+ * This structure represents file extents and holes.
+ *
+ * Unlike on-disk file extent items, extent maps can be merged to
+ * save memory.
+ * This means members only match file extent items before any merging.
+ * And users of extent_map should never assume the members are always
+ * matching an on-disk file extent item.
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


