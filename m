Return-Path: <linux-btrfs+bounces-4038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AD89CF2B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 02:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156131F233EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE550376;
	Tue,  9 Apr 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WNV5wAyG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WNV5wAyG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1A370;
	Tue,  9 Apr 2024 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621181; cv=none; b=Dqd//k9UKJRcJZMGKrxey765oHAb/2MG6DUJRZQc+Fup2hQe9QY87NGhw8SjA5freYHTsWBjziRh78VBI7Zvpscw9YUTeds89PUcyHzwUz/fxMTWi0MjyjrxkFksnt61ylJleLa/JF8Sx7Yn2cvU83j7eVUGRM+gj7gN1UQYfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621181; c=relaxed/simple;
	bh=y27PhrCaVviptffe0v4Ndes0B1MlEF2u32PvBAqdJwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQWmwQjnxgOPXVfSPP+nCFvGOxPRl6+ykGLajg46YRu2jsTgtP8rnkQ13lQpwUPSJub/h7iEo/40HR4u8IRW3p/5zINesMGuLNI/5qSC8eNXTxlicSkZUcbgDNDq0ASN+oPPdgQc3jbuWMW1VG33f87I64/DfNOViwHA98URBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WNV5wAyG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WNV5wAyG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F31AE20666;
	Tue,  9 Apr 2024 00:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712621177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGpvuEssG0+e8y0f5Ti0Sl29gMmDI+6BYc8lFPvzKJ0=;
	b=WNV5wAyGQcd/Pv4L8Ti0olwsPqpZbB3OAiKwe5Nu5VzKPbSg3tPULzOqxRH6/6HPnwWeg9
	SjpiCXf2VbE65N02YEwphlQtoPfPa+Mn+JP59ikWnXrlh5gP5z8iH0EeRxF99w93SKqDJ5
	j8WAa3usqxPvc2mqGlpkTLmOn3ALfto=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WNV5wAyG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712621177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGpvuEssG0+e8y0f5Ti0Sl29gMmDI+6BYc8lFPvzKJ0=;
	b=WNV5wAyGQcd/Pv4L8Ti0olwsPqpZbB3OAiKwe5Nu5VzKPbSg3tPULzOqxRH6/6HPnwWeg9
	SjpiCXf2VbE65N02YEwphlQtoPfPa+Mn+JP59ikWnXrlh5gP5z8iH0EeRxF99w93SKqDJ5
	j8WAa3usqxPvc2mqGlpkTLmOn3ALfto=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AE4141376F;
	Tue,  9 Apr 2024 00:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LP7CFXeGFGZ8XQAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 09 Apr 2024 00:06:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()
Date: Tue,  9 Apr 2024 09:36:12 +0930
Message-ID: <f6e36de0cc45247c30c645764f3ffe4f6a487007.1712621026.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F31AE20666
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

[BUG]
During my extent_map cleanup/refactor, with extra sanity checks,
extent-map-tests::test_case_7() would not pass the checks.

The problem is, after btrfs_drop_extent_map_range(), the resulted
extent_map has a @block_start way too large.
Meanwhile my btrfs_file_extent_item based members are returning a
correct @disk_bytenr/@offset combination.

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

This is a regression caused by commit c962098ca4af ("btrfs: fix
incorrect splitting in btrfs_drop_extent_map_range"), which removed the
@len update for pinned extents.

[FIX]
Fix it by avoiding using @start completely, and use @end - em->start
instead, which @end is exclusive bytenr number.

And update the test case to verify the @block_start to prevent such
problem from happening.

Thankfully this is not going to lead to any data corruption, as IO path
does not utilize btrfs_drop_extent_map_range() with @skip_pinned set.

So this fix is only here for the sake of consistency/correctness.

CC: stable@vger.kernel.org # 6.5+
Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove the mention of possible corruption
  Thankfully this bug does not affect IO path thus it's fine.

- Explain why c962098ca4af is the cause
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


