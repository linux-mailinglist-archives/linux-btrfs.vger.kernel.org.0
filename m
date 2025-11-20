Return-Path: <linux-btrfs+bounces-19202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DAAC72A88
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 08:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18185349295
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90E307AF7;
	Thu, 20 Nov 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pD+S7UvM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pD+S7UvM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B32D8368
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625130; cv=none; b=s0T20m7y8hTWCZuFjx5eT/If4zywZKmRznxtPV9e9Je7vao8DGwm1DaURUW2T3DAz8pUkdLKBIAOI1laIPKNLtpRC/K17W9NlnfUOpxgSKPmFTMSPVnx0/40F0rulTAKGIytXZKKxHDUY/5AfT/c7bLez7aeafHbj8aWwk3Pv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625130; c=relaxed/simple;
	bh=qjdPG0p6Gm+KefSYzSA+VCUacsD8oXFVrLqtIlg9qvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj5oFmPS9baMPLhQ8Xnj83NbRyEhz5QkjlPenLNkYkMlyIQsDKBm1fJ6hocS98TM/LZyeyfIqQP+PuPCNX1NaApmtzaQcSJWW85q0bXbmn1KNjJOtZIIV+02RdYINAwaViJIeYwOGnQcUBg4zhANHcyp5iIr2X+Ev+fPRO294kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pD+S7UvM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pD+S7UvM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A25121746
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu2gFuLDn2e7KJddtCJu/s9ad32iJdvcHmMAamRxghI=;
	b=pD+S7UvMo53NiRlUAjxLSccBcC6xUdRnbY0apDyWexWJH7MDRbiEOFXQvIbqnIA4UX9kVO
	QGub8Dn0jNxvJ8NCHAZ8jH3MYBl2G38uXLD/taq5IbU462gGc2pb0dKtwu1V+xd7ucwzmY
	IICTqS8Eahy1gbGpAr8n51ulSgizTm4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu2gFuLDn2e7KJddtCJu/s9ad32iJdvcHmMAamRxghI=;
	b=pD+S7UvMo53NiRlUAjxLSccBcC6xUdRnbY0apDyWexWJH7MDRbiEOFXQvIbqnIA4UX9kVO
	QGub8Dn0jNxvJ8NCHAZ8jH3MYBl2G38uXLD/taq5IbU462gGc2pb0dKtwu1V+xd7ucwzmY
	IICTqS8Eahy1gbGpAr8n51ulSgizTm4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8BEC3EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KNXnGqLIHmmAQwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: make sure all ordered extents beyond EOF is properly truncated
Date: Thu, 20 Nov 2025 18:21:40 +1030
Message-ID: <5960f3429b90311423a57beff157494698ab1395.1763620860.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763620860.git.wqu@suse.com>
References: <cover.1763620860.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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

However during the EOF handling, we only call
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

Fixes: f0a0f5bfe04e ("btrfs: truncate ordered extent when skipping writeback past i_size")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c    | 19 +------------------
 fs/btrfs/ordered-data.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 ++
 3 files changed, 41 insertions(+), 18 deletions(-)

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
index a421f7db9eec..9a0638d13225 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -546,6 +546,44 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	spin_unlock(&inode->ordered_tree_lock);
 }
 
+/*
+ * Mark all ordered extents io inside the specified range as truncated.
+ *
+ * This is utilized by writeback path, thus there must be an ordered extent
+ * for the range.
+ */
+void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct folio *folio,
+				     u64 file_offset, u32 len)
+{
+	u64 cur = file_offset;
+
+	ASSERT(file_offset >= folio_pos(folio));
+	ASSERT(file_offset + len <= folio_end(folio));
+
+	while  (cur < file_offset + len) {
+		u32 cur_len = file_offset + len - cur;
+		struct btrfs_ordered_extent *ordered;
+
+		ordered = btrfs_lookup_first_ordered_range(inode, cur, cur_len);
+
+		/*
+		 * We have just run delalloc before getting here, so there must
+		 * be an ordered extent.
+		 */
+		ASSERT(ordered != NULL);
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


