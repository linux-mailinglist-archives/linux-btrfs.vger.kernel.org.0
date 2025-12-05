Return-Path: <linux-btrfs+bounces-19541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C1CA6FBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 10:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3A1C38FFD25
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A0D34A3B0;
	Fri,  5 Dec 2025 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UfndRgyG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UfndRgyG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08333F382
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921910; cv=none; b=I8ve+sjMpu7db5iySqEesKHewj7wmUtDvWbG4gGG8S1etCNk/+NbsVpJZ1+Y5HyOrdg9VrkvBG2FDs8qSKfNF+5g5dmHUImlsPkulwhFQVnL6OsEaRryCRSuYxR/ZpgpsXYymSlR6oO1tDvBCgEKgArmFxIfHNKXf5W5UtnEci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921910; c=relaxed/simple;
	bh=UIXPgAFFJPBSWougEyBCn2iso/13+uYg5+3EBb9s/88=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N1o4DZdX2EWQnD/bgtx5RIT1Az/LhRiihReP4gU9kse2XrglG9ftdXLmDHdW0SGVfh4GrsdVbtQje/ZECZaFg+SApslaPw2HdMai6x25kKpilDykN9udMugH0IZZsUyZpJPEn/JsOogYRVQ5iwCAGqbNmnrLjfHz8UW2KSJa2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UfndRgyG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UfndRgyG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04F92336CA
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764921889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8enQroTOsCz6L5bgljmVML2rSo1rUR9c0JK5kYDyFDQ=;
	b=UfndRgyGJDLi3lt8mWkye890rWRw2UOcW6F77zOvQLw0GwQLSblRDknPsM+2sIgwKfDkk1
	ko8urM543kjX3JcLAuF/4PP7W5eIfZueKDQ7OChX1S+EpyRq9INjRmB9sTXOf16/RwSl1Q
	5MBKSjkVCY4LxPgs7K5U7afHDbWKZrQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UfndRgyG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764921889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8enQroTOsCz6L5bgljmVML2rSo1rUR9c0JK5kYDyFDQ=;
	b=UfndRgyGJDLi3lt8mWkye890rWRw2UOcW6F77zOvQLw0GwQLSblRDknPsM+2sIgwKfDkk1
	ko8urM543kjX3JcLAuF/4PP7W5eIfZueKDQ7OChX1S+EpyRq9INjRmB9sTXOf16/RwSl1Q
	5MBKSjkVCY4LxPgs7K5U7afHDbWKZrQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34FDE3EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 08:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eP4NOh+SMmlfIwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Dec 2025 08:04:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: shrink the size of btrfs_bio
Date: Fri,  5 Dec 2025 18:34:30 +1030
Message-ID: <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 04F92336CA
X-Spam-Flag: NO
X-Spam-Score: -4.01

This is done by:

- Shrink the size of btrfs_bio::mirror_num
  From 32 bits unsigned int to 8 bits u8.

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

  And there are spaces for 12 more bits before increasing the size of
  btrfs_bio again, which should be very future proof.

- Reorder the structure members
  Now we always put the largest member first (after the huge 120 bytes
  union), making it easier to fill any holes.

This reduce the size of btrfs_bio by 8 bytes, from 312 bytes to 304 bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index d6da9ed08bfa..33179b45045c 100644
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
 
 	/* Save the first error status of split bio. */
 	blk_status_t status;
+	u8 mirror_num;
 
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


