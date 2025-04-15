Return-Path: <linux-btrfs+bounces-13025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758CA89461
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625C7188CDAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA802750E3;
	Tue, 15 Apr 2025 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="or/cG62q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="or/cG62q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79C1AD41F
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700540; cv=none; b=XY7CtY6D7aHHyshBWN2S7j/AwpUPn/R1fYAsV41u70pADJLJC2BFSW98xW1KaQ6UrRNUwYwmVE53nCX5jxAMFgytq/1ZcQ4ExFgRhYWmCAbqR8E3yuHcthbnnItrASEcCESBnBJYzcfIZjYSzIScWvfr8EzAXo/TdeCUGnJ7QYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700540; c=relaxed/simple;
	bh=7Gn2T5bNx7/aRiOwbYLRWQOHhxv5Nk3fU4fnaeO0V4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zu7RkM2k/7X0RK8GIXRxAw773GCME4yhpuk+F6hps+3AIkBeGc44Wq8dZsPNoMIbqX5ei+HvvjYhp55ZziTug5dwdkex36khEHN19zNw7NEbbReEd+fhHrrzK9i1xWzRuxqkSl+GUuGYHUzGYoaMkyER8mzUoKWiWDu0jt5Voww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=or/cG62q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=or/cG62q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E0962117D;
	Tue, 15 Apr 2025 07:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744700536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hm0aIa6FNTxLPfZPKXBu5f+l2+zt2F/XOV1eAeC50/s=;
	b=or/cG62qTFZa53iNylkk4E3MEtQAgVGzFrR8NFw2RZj5n3SlD3xdUbPwcARQQY68Qq3Woc
	1Ru7h5vnsw7VMTEYM9yaNgjsG3bxpk8Wqv/XYCS4yTT5A7bDdi08CtIY5wnqGyJjYANxZR
	vM+7fQ4l35acjuw5Pc7fIT/8/Q59V7I=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="or/cG62q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744700536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hm0aIa6FNTxLPfZPKXBu5f+l2+zt2F/XOV1eAeC50/s=;
	b=or/cG62qTFZa53iNylkk4E3MEtQAgVGzFrR8NFw2RZj5n3SlD3xdUbPwcARQQY68Qq3Woc
	1Ru7h5vnsw7VMTEYM9yaNgjsG3bxpk8Wqv/XYCS4yTT5A7bDdi08CtIY5wnqGyJjYANxZR
	vM+7fQ4l35acjuw5Pc7fIT/8/Q59V7I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B46137A5;
	Tue, 15 Apr 2025 07:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DsYjFXgE/md7KAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 15 Apr 2025 07:02:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: rename iov_iter iterator parameter in btrfs_buffered_write()
Date: Tue, 15 Apr 2025 09:02:13 +0200
Message-ID: <20250415070213.2159193-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E0962117D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Using 'i' for a parameter is confusing and conforming to current
preferences, so rename it to 'iter'.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 98a8814a08efa4..1e164530d9dc2a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1335,7 +1335,7 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 	return copied;
 }
 
-ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
+ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos;
@@ -1361,7 +1361,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	 */
 	old_isize = i_size_read(inode);
 
-	ret = generic_write_checks(iocb, i);
+	ret = generic_write_checks(iocb, iter);
 	if (ret <= 0)
 		goto out;
 
@@ -1370,8 +1370,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		goto out;
 
 	pos = iocb->ki_pos;
-	while (iov_iter_count(i) > 0) {
-		ret = copy_one_range(BTRFS_I(inode), i, &data_reserved, pos, nowait);
+	while (iov_iter_count(iter) > 0) {
+		ret = copy_one_range(BTRFS_I(inode), iter, &data_reserved, pos, nowait);
 		if (ret < 0)
 			break;
 		pos += ret;
-- 
2.49.0


