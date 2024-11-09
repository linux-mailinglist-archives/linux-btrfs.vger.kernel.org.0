Return-Path: <linux-btrfs+bounces-9401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B39C300A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2024 00:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38291B21649
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2024 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD511990BB;
	Sat,  9 Nov 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PJOI4FdW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nnz8JurM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DD38DF9
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731194297; cv=none; b=ZOT1WcQZU2aK3EbJiKuFaItLcbKl/IJ3rfFl1aW+1oxIgQjkzHyn7OzwL76p3Su6HPF2nhegjD0mrd1IlNe/mPwRJ3GDVaX5K9+TXhxZeD9zEY+17aDktsBpXFaifq2u+PE464n5HeO3Ql2uFeH5xMWgCB/PG91nO9acdMIn4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731194297; c=relaxed/simple;
	bh=ykoFWpYXfZlG9DRplDsVVMP+AOSmDID1VQ1ts/NKFIQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O5rhRCS7Z4O2KcgbK/6VK5F6ZAnSYkcz25kf3OBZ7OlL/jUYSTkhF9vDFoCcL6Rgl4+MuQkg67dvSDT9IMeNsiKVnCLdq2KtPbUPFFYxnh4rGOj8Sm8q2T1Q5O9s5qEiiDD+yXfOzud6mEBEL4QJtL+PVOW20V/Yayt+CvRcVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PJOI4FdW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nnz8JurM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E659621A4B
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2024 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731194294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oONUxTomFmI1zhpHdpibbe9PMJ2fMYhDsH0HIBR512Y=;
	b=PJOI4FdWmbMO1bI50yOT7OSsTZ+i0XWkaMZVHcmHkIPozQ5nhRgUPa01gIXGtHdsnOTCk2
	Cb3WxmMfwx7LhDMw1FA4pPdpCMSiC3iHfCYzC4K0+L8KmndBYFrr1EPXJQcDvT/dYQ06F6
	+8FUD6cYbRxyUVICIe2fQSIEYy+mrfY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nnz8JurM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731194293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oONUxTomFmI1zhpHdpibbe9PMJ2fMYhDsH0HIBR512Y=;
	b=nnz8JurMKEgocftp2kiMwnUNjXWejwUe5LvZLtKh0AhzupoSYjnBPaMRDpiF1lUnIGBogw
	xtoWl+uibmK9nGSQ9Z6UCWi+9nFt+sdPAgFG0koDyUVeLOxSY+dj1K9gdOa7KaVrHwfnwh
	mcJvEDWZc+56U/bNS+pdlePaXoVOUug=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F77A136CC
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2024 23:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9HzWOLTtL2cPfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Nov 2024 23:18:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: improve error handling in btrfs_split_item()
Date: Sun, 10 Nov 2024 09:47:51 +1030
Message-ID: <2d164b3ee567836cb7d2111b293b53bdec6b9b65.1731194259.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E659621A4B
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This involves the following error cases:

- Unable to find the original item
  Return -EAGAIN and release the path (which is not done in the original
  code)

- Error from split_leaf()
  Remove the BUG_ON() and handle the error.
  The most common error is ENOSPC.

- Error from kmalloc()
  Just handle the error and return -ENOMEM.

Issue: #312
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index cfcad0fec61f..c540cf7b1854 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2450,7 +2450,7 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	u32 nritems;
 	u32 orig_offset;
 	struct btrfs_disk_key disk_key;
-	char *buf;
+	char *buf = NULL;
 
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &orig_key, path->slots[0]);
@@ -2469,11 +2469,13 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	/* if our item isn't there or got smaller, return now */
 	if (ret != 0 || item_size != btrfs_item_size(path->nodes[0],
 							path->slots[0])) {
-		return -EAGAIN;
+		ret = -EAGAIN;
+		goto error;
 	}
 
 	ret = split_leaf(trans, root, &orig_key, path, 0, 0);
-	BUG_ON(ret);
+	if (ret < 0)
+		goto error;
 
 	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
 	leaf = path->nodes[0];
@@ -2484,7 +2486,10 @@ split:
 
 
 	buf = kmalloc(item_size, GFP_NOFS);
-	BUG_ON(!buf);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto error;
+	}
 	read_extent_buffer(leaf, buf, btrfs_item_ptr_offset(leaf,
 			    path->slots[0]), item_size);
 	slot = path->slots[0] + 1;
@@ -2530,6 +2535,10 @@ split:
 	}
 	kfree(buf);
 	return ret;
+error:
+	kfree(buf);
+	btrfs_release_path(path);
+	return ret;
 }
 
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
-- 
2.47.0


