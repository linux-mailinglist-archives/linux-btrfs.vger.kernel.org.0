Return-Path: <linux-btrfs+bounces-17197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E382BA1E3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 00:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8407A190B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC12EA730;
	Thu, 25 Sep 2025 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CTdAQsZl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X8snIANh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55527703C
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840637; cv=none; b=tT40IwjRAy+4iDkJNXLLjDHZItMVFgxyHZVUeZV9Xew+Njc6WiO7/B41e+MX/vPiwl2VzjnmY8aLfJnDZYmftoLoodpzQJB23XqXPRq6b7/BvjmvSYTfbZWc/aBPM4oMp+nwRAmxMR24vyOguu1+vcq51KO98ukq9q8g6jIu3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840637; c=relaxed/simple;
	bh=jZ3UAv/QsXkru5VzXsB+ralPk2H/DdHcQnRd9AZG27o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OJ8JSsMRUK04kxMDc5TeYgHRQWgD4RimcFIHURH2kNy/8CKs5L3+hDi3VAd8oh2ioExSqxR3zGCVeZTPbQ0SrwC5L64NmgdcKcYOjG2MGc+hqaIBN1toJh+jQU4NeDxBsnT8n7gAMu+D8vWTyIXkjdw3ZLNl6/JgFkvYXfLZteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CTdAQsZl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X8snIANh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5814A26093
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758840633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Kt0IDM3wB31mFc+AFxmVeudHJrWd41U5M7L4KrHVT7s=;
	b=CTdAQsZlJPaIMZZElTzgu+57PSqTjl5e1cdWVgQTQH5C37YYmhSgCUUyjZn66o6xJRXp+T
	sGc+m+iOIv1zfv1IXHWkUQjp4rkpFtvRB5GbOZiQk17tDGeJAAt73bwhqkc7/+x8DDXQ9S
	7e+6fkNAACJiIDM4G1L7HcgrfBwtvys=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=X8snIANh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758840632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Kt0IDM3wB31mFc+AFxmVeudHJrWd41U5M7L4KrHVT7s=;
	b=X8snIANhtCJkmy6rTTeZuu8UfxLbbWr1BUzLMmnXlmfAuCPg3tv6hts01l2EJFb9CdLRRz
	Y5aCyWnqtgUcND/lF95VxydyK/avf7X7XQMOYu1J6J5bl8VQcC6ZQS71HF3Z3rkVHgZwQH
	IxvVOkOquvMjzcucxnh0GoHJl115D9g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C539132C9
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 22:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S1w+EzfH1WjaUwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 22:50:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fallback to buffered read if the inode has data checksum
Date: Fri, 26 Sep 2025 08:20:13 +0930
Message-ID: <aa09b68f159fb0de4864de151eeba9250f2e34fd.1758840406.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5814A26093
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Commit 968f19c5b1b7 ("btrfs: always fallback to buffered write if the
inode requires checksum") makes direct writes to fallback to buffered
ones if the inode has data checksum.

That commit is to avoid unreliable user space modifying the write buffer
during writeback, which can lead to data checksum mismatch.
(As the checksum is calculated, then buffer is modified, and the
modified data is submitted)

On the other hand, it's also possible that the user space program can
modify the read buffer at any time.

If the content is just read from the disk, then during checksum
verification the user space program modified the read buffer, it will
cause false alerts about csum mismatch.

Despite the possibility of false alerts, we should also keep the
behavior between direct read and direct write consistent.
If direct writes are already falling back to buffered for inodes with
checksum, the direct reads should also follow the same behavior.

So here, add the same data checksum checks for direct reads, so that
those reads will also fallback to buffered reads.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This will make test case btrfs/267 fail, as the fallback to buffered
read will happen in a different context (workqueue), screwing up the pid
based read balance.

Furthermore true direct reads will require NODATASUM, it no longer makes
any sense to test direct IO read repair.

If this is merged, I'll send out a patch to remove btrfs/267.
---
 fs/btrfs/direct-io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 6018d8c3e101..6f35fed5fa3f 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -1046,6 +1046,13 @@ ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (check_direct_read(inode_to_fs_info(inode), to, iocb->ki_pos))
 		return 0;
 
+	/*
+	 * To keep the behavior consistent with direct write, fall back to
+	 * buffered IO if the inode has data checksum.
+	 */
+	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
+		return 0;
+
 	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 again:
 	/*
-- 
2.50.1


