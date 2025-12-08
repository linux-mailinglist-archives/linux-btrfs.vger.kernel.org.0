Return-Path: <linux-btrfs+bounces-19585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFACAE386
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 22:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF1B304FFD1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB732DF6E3;
	Mon,  8 Dec 2025 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lA9wo3Vr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QWkq/pCq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49128281341
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229128; cv=none; b=R38YwwjE0vF61AwsKN8HjMhq6MxqKqCxdP2/kXhi1j6Op9pvtLoTXuc5bzA6+OeTdtFilcwMg/Feg6B+mSZAPmP6D+oushxWyx2ss96P6KZyUeLCvyPWzrMuSzYAaPvmQQ2ZO8EdB8eB2PwWo0sSw6ZjWgXurG5fXOmngzGA1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229128; c=relaxed/simple;
	bh=dSA0gLmS7AiaVDJAT1S5AQSqPCj8VcBI0KkOWHjP9d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlRup0yqEh2zjRzTxja1a0Nd4PYo/VKoNXAiLz+QvRJf1bz0TH4kMpymQnLakY4dwZBLpA0JqZLqskXgyYglCwvehXPEjARiPF1KkXPtXkRXxU4iHRCWVwEtYai9ujqlEqo0wtBIIzTDZ3MqGKK+7FAfEVFW1XVomiem9j9qPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lA9wo3Vr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QWkq/pCq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCF193374E;
	Mon,  8 Dec 2025 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765229123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nqZ3DIC5wBi3uYCLIdg3qeNam+tgeoDBygarTf/OWhE=;
	b=lA9wo3VrvzdM937GXE8UqLQ2rmFoi/4ugL5gMNypJZyyB6eqdEX9ZAZHEi1O/jKKBufIzZ
	glAXSSs5yNgfnAnmk9Ak5doUoHRHMwCOQB5+7vvhnZrxRewnHKXyDx+RDHyBw/wbH0ZENL
	6p2KWFWbM4nvgnT86tLyJ08zb/PVhl0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="QWkq/pCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765229121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nqZ3DIC5wBi3uYCLIdg3qeNam+tgeoDBygarTf/OWhE=;
	b=QWkq/pCqsht+/ceSJ+OJjXGKaaCzVICj46D+CD0naaXgceRHSU/spvtN22m0xCQJRWz9wn
	lJix7gZJ7u4BEM+aAIy1o3I+D03KAKFgE/dlTCRuKIiNTSF1E0m8WV4dTfPS8Fh/Ty1o+S
	VJZYiSCad16PjrvXEi87ZtQL4C/EJqk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1B43EA63;
	Mon,  8 Dec 2025 21:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xig/IkBCN2kbNQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 08 Dec 2025 21:25:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: shrink the size of btrfs_bio
Date: Tue,  9 Dec 2025 07:55:03 +1030
Message-ID: <0f25d1779166876e3bd4c1509d8eaf67968a6f65.1765229068.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: CCF193374E
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

This is done by:

- Shrink the size of btrfs_bio::mirror_num
  From 32 bits unsigned int to u16.

  Normally btrfs mirror number is either 0 (all profiles), 1 (all
  profiles), 2 (DUP/RAID1/RAID10/RAID5), 3 (RAID1C3) or 4 (RAID1C4).

  But for RAID6 the mirror number can go as large as the number of
  devices of that chunk.

  Currently the limit for number of devices for a data chunk is
  BTRFS_MAX_DEVS(), which is around 500 for the default 16K nodesize.
  And if going the max 64K nodesize, we can have a little over 2000
  devices for a chunk.

  Although I'd argue it's way overkilled, we don't reject such cases yet
  thus u8 is not going to cut it, and have to use u16 (max out at 64K).

- Use bit fields for boolean members
  Although it's not always safe for racy call sites, those members are
  safe.

  * csum_search_commit_root
  * is_scrub
    Those two are set immediately after bbio allocation and no more
    writes after allocation, thus they are very safe.

  * async_csum
  * can_use_append
    Those two are set for each split range, and after that there is no
    writes into those two members in different threads, thus they are
    also safe.

  And there are spaces for 4 more bits before increasing the size of
  btrfs_bio again, which should be future proof enough.

- Reorder the structure members
  Now we always put the largest member first (after the huge 120 bytes
  union), making it easier to fill any holes.

This reduce the size of btrfs_bio by 8 bytes, from 312 bytes to 304 bytes.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Change mirror number from u8 to u16
  As for RAID6 we can have cases (that's beyond 255 devices in a RAID6
  chunk) where u8 is not large enough.
  Thankfully u16 is large enough for the max number of devices possible
  for a RAID6 chunk.

  And we have exactly a one-byte hole the in structure, and expanding
  the widith of @mirror_num will not increase the size of btrfs_bio.
---
 fs/btrfs/bio.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 246c7519dff3..157cdfa2f78a 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -68,32 +68,33 @@ struct btrfs_bio {
 		struct btrfs_tree_parent_check parent_check;
 	};
 
+	/* For internal use in read end I/O handling */
+	struct work_struct end_io_work;
+
 	/* End I/O information supplied to btrfs_bio_alloc */
 	btrfs_bio_end_io_t end_io;
 	void *private;
 
-	/* For internal use in read end I/O handling */
-	unsigned int mirror_num;
 	atomic_t pending_ios;
-	struct work_struct end_io_work;
+	u16 mirror_num;
 
 	/* Save the first error status of split bio. */
 	blk_status_t status;
 
 	/* Use the commit root to look up csums (data read bio only). */
-	bool csum_search_commit_root;
+	bool csum_search_commit_root:1;
 
 	/*
 	 * Since scrub will reuse btree inode, we need this flag to distinguish
 	 * scrub bios.
 	 */
-	bool is_scrub;
+	bool is_scrub:1;
 
 	/* Whether the csum generation for data write is async. */
-	bool async_csum;
+	bool async_csum:1;
 
 	/* Whether the bio is written using zone append. */
-	bool can_use_append;
+	bool can_use_append:1;
 
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
-- 
2.52.0


