Return-Path: <linux-btrfs+bounces-17217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F4BA3450
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C50744E2B78
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CA31114;
	Fri, 26 Sep 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yu14g3No";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qoZU3SMJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933A2BD5B4
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880804; cv=none; b=tQzoHPuqqoMFDVXuhK+mUr8MhwGlmyvPOW+7jdg4cnNLzmvmoZ/G/Nuo55uqFD9ict9uqNb4HcQCYvY7Q0a2f4Ss7d7mbUay6QjvnGe2uWEd0uvqCz+v2k549dGIfgJgyzBosj7ikEOXkRmJUOM62jSX8qgAyhT8Iolyq4OdgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880804; c=relaxed/simple;
	bh=ycEGpViGUv6Bwhm9mLoLHeQKXclMAqDXzlwb8EXpk+U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LwGA5auoG+Kc+UYe9wQxEIBXYG4em306O2t+8QAg7DQxPvAeYTf6dlWgkG0jM16WIeFIce2ETsglAnNwh/R4gH2LYD5fcl+TqnZ+NIvyjYbmNggV2k7G/XT6K7K9hds50h+KxgMD4gX2XKHgN2Bx0pAWwP/knJDrcCyihZBPwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yu14g3No; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qoZU3SMJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D086D23E2A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758880800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VaNYMjdp32nKv9jIT6pA3pKZyN8ADkjdZclL1s/mqrI=;
	b=Yu14g3NoSprLkzuUy1dPXD9Uo05mLZbYxxB/vH1cus0m/gVI3pQb/kmL8Hlb8GIZdc6ybQ
	Fzb8wq1l3P+Ltnrj4CevHTmKFXJgS9w10eDYaKXuNlPbNKdT3KiEDxkD/VYWiopWV9fR76
	9LoiJo4sUPNSEciHAXC8pssuK9NfST0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qoZU3SMJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758880799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VaNYMjdp32nKv9jIT6pA3pKZyN8ADkjdZclL1s/mqrI=;
	b=qoZU3SMJnAoJyopJeuwlkRMFmSKzxJX4kafY1w9yfGdw7GO9xzd6DTM+Bw4NxhJLDP5AA1
	HFmMzFzAgmcYT5nHmH5UyhnDnAFQdzzL2b/WFDGASj1rtMzTynq3o8uQPnCNGOdeBwy27H
	XrD1b3Sv9epDApHUDPUyhOvn2uRStI0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AE6E1373E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 09:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xLKxMx5k1mjrFAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 09:59:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: update the behavior of direct IO
Date: Fri, 26 Sep 2025 19:29:41 +0930
Message-ID: <9dc3b54856ed486aef98e94d52345b235aca5f34.1758880767.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D086D23E2A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Since direct read buffer can also be interfered by user space, it has
the same problem of false checksum mismatch, and there is already a
kernel patch submitted for it.

Update the documents to reflect this. Since the patch is pretty small,
the ETA for the kernel fix is targeted at 6.18.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-checksumming.rst | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/ch-checksumming.rst b/Documentation/ch-checksumming.rst
index a47cc3a3dca9..f9c295b85c65 100644
--- a/Documentation/ch-checksumming.rst
+++ b/Documentation/ch-checksumming.rst
@@ -5,18 +5,21 @@ has a detached checksum stored in the checksum tree.
 
 .. note::
    Since a data checksum is calculated just before submitting to the block
-   device, btrfs has a strong requirement that the corresponding data block must
-   not be modified until the writeback is finished.
+   device for writes and verified just before returning the contents for reads,
+   btrfs has a strong requirement that the corresponding data block must
+   not be modified during reading/writing.
 
-   This requirement is met for a buffered write as btrfs has the full control on
-   its page cache, but a direct write (``O_DIRECT``) bypasses page cache, and
-   btrfs can not control the direct IO buffer (as it can be in user space memory).
-   Thus it's possible that a user space program modifies its direct write buffer
-   before the buffer is fully written back, and this can lead to a data
+   This requirement is met for a buffered read/write as btrfs has the full
+   control on its page cache, but a direct read/write (``O_DIRECT``) bypasses
+   page cache, and btrfs can not control the direct IO buffer (as it can be in
+   user space memory).
+   Thus it's possible that a user space program modifies its direct read/write
+   buffer before the read/write is finished, and this can lead to a data
    checksum mismatch.
 
-   To avoid this, kernel starting with version 6.14 will force a direct
-   write to fall back to buffered, if the inode requires a data checksum.
+   To avoid this, kernel starting with version 6.14 (for write) and 6.18 (for read)
+   will force a direct read/write to fall back to buffered, if the inode requires
+   a data checksum.
    This will bring a small performance penalty. If you require true zero-copy
    direct writes, then set the ``NODATASUM`` flag for the inode and make
    sure the direct IO buffer is fully aligned to block size.
-- 
2.50.1


