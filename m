Return-Path: <linux-btrfs+bounces-20682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A49D39F3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 08:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F387330263F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27472D0C9C;
	Mon, 19 Jan 2026 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uWnrodQu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uWnrodQu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC0241C8C
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806104; cv=none; b=rUvjkbfnGeWBU70Njoc12MAaD8FtH3j1Yxw1LdFzNkOhY7NQKFzDQU2lIyMZPET9S5Z87CamPgbDUo7d91YaxAnnREKgGM69QvY+PywkeBwFiKN/QU8PyrJt1pjw1QOsaYbKlqNAXcLjXea/xy9e4AtVtTg6H35SOYgI1r5IwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806104; c=relaxed/simple;
	bh=ijgr8aof7oV2AI2gKDXDVt0ciMZ5rupJI31C3Vc/4u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3Sxvxlg3V9nYfsKJLjxosAS1ug6moCCasWMmZTSbddlE5b6mbSg/Uz3PPYqAqr3L7UCmyiMdNZ5HA/B5AKrTi4KNHSvZQHSNFMn/ydbAOl93TCdgLV1yXO2M87v6fUQIaaEDohbBDuFn3EGOQ5ANnTo+qZRZZxU4D30d5/AKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uWnrodQu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uWnrodQu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38133336A4;
	Mon, 19 Jan 2026 07:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768806100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yx1sVwO5GGeu4t+K4A6slKpQX94kRzgbaLQ7yNRmsh0=;
	b=uWnrodQu4mNlwV5mGshbfTKPO5XE9mk1F+N8k83+QNl3rqmj5ykH/0HXxmzf8zSQakY9ey
	k1hhSNIuIAGM4L8NdwOEGOvHVLKfG8bUmGhKGlb/srpt0PyloBxzMl65BtDvbinAZ1vsGG
	yiduXPTfSvxTJJxhpfCY7BERAvq32K0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uWnrodQu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768806100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yx1sVwO5GGeu4t+K4A6slKpQX94kRzgbaLQ7yNRmsh0=;
	b=uWnrodQu4mNlwV5mGshbfTKPO5XE9mk1F+N8k83+QNl3rqmj5ykH/0HXxmzf8zSQakY9ey
	k1hhSNIuIAGM4L8NdwOEGOvHVLKfG8bUmGhKGlb/srpt0PyloBxzMl65BtDvbinAZ1vsGG
	yiduXPTfSvxTJJxhpfCY7BERAvq32K0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 294123EA63;
	Mon, 19 Jan 2026 07:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DnnbMdHWbWlgQAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 19 Jan 2026 07:01:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v4] btrfs: do not strictly require dirty metadata threshold for metadata writepages
Date: Mon, 19 Jan 2026 17:31:19 +1030
Message-ID: <18474605a8d19f7a523733f8c461513c0d19a645.1768806045.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 38133336A4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

[BUG]
There is an internal report that over 1000 processes are
waiting at the io_schedule_timeout() of balance_dirty_pages(), causing
a system hang and triggered a kernel coredump.

The kernel is v6.4 kernel based, but the root problem still applies to
any upstream kernel before v6.18.

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

- Btrfs doesn't want to write back btree inode until more dirty pages

- Cgroup/MM doesn't want more dirty pages for btrfs btree inode
  Thus any process touching that btree inode is put into sleep until
  the number of dirty pages is reduced.

Thanks Jan Kara a lot for the analyze on the root cause.

[ENHANCEMENT]
Since kernel commit b55102826d7d ("btrfs: set AS_KERNEL_FILE on the
btree_inode"), btrfs btree inode pages will only be charged to the root
cgroup which should have a much larger limit than btrfs' 32MiB
threshold.
So it should not affect newer kernels.

But for all current LTS kernels, they are all affected by this problem,
and backporting the whole AS_KERNEL_FILE may not be a good idea.

Even for newer kernels I still think it's a good idea to get
rid of the internal threshold at btree_writepages(), since for most cases
cgroup/MM has a better view of full system memory usage than btrfs' fixed
threshold.

For internal callers using btrfs_btree_balance_dirty() since that
function is already doing internal threshold check, we don't need to
bother them.

But for external callers of btree_writepages(), just respect their
requests and just write back whatever they want, ignoring the internal
btrfs threshold to avoid such deadlock on btree inode dirty page
balancing.

Cc: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v4:
- Align the btree writeback function name to "btree_writepages"

v3:
- Update "[FIX]" section to "[ENHANCEMENT]"
  I totally forgot that the btree-skip-cgroup patchset is already merged,
  thus it's no longer possible to hit this problem on v6.18+ kernels.
  Although there is still some value to simplify the btree writeback
  behavior, the more important part is mostly for the LTS kernels.

- Add Cc to the stable list

v2:
- Update the commit message to include more details about the
  balance_dirty_pages() behavior

- With that background knowledge explain the deadlock better
  It's between cgroup where no more btree inode dirty pages are allowed
  and all involved processes are put into sleep until dirty pages
  drops, and btrfs where it won't write back any dirty pages until
  there are more dirty pages.
---
 fs/btrfs/disk-io.c   | 22 ----------------------
 fs/btrfs/extent_io.c |  3 +--
 fs/btrfs/extent_io.h |  3 +--
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5e4b7933ab20..764da96ac27e 100644
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
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bbc55873cb16..f804131b1c78 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2306,8 +2306,7 @@ void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start,
 	}
 }
 
-int btree_write_cache_pages(struct address_space *mapping,
-				   struct writeback_control *wbc)
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct btrfs_eb_write_context ctx = { .wbc = wbc };
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 02ebb2f238af..73571d5d3d5a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -237,8 +237,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty);
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
-int btree_write_cache_pages(struct address_space *mapping,
-			    struct writeback_control *wbc);
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
-- 
2.52.0


