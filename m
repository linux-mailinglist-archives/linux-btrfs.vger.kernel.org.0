Return-Path: <linux-btrfs+bounces-15738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DD0B14B4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6863AEB75
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 09:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DA287518;
	Tue, 29 Jul 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YUPQflTQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YUPQflTQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D62877C6
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781535; cv=none; b=S8dEGX7GMoT/a7/JfBnB59O58Uwv6kM1OvAPuwEiUkY8gqPnn/36L4vjJWWeuA8rN/Pcm8GOlKf0W0rU1UrkiC3GJWdptDKxLLpvDNfE4okQKqxyNeKJN62M3/676ObHJvhhhjVyxxo+WG+g9EUDg7oH9y8vZLkPNl30pZbR1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781535; c=relaxed/simple;
	bh=wRr+2P+YbauonwZYWoLqCQHx3tqiw+jtXu7XlX6bMjc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cldB9RjZu40+2KoOhlwkS80ftf0Urb7ehqkyO6OQEoqAw27iB33E+aBLC+nWo5GjB6zg3dDMRMdWdHY65glhy/XfCUB3cWNsKBrMLaqntvJmTWMnKXgPr+xT85waSCu3YoumViAWUAxOn7uYSlBQnX5smhA50erLVyU2RA8VuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YUPQflTQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YUPQflTQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C98E21A2C
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753781526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK0qR9r5L5k3Mq4OXvAMdOUGY/I8rFQ9hjGJVVUvcYs=;
	b=YUPQflTQoufl9iSQXoRmaH0FhdsON86EkqtyRPQi0vgU9KZG2z9wklY5ZvTNgViY0fa5pu
	wX0X5QCT+2FANrI1+H2que1zvcjo3Q7qps1dLWOxgjr++Vfnj2ZFIPtOBFj5By+wIckCmp
	GQuSZhW3NpGBZETptTURplu+0r9IK4E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753781526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK0qR9r5L5k3Mq4OXvAMdOUGY/I8rFQ9hjGJVVUvcYs=;
	b=YUPQflTQoufl9iSQXoRmaH0FhdsON86EkqtyRPQi0vgU9KZG2z9wklY5ZvTNgViY0fa5pu
	wX0X5QCT+2FANrI1+H2que1zvcjo3Q7qps1dLWOxgjr++Vfnj2ZFIPtOBFj5By+wIckCmp
	GQuSZhW3NpGBZETptTURplu+0r9IK4E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9874813876
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8HGbFhWViGgxUQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: clear block dirty if submit_one_sector() failed
Date: Tue, 29 Jul 2025 19:01:45 +0930
Message-ID: <c4e6696127d2205d7faef094e0b951ca88098410.1753781242.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753781242.git.wqu@suse.com>
References: <cover.1753781242.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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

[BUG]
If submit_one_sector() failed, the block will be kept dirty, but with
their corresponding range finished in the ordered extent.

This means if later a writeback happens again, we can hit the following
problems:

- ASSERT(block_start != EXTENT_MAP_HOLE) in submit_one_sector()
  If the original extent map is a hole, then we can hit this case, as
  the new ordered extent failed, we will drop the new extent map and
  re-read one from the disk.

- DEBUG_WARN() in btrfs_writepage_cow_fixup()
  This is because we no longer have an ordered extent for those dirty
  blocks. The original for them is already finished with error.

[CAUSE]
The function submit_one_sector() is not following the regular error
handling of writeback.
The common practice is to clear the folio dirty, start and finish the
writeback for the block.

This is normally done by extent_clear_unlock_delalloc() with
PAGE_START_WRITEBACK | PAGE_END_WRITEBACK flags during
run_delalloc_range().

So if we keep those failed blocks dirty, they will stay in the page
cache and wait for the next writeback.

And since the original ordered extent is already finished and removed,
depending on the original extent map, we either hit the ASSERT() inside
submit_one_sector(), or hit the DEBUG_WARN() in
btrfs_writepage_cow_fixup().

[FIX]
Follow the regular error handling to clear the dirty flag for the block,
start and finish writeback for that block instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c11c93bcc7f6..f6765ddab4a7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1548,7 +1548,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 /*
  * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors.
+ * Return <0 for critical errors, and the sector will have its dirty flag cleared.
  *
  * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
@@ -1571,8 +1571,19 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	ASSERT(filepos < i_size);
 
 	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
+	if (IS_ERR(em)) {
+		int ret = PTR_ERR(em);
+
+		/*
+		 * When submission failed, we should still clear the folio dirty.
+		 * Or the folio will be written back again but without any
+		 * ordered extent.
+		 */
+		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
+		return ret;
+	}
 
 	extent_offset = filepos - em->start;
 	em_end = btrfs_extent_map_end(em);
@@ -1702,8 +1713,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 * Here we set writeback and clear for the range. If the full folio
 	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
 	 *
-	 * If we hit any error, the corresponding sector will still be dirty
-	 * thus no need to clear PAGECACHE_TAG_DIRTY.
+	 * If we hit any error, the corresponding sector will still have its
+	 * dirty flag cleared and finish writeback just like below, thus
+	 * no need to handle error case either.
 	 */
 	if (!submitted_io && !error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
-- 
2.50.1


