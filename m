Return-Path: <linux-btrfs+bounces-15573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0405AB0B3C8
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 08:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236E47A2561
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC61C84A0;
	Sun, 20 Jul 2025 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uIPMHJzJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uIPMHJzJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B51ACEAF
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992978; cv=none; b=H+pk0n/ZOVBnqSHxcvPR/LVDC114yaLTGoxLDXx4uyw6Qg3ejggQmrUviWmYd0EQR7DdVEuOVxUiWpeKLZfk/OfGABfUB93+ckytiHiZWLl75miBU5VRKJP5v3mJomrM1LoQocZJuRINVhAVzthTv2JaM2/aJfysyabbaX3RhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992978; c=relaxed/simple;
	bh=Obfx3jWD7GF4kJ6569rbu66V9mT8sj2om17YSfZyxkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxlwXRaRqZlplSfmvTtpYhZcaTLloyTNehlQW8npZP0AjOvnA6x+7F/0rcUaTBh+z+bzT4zdRXakzSOhq0XVPWlYGiJlG0Rq5hQH2x7pvx5KFyRHF3Q2UPoxCG8le4e6Vd/JM3VUOO9Vmqj98EUPbJszpp/XW65Qs/3BZfHQU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uIPMHJzJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uIPMHJzJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3867B1F38A
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiFPjiKWkBbg00eSV4xuaphccpj2Z1dg41ClOQIXJR4=;
	b=uIPMHJzJpyXxduHROPJ0Yj6oD148a5pxL90+xRcWDlqahXoZbz3uHC+KRNYK+Y2MMehfAf
	c7v/hmizkNcs+hYEGPnd0LvuOF4j8U8y1Gd3Tnq9mn98Z9j97XpDnxJW0Fh2HwFGQvb4+t
	XMiw93W2Ge0szqaOe55VJdvA/S8lDtQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiFPjiKWkBbg00eSV4xuaphccpj2Z1dg41ClOQIXJR4=;
	b=uIPMHJzJpyXxduHROPJ0Yj6oD148a5pxL90+xRcWDlqahXoZbz3uHC+KRNYK+Y2MMehfAf
	c7v/hmizkNcs+hYEGPnd0LvuOF4j8U8y1Gd3Tnq9mn98Z9j97XpDnxJW0Fh2HwFGQvb4+t
	XMiw93W2Ge0szqaOe55VJdvA/S8lDtQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73B2F13A1E
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OG27DcqMfGjJfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: replace double boolean parameters of cow_file_range()
Date: Sun, 20 Jul 2025 15:59:09 +0930
Message-ID: <3480a38763369c46ca8bbe79a8e4a5b87d20197a.1752992367.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752992367.git.wqu@suse.com>
References: <cover.1752992367.git.wqu@suse.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

The function cow_file_range() has two boolean parameters, which is never
a good thing for eyes.

Replace it with a single @flags parameter, with two flags:

- COW_FILE_RANGE_NO_INLINE
- COW_FILE_RANGE_KEEP_LOCKED

And since we're here, also update the comments of cow_file_range() to
replace the old "page" usage with "folio".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b77dd22b8cdb..fc47e234b729 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -72,6 +72,9 @@
 #include "raid-stripe-tree.h"
 #include "fiemap.h"
 
+#define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
+#define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
+
 struct btrfs_iget_args {
 	u64 ino;
 	struct btrfs_root *root;
@@ -1243,18 +1246,18 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * locked_folio is the folio that writepage had locked already.  We use
  * it to make sure we don't do extra locks or unlocks.
  *
- * When this function fails, it unlocks all pages except @locked_folio.
+ * When this function fails, it unlocks all folios except @locked_folio.
  *
  * When this function successfully creates an inline extent, it returns 1 and
- * unlocks all pages including locked_folio and starts I/O on them.
- * (In reality inline extents are limited to a single page, so locked_folio is
- * the only page handled anyway).
+ * unlocks all folios including locked_folio and starts I/O on them.
+ * (In reality inline extents are limited to a single block, so locked_folio is
+ * the only folio handled anyway).
  *
- * When this function succeed and creates a normal extent, the page locking
+ * When this function succeed and creates a normal extent, the folio locking
  * status depends on the passed in flags:
  *
- * - If @keep_locked is set, all pages are kept locked.
- * - Else all pages except for @locked_folio are unlocked.
+ * - If COW_FILE_RANGE_KEEP_LOCKED flag is set, all folios are kept locked.
+ * - Else all folios except for @locked_folio are unlocked.
  *
  * When a failure happens in the second or later iteration of the
  * while-loop, the ordered extents created in previous iterations are cleaned up.
@@ -1262,7 +1265,7 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct folio *locked_folio, u64 start,
 				   u64 end, u64 *done_offset,
-				   bool keep_locked, bool no_inline)
+				   unsigned long flags)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1290,7 +1293,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
 
-	if (!no_inline) {
+	if (!(flags & COW_FILE_RANGE_NO_INLINE)) {
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, locked_folio, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
@@ -1318,7 +1321,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * Do set the Ordered (Private2) bit so we know this page was properly
 	 * setup for writepage.
 	 */
-	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
+	page_ops = ((flags & COW_FILE_RANGE_KEEP_LOCKED) ? 0 : PAGE_UNLOCK);
 	page_ops |= PAGE_SET_ORDERED;
 
 	/*
@@ -1685,7 +1688,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_folio, start, end,
-				     &done_offset, true, false);
+				     &done_offset, COW_FILE_RANGE_KEEP_LOCKED);
 		if (ret)
 			return ret;
 		extent_write_locked_range(&inode->vfs_inode, locked_folio,
@@ -1767,8 +1770,8 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 * is written out and unlocked directly and a normal NOCOW extent
 	 * doesn't work.
 	 */
-	ret = cow_file_range(inode, locked_folio, start, end, NULL, false,
-			     true);
+	ret = cow_file_range(inode, locked_folio, start, end, NULL,
+			     COW_FILE_RANGE_NO_INLINE);
 	ASSERT(ret != 1);
 	return ret;
 }
@@ -2347,8 +2350,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 		ret = run_delalloc_cow(inode, locked_folio, start, end, wbc,
 				       true);
 	else
-		ret = cow_file_range(inode, locked_folio, start, end, NULL,
-				     false, false);
+		ret = cow_file_range(inode, locked_folio, start, end, NULL, 0);
 	return ret;
 }
 
-- 
2.50.0


