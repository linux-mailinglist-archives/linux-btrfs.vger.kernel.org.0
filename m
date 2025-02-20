Return-Path: <linux-btrfs+bounces-11623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF384A3D5E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A973BBF8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B61F3BA4;
	Thu, 20 Feb 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NwT/NrWI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t+o73we/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DD1F0E38
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045689; cv=none; b=P0VQjuj/GcxfZvBeyGBx0y3QOEHtV7KdrmuBkEyZrfQfBNX1bqTuhuMnF9lAi4tartXPDNQtOl9mvvQgBbNKc6e63yayudqCeP2yvdsUFISNiqanHCoDihnBT19640vdHQdB5M+bvVuJySi+RDSmYVh6k/s/VaMw3QgEHCgfnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045689; c=relaxed/simple;
	bh=cpbEOqesFs/Itv2dqrj0x78fYQFkirpc1A+f2mjDerY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvuTCUDROuQk64Zz6DDmatewqVSbfZ1S1zRONgEEenJ6P9kuPBkWyX4nVAXlQrFHPhzmtay5YqKvEsVhKpidVpWUhOsT7TsFha9ijHpUAH2NPoqJi0KkUvpbhaXA0fKB60fqGzjir2P0skqr/gvcu/GKb42WbgPjgRdhdGAwH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NwT/NrWI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t+o73we/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF14C1F38D;
	Thu, 20 Feb 2025 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7xBHBXz9PjJyS98hHHVIHTcskY3AxNFaBXUU73epLw=;
	b=NwT/NrWIjoB3fklK0ZViMsORpYl8jr0Pt9/OhXXjLn1EUS/2rP/baGTluTlzHPf6uYqPd5
	gVkjBMbGTDetOW3O1TO0Ses1fw/Hk1D1tyaduTr9lZesTFr62rzE9tRD9SAupLyDB0YhKd
	SRgp5ommh/XoG+E51alFegZJf7ML/Wo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="t+o73we/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7xBHBXz9PjJyS98hHHVIHTcskY3AxNFaBXUU73epLw=;
	b=t+o73we/u2P5mQS4lnQMnQrDM7ev3mXuSvkPVQMgfBSdVJEwm7q1wY2XP1hihuC3eQHfIX
	3WgQ2cNfBDSwJZnQMtV+PQ6m4WURgXCn52kMbp1xokPJccgvOSPxAndZZoumkJ3K/lrnsm
	ocbS/w7KADQe1hZ8xdejcuPglbl9arA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC4C113301;
	Thu, 20 Feb 2025 10:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LijHNW/9tmd9fwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/22] btrfs: pass struct btrfs_inode to btrfs_fill_inode()
Date: Thu, 20 Feb 2025 11:01:15 +0100
Message-ID: <1fa9fcdb29ad9f32578570d3248fe2ac6c3045a0.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF14C1F38D
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Pass a struct btrfs_inode to btrfs_fill_inode() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 49 ++++++++++++++++++++--------------------
 fs/btrfs/delayed-inode.h |  2 +-
 fs/btrfs/inode.c         |  2 +-
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index bcafbb5ba61d..b18052213a5d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1856,13 +1856,14 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_timespec_nsec(&inode_item->otime, inode->i_otime_nsec);
 }
 
