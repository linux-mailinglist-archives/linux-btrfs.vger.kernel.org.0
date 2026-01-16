Return-Path: <linux-btrfs+bounces-20646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A847D389C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 00:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD538303E284
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72268315D26;
	Fri, 16 Jan 2026 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i6FPc9DO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i6FPc9DO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E4B665
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768605775; cv=none; b=IrUxL2WuNe5VQqUuBe9vscC3fyf9dsi+bTX6bTzDvz3UtrNtN9tHuHrmWlKOAzmc5wH90blxEdRC+X3kf30T1lqycFoFrbU5EPNQIVpnH6AjAq4JmGzPaeaA1OL+lNQO2+n3LD4gghVKrl3n4TgDZ7jC4aw1VhXDG/a0svw3Jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768605775; c=relaxed/simple;
	bh=YGNeFHuPDnRjqP439LUHEeUFN7z27OzTMzdCYLYCWYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEifWSD7GzwfCOfnc12WeAhFFqKw0ON3W8OPy8p8/oAxzg9pTIXosTMllH61kd37UznoTf4a9FQDIvmY1lfm3+GEqsao5YvOGbRfeUX1NuDX76cHyhIa4Gx9t/QPGhiXzDRHepgYV6Ab5d2RyuC2jDuUnU/uqDkDUyZZzW4QMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i6FPc9DO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i6FPc9DO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ECE933699;
	Fri, 16 Jan 2026 23:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768605772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IxFZwCGpDn0a72Q/lF66OrWrpA/LJFb/gHfsuXGnNBg=;
	b=i6FPc9DOgXJmxarncExvCczC0V3SI0AXCaGacZRT5KF4bYQOt62K0R9IdrZ7ROjeMcpnf6
	FMJ4V3En+AlwI6x5g7kQRZTO+j1M4NpV8FprDA5K1gUiPAa382ochFGGPsmtS4fEuOhU1s
	MYuGpixuJdrRKr86gadbRmiNtlWWtw4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=i6FPc9DO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768605772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IxFZwCGpDn0a72Q/lF66OrWrpA/LJFb/gHfsuXGnNBg=;
	b=i6FPc9DOgXJmxarncExvCczC0V3SI0AXCaGacZRT5KF4bYQOt62K0R9IdrZ7ROjeMcpnf6
	FMJ4V3En+AlwI6x5g7kQRZTO+j1M4NpV8FprDA5K1gUiPAa382ochFGGPsmtS4fEuOhU1s
	MYuGpixuJdrRKr86gadbRmiNtlWWtw4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 652AA3EA63;
	Fri, 16 Jan 2026 23:22:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JY/QBErIamkPbQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 16 Jan 2026 23:22:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs: do not strictly require dirty metadata threshold for metadata writepages
Date: Sat, 17 Jan 2026 09:52:31 +1030
Message-ID: <6a6b5f2bb0d3cbcdd0d3dc6ee46c3ebfc4ce63af.1768605742.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1ECE933699
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

[BUG]
There is an internal report that over 1000 processes are
waiting at the io_schedule_timeout() of balance_dirty_pages(), causing
a system hang and triggered a kernel coredump.

[CAUSE]
From Jan Kara for his wisdom on the dirty page balance behavior first.

 This cgroup dirty limit was what was actually playing the role here
 because the cgroup had only a small amount of memory and so the dirty
 limit for it was something like 16MB.

 Dirty throttling is responsible for enforcing that nobody can dirty
 (significantly) more dirty memory than there's dirty limit. Thus when
 a task is dirtying pages it periodically enters into balance_dirty_pages()
 and we let it sleep there to slow down the dirtying.

 When the system is over dirty limit already (either globally or within
 a cgroup of the running task), we will not let the task exit from
 balance_dirty_pages() until the number of dirty pages drops below the
 limit.

 So in this particular case, as I already mentioned, there was a cgroup
 with relatively small amount of memory and as a result with dirty limit
 set at 16MB. A task from that cgroup has dirtied about 28MB worth of
 pages in btrfs btree inode and these were practically the only dirty
 pages in that cgroup.

So that means the only way to reduce the dirty pages of that cgroup is
to writeback the dirty pages of btrfs btree inode, and only after that
those processes can exit balance_dirty_pages().

Now back to the btrfs part, btree_writepages() is responsible for
writing back dirty btree inode pages.

The problem here is, there is a btrfs internal threshold that if the
btree inode's dirty bytes are below the 32M threshold, it will not
do any writeback.

This behavior is to batch as much metadata as possible so we won't write
back those tree blocks and then later re-COW then again for another
modification.

This internal 32MiB is higher than the existing dirty page size (28MiB),
meaning no writeback will happen, causing a deadlock between btrfs and
cgroup:

- Btrfs doesn't want writeback btree inode until more dirty pages

- Cgroup/MM doesn't want more dirty pages for btrfs btree inode
  Thus any process touching that btree inode is put into sleep until
  the number of dirty pages is reduced.

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
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Update the commit message to include more details about the
  balance_dirty_pages() behavior

- With that background knowledge explain the deadlock better
  It's between cgroup where no more btree inode dirty pages are allowed
  and all involved processes are put into sleep until dirty pages
  drops, and btrfs where it won't write back any dirty pages until
  there are more dirty pages.
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


