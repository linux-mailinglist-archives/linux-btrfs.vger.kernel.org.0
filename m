Return-Path: <linux-btrfs+bounces-20659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C54DDD392E8
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 06:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB0C3019B93
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 05:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0117B425;
	Sun, 18 Jan 2026 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="thJiEHiY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="thJiEHiY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A726500962
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768714238; cv=none; b=gJdMoMAnVBTAvWYznMjkdFqKsTmDRZDjDlpsJIFv+pai8lC6cXtGm0LjH48/VTQqZU7AeA4437ZJGsMCsGK0hYy4GGoNru2ZYSyTYwHzut9i+/XUaTDFMhcwOYqxk8NAHg4t/a4K5PG0KAfsXz+V6G9/NzH1L9sTuWifnlqLstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768714238; c=relaxed/simple;
	bh=jqpeOeKVkE4HkVdqVXNBjSYRejZDcCIgeUt/BlQEPiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNxNvfbjSWMwpMcjICfVb9od9VYcJPr+xl7oyS7/unKCkqehSAHNcCK6wmegfDst9LV4dUFP2qXcbNuDuSDCGpezrKlcbwbkgP7wN5VuVun/0HTs4jmIaTNOL6I3OK+c/wVRdObrj0l3BDIzzJ1bDq7GIncvu6c/6rTx/cQB9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=thJiEHiY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=thJiEHiY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FD805BCC4
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov2S0b3a9YnLjXLhZqLitzoywBCJDZPuUYiVIU2/p04=;
	b=thJiEHiYljCD4FzsukdrZQgygWcmqYOwi3uzGwTZBF/iqQ0ZrerJfp+JYj9YSjkMp+hqZn
	hQwH3By09ATopXUOHolCDUMWfaXSonBdcbPjRKanNrij213bcBSqbO0aeHzrn/HwQ4qyPA
	NK7p4T0MyRU7yj73GLVqh9VzV2jstBI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov2S0b3a9YnLjXLhZqLitzoywBCJDZPuUYiVIU2/p04=;
	b=thJiEHiYljCD4FzsukdrZQgygWcmqYOwi3uzGwTZBF/iqQ0ZrerJfp+JYj9YSjkMp+hqZn
	hQwH3By09ATopXUOHolCDUMWfaXSonBdcbPjRKanNrij213bcBSqbO0aeHzrn/HwQ4qyPA
	NK7p4T0MyRU7yj73GLVqh9VzV2jstBI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32C123EA63
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGG+NPFvbGnScQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: tests: prepare extent map tests for strict alignment checks
Date: Sun, 18 Jan 2026 15:59:59 +1030
Message-ID: <81ea002b4dd0a522b41fd9f9fd2bec5ef97d515c.1768714131.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768714131.git.wqu@suse.com>
References: <cover.1768714131.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Currently the extent map self tests have the following points that will
cause false alerts for the incoming strict extent map alignment checks:

- Inlined extents have their sized smaller than block size
  Which is not following what the kernel is doing for inlined extents,
  as btrfs_extent_item_to_extent_map() always uses the fs block size as
  the length, not the ram_bytes.

  Fix it by using SZ_4K as extent map's length.

- btrfs_fs_info::sectorsize is not properly initialized
  As we always use PAGE_SIZE, which can be values larger than 4K.
  And all the immediate numbers used in the test case is based on 4K
  fs block size.

  Fix it by using fixed SZ_4K fs block size when allocating the dummy
  btrfs_fs_info.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index aabf825e8d7b..811f36d41101 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -173,9 +173,12 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		return -ENOMEM;
 	}
 
-	/* Add [0, 1K) */
+	/*
+	 * Add [0, 1K) which is inlined. And the extent map length must
+	 * be one block.
+	 */
 	em->start = 0;
-	em->len = SZ_1K;
+	em->len = SZ_4K;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -219,7 +222,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	/* Add [0, 1K) */
 	em->start = 0;
-	em->len = SZ_1K;
+	em->len = SZ_4K;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -235,7 +238,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		ret = -ENOENT;
 		goto out;
 	}
-	if (em->start != 0 || btrfs_extent_map_end(em) != SZ_1K ||
+	if (em->start != 0 || btrfs_extent_map_end(em) != SZ_4K ||
 	    em->disk_bytenr != EXTENT_MAP_INLINE) {
 		test_err(
 "case2 [0 1K]: ret %d return a wrong em (start %llu len %llu disk_bytenr %llu",
@@ -1131,8 +1134,11 @@ int btrfs_test_extent_map(void)
 	/*
 	 * Note: the fs_info is not set up completely, we only need
 	 * fs_info::fsid for the tracepoint.
+	 *
+	 * And all the immediate numbers are based on 4K blocksize,
+	 * thus we have to use 4K as sectorsize no matter the page size.
 	 */
-	fs_info = btrfs_alloc_dummy_fs_info(PAGE_SIZE, PAGE_SIZE);
+	fs_info = btrfs_alloc_dummy_fs_info(SZ_4K, SZ_4K);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
-- 
2.52.0