-int btrfs_fill_inode(struct inode *inode, u32 *rdev)
+int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 {
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_inode_item *inode_item;
+	struct inode *vfs_inode = &inode->vfs_inode;
 
-	delayed_node = btrfs_get_delayed_node(BTRFS_I(inode));
+	delayed_node = btrfs_get_delayed_node(inode);
 	if (!delayed_node)
 		return -ENOENT;
 
@@ -1875,39 +1876,39 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 
 	inode_item = &delayed_node->inode_item;
 
-	i_uid_write(inode, btrfs_stack_inode_uid(inode_item));
-	i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
-	btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(inode_item));
-	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
-			round_up(i_size_read(inode), fs_info->sectorsize));
-	inode->i_mode = btrfs_stack_inode_mode(inode_item);
-	set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
-	inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
-	BTRFS_I(inode)->generation = btrfs_stack_inode_generation(inode_item);
-        BTRFS_I(inode)->last_trans = btrfs_stack_inode_transid(inode_item);
+	i_uid_write(vfs_inode, btrfs_stack_inode_uid(inode_item));
+	i_gid_write(vfs_inode, btrfs_stack_inode_gid(inode_item));
+	btrfs_i_size_write(inode, btrfs_stack_inode_size(inode_item));
+	btrfs_inode_set_file_extent_range(inode, 0,
+			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
+	vfs_inode->i_mode = btrfs_stack_inode_mode(inode_item);
+	set_nlink(vfs_inode, btrfs_stack_inode_nlink(inode_item));
+	inode_set_bytes(vfs_inode, btrfs_stack_inode_nbytes(inode_item));
+	inode->generation = btrfs_stack_inode_generation(inode_item);
+        inode->last_trans = btrfs_stack_inode_transid(inode_item);
 
-	inode_set_iversion_queried(inode,
+	inode_set_iversion_queried(vfs_inode,
 				   btrfs_stack_inode_sequence(inode_item));
-	inode->i_rdev = 0;
+	vfs_inode->i_rdev = 0;
 	*rdev = btrfs_stack_inode_rdev(inode_item);
 	btrfs_inode_split_flags(btrfs_stack_inode_flags(inode_item),
-				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
+				&inode->flags, &inode->ro_flags);
 
-	inode_set_atime(inode, btrfs_stack_timespec_sec(&inode_item->atime),
+	inode_set_atime(vfs_inode, btrfs_stack_timespec_sec(&inode_item->atime),
 			btrfs_stack_timespec_nsec(&inode_item->atime));
 
-	inode_set_mtime(inode, btrfs_stack_timespec_sec(&inode_item->mtime),
+	inode_set_mtime(vfs_inode, btrfs_stack_timespec_sec(&inode_item->mtime),
 			btrfs_stack_timespec_nsec(&inode_item->mtime));
 
-	inode_set_ctime(inode, btrfs_stack_timespec_sec(&inode_item->ctime),
+	inode_set_ctime(vfs_inode, btrfs_stack_timespec_sec(&inode_item->ctime),
 			btrfs_stack_timespec_nsec(&inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime_sec = btrfs_stack_timespec_sec(&inode_item->otime);
-	BTRFS_I(inode)->i_otime_nsec = btrfs_stack_timespec_nsec(&inode_item->otime);
+	inode->i_otime_sec = btrfs_stack_timespec_sec(&inode_item->otime);
+	inode->i_otime_nsec = btrfs_stack_timespec_nsec(&inode_item->otime);
 
-	inode->i_generation = BTRFS_I(inode)->generation;
-	if (S_ISDIR(inode->i_mode))
-		BTRFS_I(inode)->index_cnt = (u64)-1;
+	vfs_inode->i_generation = inode->generation;
+	if (S_ISDIR(vfs_inode->i_mode))
+		inode->index_cnt = (u64)-1;
 
 	mutex_unlock(&delayed_node->mutex);
 	btrfs_release_delayed_node(delayed_node);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index f4d9feac0d0e..c4b4ba122beb 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -133,7 +133,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode);
 
 int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 			       struct btrfs_inode *inode);
-int btrfs_fill_inode(struct inode *inode, u32 *rdev);
+int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev);
 int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode);
 
 /* Used for drop dead root */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef02ba48522a..c21d60de936d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3865,7 +3865,7 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 	if (ret)
 		goto out;
 
-	ret = btrfs_fill_inode(vfs_inode, &rdev);
+	ret = btrfs_fill_inode(inode, &rdev);
 	if (!ret)
 		filled = true;
 
-- 
2.47.1


