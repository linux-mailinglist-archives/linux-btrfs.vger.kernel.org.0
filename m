Return-Path: <linux-btrfs+bounces-15642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BB6B0F10C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913BD16D21E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA629CB45;
	Wed, 23 Jul 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XLx4jDFq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XLx4jDFq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9DF277CBC
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269694; cv=none; b=ChcHa+6RiP2ulVof+P61vA4RefjK0j3L/4QIfEJuSfClv8/5/cceQXC9iF21TkYvo9c1geEc0Oi1eVss8CvWSJcZpdxRMC+LpQaYEADJrglaN5FKO8NzCTKMS77mQgNzQZDjYehE1XFfVd4B3P6wcJclRZFyFj3yqWSJ9574cyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269694; c=relaxed/simple;
	bh=7int10wbmyyPZ+8Nw61eNG//fehzDPfnnfIZtg6+ZWY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6aYcn0yUm8JLIolwjNiMs6cRqyH7ZUqayZkQ8jH8pi6KwB+OPji7wgiaBodbrGNIJKHoINN8//UJaDf238CrwW3L8ZvXJudYuBPsd+CaHX0UDmhDoh4SvvAIRH6CGJ8WVHnuArYUfECRRGmyVkHcUaXibIy78R1hB4QEGOmgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XLx4jDFq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XLx4jDFq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BF6C1F399
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/WILujG0EWzqXOrr+R06rq/apkEaE7l9syjtrLrMHA=;
	b=XLx4jDFqh0bVrchcoxRfu0yXwfc5OslCxWiRxd851KIWWdOZds2WHwlTMI41a4kdLG7sgh
	BR2EonIxclDUMD3Wwc2OCX1eoTtl5x4dxTbK578bpcorU4GwPxyCTCThhlpfWGsWfp4SLY
	jI0+RUgzSQWhKz9cWpxUkMYihwXnv7o=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XLx4jDFq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/WILujG0EWzqXOrr+R06rq/apkEaE7l9syjtrLrMHA=;
	b=XLx4jDFqh0bVrchcoxRfu0yXwfc5OslCxWiRxd851KIWWdOZds2WHwlTMI41a4kdLG7sgh
	BR2EonIxclDUMD3Wwc2OCX1eoTtl5x4dxTbK578bpcorU4GwPxyCTCThhlpfWGsWfp4SLY
	jI0+RUgzSQWhKz9cWpxUkMYihwXnv7o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D834B13302
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QHxFJrjFgGhaeAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: enhance error messages for delalloc range failure
Date: Wed, 23 Jul 2025 20:51:22 +0930
Message-ID: <770950dc29a5d621682d80c4069a8cde0e2d629b.1753269601.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753269601.git.wqu@suse.com>
References: <cover.1753269601.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9BF6C1F399
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

When running emulated write error tests like generic/475, we can hit
error messages like this:

 BTRFS error (device dm-12 state EA): run_delalloc_nocow failed, root=596 inode=264 start=1605632 len=73728: -5
 BTRFS error (device dm-12 state EA): failed to run delalloc range, root=596 ino=264 folio=1605632 submit_bitmap=0-7 start=1605632 len=73728: -5

Which is normally buried by direct IO error messages.

However above error messages are not enough to determine which is the
real range that caused the error.
Considering we can have multiple different extents in one delalloc
range (e.g. some COW extents along with some NOCOW extents), just
outputting the error at the end of run_delalloc_nocow() is not enough.

To enhance the error messages:

- Remove the rate limit on the existing error messages
  In the generic/475 example, most error messages are from direct IO,
  not really from the delalloc range.
  Considering how useful the delalloc range error messages are, we don't
  want they to be rate limited.

- Add extra @cur_offset output for cow_file_range()
- Add extra @cow_start and @cow_end output for run_delalloc_nocow()
  This is especially important for run_delalloc_nocow(), as there
  are extra error paths where we can hit error without into
  nocow_one_range() nor fallback_to_cow().

- Add an error message for nocow_one_range()
  That's the missing part.
  For fallback_to_cow(), we have error message from cow_file_range()
  already.

- Constify the @len and @end local variables for nocow_one_range()
  This makes it much easier to make sure @len and @end are not modified
  at runtime.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d9a8d8bea4c..55d42f2b4a86 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1534,10 +1534,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
 				       end - start - cur_alloc_size + 1, NULL);
 	}
-	btrfs_err_rl(fs_info,
-		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
-		     __func__, btrfs_root_id(inode->root),
-		     btrfs_ino(inode), orig_start, end + 1 - orig_start, ret);
+	btrfs_err(fs_info,
+		  "%s failed, root=%llu inode=%llu start=%llu len=%llu cur_offset=%llu cur_alloc_size=%llu: %d",
+		  __func__, btrfs_root_id(inode->root),
+		  btrfs_ino(inode), orig_start, end + 1 - orig_start,
+		  start, cur_alloc_size, ret);
 	return ret;
 }
 
@@ -1969,8 +1970,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 			   u64 file_pos, bool is_prealloc)
 {
 	struct btrfs_ordered_extent *ordered;
-	u64 len = nocow_args->file_extent.num_bytes;
-	u64 end = file_pos + len - 1;
+	const u64 len = nocow_args->file_extent.num_bytes;
+	const u64 end = file_pos + len - 1;
 	int ret = 0;
 
 	btrfs_lock_extent(&inode->io_tree, file_pos, end, cached);
@@ -2017,8 +2018,13 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 	 * We do not clear the folio Dirty flags because they are set and
 	 * cleaered by the caller.
 	 */
-	if (ret < 0)
+	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, file_pos, len);
+		btrfs_err(inode->root->fs_info,
+			  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
+			  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
+			  file_pos, len, ret);
+	}
 	return ret;
 }
 
@@ -2304,10 +2310,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
 	}
 	btrfs_free_path(path);
-	btrfs_err_rl(fs_info,
-		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
-		     __func__, btrfs_root_id(inode->root),
-		     btrfs_ino(inode), start, end + 1 - start, ret);
+	btrfs_err(fs_info,
+		  "%s failed, root=%llu inode=%llu start=%llu len=%llu cow_start=%lld cow_end=%llu: %d",
+		  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
+		  start, end + 1 - start, cow_start, cow_end, ret);
 	return ret;
 }
 
-- 
2.50.0


