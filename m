Return-Path: <linux-btrfs+bounces-11010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1EA16484
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 00:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EF23A2248
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE61E009B;
	Sun, 19 Jan 2025 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m9QNqdrP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m9QNqdrP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F41DFDB5
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737328276; cv=none; b=Fyci41Zgx8CL4NQp8t2bMzc5wVQblSqC5nITH4w1YCd7Ydf3OjJbmLnbtNt8LX8j5skZKrUARTthSReD1nfkIVVcG1F6ZplEoxVqcDwZ8k8PAe+UR+wMuCbrzzMpTuVRz4AUaC3lPOpk1PcV/Nfu2ndo+AIGLfpikZmzrmksEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737328276; c=relaxed/simple;
	bh=bQGdi7M4gRhfkBiT2qO4AWy0RRccVpfy7xVMiikNXbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itMCEWpaILxw30bLcRzJX4v6ioNzCfozmGJOyB2vbs+SC2Z8Q5cLUunsHp+38OL/HzL3J0gQlwKGYTixgVN8Pi0MigXURQCw7VbqBe/mV8PXazdE98mLjH5xpHH5s6pVmPvNbsmcmPtBCeUK/PZ+y9cImDgIgftanPBPqSx3YTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m9QNqdrP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m9QNqdrP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B0342119A;
	Sun, 19 Jan 2025 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737328272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gqeL0OADzPGvB28SvP7qTS42D/3aTgqLNUwCO8Np5yI=;
	b=m9QNqdrPXmzfsHW/KZszKyalYQUuvmwhGRTy55BhoQPBKXG2XCLIFvK+sN94HfBDNZJRFU
	RR5/3GkcwRzPSGMN8is1dXsKQ9k5q3Cz+ZudN0t6IP7dvT5nydeOV4xd2w5cCIypeFh7DE
	1JHvOcs6fHjLryGZJzpyzZg1YoaAniM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=m9QNqdrP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737328272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gqeL0OADzPGvB28SvP7qTS42D/3aTgqLNUwCO8Np5yI=;
	b=m9QNqdrPXmzfsHW/KZszKyalYQUuvmwhGRTy55BhoQPBKXG2XCLIFvK+sN94HfBDNZJRFU
	RR5/3GkcwRzPSGMN8is1dXsKQ9k5q3Cz+ZudN0t6IP7dvT5nydeOV4xd2w5cCIypeFh7DE
	1JHvOcs6fHjLryGZJzpyzZg1YoaAniM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DC52139CB;
	Sun, 19 Jan 2025 23:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BKt9Co6GjWeiWAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 19 Jan 2025 23:11:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: John Shand <jshand2013@gmail.com>
Subject: [PATCH] btrfs: do not output error message if a qgroup is already cleaned up
Date: Mon, 20 Jan 2025 09:40:43 +1030
Message-ID: <d538309bf9cbfb732b4f9c3bc174ccdcfe9ccafa.1737328208.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B0342119A
X-Spam-Level: 
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
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
There is a bug report that btrfs outputs the following error message:

 BTRFS info (device nvme0n1p2): qgroup scan completed (inconsistency flag cleared)
 BTRFS warning (device nvme0n1p2): failed to cleanup qgroup 0/1179: -2

[CAUSE]
The error itself is pretty harmless, and the end user should ignore it.

When a subvolume is fully dropped, btrfs will call
btrfs_qgroup_cleanup_dropped_subvolume() to delete the qgroup.

However if a qgroup rescan happened before a subvolume fully dropped,
qgroup for that subvolume will not be re-created, as rescan will only
create new qgroup if there is a BTRFS_ROOT_REF_KEY found.

But before we drop a subvolume, the subvolume is unlinked thus there is no
BTRFS_ROOT_REF_KEY.

In that case, btrfs_remove_qgroup() will fail with -ENOENT and trigger
the above error message.

[FIX]
Just ignore -ENOENT error from btrfs_remove_qgroup() inside
btrfs_qgroup_cleanup_dropped_subvolume().

Reported-by: John Shand <jshand2013@gmail.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1236056
Fixes: 839d6ea4f86d ("btrfs: automatically remove the subvolume qgroup")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b90fabe302e6..aaf16019d829 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1897,8 +1897,11 @@ int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info, u64 su
 	/*
 	 * It's squota and the subvolume still has numbers needed for future
 	 * accounting, in this case we can not delete it.  Just skip it.
+	 *
+	 * Or the qgroup is already removed by a qgroup rescan. For both cases we're
+	 * safe to ignore them.
 	 */
-	if (ret == -EBUSY)
+	if (ret == -EBUSY || ret == -ENOENT)
 		ret = 0;
 	return ret;
 }
-- 
2.48.0


