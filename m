Return-Path: <linux-btrfs+bounces-20526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A300DD2264C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 05:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 918D7300647C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 04:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45752D238A;
	Thu, 15 Jan 2026 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prsLRgTE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prsLRgTE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2426ED25
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768452832; cv=none; b=Y92/b67OTqWfz9spDkK0Uapm9leA2tdHOPkxFn3A8SDFzK0OASkjoLv+rogdJwKGaiWnJP8Q22OAphqrjOyYudQ8gnWDCf+4XAgPrOmIudySzPilIsGibTGCxdcqt05u6xVUHZH/rF4kidFqU5p9kEhHXXAVmtgrK/L3yBHp1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768452832; c=relaxed/simple;
	bh=iNFocSChxadB4SQTZjqtD10wY5kiJKB7lbUd4VVmrMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsTuF81eTfGMRwj5UyuX4NOy7IfKbUx6IA3EsxdmnDDfEu+/ASeCvqhdRbCowxEzgBRxJ7DL0iyCI5JFm5Tuh8tQQT+R48ph5lF9MVZ7EL168EreLx22Cu3OM0gm7d0VYYvMZN72keFM1ToiSdaxc71gkQVkQd9eMSAiw6VPgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prsLRgTE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prsLRgTE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D7E233683;
	Thu, 15 Jan 2026 04:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768452828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNlYlE3DUsElDdf9nxN6He6XEY+XP6+QkYL02z51rB0=;
	b=prsLRgTE1We5trjJQS1Dt+JHTD+lXrJSlODvdSxzrf3XPi28eVSXwiMug9M4CZYQlsODCi
	/cy87d31oFclAgcLtCHUfnyyiyoF4GHsCUDEk9kHL5nAUb83ytjg8D2wqc6uf9e4knY3P2
	hWPWLDx5nE8p7k5ndQVEPsBccVC91nI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768452828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNlYlE3DUsElDdf9nxN6He6XEY+XP6+QkYL02z51rB0=;
	b=prsLRgTE1We5trjJQS1Dt+JHTD+lXrJSlODvdSxzrf3XPi28eVSXwiMug9M4CZYQlsODCi
	/cy87d31oFclAgcLtCHUfnyyiyoF4GHsCUDEk9kHL5nAUb83ytjg8D2wqc6uf9e4knY3P2
	hWPWLDx5nE8p7k5ndQVEPsBccVC91nI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8420F3EA63;
	Thu, 15 Jan 2026 04:53:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XC3rEdtyaGmkLwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 15 Jan 2026 04:53:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH] btrfs: do not strictly require dirty metadata threshold for metadata writepages
Date: Thu, 15 Jan 2026 15:23:44 +1030
Message-ID: <ccfd051d2ae173d95f3f6e75b7466efbf4596620.1768452808.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO

[BUG]
There is an internal report that btrfs hits a hang at
balance_dirty_pages() for btree inode.

[CAUSE]
balance_dirty_pages() can be triggered by both internal calls like
btrfs_btree_balance_dirty() and external callers like mm or cgroup.

For internal calls, btrfs_btree_balance_dirty() calls
__btrfs_btree_balance_dirty() which will check if the current dirty
metadata reaches a certain threshold (32M), and if not we just skip the
workload.

For external calls they can directly call btree_writepages(), which
is doing a similar check against the threshold, and skip the writeback
again if it's not reaching the same 32M threshold.

But the threshold is only internal to btrfs, if cgroup or mm chose to
balance dirty pages for the metadata inode at a much lower threshold, in
this case the dirty pages count is around 28M, lower than btrfs'
internal threshold.

This causes all writeback request to be ignored, and no dirty pages for
btrfs btree inode can be balanced, resulting hang for all
balance_dirty_pages() callers.

Thanks Jan Kara a lot for the analyze on the root cause.

[FIX]
For internal callers using btrfs_btree_balance_dirty() since that
function is already doing internal threshold check, we don't need to
bother it.

But for external callers of btree_writepages(), then respect their
request and just writeback whatever they want, ignoring the internal
btrfs threshold to avoid such deadlock on btree inode dirty page
balancing.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5e4b7933ab20..9add1f287635 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -485,28 +485,6 @@ static int btree_migrate_folio(struct address_space *mapping,
 #define btree_migrate_folio NULL
 #endif
 
-static int btree_writepages(struct address_space *mapping,
-			    struct writeback_control *wbc)
-{
-	int ret;
-
-	if (wbc->sync_mode == WB_SYNC_NONE) {
-		struct btrfs_fs_info *fs_info;
-
-		if (wbc->for_kupdate)
-			return 0;
-
-		fs_info = inode_to_fs_info(mapping->host);
-		/* this is a bit racy, but that's ok */
-		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
-					     BTRFS_DIRTY_METADATA_THRESH,
-					     fs_info->dirty_metadata_batch);
-		if (ret < 0)
-			return 0;
-	}
-	return btree_write_cache_pages(mapping, wbc);
-}
-
 static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (folio_test_writeback(folio) || folio_test_dirty(folio))
@@ -584,7 +562,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 #endif
 
 static const struct address_space_operations btree_aops = {
-	.writepages	= btree_writepages,
+	.writepages	= btree_write_cache_pages,
 	.release_folio	= btree_release_folio,
 	.invalidate_folio = btree_invalidate_folio,
 	.migrate_folio	= btree_migrate_folio,
-- 
2.52.0


