Return-Path: <linux-btrfs+bounces-5926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F2915388
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822461C220DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFA219D8BB;
	Mon, 24 Jun 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IHzaS+48";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IHzaS+48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8819E7CD
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246187; cv=none; b=hOAaxvY+hmDyYwT4w7wYxuacqgr8vhOfadONEyx3je8kJmCHQOPdBL2F4Zj6ZgkmxU3i/hUrK5Fzhyu2wJE5iYXTH++hGJ80wGbn71nAwSEPVrTvzuWZSnOBQ2MOSYAV7D3A8moNb+2O7cStTWlMnbHNJ3wdRdJg1digcRt3SOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246187; c=relaxed/simple;
	bh=MwUqckwzYMhZMPo8fTID6X5tG1GkPt73w6JwGixHc28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBwWAkyw+LL7WNbT560PD6XhFugTQWSYHfDJfwJ8Vb6cchDOieGzgenIVVbs9VieLsq1FUwKAC1unzCAamAgZ5W78mDeX0a3U/dkPlJ8WVJ5WZuO50K/ISMzOBvtTkO3W5cPKV4uYykSEDyr3A6UsP/fvOnRZzlnCQq3SFrryVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IHzaS+48; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IHzaS+48; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD792122D;
	Mon, 24 Jun 2024 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsX56RAuRrDeRupzHpGcGvbJ7XQVCd8h3FrSmBrSBLw=;
	b=IHzaS+489NcIo7Rg5VTi6lze5j+509q9gqi08gszGpjrMdrFEFvqxVhY8P1cE8TnHAg2ae
	qft222uUgzXoE9eLTzeQneCfxhCTBPzaPiMWpTnmDHL6YGv4UXohGVpwc0RQYfYMHvihbM
	r7HRqp7MP4MruUPYT+5CH3iQtEK90lI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsX56RAuRrDeRupzHpGcGvbJ7XQVCd8h3FrSmBrSBLw=;
	b=IHzaS+489NcIo7Rg5VTi6lze5j+509q9gqi08gszGpjrMdrFEFvqxVhY8P1cE8TnHAg2ae
	qft222uUgzXoE9eLTzeQneCfxhCTBPzaPiMWpTnmDHL6YGv4UXohGVpwc0RQYfYMHvihbM
	r7HRqp7MP4MruUPYT+5CH3iQtEK90lI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 949A61384C;
	Mon, 24 Jun 2024 16:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZJFJGedeWbVLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:03 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/11] btrfs: pass a btrfs_inode to btrfs_readdir_put_delayed_items()
Date: Mon, 24 Jun 2024 18:23:03 +0200
Message-ID: <9864e42f509d4c2cbdca070f4ee2cb4852ca3632.1719246104.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>
References: <cover.1719246104.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Pass a struct btrfs_inode to btrfs_readdir_put_delayed_items() as it's
an internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 4 ++--
 fs/btrfs/delayed-inode.h | 2 +-
 fs/btrfs/inode.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 7b8b1bd0ca39..3a1b6e120959 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1730,7 +1730,7 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 	return true;
 }
 
-void btrfs_readdir_put_delayed_items(struct inode *inode,
+void btrfs_readdir_put_delayed_items(struct btrfs_inode *inode,
 				     struct list_head *ins_list,
 				     struct list_head *del_list)
 {
@@ -1752,7 +1752,7 @@ void btrfs_readdir_put_delayed_items(struct inode *inode,
 	 * The VFS is going to do up_read(), so we need to downgrade back to a
 	 * read lock.
 	 */
-	downgrade_write(&inode->i_rwsem);
+	downgrade_write(&inode->vfs_inode.i_rwsem);
 }
 
 int btrfs_should_delete_dir_index(const struct list_head *del_list,
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 654c04d38fb3..e30ba7962d44 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -147,7 +147,7 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
-void btrfs_readdir_put_delayed_items(struct inode *inode,
+void btrfs_readdir_put_delayed_items(struct btrfs_inode *inode,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
 int btrfs_should_delete_dir_index(const struct list_head *del_list,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6c43120c5d3..6cddc7841238 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6037,7 +6037,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	ret = 0;
 err:
 	if (put)
-		btrfs_readdir_put_delayed_items(inode, &ins_list, &del_list);
+		btrfs_readdir_put_delayed_items(BTRFS_I(inode), &ins_list, &del_list);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.45.0


