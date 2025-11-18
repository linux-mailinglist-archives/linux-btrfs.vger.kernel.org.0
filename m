Return-Path: <linux-btrfs+bounces-19095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D04C6A7FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27E624EB98A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9336B059;
	Tue, 18 Nov 2025 16:01:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B31369990
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481672; cv=none; b=VHv3vnNg22mclxGaHmPTjdMS6WqccOQOC22dI48Z1n8DDC87MUhXvWsDNBgqOnN2D4z6n1eu4lsm9PgO9xpPLdsdG/M7n4HjqVTTrgWzlDc8omN99tHqX1cId6lAexprWetiW7UQsR8omh2qbnvQmOTfzrMHDByG/ocSRN/AUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481672; c=relaxed/simple;
	bh=eQaGiBGI7QDJGR9sw+SddJxeZY7/xSEdUXr+OnfvMe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIFrd27W4MFxkXymHwgls7PS9RqCzB3JApEneyH1DIjxGlZLZ3vX5EFRUlBIx8vCtXxby400NMDl95CFrx4F3+F8T4f+DSljtb206JZC24a2a27RNON03vUD5Ct1c8n5yvYCmTwRwCdxul7v158Uhu5HChiptmYPRSEGIh/lfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5DA22121F;
	Tue, 18 Nov 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 994DF3EA61;
	Tue, 18 Nov 2025 16:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AK/qJDyYHGkSWgAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 18 Nov 2025 16:01:00 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Daniel Vacek <neelx.g@gmail.com>
Subject: [PATCH v7 1/6] btrfs: disable various operations on encrypted inodes
Date: Tue, 18 Nov 2025 17:00:36 +0100
Message-ID: <20251118160043.3005684-2-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118160043.3005684-1-neelx@suse.com>
References: <20251118160043.3005684-1-neelx@suse.com>
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
X-Rspamd-Queue-Id: B5DA22121F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]

From: Omar Sandoval <osandov@osandov.com>

Initially, only normal data extents will be encrypted. This change
forbids various other bits:
- allows reflinking only if both inodes have the same encryption status
- disable inline data on encrypted inodes

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
--
v5 was 'Reviewed-by: Boris Burkov <boris@bur.io>' but the rebase changed
the code a bit so dropping.
https://lore.kernel.org/linux-btrfs/20240124195303.GC1789919@zen.localdomain/
Signed-off-by: Daniel Vacek <neelx.g@gmail.com>
---
 fs/btrfs/inode.c   | 4 ++++
 fs/btrfs/reflink.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f71a5f7f55b9..8e13117eca16 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -592,6 +592,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	if (size < i_size_read(&inode->vfs_inode))
 		return false;
 
+	/* Encrypted file cannot be inlined. */
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return false;
+
 	return true;
 }
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 775a32a7953a..3c9c570d6493 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/blkdev.h>
+#include <linux/fscrypt.h>
 #include <linux/iversion.h>
 #include "ctree.h"
 #include "fs.h"
@@ -789,6 +790,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		ASSERT(inode_in->vfs_inode.i_sb == inode_out->vfs_inode.i_sb);
 	}
 
+	/*
+	 * Can only reflink encrypted files if both files are encrypted.
+	 */
+	if (IS_ENCRYPTED(&inode_in->vfs_inode) != IS_ENCRYPTED(&inode_out->vfs_inode))
+		return -EINVAL;
+
 	/* Don't make the dst file partly checksummed */
 	if ((inode_in->flags & BTRFS_INODE_NODATASUM) !=
 	    (inode_out->flags & BTRFS_INODE_NODATASUM)) {
-- 
2.51.0


