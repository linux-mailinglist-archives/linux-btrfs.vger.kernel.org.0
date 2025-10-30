Return-Path: <linux-btrfs+bounces-18426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBCAC22BC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 00:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E43F03445A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14E233E35D;
	Thu, 30 Oct 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RVxfReCi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sy+r+LaC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DCE33FE39
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867833; cv=none; b=RUYPudNlmIXh/q9rhdTxylYrQXQtTUhXSnjT9PyxTS53xurtXD3LILXlCBl4Et0udExWvBtu8tJZotGyd72WrRsA0i36OA0LOCY65kf/Mdj8q3IP7shCysKYkpUUeG5Coatfr+/SrKgpjLB1QmCmhCNCfj1eUK1n+tSWholjEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867833; c=relaxed/simple;
	bh=51TVAf63rYGGrCMMMP+f+Bp20iI78j368SRaMoZNQxs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ex12U/CFf1YdNsDWRhFlGICI9vWOXTvlqMnKZuGqzfHb+fCULU47pz9MvRDXTjPAUOMLEz/8TNZTpY+IPwGDieCSAjyonLTBG85632EYpPY/ALOqWdDBksZ488t2AKEltcqMf6p5/IzShbZ+ZcNyb9HG+5KVzPeqKDu6bQi38Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RVxfReCi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sy+r+LaC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66CA11F7D3
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 23:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761867826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jLoC31r/q12H70mkFdrr0Wsbcr3zXlL2JCOXTiJf0ac=;
	b=RVxfReCic8P9rI28SqMtVJvraO4tM2dwwhgm4XWT8+07bshZTJHP4xa9IwUKeETP1giLPy
	ofeMH9zCoiESzwtibudFR28sMcna6qsIzAT631+gPYetvf47cm+usTsfDwzGNBt2TQXR7E
	2D4VOyHgWick0Lbsd3T8qSgFwxigOWY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761867825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jLoC31r/q12H70mkFdrr0Wsbcr3zXlL2JCOXTiJf0ac=;
	b=sy+r+LaChLsmli9YZHynjlSOQ8lQBJFAXAhqvMvpm87mAS8lt15FZ7Z2ZX2mOqCS8NSiA5
	jKUuxdH+4YlnS+pDzdz+LW7GBfpvkKDsXPixlELLdD/Kqm11HFm37viTtzAnqZBhIl2GPq
	fTldaZ0dGLfqztCwPnOuQPlbr+EFFoQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3FD21396A
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 23:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G9WQGTD4A2nmNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 23:43:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fallback to buffered IO if the data profile has duplication
Date: Fri, 31 Oct 2025 10:13:26 +1030
Message-ID: <fe6582f4535be27e11a6125f89265ebe8c82aac6.1761867805.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[BACKGROUND]
Inspired by a recent kernel bug report, which is related to direct IO
buffer modification during writeback, that leads to contents mismatch of
different RAID1 mirrors.

[CAUSE AND PROBLEMS]
The root cause is exactly the same explained in commit 968f19c5b1b7
("btrfs: always fallback to buffered write if the inode requires
checksum"), that we can not trust direct IO buffer which can be modified
halfway during writeback.

Unlike data checksum verification, if this happened on inodes without
data checksum but has the data has extra mirrors, it will lead to
stealth data mismatch on different mirrors.

This will be way harder to detect without data checksum.

Furthermore for RAID56, we can even have data without checksum and data
with checksum mixed inside the same full stripe.

In that case if the direct IO buffer got changed halfway for the
nodatasum part, the data with checksum immediately lost its ability to
recover, e.g.:

" " = Good old data or parity calculated using good old data
"X" = Data modified during writeback

              0                32K                      64K
  Data 1      |                                         |  Has csum
  Data 2      |XXXXXXXXXXXXXXXX                         |  No csum
  Parity      |                                         |

In above case, the parity is calculated using data 1 (has csum, from
page cache, won't change during writeback), and old data 2 (has no csum,
direct IO write).

After parity is calculated, but before submission to the storage, direct
IO buffer of data 2 is modified, causing the range [0, 32K) of data 2
has a different content.

Now all data is submitted to the storage, and the fs got fully synced.

Then the device of data 1 is lost, has to be rebuilt from data 2 and
parity. But since the data 2 has some modified data, and the parity is
calculated using old data, the recovered data is no the same for data 1,
causing data checksum mismatch.

[FIX]
Fix this problem by introduce a new helper,
btrfs_has_data_duplication(), to check if there is any data profiles
that have any duplication. If so fallback to buffered IO to keep data
consistent, no matter if the inode has data checksum or not.

However this is not going to fix all situations, as it's still possible
to race with balance where the fs got a new data profile after
btrfs_has_data_duplication() check.
But this fix should still greatly reduce the window of the original bug.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/direct-io.c  |  9 +++++++++
 fs/btrfs/space-info.c | 18 ++++++++++++++++++
 fs/btrfs/space-info.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 962fccceffd6..3165543f35bc 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -12,6 +12,7 @@
 #include "volumes.h"
 #include "bio.h"
 #include "ordered-data.h"
+#include "space-info.h"
 
 struct btrfs_dio_data {
 	ssize_t submitted;
@@ -827,6 +828,14 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) && IS_NOSEC(inode))
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
+	/*
+	 * If our data profile has duplication (either extra mirrors or RAID56),
+	 * we can not trust the direct IO buffer, the content may change during
+	 * writeback and cause different contents written to different mirrors.
+	 */
+	if (btrfs_has_data_duplication(fs_info))
+		goto buffered;
+
 relock:
 	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 63d14b5dfc6c..02b5ebdd3146 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2203,3 +2203,21 @@ void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len)
 	if (len)
 		btrfs_try_granting_tickets(space_info);
 }
+
+bool btrfs_has_data_duplication(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *sinfo = fs_info->data_sinfo;
+	bool ret = false;
+
+	down_write(&sinfo->groups_sem);
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		if (!list_empty(&sinfo->block_groups[i]) &&
+		    (btrfs_raid_array[i].ncopies > 1 ||
+		     btrfs_raid_array[i].nparity != 0)) {
+			ret = true;
+			break;
+		}
+	}
+	up_write(&sinfo->groups_sem);
+	return ret;
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a4c2a3c8b388..15b96163a167 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -315,5 +315,6 @@ void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool
 int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
+bool btrfs_has_data_duplication(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.51.2


