Return-Path: <linux-btrfs+bounces-19635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A434BCB489C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 03:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FC9330014DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EF7469D;
	Thu, 11 Dec 2025 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cGyZBPwc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W+M6dGml"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292212C0273
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419347; cv=none; b=DyPweAohYH9HepW7acsURsjL29k4XakbFli/J8NPqZiSGtJGbbsN4NoXM7NfHRTsu39oCdbCifPkaqNB0QLnApCgOvuP580ZzJUWWTymbfYqotAXcubi9DE6sDA6IISHUGoV9cq9bMOXNa9IcUcpbXmS4uUjz3ZCtpvCKF0j+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419347; c=relaxed/simple;
	bh=HnDC7atMnZ92ATMbfY05k2xqe5Jb55riJuhUB1JL2Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RojS1gNYFeTbw2IaudV9t9GIPOH66IbtSfCunCqAqSluGMUpKy7/0QyN5ybZC91aGLakYWfNmlNI6k0juH+jfEP6Ya+Fq0VchjBkNaVnAbk1aNbYTv/C00ZXOFStfI9vRj5R6Av+fhBoMjzDn+AVfzYdlZWLQlN9MJ5zltqoAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cGyZBPwc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W+M6dGml; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83047336F0;
	Thu, 11 Dec 2025 02:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765419339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqXfHlFZib8cs2VdaxRF22MjV2D5B6NeCgV24uVK5aI=;
	b=cGyZBPwcLN3QSrwJg0JMj+iaLPrX94G20Rnhzu8zovKvcWvMfgCWjerKAjdicUPefQIS5k
	SMKHmElCfcFK3zESOfqqeykHNyiDUG0eJA5guc3vRv655fj4Sw6SiSolFjh2Ttdw0IiftJ
	iv/etNJmVxi86BWKuynfccOMzeREQ7U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=W+M6dGml
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765419338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqXfHlFZib8cs2VdaxRF22MjV2D5B6NeCgV24uVK5aI=;
	b=W+M6dGmlXpiI7TJ3KwiyM0mSjBFV+kJSq6LEebTX7qnrSGBm0WKxtdcfzuqCZ3NJnw7uBU
	D9/ZqNpHkWJO2hwTYsWh427mwEMxkeXNA7lSduhX3IZuOcJg7tpcXgWwmrvJiKFyCqPo52
	1wCv3cUAhlZxuRV4egSpLr4eFddAo9Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 853653EA65;
	Thu, 11 Dec 2025 02:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oMIIEkkpOmmBAQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 11 Dec 2025 02:15:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix beyond-EOF write handling
Date: Thu, 11 Dec 2025 12:45:17 +1030
Message-ID: <2e646aa21c452f80c2afbbf50ceda081c5c3ed4c.1765418669.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765418669.git.wqu@suse.com>
References: <cover.1765418669.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 83047336F0
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

[BUG]
For the following write sequence with 64K page size and 4K fs block size,
it will lead to file extent items to be inserted without any data
checksum:

  mkfs.btrfs -s 4k -f $dev > /dev/null
  mount $dev $mnt
  xfs_io -f -c "pwrite 0 16k" -c "pwrite 32k 4k" -c pwrite "60k 64K" \
            -c "truncate 16k" $mnt/foobar
  umount $mnt

This will result the following 2 file extent items to be inserted (extra
trace point added to insert_ordered_extent_file_extent()):

   btrfs_finish_one_ordered: root=5 ino=257 file_off=61440 num_bytes=4096 csum_bytes=0
   btrfs_finish_one_ordered: root=5 ino=257 file_off=0 num_bytes=16384 csum_bytes=16384

Note for file offset 60K, we're inserting an file extent without any
data checksum.

Also note that range [32K, 36K) didn't reach
insert_ordered_extent_file_extent(), which is the correct behavior as
that OE is fully truncated, should not result any file extent.

Although file extent at 60K will be later dropped by btrfs_truncate(),
if the transaction got committed after file extent inserted but before
the file extent dropping, we will have a small window where we have a
file extent beyond EOF and without any data checksum.

That will cause "btrfs check" to report error.

[CAUSE]
The sequence happens like this:

- Buffered write dirtied the page cache and updated isize

  Now the inode size is 64K, with the following page cache layout:

  0             16K             32K              48K           64K
  |/////////////|               |//|                        |//|

- Truncate the inode to 16K
  Which will trigger writeback through:

  btrfs_setsize()
  |- truncate_setsize()
  |  Now the inode size is set to 16K
  |
  |- btrfs_truncacte()
     |- btrfs_wait_ordered_range() for [16K, u64(-1)]
        |- btrfs_fdatawrite_range() for [16K, u64(-1)}
	   |- extent_writepage() for folio 0
	      |- writepage_delalloc()
	      |  Generated OE for [0, 16K), [32K, 36K] and [60K, 64K)
	      |
	      |- extent_writepage_io()

  Then inside extent_writepage_io(), the dirty fs blocks are handled
  differently:

  - Submit write for range [0, 16K)
    As they are still inside the inode size (16K).

  - Mark OE [32K, 36K) as truncated
    Since we only call btrfs_lookup_first_ordered_range() once, which
    returned the first OE after file offset 16K.

  - Mark all OEs inside range [16K, 64K) as finished
    Which will mark OE ranges [32K, 36K) and [60K, 64K) as finished.

    For OE [32K, 36K) since it's already marked as truncated, and its
    truncated length is 0, no file extent will be inserted.

    For OE [60K, 64K) it has never been submitted thus has no data
    checksum, and we insert the file extent as usual.
    This is the root cause of file extent at 60K to be inserted without
    any data checksum.

  - Clear dirty flags for range [16K, 64K)
    It is the function btrfs_folio_clear_dirty() which search and clear
    any dirty blocks inside that range.

[FIX]
The bug itself is introduced a long time ago, way before subpage and
larger folio support.

At that time, fs block size must match page size, thus the range
[cur, end) is just one fs block.

But later with subpage and larger folios, the same range [cur, end)
can have multiple blocks and ordered extents.

Later commit 18de34daa7c6 ("btrfs: truncate ordered extent when skipping
writeback past i_size") is fixing a bug related to subpage/larger
folios, but it's still utilizing the old range [cur, end), meaning only
the first OE will be marked as truncated.

The proper fix here is to make EOF handling block-by-block, not trying
to handle the whole range to @end.

By this we always locate and truncate the OE for every dirty block.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 629fd5af4286..a4b74023618d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1728,7 +1728,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			struct btrfs_ordered_extent *ordered;
 
 			ordered = btrfs_lookup_first_ordered_range(inode, cur,
-								   folio_end - cur);
+								   fs_info->sectorsize);
 			/*
 			 * We have just run delalloc before getting here, so
 			 * there must be an ordered extent.
@@ -1742,7 +1742,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			btrfs_put_ordered_extent(ordered);
 
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       end - cur, true);
+						       fs_info->sectorsize, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1751,8 +1751,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
-			break;
+			btrfs_folio_clear_dirty(fs_info, folio, cur, fs_info->sectorsize);
+			continue;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
 		if (unlikely(ret < 0)) {
-- 
2.52.0


