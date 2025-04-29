Return-Path: <linux-btrfs+bounces-13499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852FAA08F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B4E1A86AFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEBC2BF3F7;
	Tue, 29 Apr 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A5k1sheW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Je8wkxhm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E1EEB5
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924210; cv=none; b=cucCX39GDcU/vPrMkE3SUgTlt+CIH5rKy/VC334o1txO7L9piq16Z+Pix/9cCBNKNutXsB/2eqnRnM7nBzY6Y5JeSgeuXg5B66RykxMcEf7reCwYnZXSqDiyi2+dbOug7XmAXSFf6mXvYreyRlkWMo6zqW0Sz0/5nUGWVJtCPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924210; c=relaxed/simple;
	bh=sj79heuaCuGBo3Aci/rm4X64BYJo7ZpYkNfZc4lrZDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNo6pQ9YTx54DbBt9dKFMxWeJSUKUxh4SA7dxP6STialhyN/dqnzg6nhppwai7WYDsKAgd2PLbdUxGCGl/V5su2av4l1oBYWdKu9vodwCoPaufHVf+E5xjwBW5GSS7GXfTzNdXUMHNJN/Av4H3aoKrpude9AfHWDiABiVdtOHok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A5k1sheW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Je8wkxhm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBE1321199;
	Tue, 29 Apr 2025 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745924207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TiLDk7ZRLk3dPRCZzFd7lUR0aW4D/5Q/cNW3g5kx0Zs=;
	b=A5k1sheW5lXcLDopmfpSv8SiHr15rzdiBhZ9fCR1R6xSuzDN8zeZimFdL+EfitWSHXfBCb
	j/egx9WT3tgaLfKgmQR8Chumt6jQVdlW5yDfOB/6CybEGBFTcCARWXSsdNvZcv8/C54Si8
	7mRIVFSdnBQq6Rv9FnjaDhNQj39+fH8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745924206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TiLDk7ZRLk3dPRCZzFd7lUR0aW4D/5Q/cNW3g5kx0Zs=;
	b=Je8wkxhmHuGD7FZmBEuW5SYmXLI9K9mMN0x2gB6s9PHwKo8dbqu7PDz3gwpswwwqttXSSw
	wCF917F19hmh4PkhnatnnDvgxBpAD0nJ/2I6NS9oqAGeBx5owhQ8egdXnlAXZFhl3ks82o
	ZfOrnvAs7zEFo4yDRJwfZ0xIOPBZpUM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E522013931;
	Tue, 29 Apr 2025 10:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V0LqN26wEGjFNwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 29 Apr 2025 10:56:46 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: rename btrfs_discard workqueue to btrfs-discard
Date: Tue, 29 Apr 2025 12:56:41 +0200
Message-ID: <20250429105641.2313776-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

We use the "btrfs-" prefix for our workqueues, the discard has
underscore instead of dash, so unify it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 002a3d648180eb..b3e8a55d29f7d5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1994,7 +1994,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 		btrfs_alloc_ordered_workqueue(fs_info, "qgroup-rescan",
 					      ordered_flags);
 	fs_info->discard_ctl.discard_workers =
-		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
+		alloc_ordered_workqueue("btrfs-discard", WQ_FREEZABLE);
 
 	if (!(fs_info->workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
-- 
2.49.0


