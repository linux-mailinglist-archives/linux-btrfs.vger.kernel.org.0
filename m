Return-Path: <linux-btrfs+bounces-21517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG6lD3lYiWlQ7AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21517-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:46:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C710B755
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 654F730078F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452162765C5;
	Mon,  9 Feb 2026 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XqFxV25A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XqFxV25A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD3176FB1
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608733; cv=none; b=imBJJKRumS6btdBsjBCuEtOcuEy+0JQK2yJDSNzQXaBANBVFtWVfY4pX1ea8Zk4F/nqHULx4uCyJGyzibR2e2lz/nLbppWt041ZbP1wb7K3OzgCvkrlb3pP9L77RG3jk5rlY/3BP1x0oPMHO5EPjTL4+FceNE2YXnD1JdN9Z8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608733; c=relaxed/simple;
	bh=dBebfKE0kEs+87bKpRYi7zKbqxZlWJniPvZK1rMWtOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqQ9Uwm/+dbYx4UMqct86ndzIyAjfVu5ZAYepjE4E7l2RPERKq2TqEXmYOkg5QQkM8BmVddSVXaylHp5IIHgEuTyyUyXTUPflRRXOAnq3FUKtl5ZJeIijcOh5hv7AAJX9hQnZRc50N72zH1glk+0JmfzYAs1sRBPP7oZ1DMinaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XqFxV25A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XqFxV25A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 826D53E6E1;
	Mon,  9 Feb 2026 03:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770608731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6PEhiq+xKTZzSKKXPqfgEY9qeV6NGFSPOKhi0pD51oc=;
	b=XqFxV25A5UhNBg5vlAgIawCCv8MAj493Hh3+SKqpyAe/6G/n/+Kmm+Xvz5jVR7NSTn3BpU
	7h1NxU+iMg9w6blx/UO3tnxVYe5cZ35nIA3m8hmqQiGYyy82JsxpBpYyqmxvKDK1nieRHv
	diLAPSlbdRDpx3oDCAHKNj/7EUi61+I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770608731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6PEhiq+xKTZzSKKXPqfgEY9qeV6NGFSPOKhi0pD51oc=;
	b=XqFxV25A5UhNBg5vlAgIawCCv8MAj493Hh3+SKqpyAe/6G/n/+Kmm+Xvz5jVR7NSTn3BpU
	7h1NxU+iMg9w6blx/UO3tnxVYe5cZ35nIA3m8hmqQiGYyy82JsxpBpYyqmxvKDK1nieRHv
	diLAPSlbdRDpx3oDCAHKNj/7EUi61+I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 223213EA63;
	Mon,  9 Feb 2026 03:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6zMjMFlYiWmPFAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 09 Feb 2026 03:45:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@meta.com>
Subject: [PATCH] btrfs: fix a double release on reserved extents in cow_one_range()
Date: Mon,  9 Feb 2026 14:15:11 +1030
Message-ID: <09b588005eec0809898978728261fff1a7b23d35.1770608707.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21517-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 8F7C710B755
X-Rspamd-Action: no action

[BUG]
Commit c28214bde6da ("btrfs: refactor the main loop of
cow_file_range()") refactored the handling of COWing one range.

However it changed the error handling of the reserved extent.

The old cleanup looks like this:

out_drop_extent_cache:
	btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size - 1, false);
out_reserve:
	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
	[...]
	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
		     EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
	/*
	 * For the range (2). If we reserved an extent for our delalloc range
	 * (or a subrange) and failed to create the respective ordered extent,
	 * then it means that when we reserved the extent we decremented the
	 * extent's size from the data space_info's bytes_may_use counter and
	 * incremented the space_info's bytes_reserved counter by the same
	 * amount. We must make sure extent_clear_unlock_delalloc() does not try
	 * to decrement again the data space_info's bytes_may_use counter,
	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
	 */
	if (cur_alloc_size) {
	        extent_clear_unlock_delalloc(inode, start,
	                                     start + cur_alloc_size - 1,
	                                     locked_folio, &cached, clear_bits,
	                                     page_ops);
	        btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
	}

Which only calls EXTENT_CLEAR_META_RESV.
As the reserved extent is properly handled by
btrfs_free_reserved_extent().

However the new cleanup is:

	extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_folio, cached,
				     EXTENT_LOCKED | EXTENT_DELALLOC |
				     EXTENT_DELALLOC_NEW |
				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
				     PAGE_END_WRITEBACK);
	btrfs_qgroup_free_data(inode, NULL, file_offset, cur_len, NULL);
	btrfs_dec_block_group_reservations(fs_info, ins->objectid);
	btrfs_free_reserved_extent(fs_info, ins->objectid, ins->offset, true);

The flag EXTENT_DO_ACCOUNTING implies both EXTENT_CLEAR_META_RESV and
EXTENT_CLEAR_DATA_RESV, which will release the bytes_may_use, which
later btrfs_free_reserved_extent() will do again, causing incorrect
double release (and may underflow bytes_may_use).

[FIX]
Use EXTENT_CLEAR_META_RESV to replace EXTENT_DO_ACCOUNTING, and add back
the comments on why we only use EXTENT_CLEAR_META_RESV.

Fixes: c28214bde6da ("btrfs: refactor the main loop of cow_file_range()")
Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/linux-btrfs/20260208184920.1102719-1-clm@meta.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7b23ae6872fc..4ba38ec22610 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1393,10 +1393,25 @@ static int cow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
 	return ret;
 
 free_reserved:
+	/*
+	 * If we have reserved an extent for the current range and failed to
+	 * create the respectiv extent map or ordered extent, it means that
+	 * when we reserved the extent we decremented the extent's size from
+	 * the data space_info's bytes_may_use counter and
+	 * incremented the space_info's bytes_reserved counter by the same
+	 * amount.
+	 *
+	 * We must make sure extent_clear_unlock_delalloc() does not try
+	 * to decrement again the data space_info's bytes_may_use counter, which
+	 * will be handled by btrfs_free_reserved_extent().
+	 *
+	 * Therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV, but only
+	 * EXTENT_CLEAR_META_RESV.
+	 */
 	extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_folio, cached,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
-				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
+				     EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
 	btrfs_qgroup_free_data(inode, NULL, file_offset, cur_len, NULL);
-- 
2.52.0


