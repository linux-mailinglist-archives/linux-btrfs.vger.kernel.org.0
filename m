Return-Path: <linux-btrfs+bounces-10932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA8A0B37F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 10:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64CA169E8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D021ADB1;
	Mon, 13 Jan 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oclTvdZs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D5Mg1Y6C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735C1FDA65
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761359; cv=none; b=UHDBr4aviUzQ21zh4dDkoGOkgsZkZ56+avTXWufpUvYBau3LBD6toZJSBU40GO0YTRdfVINVDEftVwz/wWb+VDZCsg9eLfwnXv/AhBE1/zF3ViMyuvy3xMwco0d+oHkiwvIMvo74FRflS3pM87/B7AArsogUIMqe8oIY6kbq6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761359; c=relaxed/simple;
	bh=shxFN+jMxhN7l98OegCuVbMQSwwXf1EMLsuFvEmw9ZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbpDbOHXd4rsHMZgUfOFdWEvzgHDvqy2KohBaG3+4RuKrxZ7pMlZBi14I3z7Fb1CclYYT0TQuX3EQhq3n/V+fw0CPzSJBY7Ij59KDiaj++EKFNg1aza+iaynCHPvlWfSxGAF8FPpOyw4kEpo3kGCgAizvzHGp2jnvU7Qbr3IArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oclTvdZs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D5Mg1Y6C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBFB01F37E
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736761355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXTQXFwW54nNKiKdeT6mrIo+jt5imt2K7nqs2cPEXSU=;
	b=oclTvdZsnuPb1iuThphYLw56KtPDtHRvoX8uRyFnnPUjP+TlexIr8evMBJ60tPLDPjUWi+
	8Y3PeqbBQO3WLLPMa1AnwgtfhBbJhZIyTR+kPw4Q+p2Kwe5eY74kA21qrdXFpagtoHkWpP
	mBWshCoJmSMKY3vK1pD/drXDrvnK338=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=D5Mg1Y6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736761354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXTQXFwW54nNKiKdeT6mrIo+jt5imt2K7nqs2cPEXSU=;
	b=D5Mg1Y6C5Vi7XAXPgjOgSZ82Iq7hsm2F0GmPb9xKwENd2wUyfCCG7Ac3FV2EZGSn2qOEnQ
	1biQUmYVERe2xzIpoAvhx1EvRXIkRvBpillZCgWOcTbxuFRDxR01ifBydGTt544Qow2L05
	EPZgFf6jAcNJPTMZ9j2I5EGWwLM+8Hw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2389D13310
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oPKlNQnghGf0WgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: move ordered extent cleanup to where they are allocated
Date: Mon, 13 Jan 2025 20:12:13 +1030
Message-ID: <ac72ae0a2f67771efaf3839aede82b1b294ccbcb.1736759698.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736759698.git.wqu@suse.com>
References: <cover.1736759698.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBFB01F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The ordered extent cleanup is hard to grasp because it doesn't follow
the common cleanup-asap pattern.

E.g. run_delalloc_nocow() and cow_file_range() allocate one or more
ordered extents, but if any error is hit, the cleanup is done later inside
btrfs_run_delalloc_range().

To change the existing delayed cleanup:

- Update the comment on error handling of run_delalloc_nocow()
  There are in fact 3 different cases other than 2 if we are doing
  ordered extents cleanup inside run_delalloc_nocow():

  1) @cow_start and @cow_end not set
     No fallback to COW at all.
     Before @cur_offset we need to cleanup the OE and page dirty.
     After @cur_offset just clear all involved page and extent flags.

  2) @cow_start set but @cow_end not set.
     This means we failed before even calling fallback_to_cow().
     It's just an variant of case 1), where it's @cow_start splitting
     the two parts (and we should just ignore @cur_offset since it's
     advanced without any new ordered extent).

  3) @cow_start and @cow_end both set
     This means fallback_to_cow() failed, meaning [start, cow_start)
     needs the regular OE and dirty folio cleanup, and skip range
     [cow_start, cow_end) as cow_file_range() has done the cleanup,
     and eventually cleanup [cow_end, end) range.

- Only reset @cow_start after fallback_to_cow() succeeded
  As above case 2) and 3) are both relying on @cow_start to determine
  cleanup range.

- Move btrfs_cleanup_ordered_extents() into run_delalloc_nocow(),
  cow_file_range() and nocow_one_range()

  For cow_file_range() it's pretty straightforward and easy.

  For run_delalloc_nocow() refer to the above 3 different error cases.

  For nocow_one_range() if we hit an error, we need to cleanup the
  ordered extents by ourselves.
  And then it will fallback to case 1), since @cur_offset is not yet
  advanced, the existing cleanup will co-operate with nocow_one_range()
  well.

- Remove the btrfs_cleanup_ordered_extents() inside
  submit_uncompressed_range()
  As failed cow_file_range() will do all the proper cleanup now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 66 ++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42f67f8a4a33..8e8b08412d35 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1090,7 +1090,6 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 		if (locked_folio)
 			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
 					     start, async_extent->ram_size);
@@ -1272,10 +1271,7 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * - Else all pages except for @locked_folio are unlocked.
  *
  * When a failure happens in the second or later iteration of the
