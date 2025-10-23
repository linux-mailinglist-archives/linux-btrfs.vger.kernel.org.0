Return-Path: <linux-btrfs+bounces-18231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885FC03DFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 01:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D011B34D20D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 23:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51DB2E2840;
	Thu, 23 Oct 2025 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ktmGf7Hn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uFzgVvat"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09D14B06C
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262943; cv=none; b=TKjMSQATonxHnxQKov4RLEZXc2dVQ5+8CQVjq3PiIAUSFeeM6iUCp944UyjLyxssJtCvPdrkDlNL/Ru+4UtXcZGdEW66qF5hcjCPkmbkdGgcSDl5kEHbKtCZKVFiozOdj3EW7VPlWn+Ax9nWDW9xAORArxAQfqJzuseMWsiqBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262943; c=relaxed/simple;
	bh=jLdybE/qki2eED1uEl4s0cHYVKVXbct1t25HD7Fa8sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2VgKLbBFYiLUAyU+FTKOhjPUrBo05KEgZA42IMl7SMLzSG7yL+AhL83Be+1Ez0VYpp0JKs6ArcSTblYBJqeS5cv8aynaoIM3AF9z7EQN1HSJC8b7TK67EvJV3oXu1H/IbY7cG6m2+UOQBQJaqL0V1b0P4MWUEx/sU8ND4ssyY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ktmGf7Hn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uFzgVvat; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 357301F388;
	Thu, 23 Oct 2025 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761262935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W1na+FtDNglbTJzDSzM6dw9QLavVXUwPQSF79yRDqpg=;
	b=ktmGf7Hn3G7KH2z4J5XPjtCMQI9m8JSPmOMqGqW75uUu9K58NYRnCK3mx9sTFMDmocsRDG
	zL9YmT4OWZ9u/Gq0nb6ZBvuKSSlaNqIqMJYJzVm24W4JWvJRcbG8z6sv8L3hnBOCCGX6yH
	4lJXYEiqnguI0D6SgmzZVAP6X+aIZZA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761262931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W1na+FtDNglbTJzDSzM6dw9QLavVXUwPQSF79yRDqpg=;
	b=uFzgVvatFM8wIzRN4javJRq690BEInwAhfI6B6GOLywC6WoPwboIdgJTKba8H+ghy1lU9p
	Dm0WbgC2buXtK9pC0l6sAQdyBTpVssdn3t25pksApIBUnTpd038n/wYX5GnPR43zcHs6iT
	B1bHYNwRd+LS2I5sLO+YLzh6CeaEKlE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 324FC13285;
	Thu, 23 Oct 2025 23:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NK63OFG9+mjUaAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 Oct 2025 23:42:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] btrfs: ensure no dirty metadata is written back for an fs with errors
Date: Fri, 24 Oct 2025 10:11:48 +1030
Message-ID: <bfc7d8db794cc39fa2909c0b38a69f1a1ae73b81.1761262682.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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

But there are some metadata modifications before that error, and they are
still in the btree inode page cache.

Since there will be no real transaction commit, all those dirty folios
are just kept as is in the page cache, and they can not be invalidated
by invalidate_inode_pages2() call inside close_ctree(), because they are
dirty.

And finally after btrfs_stop_all_workers(), we call iput() on btree
inode, which triggers writeback of those dirty metadata.

And if the fs is using RAID56 metadata, this will trigger RMW and queue
new works into rmw_workers, which is already stopped, causing warning
from queue_work() and use-after-free.

[FIX]
Add a special handling for write_one_eb(), that if the fs is already in
an error state, immediately mark the bbio as failure, instead of really
submitting them.

Then during close_ctree(), iput() will just discard all those dirty
tree blocks without really writing them back, thus no more new jobs for
already stopped-and-freed workqueues.

The extra discard in write_one_eb() also acts as an extra safenet.
E.g. the transaction abort is triggered by some extent/free space
tree corruptions, and since extent/free space tree is already corrupted
some tree blocks may be allocated where they shouldn't be (overwriting
existing tree blocks). In that case writing them back will further
corrupting the fs.

CC: stable@vger.kernel.org #6.6
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog
v2:
- Various grammar and newline fixes

- A shorter title line

- Enhance the [FIX] part, explain the full fix

- Limit the backport for 6.6
  v6.1 code base is very different compared to the current one, thus
  backporting to v6.6 would be the limit.

- Explain more why discarding bios at write_one_eb() is safer

- Remove the extra flushing part inside close_ctree()
  There is no difference flushing the dirty folios manually or by
  iput(), as dirty folios are discarded anyway, no new job will be
  created.
---
 fs/btrfs/extent_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 870584dde575..8f6b8baba003 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2246,6 +2246,14 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		wbc_account_cgroup_owner(wbc, folio, range_len);
 		folio_unlock(folio);
 	}
+	/*
+	 * If the fs is already in error status, do not submit any writeback
+	 * but immediately finish it.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info))) {
+		btrfs_bio_end_io(bbio, errno_to_blk_status(-EROFS));
+		return;
+	}
 	btrfs_submit_bbio(bbio, 0);
 }
 
-- 
2.51.0


