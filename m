Return-Path: <linux-btrfs+bounces-4051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C26989D78C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 13:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC81F25064
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B898565E;
	Tue,  9 Apr 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sefPRXwB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sefPRXwB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176F7C0B0;
	Tue,  9 Apr 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660577; cv=none; b=sTAWdoc0S9eG9YyXIwz7XiqknpLsHOAve5Aes8/KtljTLUFAuf8M8HT5tBfYiY9NYA7Co9l0L8UVyWZ+OAudt0LaU2daisNpY6TCHdGhBW820T5URbVnPM27IUDVKhXz8KCz91O/MUxP9BU7lPKD4yKi8i2Qw4tz9Q2vTseuoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660577; c=relaxed/simple;
	bh=pYyuJ9ISMWsuY+oEZ/aX4xJmk9+Fpawxw2k2/RaUYfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EU2xqSg+fB+M/0JVzQcopfqOlTpE0rfCNER9Uy0dZAS0r+tLhBRRVHomFCtkXTH6KFpiWan4IH1JTKRA+HArhDQ9lsKfgGR3fwv2I46HX8y/daF5mCwLowV3iyaD4AW1PCY4Bia1VQr0hziOEda6uJdAdihqCdz22fUItp96Soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sefPRXwB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sefPRXwB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1749F2094B;
	Tue,  9 Apr 2024 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712660574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+soQub59ruqI3xbzBPsOOqvCkHX2sSGQ4UJI06UDKY=;
	b=sefPRXwBub57fyY5WpRLQmAVae+xMzuPKjETDSIGiGuYBPuYqAagyL+h0HaeNcheO4Wtnc
	1TYkGckIOjwlELeA0sAlaa6MlY8hiPMk0dlDX50SzuW97A6sypGzJhBSZ4mEr5LARufgDw
	YlUNmX8xnsK10VJ11oJbvuFqvNyqtD8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712660574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+soQub59ruqI3xbzBPsOOqvCkHX2sSGQ4UJI06UDKY=;
	b=sefPRXwBub57fyY5WpRLQmAVae+xMzuPKjETDSIGiGuYBPuYqAagyL+h0HaeNcheO4Wtnc
	1TYkGckIOjwlELeA0sAlaa6MlY8hiPMk0dlDX50SzuW97A6sypGzJhBSZ4mEr5LARufgDw
	YlUNmX8xnsK10VJ11oJbvuFqvNyqtD8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 80F761332F;
	Tue,  9 Apr 2024 11:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dep1DVwgFWYoWwAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 09 Apr 2024 11:02:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3] btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()
Date: Tue,  9 Apr 2024 20:32:34 +0930
Message-ID: <2975263064f93759a96eb36e5795b9f3cc2ce423.1712660483.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove the mention of possible corruption
  Thankfully this bug does not affect IO path thus it's fine.

- Explain why c962098ca4af is the cause

v3:
- Fix an accidental removal of a newline
---
 fs/btrfs/extent_map.c             | 2 +-
 fs/btrfs/tests/extent-map-tests.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index 253cce7ffecf..47b5d301038e 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -847,6 +847,11 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
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


