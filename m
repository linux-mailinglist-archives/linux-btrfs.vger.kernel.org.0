Return-Path: <linux-btrfs+bounces-12786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857ECA7B5A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 03:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3571189A024
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63C42077;
	Fri,  4 Apr 2025 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uZkUyp88";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uZkUyp88"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F079D0
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743731288; cv=none; b=q+7rhTMtme21LUkzoD49FxgqQGhwuWAWOIkr8RtSqQeWa2ROH047bLm5ReqpFeVdha0K+sqfQnjB8qQNss9k68scSKbiOrGU07KOaX2orGqpddrupZCZSqZuN9J+xpw6pTrhlMYuK1O0UCRXdNrrUHUmpl19bMBIJQcPikp23tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743731288; c=relaxed/simple;
	bh=7AKgjl9lpYwTAfMIYsYrpCqznIFnoiJPfwSpoU4cQC0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dslmj40yjccdl94GWgVhpbv+9PbC+unFRXAd28KvyxeHPICiBUecyxMD50VHAjY61qE59l5gjmF8TJl36mUYCTu3qiHBJVpOiSQ8NRATP4Qp1ffQO4mwfHrE+nYbu0BfLIKA0DP1ZvsJ12bzLyzRsI2v1vwwD1LJ2nc2cnI14Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uZkUyp88; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uZkUyp88; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3A4E1F387
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xvToc+0scTpjmbCcTjtRgS5DN5JVjv7MxxdFFB56ko=;
	b=uZkUyp88FLv0q9P/G4C9mfS9GYpmL61Pgq01GvL1wvSZfeB3W7MjCVzJKaR3B+o10YCoX8
	YK/UagjQDNHXZ/Z7Y1gTnLhtaWC8ViYRSU3Fb0doYRAX3+laO2l+uTRHgS/pyO6sOzhf6P
	TUjYi4j2lQAL4x6KNRSsysxI/B+JGWU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xvToc+0scTpjmbCcTjtRgS5DN5JVjv7MxxdFFB56ko=;
	b=uZkUyp88FLv0q9P/G4C9mfS9GYpmL61Pgq01GvL1wvSZfeB3W7MjCVzJKaR3B+o10YCoX8
	YK/UagjQDNHXZ/Z7Y1gTnLhtaWC8ViYRSU3Fb0doYRAX3+laO2l+uTRHgS/pyO6sOzhf6P
	TUjYi4j2lQAL4x6KNRSsysxI/B+JGWU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7A7C134C7
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CDZcKVI672dIDwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 01:48:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use folio_contains() for EOF detection
Date: Fri,  4 Apr 2025 12:17:41 +1030
Message-ID: <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743731232.git.wqu@suse.com>
References: <cover.1743731232.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently we use the following pattern to detect if the folio contains
the end of a file:

	if (folio->index == end_index)
		folio_zero_range();

But that only works if the folio is page sized.

For the following case, it will not work and leave the range beyond EOF
uninitialized:

  The page size is 4K, and the fs block size is also 4K.

	16K        20K       24K
        |          |     |   |
	                 |
                         EOF at 22K

And we have a large folio sized 8K at file offset 16K.

In that case, the old "folio->index == end_index" will not work, thus
we the range [22K, 24K) will not be zeroed out.

Fix the following call sites which use the above pattern:

- add_ra_bio_pages()

- extent_writepage()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 +-
 fs/btrfs/extent_io.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index cb954f9bc332..7aa63681f92a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -523,7 +523,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		free_extent_map(em);
 		unlock_extent(tree, cur, page_end, NULL);
 
-		if (folio->index == end_index) {
+		if (folio_contains(folio, end_index)) {
 			size_t zero_offset = offset_in_folio(folio, isize);
 
 			if (zero_offset) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 013268f70621..f0d51f6ed951 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -221,7 +221,7 @@ static void __process_folios_contig(struct address_space *mapping,
 }
 
 static noinline void unlock_delalloc_folio(const struct inode *inode,
-					   const struct folio *locked_folio,
+					   struct folio *locked_folio,
 					   u64 start, u64 end)
 {
 	ASSERT(locked_folio);
@@ -231,7 +231,7 @@ static noinline void unlock_delalloc_folio(const struct inode *inode,
 }
 
 static noinline int lock_delalloc_folios(struct inode *inode,
-					 const struct folio *locked_folio,
+					 struct folio *locked_folio,
 					 u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -1711,7 +1711,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 		return 0;
 	}
 
-	if (folio->index == end_index)
+	if (folio_contains(folio, end_index))
 		folio_zero_range(folio, pg_offset, folio_size(folio) - pg_offset);
 
 	/*
-- 
2.49.0


