Return-Path: <linux-btrfs+bounces-15703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0676B136AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 10:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C691017B204
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026B82459FF;
	Mon, 28 Jul 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uolqjH4Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uolqjH4Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB123535A
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691301; cv=none; b=it12943D+hlZjSWodrELnIkMKoPReR+dmgriMNthh7ILM6Ap5Lu63kNJgb976K9ceZEwlwXvIMPIIKVr/GpKtD695W8uJr95OjW/GkBJd6cTqsP27LwQC1dJKn1SKluASdnqyYEkx5TXDV4Jm97TdgEHZglZjkrcA4cSGaT+e8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691301; c=relaxed/simple;
	bh=ubb+5BcHbD1twU8PygJAKiUao6GzwEKonvYQzrtq9Z8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cev35Izdl2qPARH9pIXOTE7ixuwkQImegRMppHusS0BQ16eGiqhCsswmDP6NIVll4DgWFMyaugcOWd05xtPSdNQoS+WmPmaGRmpnYnxy9qcBEf1j0Yd5tgPK2PFrGXZyHAB0Dg65eJi/4tj3z0I7jAr6re4Om1OESE1OPTj9ksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uolqjH4Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uolqjH4Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31F7C1F444
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r568NSciIL/nN2frZyVIm36dwJSecQhp7iVL/brOstY=;
	b=uolqjH4YdiFUpXlwIeuL/llTXkZ0yZrwKmJSDhUvtGuFZG+3lpCPIRmEzeSg8sXF7jJP7X
	DBgs0cMJ9YQGTejQnEiAXcefE/aSFI/4E15d6C7mwzjpn+8bA1YBqaDZ0raJlDkwMWw/G4
	lQh502Z7umd+gPEvSDEZ/qb6K0T0aUc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r568NSciIL/nN2frZyVIm36dwJSecQhp7iVL/brOstY=;
	b=uolqjH4YdiFUpXlwIeuL/llTXkZ0yZrwKmJSDhUvtGuFZG+3lpCPIRmEzeSg8sXF7jJP7X
	DBgs0cMJ9YQGTejQnEiAXcefE/aSFI/4E15d6C7mwzjpn+8bA1YBqaDZ0raJlDkwMWw/G4
	lQh502Z7umd+gPEvSDEZ/qb6K0T0aUc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F06E138A5
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8HWDDKA0h2g0GwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: rework the error handling of run_delalloc_nocow()
Date: Mon, 28 Jul 2025 17:57:54 +0930
Message-ID: <fc949c60da3067060110c07b089726c0c289b74d.1753687685.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753687685.git.wqu@suse.com>
References: <cover.1753687685.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

Currently the error handling of run_delalloc_nocow() modifies
@cur_offset to handle different parts of the delalloc range.

However the error handling can always be split into 3 parts:

1) The range with ordered extents allocated (OE cleanup)
   We have to cleanup the ordered extents and unlock the folios.

2) The range that have been cleaned up (skip)
   For now it's only for the range of fallback_to_cow().

   We should not touch it at all.

3) The range that is not yet touched (untouched)
   We have to unlock the folios and clear any reserved space.

This 3 ranges split has the same principle as cow_file_range(), however
the NOCOW/COW handling makes the above 3 range split much more complex:

a) Failure immediately after a successful OE allocation
   Thus no @cow_start nor @cow_end set.

   start         cur_offset               end
   | OE cleanup  |       untouched        |

b) Failure after hitting a COW range but before calling
   fallback_to_cow()

   start        cow_start    cur_offset   end
   | OE Cleanup |       untouched         |

c) Failure to call fallback_to_cow()

   start        cow_start    cow_end      end
   | OE Cleanup |    skip    |  untouched |

Instead of modifying @cur_offset, do proper range calculation for
OE-cleanup and untouched ranges using above 3 cases with proper range
charts.

