Return-Path: <linux-btrfs+bounces-4003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36D89ADD8
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 03:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446B9B22032
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 01:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E963BF;
	Sun,  7 Apr 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pLEL5A4E";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pLEL5A4E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590617C2;
	Sun,  7 Apr 2024 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452717; cv=none; b=Nx5sQEBoJ3AoOyLFlMTSz7MZuTR4d+l9FtFM8cMld62/hhSu5yeGiiD/57hlzzX0lrQtTKvHLarESs2xilvt/GuZFTdHtuqh21KNDHdjiH0aFtXI8DhgmqQjJJzJIvkvAhjn1LGpTb3MwuWcQXJweOXhyQ3TY/7T/dACiX2csmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452717; c=relaxed/simple;
	bh=DcFta6ls/izlo58fwzzl6ORWLkecjCJfz8lEVHGahE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gh7kpZkvMFofmMpAizixlyMVflvIldvd16Sly7kRI7bSzoxvb10MAJSYNdQGXXnuPi05lLNVLibPyDTUHeF3GXs/mtCpUK/U+zikzQselfAR3BL0zFS3Awr2KfeHzUA7N3OzWFKB01CZ0dcaphK+nibK3zh9CraCO324fKKAp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pLEL5A4E; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pLEL5A4E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4952621B54;
	Sun,  7 Apr 2024 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712452708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8vHQfAWcIYGuMZDMV2jP2L8rJ2/WeZkUp6xTPeY0gIg=;
	b=pLEL5A4Ew45dlLSZwz9ocS1AS6siJneQdv1msNOnhJV1tZRRkaBl/qD5Zt5wn+VVm75GI8
	cHpNwNu1ITJnfr1hATzKg5jKdaCY6x516pH1spSSSsQy4CoA1V1dnmA+RhOTPJ0/x3Z6GJ
	PoL0T3wuHGXM+JSAUBe6VB2i4PCMRkQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712452708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8vHQfAWcIYGuMZDMV2jP2L8rJ2/WeZkUp6xTPeY0gIg=;
	b=pLEL5A4Ew45dlLSZwz9ocS1AS6siJneQdv1msNOnhJV1tZRRkaBl/qD5Zt5wn+VVm75GI8
	cHpNwNu1ITJnfr1hATzKg5jKdaCY6x516pH1spSSSsQy4CoA1V1dnmA+RhOTPJ0/x3Z6GJ
	PoL0T3wuHGXM+JSAUBe6VB2i4PCMRkQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 25071134F7;
	Sun,  7 Apr 2024 01:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tJR6MmL0EWbyWQAAn2gu4w
	(envelope-from <wqu@suse.com>); Sun, 07 Apr 2024 01:18:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()
Date: Sun,  7 Apr 2024 10:48:05 +0930
Message-ID: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]

[BUG]
During my extent_map cleanup/refactor, with more than too strict sanity
checks, extent-map-tests::test_case_7() would crash my extent_map sanity
checks.

The problem is, after btrfs_drop_extent_map_range(), the resulted
extent_map has a @block_start way too large.
Meanwhile my btrfs_file_extent_item based members are returning a
correct @disk_bytenr along with correct @offset.

The extent map layout looks like this:

     0        16K    32K       48K
     | PINNED |      | Regular |

The regular em at [32K, 48K) also has 32K @block_start.

Then drop range [0, 36K), which should shrink the regular one to be
[36K, 48K).
However the @block_start is incorrect, we expect 32K + 4K, but got 52K.

[CAUSE]
Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
that covers the target range but is still beyond it, we need to split
that extent map into half:

	|<-- drop range -->|
		 |<----- existing extent_map --->|

And if the extent map is not compressed, we need to forward
extent_map::block_start by the difference between the end of drop range
and the extent map start.

However in that particular case, the difference is calculated using
(start + len - em->start).

The problem is @start can be modified if the drop range covers any
pinned extent.

This leads to wrong calculation, and would be caught by my later
extent_map sanity checks, which checks the em::block_start against
btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.

And unfortunately this is going to cause data corruption, as the
splitted em is pointing an incorrect location, can cause either
unexpected read error or wild writes.

[FIX]
Fix it by avoiding using @start completely, and use @end - em->start
instead, which @end is exclusive bytenr number.

And update the test case to verify the @block_start to prevent such
problem from happening.

CC: stable@vger.kernel.org # 6.7+
Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c             | 2 +-
 fs/btrfs/tests/extent-map-tests.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 471654cb65b0..955ce300e5a1 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -799,7 +799,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 					split->block_len = em->block_len;
 					split->orig_start = em->orig_start;
 				} else {
-					const u64 diff = start + len - em->start;
+					const u64 diff = end - em->start;
 
 					split->block_len = split->len;
 					split->block_start += diff;
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 253cce7ffecf..80e71c5cb7ab 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -818,7 +818,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 		test_err("em->len is %llu, expected 16K", em->len);
 		goto out;
 	}
-
 	free_extent_map(em);
 
 	read_lock(&em_tree->lock);
@@ -847,6 +846,11 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (em->block_start != SZ_32K + SZ_4K) {
+		test_err("em->block_start is %llu, expected 36K", em->block_start);
+		goto out;
+	}
+
 	free_extent_map(em);
 
 	read_lock(&em_tree->lock);
-- 
2.44.0


