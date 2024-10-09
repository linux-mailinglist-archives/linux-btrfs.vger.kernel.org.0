Return-Path: <linux-btrfs+bounces-8712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D4996DF4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27CAB21CF0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98E1A2C0B;
	Wed,  9 Oct 2024 14:31:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF91A2550
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484317; cv=none; b=Pt6USLESevebU1K54LWUwTjHHC+ry7ottEBJe7kHdzTv3PQ0feM2ZdLxAVJhEsACdRukaLyOzprJ2UxF8kIUy3gMy9+KTy/pg27IRMG2MU5vbq8nCr6+TWsBdeYQeNUj95YkrdpK6gqGXUwi2shH6xpFHxvGlPFVftjPJHPYjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484317; c=relaxed/simple;
	bh=APVpFfm0ox9LgHUjJhpP0SkoW4v31SuM9dcx/ble4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E65/+BvEa3Cpb53MQHTmERtzwTU7sy9LCcej+9iq+8sn4S09J6fRlLUYBCXA+lsyd/S2sr6ouXMF9z1IUy1miaJZq+bqreHvYAhhZS6MuwNWvZYnj9Nm83hEves+JMtOYQ/Tw51HyfEmkar8qWG8rN34BcP/iR0BOtgFR/Vmp9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11D3F21EB2;
	Wed,  9 Oct 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B77E136BA;
	Wed,  9 Oct 2024 14:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hVHKAtqTBmdgRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 17/25] btrfs: drop unused parameter iov_iter from btrfs_write_check()
Date: Wed,  9 Oct 2024 16:31:49 +0200
Message-ID: <be6697b9b6f84f38e1a034aee9e09efd29f8feae.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 11D3F21EB2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The parameter 'from' has never been used since commit b8d8e1fd570a
("btrfs: introduce btrfs_write_check()"), this is for buffered write.
Direct io write needs it so it was probably an interface thing, but we
can drop it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/direct-io.c | 2 +-
 fs/btrfs/file.c      | 6 +++---
 fs/btrfs/file.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index bd38df5647e3..a7c3e221378d 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -834,7 +834,7 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		return ret;
 	}
 
-	ret = btrfs_write_check(iocb, from, ret);
+	ret = btrfs_write_check(iocb, ret);
 	if (ret < 0) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto out;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 160d77f8eb6f..033f85ea8c9d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1144,7 +1144,7 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count)
+int btrfs_write_check(struct kiocb *iocb, size_t count)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -1222,7 +1222,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	if (ret <= 0)
 		goto out;
 
-	ret = btrfs_write_check(iocb, i, ret);
+	ret = btrfs_write_check(iocb, ret);
 	if (ret < 0)
 		goto out;
 
@@ -1467,7 +1467,7 @@ static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (ret || encoded->len == 0)
 		goto out;
 
-	ret = btrfs_write_check(iocb, from, encoded->len);
+	ret = btrfs_write_check(iocb, encoded->len);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index c23d0bf42598..c2ce0ae94a9c 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -44,7 +44,7 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
 bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state,
 				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
-int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count);
+int btrfs_write_check(struct kiocb *iocb, size_t count);
 ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i);
 
 #endif
-- 
2.45.0