This avoid updating @cur_offset, as it will an extra output for debug
purposes later, and explain the behavior easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 120 ++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 793b1d520e8d..c7e2205c466f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2047,6 +2047,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	bool check_prev = true;
 	u64 ino = btrfs_ino(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
+	/* The range that has ordered extent(s). */
+	u64 oe_cleanup_start;
+	u64 oe_cleanup_len = 0;
+	/* The range that is untouched. */
+	u64 untouched_start;
+	u64 untouched_len = 0;
 
 	/*
 	 * Normally on a zoned device we're only doing COW writes, but in case
@@ -2232,76 +2238,72 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	return 0;
 
 error:
-	/*
-	 * There are several error cases:
-	 *
-	 * 1) Failed without falling back to COW
-	 *    start         cur_offset             end
-	 *    |/////////////|                      |
-	 *
-	 *    In this case, cow_start should be (u64)-1.
-	 *
-	 *    For range [start, cur_offset) the folios are already unlocked (except
-	 *    @locked_folio), EXTENT_DELALLOC already removed.
-	 *    Need to clear the dirty flags and finish the ordered extents.
-	 *
-	 * 2) Failed with error before calling fallback_to_cow()
-	 *
-	 *    start         cow_start              end
-	 *    |/////////////|                      |
-	 *
-	 *    In this case, only @cow_start is set, @cur_offset is between
-	 *    [cow_start, end)
-	 *
-	 *    It's mostly the same as case 1), just replace @cur_offset with
-	 *    @cow_start.
-	 *
-	 * 3) Failed with error from fallback_to_cow()
-	 *
-	 *    start         cow_start   cow_end    end
-	 *    |/////////////|-----------|          |
-	 *
-	 *    In this case, both @cow_start and @cow_end is set.
-	 *
-	 *    For range [start, cow_start) it's the same as case 1).
-	 *    But for range [cow_start, cow_end), all the cleanup is handled by
-	 *    cow_file_range(), we should not touch anything in that range.
-	 *
-	 * So for all above cases, if @cow_start is set, cleanup ordered extents
-	 * for range [start, @cow_start), other wise cleanup range [start, @cur_offset).
-	 */
-	if (cow_start != (u64)-1)
-		cur_offset = cow_start;
-
-	if (cur_offset > start) {
-		btrfs_cleanup_ordered_extents(inode, start, cur_offset - start);
-		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+	if (cow_start == (u64)-1) {
+		/*
+		 * case a)
+		 *    start           cur_offset               end
+		 *    |   OE cleanup  |       Untouched        |
+		 *
+		 * We finished a fallback_to_cow() or nocow_one_range() call, but
+		 * failed to check the next range.
+		 */
+		oe_cleanup_start = start;
+		oe_cleanup_len = cur_offset - start;
+		untouched_start = cur_offset;
+		untouched_len = end + 1 - untouched_start;
+	} else if (cow_start != (u64)-1 && cow_end == 0) {
+		/*
+		 * case b)
+		 *    start        cow_start    cur_offset   end
+		 *    | OE cleanup |        Untouched        |
+		 *
+		 * We got a range that needs COW, but before we hit the next NOCOW range,
+		 * thus [cow_start, cur_offset) doesn't yet have any OE.
+		 */
+		oe_cleanup_start = start;
+		oe_cleanup_len = cow_start - start;
+		untouched_start = cow_start;
+		untouched_len = end + 1 - untouched_start;
+	} else {
+		/*
+		 * case c)
+		 *    start        cow_start    cow_end      end
+		 *    | OE cleanup |   Skip     |  Untouched |
+		 *
+		 * fallback_to_cow() failed, and fallback_to_cow() will do the
+		 * cleanup for its range, we shouldn't touch the range
+		 * [cow_start, cow_end].
+		 */
+		ASSERT(cow_start != (u64)-1 && cow_end != 0);
+		oe_cleanup_start = start;
+		oe_cleanup_len = cow_start - start;
+		untouched_start = cow_end + 1;
+		untouched_len = end + 1 - untouched_start;
 	}
 
-	/*
-	 * If an error happened while a COW region is outstanding, cur_offset
-	 * needs to be reset to @cow_end + 1 to skip the COW range, as
-	 * cow_file_range() will do the proper cleanup at error.
-	 */
-	if (cow_end)
-		cur_offset = cow_end + 1;
+	if (oe_cleanup_len) {
+		btrfs_cleanup_ordered_extents(inode, oe_cleanup_start, oe_cleanup_len);
+		cleanup_dirty_folios(inode, locked_folio, oe_cleanup_start,
+				     oe_cleanup_start + oe_cleanup_len - 1, ret);
+	}
 
-	/*
-	 * We need to lock the extent here because we're clearing DELALLOC and
-	 * we're not locked at this point.
-	 */
-	if (cur_offset < end) {
+	if (untouched_len) {
 		struct extent_state *cached = NULL;
+		const u64 untouched_end = untouched_start + untouched_len - 1;
 
-		btrfs_lock_extent(&inode->io_tree, cur_offset, end, &cached);
-		extent_clear_unlock_delalloc(inode, cur_offset, end,
+		/*
+		 * We need to lock the extent here because we're clearing DELALLOC and
+		 * we're not locked at this point.
+		 */
+		btrfs_lock_extent(&inode->io_tree, untouched_start, untouched_end, &cached);
+		extent_clear_unlock_delalloc(inode, untouched_start, untouched_end,
 					     locked_folio, &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
-		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
+		btrfs_qgroup_free_data(inode, NULL, untouched_start, untouched_len, NULL);
 	}
 	btrfs_free_path(path);
 	btrfs_err_rl(fs_info,
-- 
2.50.1