- * while-loop, the ordered extents created in previous iterations are kept
- * intact. So, the caller must clean them up by calling
- * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
- * example.
+ * while-loop, the ordered extents created in previous iterations are cleaned up.
  */
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct folio *locked_folio, u64 start,
@@ -1488,11 +1484,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	/*
 	 * For the range (1). We have already instantiated the ordered extents
-	 * for this region. They are cleaned up by
-	 * btrfs_cleanup_ordered_extents() in e.g,
-	 * btrfs_run_delalloc_range().
+	 * for this region, thus we need to cleanup those ordered extents.
 	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
-	 * are also handled by the cleanup function.
+	 * are also handled by the ordered extents cleanup.
 	 *
 	 * So here we only clear EXTENT_LOCKED and EXTENT_DELALLOC flag,
 	 * and finish the writeback of the involved folios, which will be
@@ -1504,6 +1498,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
+
+		btrfs_cleanup_ordered_extents(inode, orig_start, start - orig_start);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
 					     locked_folio, NULL, clear_bits, page_ops);
 	}
@@ -2030,12 +2026,15 @@ static int nocow_one_range(struct btrfs_inode *inode,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_CLEAR_DATA_RESV,
 				     PAGE_UNLOCK | PAGE_SET_ORDERED);
-
 	/*
-	 * btrfs_reloc_clone_csums() error, now we're OK to call error
-	 * handler, as metadata for created ordered extent will only
-	 * be freed by btrfs_finish_ordered_io().
+	 * On error, we need to cleanup the ordered extents we created.
+	 *
+	 * We also need to clear the folio Dirty flags for the range,
+	 * but it's not something touched by us, it will be cleared
+	 * by the caller (with cleanup_dirty_folios()).
 	 */
+	if (ret < 0)
+		btrfs_cleanup_ordered_extents(inode, file_pos, end);
 	return ret;
 }
 
@@ -2214,12 +2213,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (cow_start != (u64)-1) {
 			ret = fallback_to_cow(inode, locked_folio, cow_start,
 					      found_key.offset - 1);
-			cow_start = (u64)-1;
 			if (ret) {
 				cow_end = found_key.offset - 1;
 				btrfs_dec_nocow_writers(nocow_bg);
 				goto error;
 			}
+			cow_start = (u64)-1;
 		}
 
 		ret = nocow_one_range(inode, locked_folio, &cached_state,
@@ -2237,11 +2236,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (cow_start != (u64)-1) {
 		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
-		cow_start = (u64)-1;
 		if (ret) {
 			cow_end = end;
 			goto error;
 		}
+		cow_start = (u64)-1;
 	}
 
 	btrfs_free_path(path);
@@ -2255,16 +2254,32 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 *    start         cur_offset             end
 	 *    |/////////////|                      |
 	 *
+	 *    In this case, cow_start should be (u64)-1.
+	 *
 	 *    For range [start, cur_offset) the folios are already unlocked (except
 	 *    @locked_folio), EXTENT_DELALLOC already removed.
 	 *    Only need to clear the dirty flag as they will never be submitted.
 	 *    Ordered extent and extent maps are handled by
 	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
 	 *
-	 * 2) Failed with error from fallback_to_cow()
-	 *    start         cur_offset  cow_end    end
+	 * 2) Failed with error before calling fallback_to_cow()
+	 *
+	 *    start         cow_start              end
+	 *    |/////////////|                      |
+	 *
+	 *    In this case, only @cow_start is set, @cur_offset is between
+	 *    [cow_start, end)
+	 *
+	 *    It's mostly the same as case 1), just replace @cur_offset with
+	 *    @cow_start.
+	 *
+	 * 3) Failed with error from fallback_to_cow()
+	 *
+	 *    start         cow_start   cow_end    end
 	 *    |/////////////|-----------|          |
 	 *
+	 *    In this case, both @cow_start and @cow_end is set.
+	 *
 	 *    For range [start, cur_offset) it's the same as case 1).
 	 *    But for range [cur_offset, cow_end), the folios have dirty flag
 	 *    cleared and unlocked, EXTENT_DEALLLOC cleared by cow_file_range().
@@ -2272,10 +2287,17 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 *    Thus we should not call extent_clear_unlock_delalloc() on range
 	 *    [cur_offset, cow_end), as the folios are already unlocked.
 	 *
-	 * So clear the folio dirty flags for [start, cur_offset) first.
+	 *
+	 * So for all above cases, if @cow_start is set, cleanup ordered extents
+	 * for range [start, @cow_start), other wise cleanup range [start, @cur_offset).
 	 */
-	if (cur_offset > start)
+	if (cow_start != (u64)-1)
+		cur_offset = cow_start;
+
+	if (cur_offset > start) {
+		btrfs_cleanup_ordered_extents(inode, start, cur_offset - start);
 		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+	}
 
 	/*
 	 * If an error happened while a COW region is outstanding, cur_offset
@@ -2340,7 +2362,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 	if (should_nocow(inode, start, end)) {
 		ret = run_delalloc_nocow(inode, locked_folio, start, end);
-		goto out;
+		return ret;
 	}
 
 	if (btrfs_inode_can_compress(inode) &&
@@ -2354,10 +2376,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 	else
 		ret = cow_file_range(inode, locked_folio, start, end, NULL,
 				     false, false);
-
-out:
-	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 	return ret;
 }
 
-- 
2.47.1


