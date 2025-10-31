Return-Path: <linux-btrfs+bounces-18501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D7C273A4
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 00:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A23A8CD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0623330B13;
	Fri, 31 Oct 2025 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U7xuW47Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sP23qSmk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283D32ED3A
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954760; cv=none; b=bmHyeHa85DMx0nZQgfVulfvzFIaEseBb26WI6u8MdmhC/gdSOKHFPSUPNfz3l6GeJs7dV2pOsUWxYY0BdeWcHbIjhBqf6ee4MpTm1HbbgXPf0KMZEpHgBu9zWioxh/mVaeeVoS/9Ya/tHKW7EXHIyJzV7zT5HXm/P16Hn2GLG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954760; c=relaxed/simple;
	bh=2YnbAfLAW/ct5zIZwN/NxLfgtfjmTu+3KIdHvhWb5XE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iUtJg4wr33FvO7d882hL1S+MS3sEhcU4bVHSrb8MgTQF6uY4BRkpf+cTTduYYeha0XHCoM/ZNyUYCq062u9MBMvBMsLu6W3axAI7NTX5tQKoJCjQk3ckC3JBqPqw+/Ld8WZuhHAptiLSh2B+62TP4cjPA6be4KlmUdjtob9Alo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U7xuW47Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sP23qSmk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 656D121A06
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 23:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761954756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uu6H9erXa3ubw9lakgcCmPdTzf4G4C3PK+ZLUtSPcSg=;
	b=U7xuW47QluGfrwEK5fylZl9Vz2bnVLv9qUKMZquuhQCqFt/+dBO3R2thBGZ3eKIlk5/p2v
	STyQl4djFfl/jWhKzMY003RIRh6Y9RJ7WYefE622rVhn3CKmF0k7ISlOdll1t2S+jZ51m+
	AhXsPCu7pbx/Jlrr+VZ1lRzbPtIqT8I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761954755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uu6H9erXa3ubw9lakgcCmPdTzf4G4C3PK+ZLUtSPcSg=;
	b=sP23qSmktDA72BYHLfMteQEvfF8tkvDVm4rmNLMuDWERR9+CADY7PCbjfpdj1LZNsvHjkh
	OnE89IRIkgpIv3Emtas4Vq5FJyu6AsCarwPdL9VB7M69HaoA50rW4Ntxe/W73CEMN7IsaG
	QSHya/Hnl9KfDyk7zOd3w1ixx7/Bt+o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DE8913991
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 23:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id asRtDcJLBWkYJQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 23:52:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fallback to buffered IO if the data profile has duplication
Date: Sat,  1 Nov 2025 10:22:16 +1030
Message-ID: <c233e29e6b011666accf3be888f61a78d7833f1b.1761954724.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
Fix the problem by checking the data allocation profile.
If our data allocation profile is either RAID0 or SINGLE, we can allow
true zero-copy direct IO and the end user is fully responsible for any
race.

However this is not going to fix all situations, as it's still possible
to race with balance where the fs got a new data profile after the data
allocation profile check.
But this fix should still greatly reduce the window of the original bug.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use btrfs_data_alloc_profile() to avoid expensive rw semaphore in
  write path
  Which is now only a seqlock, which is way lighter weight.
---
 fs/btrfs/direct-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 962fccceffd6..6ff186595625 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -814,6 +814,8 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio;
+	const u64 data_profile = btrfs_data_alloc_profile(fs_info) &
+				 BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -827,6 +829,16 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) && IS_NOSEC(inode))
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
+	/*
+	 * If our data profile has duplication (either extra mirrors or RAID56),
+	 * we can not trust the direct IO buffer, the content may change during
+	 * writeback and cause different contents written to different mirrors.
+	 *
+	 * Thus only RAID0 and SINGLE can go true zero-copy direct IO.
+	 */
+	if (data_profile != BTRFS_BLOCK_GROUP_RAID0 && data_profile != 0)
+		goto buffered;
+
 relock:
 	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
-- 
2.51.2


