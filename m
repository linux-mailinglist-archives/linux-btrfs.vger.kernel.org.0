Return-Path: <linux-btrfs+bounces-3815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34843894B53
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 08:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A5A2840FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1316B224F2;
	Tue,  2 Apr 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aJPt6SkM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359419477
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039029; cv=none; b=lLPTQEO/QX5ghjAsA+VFLzct3jybND03vTGycJPPKXBv8D8aeaO8fY20F72goLmxQoEGqgRQTgP0zdT6SXpAHbMAgjuAwtiDJgUqNRGfItHzWySjYMsBue0wHAvoDFb5M63wwruO80hzWlX7dCBuc4CpD57o7GUQuSkDhbLhGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039029; c=relaxed/simple;
	bh=nnroCldiv6B1R2ovsTvLXVsO4XvyPnojnIXxqEgPCAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GISSHiCKW5538qBJBVLJzR/ythI0VqPZOGELDRXFyOJHJKZGAcKkJKIIueF/Qn/QZFMo5ivDKmDV/0s7zkPnDiRsSaSDILKiS+QM9tp7NT/38bF9fRjm8bFJzByqqgQCN+XStSXc3uSS/jfWzNrHNH+Iy0CXIYrjye+0Xx2IQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aJPt6SkM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 802E93433F
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712039024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UplTZfVJNmBEC3u0WY6fwUJkUEKxyilCT8SyjbA93is=;
	b=aJPt6SkMGDTv01YkF55ELFosSJbloq9V8yKD67W/gxfkV4kO38Oa8qQUP0Zmf/ZB7ArWx+
	XQx5n299XYJSkBhsxSWRyROXMnp6tlzm1hfqojvUNyeAMMCvR46Kqu+4T92vU9xi8NsAAm
	HIrF3idGO28LWTegSMy5ZvcM5JcfMKw=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A82BB13A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GKnrFm+kC2biOQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 06:23:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add extra comments on extent_map members
Date: Tue,  2 Apr 2024 16:53:19 +1030
Message-ID: <50b37f24a3ac5a2c68529a2373ad98d9c45e6f33.1712038308.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712038308.git.wqu@suse.com>
References: <cover.1712038308.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.82
X-Spamd-Result: default: False [0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.08)[-0.392];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO

The extent_map structure is very critical to btrfs, as it is involved
for both read and write paths.

Unfortunately the structure is not properly explained, making it pretty
hard to understand nor to do further improvement.

This patch would add extra comments explaining the major numbers base on
my code reading.
Hopefully we can find more members to cleanup in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.h | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index c5a098c99cc6..30322defcd03 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -37,21 +37,81 @@ enum {
 };
 
 /*
+ * This extent_map structure is an in-memory representation of file extents,
+ * it would represent all file extents (including holes, no matter if we have
+ * hole file extents).
+ *
  * Keep this structure as compact as possible, as we can have really large
  * amounts of allocated extent maps at any time.
  */
 struct extent_map {
 	struct rb_node rb_node;
 
-	/* all of these are in bytes */
+	/* All of these are in bytes */
+
+	/*
+	 * File offset of the file extent. matching key.offset of
+	 * (INO EXTENT_DATA FILEPOS) key.
+	 */
 	u64 start;
+
+	/*
+	 * Length of the file extent.
+	 * For non-inlined file extents it's btrfs_file_extent_item::num_bytes.
+	 * For inlined file extents it's sectorsize. (as there is no reliable
+	 * btrfs_file_extent::num_bytes).
+	 */
 	u64 len;
+
+	/*
+	 * The modified range start/length, these are in-memory-only
+	 * members for fsync/logtree optimization.
+	 */
 	u64 mod_start;
 	u64 mod_len;
+
+	/*
+	 * The file offset of the original file extent before splitting.
+	 *
+	 * This is an in-memory-only member, mathcing
+	 * em::start - btrfs_file_extent_item::offset for regular/preallocated
+	 * extents. EXTENT_MAP_HOLE otherwise.
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
+	 *
+	 * For non-compressed extents, this matches orig_block_len.
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
+	 * For hole extents it is EXTENT_MAP_HOLE and for inline extents it is
+	 * EXTENT_MAP_INLINE.
+	 */
 	u64 block_start;
+
+	/*
+	 * The on-disk length for the file extent.
+	 *
+	 * For compressed extents it matches btrfs_file_extent_item::disk_num_bytes.
+	 * For uncompressed extents it matches em::len.
+	 * Otherwise -1 (aka doesn't make much sense).
+	 */
 	u64 block_len;
 
 	/*
-- 
2.44.0


