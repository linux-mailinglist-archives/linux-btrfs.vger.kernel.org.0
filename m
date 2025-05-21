Return-Path: <linux-btrfs+bounces-14167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09CABF096
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CAE1B65AF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC717259C8A;
	Wed, 21 May 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qFi4THxV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qFi4THxV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475802356A0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821532; cv=none; b=NH43BR4Kh/pPhkKjCONQzMGFC1cR1Xhr7uIBZSntV3zcCUZ726AL8fCNfwEjFoPbA/wUucVcbNozYDkmKmygIYtfmk4pghV1TsX6IeFKZkaJw77MJUmnWSJQijEjNiQofj5aPStY33gUaRnoyyPC0Xque3fnHqJbeqGL6HVc3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821532; c=relaxed/simple;
	bh=QtjTexzCHr4KciWb3BzdOgQca9OahL5WGU7DQeKZklo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spNMm3lmwzPIJnZT2cyB9WCujGT1/uiYgRiCJ22C2j9lmfzg8DOvG+gei5sRk9lWq4bYT1wi1S7tD7AebxFUsk7f6TQad2+lnO8LqfmVQGAHIPccszgFJVrMFWAF2QF9xqmamtF48v2k5d/KFEYDe7h0KMA8HWI9nby+Vu038kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qFi4THxV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qFi4THxV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E65C20907
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PnkKBYNdcBLTkRLmyadjKofax0guQxm63e7pK0LFH8=;
	b=qFi4THxV2WW27gYFLLQwyexoOf1W85sC8I7Tij4hSr8Ppt97t/358YFJ98/NkYNFIfA4WP
	3yHVnUs9zdbeyKQ+Tc90cuo+oBNSwo4XhLVZMgzs6F/vswMxPzvZp3RwJT9fXDYIPYoKDi
	uwZbnyxVN5piomci3nXd9Nsj73gSEmg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PnkKBYNdcBLTkRLmyadjKofax0guQxm63e7pK0LFH8=;
	b=qFi4THxV2WW27gYFLLQwyexoOf1W85sC8I7Tij4hSr8Ppt97t/358YFJ98/NkYNFIfA4WP
	3yHVnUs9zdbeyKQ+Tc90cuo+oBNSwo4XhLVZMgzs6F/vswMxPzvZp3RwJT9fXDYIPYoKDi
	uwZbnyxVN5piomci3nXd9Nsj73gSEmg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0B6913888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eLLMF9CjLWj6RwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs-progs: allow new inodes to inherit flags from their parents
Date: Wed, 21 May 2025 19:28:18 +0930
Message-ID: <dcc413250e3b95dc7a010bf459c410026b9aaf4a.1747821454.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747821454.git.wqu@suse.com>
References: <cover.1747821454.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Inside btrfs-progs (mostly 'mkfs/rootdir.c') new inodes are created in a
different way than the kernel:

- A new orphan inode item is created
  Without knowing the parent inode, thus it will always have the default
  flags (0).

- Link the new inode to a parent

Meanwhile inside the kernel, we know exactly the parent inode at new
inode creation time, and can inherit the inode flags
(NODATACOW/NODATASUM/COMPRESS/etc).

Address the missing ability by:

- Inherit the parent inode flags when linking an orphan inode
  The function btrfs_add_link() is called when linking an inode.

  It can be called to creating the initial link if it's a new and orphan
  inode.
  It can also be called to creating extra hard links.

  If the inode is already orphan, we know it's newly created and should
  inherit the inode flag from the parent.

With this new ability, it will be much easier to implement new per-inode
flags (like NODATACOW/NODATASUM) and get them properly passed down.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/inode.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 97bcbf82225c..f77157a2df14 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -158,6 +158,59 @@ out:
 	return ret;
 }
 
+/* Similar to btrfs_inherit_iflags(), but different interfaces. */
+static int inherit_inode_flags(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root, u64 ino, u64 parent_ino)
+{
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	struct btrfs_inode_item *iitem;
+	u64 parent_inode_flags;
+	u64 child_inode_flags;
+	int ret;
+
+	key.objectid = parent_ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+
+	iitem = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_inode_item);
+	parent_inode_flags = btrfs_inode_flags(path.nodes[0], iitem);
+	btrfs_release_path(&path);
+
+	key.objectid = ino;
+
+	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+	iitem = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_inode_item);
+	child_inode_flags = btrfs_inode_flags(path.nodes[0], iitem);
+
+	if (parent_inode_flags & BTRFS_INODE_NOCOMPRESS) {
+		child_inode_flags &= ~BTRFS_INODE_COMPRESS;
+		child_inode_flags |= BTRFS_INODE_NOCOMPRESS;
+	} else if (parent_inode_flags & BTRFS_INODE_COMPRESS){
+		child_inode_flags &= ~BTRFS_INODE_NOCOMPRESS;
+		child_inode_flags |= BTRFS_INODE_COMPRESS;
+	}
+	if (parent_inode_flags & BTRFS_INODE_NODATACOW) {
+		child_inode_flags |= BTRFS_INODE_NODATACOW;
+		if (S_ISREG(btrfs_inode_mode(path.nodes[0], iitem)))
+			child_inode_flags |= BTRFS_INODE_NODATASUM;
+	}
+	btrfs_set_inode_flags(path.nodes[0], iitem, child_inode_flags);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 /*
  * Add dir_item/index for 'parent_ino' if add_backref is true, also insert a
  * backref from the ino to parent dir and update the nlink(Kernel version does
@@ -220,6 +273,17 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 					      nlink);
 			btrfs_mark_buffer_dirty(path->nodes[0]);
 			btrfs_release_path(path);
+			/*
+			 * If this is the first nlink of the inode, meaning the
+			 * inode is newly created under the parent inode, this
+			 * new child inode should inherit the inode flags from
+			 * the parent.
+			 */
+			if (nlink == 1) {
+				ret = inherit_inode_flags(trans, root, ino, parent_ino);
+				if (ret < 0)
+					goto out;
+			}
 		}
 	}
 
-- 
2.49.0


