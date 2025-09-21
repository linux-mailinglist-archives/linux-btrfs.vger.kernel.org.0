Return-Path: <linux-btrfs+bounces-17017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E3B8E901
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9123BC8B9
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066F226863;
	Sun, 21 Sep 2025 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cIPA9wjf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cIPA9wjf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8D19CC02
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494484; cv=none; b=MXTffPQ1AFLh84+T9ct8hsfcW+EcS95w/gQpJCSepaellJSdOSQaJv2eHeZwxQI+f9+zVlf9g17Ph+GI3gy1uXghAHp5LjMmpSCnRjmbAGsdydLI1HVDSPGs9uOxyS0EVJj4KVkC3+4DOqHXnAcvdok8GHyzVYqWBEFewqKeWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494484; c=relaxed/simple;
	bh=wbYul/CauuhGCtntOc8clcF5qvEQLNAoSnIefIJxF0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcDkd++jXAMC2jyBRvxVuz0NdWu22lFkWnKffF8l5sdamwMsOdu3iL47DPDesgx4YwE96QtEEnUFsRSScO7HhaIjoiJJn04B8PT9pWJGtGbqHnu49suMGGiGrfAozc4gA248aMmeLOgLBI6F7HykntD/zMSvTzD4tSlRDff5KCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cIPA9wjf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cIPA9wjf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61CE122274;
	Sun, 21 Sep 2025 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758494471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irw1cxmdVnCYzU5LBO4zADP1QmuXxt9dn2RxqZcWxUw=;
	b=cIPA9wjfFjIMLd1u2v2mqQgcflciMyH8yIoiC8uDRZjuFgYD+eqpdU+c2rnMQNrjaes5XO
	ThJALpNrVJgvgKWGbHn22yzwREjB1Cos6DypCPOOFxzsVgSHms5+brb4Zs7zIQbsM+orHJ
	BjisRVYK/qcNOOnXf/dSKAgdCVcEffo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758494471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irw1cxmdVnCYzU5LBO4zADP1QmuXxt9dn2RxqZcWxUw=;
	b=cIPA9wjfFjIMLd1u2v2mqQgcflciMyH8yIoiC8uDRZjuFgYD+eqpdU+c2rnMQNrjaes5XO
	ThJALpNrVJgvgKWGbHn22yzwREjB1Cos6DypCPOOFxzsVgSHms5+brb4Zs7zIQbsM+orHJ
	BjisRVYK/qcNOOnXf/dSKAgdCVcEffo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 693FD13ACD;
	Sun, 21 Sep 2025 22:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yCiQCwZ/0GisdwAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 21 Sep 2025 22:41:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/9] btrfs: fix the incorrect @max_bytes value for find_lock_delalloc_range()
Date: Mon, 22 Sep 2025 08:10:43 +0930
Message-ID: <8e713e74d2a2515727f5438e9f86f68ad2f4cceb.1758494327.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758494326.git.wqu@suse.com>
References: <cover.1758494326.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[BUG]
With my local branch to enable bs > ps support for btrfs, sometimes I
hit the following ASSERT() inside submit_one_sector():

	ASSERT(block_start != EXTENT_MAP_HOLE);

Please note that it's not yet possible to hit this ASSERT() in the wild
yet, as it requires btrfs bs > ps support, which is not even in the
development branch.

But on the other hand, there is also a very low chance to hit above
ASSERT() with bs < ps cases, so this is an existing bug affect not only
the incoming bs > ps support but also the existing bs < ps support.

[CAUSE]
Firstly that ASSERT() means we're trying to submit a dirty block but
without a real extent map nor ordered extent map backing it.

Furthermore with extra debugging, the folio triggering such ASSERT() is
always larger than the fs block size in my bs > ps case.
(8K block size, 4K page size)

After some more debugging, the ASSERT() is trigger by the following
sequence:

 extent_writepage()
 |  We got a 32K folio (4 fs blocks) at file offset 0, and the fs block
 |  size is 8K, page size is 4K.
 |  And there is another 8K folio at file offset 32K, which is also
 |  dirty.
 |  So the filemap layout looks like the following:
 |
 |  "||" is the filio boundary in the filemap.
 |  "//| is the dirty range.
 |
 |  0        8K       16K        24K         32K       40K
 |  |////////|        |//////////////////////||////////|
 |
 |- writepage_delalloc()
 |  |- find_lock_delalloc_range() for [0, 8K)
 |  |  Now range [0, 8K) is properly locked.
 |  |
 |  |- find_lock_delalloc_range() for [16K, 40K)
 |  |  |- btrfs_find_delalloc_range() returned range [0, 8K)
 |  |  |- lock_delalloc_folios() succeeded.
 |  |  |
 |  |  |  The filemap range [32K, 40K) got dropped from filemap.
 |  |  |
 |  |  |- lock_delalloc_folios() failed with -EAGAIN.
 |  |  |  As it failed to lock the folio at [32K, 40K).
 |  |  |
 |  |  |- loops = 1;
 |  |  |- max_bytes = PAGE_SIZE;
 |  |  |- goto again;
 |  |  |  This will re-do the lookup for dirty delalloc ranges.
 |  |  |
 |  |  |- btrfs_find_delalloc_range() called with @max_bytes == 4K
 |  |  |  This is smaller than block size, so
 |  |  |  btrfs_find_delalloc_range() is unable to return any range.
 |  |  \- return false;
 |  |
 |  \- Now only range [0, 8K) has an OE for it, but for dirty range
 |     [16K, 32K) it's dirty without an OE.
 |     This breaks the assumption that writepage_delalloc() will find
 |     and lock all dirty ranges inside the folio.
 |
 |- extent_writepage_io()
    |- submit_one_sector() for [0, 8K)
    |  Succeeded
    |
    |- submit_one_sector() for [16K, 24K)
       Triggering the ASSERT(), as there is no OE, and the original
       extent map is a hole.

Please note that, this also exposed the same problem for bs < ps
support. E.g. with 64K page size and 4K block size.

If we failed to lock a folio, and falls back into the "loops = 1;"
branch, we will re-do the search using 64K as max_bytes.
Which may fail again to lock the next folio, and exit early without
handling all dirty blocks inside the folio.

[FIX]
Instead of using the fixed size PAGE_SIZE as @max_bytes, use
@sectorsize, so that we are ensured to find and lock any remaining
blocks inside the folio.

And since we're here, add an extra ASSERT() to
before calling btrfs_find_delalloc_range() to make sure the @max_bytes is
at least no smaller than a block to avoid false negative.

Cc: stable@vger.kernel.org #5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca7174fa0240..2fd82055a779 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -393,6 +393,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
 	delalloc_end = 0;
+
+	/*
+	 * If @max_bytes is smaller than a block, btrfs_find_delalloc_range() can
+	 * return early without handling any dirty ranges.
+	 */
+	ASSERT(max_bytes >= fs_info->sectorsize);
+
 	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
 					  max_bytes, &cached_state);
 	if (!found || delalloc_end <= *start || delalloc_start > orig_end) {
@@ -423,13 +430,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				   delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
 	if (ret == -EAGAIN) {
-		/* some of the folios are gone, lets avoid looping by
-		 * shortening the size of the delalloc range we're searching
+		/*
+		 * Some of the folios are gone, lets avoid looping by
+		 * shortening the size of the delalloc range we're searching.
 		 */
 		btrfs_free_extent_state(cached_state);
 		cached_state = NULL;
 		if (!loops) {
-			max_bytes = PAGE_SIZE;
+			max_bytes = fs_info->sectorsize;
 			loops = 1;
 			goto again;
 		} else {
-- 
2.50.1


