Return-Path: <linux-btrfs+bounces-19106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203FC6A8B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3A5D36637A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC54377E9A;
	Tue, 18 Nov 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rWeRhXbc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rWeRhXbc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBB3730DC
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482155; cv=none; b=pkQfD7Wj7SPEEZMuvFaBW1vmJyy5Cpxpsk2C3kcWnrsKkPn06b/Q1eF8T6s0YXd1oTuJM0nIV8s/Faw2s7g5m1rZjToDWWwMbSrOATsjWk3EFiLD7TrCyL4BMfanAzpwWJ9uM3awkDck08yfn/lx7YSxtDlNd9jeUkRoX/NqQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482155; c=relaxed/simple;
	bh=H09kXkzCHjshIOsBvxrpbDVneOhMeKZ4DakgDGkO498=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5Ki5089UO7wMo2QCwMcKlhRmCIQpRvHlCI6uundY4Wo5XPsjnH2cEE+LlWf5VI2/Pqqv14MzzffsVwVf0Am3YwTk65oQzmPjCi/mc/zG/g7i/aKCHwDbgfReNrd4Q5hUnRbVk0fx45F29E5VvRZtHcLJWTc3lmcR+XF5lZw3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rWeRhXbc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rWeRhXbc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB8791FF8B;
	Tue, 18 Nov 2025 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izpK1ZO+0JeJl4swc++dI5OHKibxqNBLEWwV3CvwziQ=;
	b=rWeRhXbcmaeroHmZG4GZU5coA/btSey/IEb6usvfnVxEgsyRrSaqOKhotd3O72suVQU91P
	u01UCI6fw+0JJxxe7mijKHWgfJPuF2kzqrBxmVRXyoL2UQeTTQp9iop5o6C6ulqfBLCoCP
	yD/Fsm6RXBamilIJBuEj+lZTnz3gSQs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izpK1ZO+0JeJl4swc++dI5OHKibxqNBLEWwV3CvwziQ=;
	b=rWeRhXbcmaeroHmZG4GZU5coA/btSey/IEb6usvfnVxEgsyRrSaqOKhotd3O72suVQU91P
	u01UCI6fw+0JJxxe7mijKHWgfJPuF2kzqrBxmVRXyoL2UQeTTQp9iop5o6C6ulqfBLCoCP
	yD/Fsm6RXBamilIJBuEj+lZTnz3gSQs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A655C3EA61;
	Tue, 18 Nov 2025 16:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QNIBKBWaHGlnYQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 18 Nov 2025 16:08:53 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] btrfs: add orig_logical to btrfs_bio
Date: Tue, 18 Nov 2025 17:08:40 +0100
Message-ID: <20251118160845.3006733-4-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118160845.3006733-1-neelx@suse.com>
References: <20251118160845.3006733-1-neelx@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

From: Josef Bacik <josef@toxicpanda.com>

When checksumming the encrypted bio on writes we need to know which
logical address this checksum is for.  At the point where we get the
encrypted bio the bi_sector is the physical location on the target disk,
so we need to save the original logical offset in the btrfs_bio.  Then
we can use this when csum'ing the bio instead of the
bio->iter.bi_sector.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 10 ++++++++++
 fs/btrfs/bio.h       |  2 ++
 fs/btrfs/file-item.c |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1b38e3ee0a33..4a7bef895b97 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -94,6 +94,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	if (bbio_has_ordered_extent(bbio)) {
 		refcount_inc(&orig_bbio->ordered->refs);
 		bbio->ordered = orig_bbio->ordered;
+		bbio->orig_logical = orig_bbio->orig_logical;
+		orig_bbio->orig_logical += map_length;
 	}
 	bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
 	atomic_inc(&orig_bbio->pending_ios);
@@ -765,6 +767,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		goto end_bbio;
 	}
 
+	/*
+	 * For fscrypt writes we will get the encrypted bio after we've
+	 * remapped our bio to the physical disk location, so we need to
+	 * save the original bytenr so we know what we're checksumming.
+	 */
+	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
+		bbio->orig_logical = logical;
+
 	map_length = min(map_length, length);
 	if (use_append)
 		map_length = btrfs_append_map_length(bbio, map_length);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 035145909b00..56279b7f3b2a 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -52,6 +52,7 @@ struct btrfs_bio {
 		 * - pointer to the checksums for this bio
 		 * - original physical address from the allocator
 		 *   (for zone append only)
+		 * - original logical address, used for checksumming fscrypt bios.
 		 */
 		struct {
 			struct btrfs_ordered_extent *ordered;
@@ -60,6 +61,7 @@ struct btrfs_bio {
 			struct completion csum_done;
 			struct bvec_iter csum_saved_iter;
 			u64 orig_physical;
+			u64 orig_logical;
 		};
 
 		/* For metadata reads: parentness verification. */
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index b17632ea085f..14e5257f0f04 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -824,7 +824,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
 	if (!sums)
 		return -ENOMEM;
 
-	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	sums->logical = bbio->orig_logical;
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 	bbio->sums = sums;
-- 
2.51.0


