Return-Path: <linux-btrfs+bounces-18179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248BC00424
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 632AB340530
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55313308F3A;
	Thu, 23 Oct 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gsrrqOcF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gVtByQAA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AA308F15
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211970; cv=none; b=MudQFxAyS6dVxbkyuWftGblGtBmLzSejWlUbfoGQyTcCQf65D84kfjix8MU97YLDRlAUvwNYWOeAONGlMBanFgkIYJeh9sRsXCEOGn4ASZJV9eaH2mZZ6yY/wNXspvVBWpsLkVWBM6K1qKFhUugVKiO2L8v+VaEUcZz0mWgpQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211970; c=relaxed/simple;
	bh=Ky/VSEqGAXAkEnvNEK2NHD/qhCfcygP/YgzBCHIs/CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuMT2kE7BVT7sMHbkEIdJidVcilH4+/CInyNwBPXpLOKbdSBQ8d1pbqdGSixk8tXz6ICt+cvpKVdCCp06GioZGZbHOAe7n1DQic4octsXIPRedIJPvhZe3LaRQ6BiTXsP7OKglnB7Y3VOBAT+ksX7yuBQho34Cw2m1hMhGxS69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gsrrqOcF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gVtByQAA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D638E1F388;
	Thu, 23 Oct 2025 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761211962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NPIvLe7IJwosnpvn0Us2PzDRMFbCqY83mlv0mt7RMt4=;
	b=gsrrqOcFGMI+DXaSTvtY5E/zjjsMBxxXKhDy28jn7eSMdWpNG9S6CkU3gD2aiTDx6izsKe
	RtxmBbEwur1CSAKwoKTUKwFRPlxDl0g5fp5c6JAGeL2CTnxpODt1STAdj6qAe4YDeHpESb
	bpKxF+CsbGHwTgTFlTm77nP/PvNgEkw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761211957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NPIvLe7IJwosnpvn0Us2PzDRMFbCqY83mlv0mt7RMt4=;
	b=gVtByQAA1LPExW5mlO2gKN4H+y+CfcRgxDl1AFqlEjYtZurIHyknyubfBw+FPVOroEFUag
	iocqUkcfuPOfCfcJMdto2KFdSslw9gAMDhzyQ0KZ8XWaY0e3jtZet91ScqaAPH+bhDifrd
	9f+qULQdkMoIq39JoQ04eW1Zk20+7RM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC46513285;
	Thu, 23 Oct 2025 09:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IYVQIzT2+WhwQwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 Oct 2025 09:32:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: make sure no dirty metadata write is submitted after btrfs_stop_all_workers()
Date: Thu, 23 Oct 2025 20:02:04 +1030
Message-ID: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[BUG]
During development of a minor feature (make sure all btrfs_bio::end_io()
is called in task context), I noticed a crash in generic/388, where
metadata writes triggered new works after btrfs_stop_all_workers().

It turns out that it can even happen without any code modification, just
using RAID5 for metadata and the same workload from generic/388 is going
to trigger the use-after-free.

[CAUSE]
If btrfs hits an error, the fs is marked as error, no new
transaction is allowed thus metadata is in a frozen state.

But there are some metadata modification before that error, and they are
still in the btree inode page cache.

Since there will be no real transaction commitment, all those dirty
folios are just kept as is in the page cache, and they can not be
invalidated by invalidate_inode_pages2() call inside close_ctree(),
because they are dirty.

And finally after btrfs_stop_all_workers(), we call iput() on btree
inode, which triggers writeback of those dirty metadata.

And if the fs is using RAID56 metadata, this will trigger RMW and queue
new works into rmw_workers, which is already stopped, causing warning
from queue_work() and use-after-free.

[FIX]
Add a special handling for write_one_eb(), that if the fs is already in
an error state immediately mark the bbio as failure, instead of really
submitting them into the device.

This means for test case like generic/388, at iput() those dirty folios
will just be discarded without triggering IO.

CC: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 12 ++++++++++++
 fs/btrfs/extent_io.c | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..8b0fc2df85f1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4402,11 +4402,23 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	btrfs_put_block_group_cache(fs_info);
 
+	/*
+	 * If the fs is already in trans aborted case, also trigger writeback of all
+	 * dirty metadata folios.
+	 * Those folios will not reach disk but dicarded directly.
+	 * This is to make sure no dirty folios before iput(), or iput() will
+	 * trigger writeback again, and may even cause extra works queued
+	 * into workqueue.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info)))
+		filemap_write_and_wait(fs_info->btree_inode->i_mapping);
+
 	/*
 	 * we must make sure there is not any read request to
 	 * submit after we stopping all workers.
 	 */
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
+
 	btrfs_stop_all_workers(fs_info);
 
 	/* We shouldn't have any transaction open at this point */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 870584dde575..a8a53409bb3f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2246,6 +2246,17 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		wbc_account_cgroup_owner(wbc, folio, range_len);
 		folio_unlock(folio);
 	}
+	/*
+	 * If the fs is already in error status, do not submit any writeback
+	 * but immediately finish it.
+	 * This is to avoid iput() triggering dirty folio writeback for
+	 * transaction aborted fses, which can cause extra works into
+	 * already stopped workqueues.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info))) {
+		btrfs_bio_end_io(bbio, errno_to_blk_status(-EROFS));
+		return;
+	}
 	btrfs_submit_bbio(bbio, 0);
 }
 
-- 
2.51.0


