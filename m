Return-Path: <linux-btrfs+bounces-14162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A16ABF079
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A511F3B3F9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE625A2AB;
	Wed, 21 May 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pHJVsJv4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pHJVsJv4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A025A2DD
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821100; cv=none; b=GDACQchLcJFXoURuG7t8EJsKX5jIAWjhJg0G4Z4yhok+3DDwCldnsOzSzSyoXs8MwBagv4RqUyt364jEj24+2vKJZrZPGHHKbQe2eND4mRlb8D2+rVGwyLgDHqQwT7daTSacHEjUqvtlMGfs62OPKNbgyBDJkQF3SQEb/yFd5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821100; c=relaxed/simple;
	bh=n8CuiUsIDI8xEyOPtku3OUAdPD04Ee5u1GFOOFieRA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9rPacfcu4/zY36rNV4Wyb25/8CIgNJA38u+/oz2V39lkd5i0LGz+fxAvLq8JXG/cGWxKitY0QcCMccoxIuiQwfg3AuHMbVzO9hdL7qHX1IadfkxRgfQ9kWuKeyTWfrmfN9GrLy2X/9JHosUOhIYdnjpaD0AL8YsdFN5ytOruSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pHJVsJv4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pHJVsJv4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E087208F0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwksZ3EPtX51WxyIWYB0ztCzVlLDc4BPhyu/6BaiwVY=;
	b=pHJVsJv4+zfXTQe6QbTQTOleqpFeuiTzblVTKgaB5dkyUgeLgebHwN8hoUDS0uQ/RdfamN
	YeRQP1QMJBTV7OBcU/toDtgcutSslgkkUF3HWJWkOFWoDrBoVvC0h0u6T/uBmDhCLJOpp+
	F04jCtAGfmv1qwXTG4+ZU/b0tDyzqFs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pHJVsJv4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwksZ3EPtX51WxyIWYB0ztCzVlLDc4BPhyu/6BaiwVY=;
	b=pHJVsJv4+zfXTQe6QbTQTOleqpFeuiTzblVTKgaB5dkyUgeLgebHwN8hoUDS0uQ/RdfamN
	YeRQP1QMJBTV7OBcU/toDtgcutSslgkkUF3HWJWkOFWoDrBoVvC0h0u6T/uBmDhCLJOpp+
	F04jCtAGfmv1qwXTG4+ZU/b0tDyzqFs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D011913888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6BSxJCGiLWgBRgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: allow new inodes to inherit flags from their parents
Date: Wed, 21 May 2025 19:21:07 +0930
Message-ID: <4e5a190e3f874219c8463695995b783e6460d499.1747820747.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747820747.git.wqu@suse.com>
References: <cover.1747820747.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8E087208F0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim]

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
index 97bcbf82225c..66a57b333906 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -158,6 +158,59 @@ out:
 	return ret;
 }
 
+/* Similiar to btrfs_inherit_iflags(), but different interfaces. */
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


