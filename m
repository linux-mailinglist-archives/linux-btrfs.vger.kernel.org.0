Return-Path: <linux-btrfs+bounces-19328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383AC83E3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 09:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1EB834CBDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930982D7DD0;
	Tue, 25 Nov 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HP1QQGG2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HP1QQGG2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CD2D2391
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058095; cv=none; b=Y1ffj9g+Murb5LfKwhjN3Ya1JPMz+8zvOKmUCln65mhZ/1xup/iDPV1A99chskRCYOo69jaqTEmcJ8JiB/ZwwuQcTqWV7V1FsJHYMavc0d1e2MFzwL5ZcUiyboWX4DSFG7G0M2Zto6tQZVRcVwpZ6D7xxVCteTWidnLiT3bAJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058095; c=relaxed/simple;
	bh=YTYD1sgTmGorgZq0lc3pq1gAIeB+O8ZotApNgxZ34qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMHqLS9pCod3EAeWqlYQ/25mIcJaSM5Mf4Tfv2qElPnjwPNh2DCteuvGeqrFm5hOA2FLX7y7hmubmiG35IjJh1KVVd0HNg6g2WKrAkfcWMvL6NJVjwkr1VLBUvzbBmWLqndYNLnZv3zgmesg3+CHolyrJ28mdni1koRCf5bajDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HP1QQGG2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HP1QQGG2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F05D21B57;
	Tue, 25 Nov 2025 08:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KepHVe6HqXIYlZKYHfwTCa0tmMlLEwtsLbGHbujDpDE=;
	b=HP1QQGG2BlPq66A1BS4SkXDRxETNa0iH6l02p02Adrzyjr9tIDf41LFeDxmBWU3klxSG3S
	B89xHmKKF40iukugltI4MYvbEy0qMLvsLcHTyLobnw4cjCQlIUiCtcMG+j44OayeBjLBxq
	nHEBeh6BE2e36cBM7FMrLd6zotA2CPQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KepHVe6HqXIYlZKYHfwTCa0tmMlLEwtsLbGHbujDpDE=;
	b=HP1QQGG2BlPq66A1BS4SkXDRxETNa0iH6l02p02Adrzyjr9tIDf41LFeDxmBWU3klxSG3S
	B89xHmKKF40iukugltI4MYvbEy0qMLvsLcHTyLobnw4cjCQlIUiCtcMG+j44OayeBjLBxq
	nHEBeh6BE2e36cBM7FMrLd6zotA2CPQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B5C3EA63;
	Tue, 25 Nov 2025 08:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5A6GAupjJWldcwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 25 Nov 2025 08:08:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs: make sure all ordered extents beyond EOF are properly truncated
Date: Tue, 25 Nov 2025 18:37:52 +1030
Message-ID: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[POSSIBLE BUG]
If there are multiple ordered extents beyond EOF, at folio writeback
time we may only truncate the first ordered extent, but leaving the
remaining ones finished but not marked as truncated.

Since those OEs are not marked as truncated, it will still insert an
file extent item, and may lead to false missing csum errors during
"btrfs check".

[CAUSE]
Since we have bs < ps support for a while and experimental large data
folios are also going to graduate from experimental features soon, we
can have the following folio to be written back:

  fs block size 4K
  page size 4K, folio size 64K.

           0        16K      32K                  64K
	   |<---------------- Dirty -------------->|
	   |<-OE A->|<-OE B->|<----- OE C -------->|
               |
	       i_size 4K.

In above case we need to submit the writeback for the range [0, 4K).
For range [4K, 64K) there is no need to submit any IO but mark the
involved OEs (OE A, B, C) all as truncated.

However during the EOF handling, patch "btrfs: truncate ordered extent
when skipping writeback past i_size" only calls
btrfs_lookup_first_ordered_range() once, thus only got OE A and mark it
as truncated.

But OE B and C are not marked as truncated, they will finish as usual,
which will leave a regular file extent item to be inserted beyond EOF,
and without any data checksum.

[FIX]
Introduce a new helper, btrfs_mark_ordered_io_truncated(), to handle all
OEs of a range, and mark them all as truncated.

With that helper, all OEs (A B and C) will be marked as truncated.
OE B and C will have 0 truncated_len, preventing any file extent item to
be inserted from them.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the ASSERT() inside btrfs_mark_ordered_io_truncated()
  Since the range passed in is to the end of the folio during writeback
  path, there is no guarantee that there is always one or more ordered
  extents covering the full range.

  This get triggered during fsstress runs, especially common on bs < ps
  cases.

  Remove the ASSERT() and exit the oe search instead.

Resend:
- Move the patch out of the series 'btrfs: reduce btrfs_get_extent()
  calls for buffered write path'
  As this is a bug fix, which needs a little higher priority than
  the remaining optimizations.

- Fix various grammar errors

- Use @end to replace duplicated calculations

- Remove the Fixes: tag
  The involved patch is not yet merged upstream.
  Just mention the patch subject inside the commit message.
---
 fs/btrfs/extent_io.c    | 19 +------------------
 fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 ++
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d32dfc34ae3..2044b889c887 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1725,24 +1725,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
 
 		if (cur >= i_size) {
-			struct btrfs_ordered_extent *ordered;
-
-			ordered = btrfs_lookup_first_ordered_range(inode, cur,
-								   folio_end - cur);
-			/*
-			 * We have just run delalloc before getting here, so
-			 * there must be an ordered extent.
-			 */
-			ASSERT(ordered != NULL);
-			spin_lock(&inode->ordered_tree_lock);
-			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-			ordered->truncated_len = min(ordered->truncated_len,
-						     cur - ordered->file_offset);
-			spin_unlock(&inode->ordered_tree_lock);
-			btrfs_put_ordered_extent(ordered);
-
-			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       end - cur, true);
+			btrfs_mark_ordered_io_truncated(inode, folio, cur, end - cur);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a421f7db9eec..3c0b89164139 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -546,6 +546,39 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	spin_unlock(&inode->ordered_tree_lock);
 }
 
+/*
+ * Mark any ordered extents io inside the specified range as truncated.
+ */
+void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct folio *folio,
+				     u64 file_offset, u32 len)
+{
+	const u64 end = file_offset + len;
+	u64 cur = file_offset;
+
+	ASSERT(file_offset >= folio_pos(folio));
+	ASSERT(end <= folio_pos(folio) + folio_size(folio));
+
+	while (cur < end) {
+		u32 cur_len = end - cur;
+		struct btrfs_ordered_extent *ordered;
+
+		ordered = btrfs_lookup_first_ordered_range(inode, cur, cur_len);
+
+		if (!ordered)
+			break;
+		scoped_guard(spinlock, &inode->ordered_tree_lock) {
+			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+			ordered->truncated_len = min(ordered->truncated_len,
+						     cur - ordered->file_offset);
+		}
+		cur_len = min(cur_len, ordered->file_offset + ordered->num_bytes - cur);
+		btrfs_put_ordered_extent(ordered);
+
+		cur += cur_len;
+	}
+	btrfs_mark_ordered_io_finished(inode, folio, file_offset, len, true);
+}
+
 /*
  * Finish IO for one ordered extent across a given range.  The range can only
  * contain one ordered extent.
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 1e6b0b182b29..dd4cdc1a8b78 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -169,6 +169,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 				    struct folio *folio, u64 file_offset,
 				    u64 num_bytes, bool uptodate);
+void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct folio *folio,
+				     u64 file_offset, u32 len);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
-- 
2.52.0


