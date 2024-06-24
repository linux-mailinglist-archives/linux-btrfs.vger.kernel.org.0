Return-Path: <linux-btrfs+bounces-5928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AEE91538A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350262868E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3B19DF74;
	Mon, 24 Jun 2024 16:23:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150419E7EC
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246191; cv=none; b=PjVQzcUJLFDL7D27M+Cx1c5PNHWEyAEsy7OzSTLgLPIT3V0MUiWgxVH9OwerZXjcIqlQpIm1agrTAIldqX7FoxShXfg8h56aReqfV78bHArPfKhCbUh+1i4IAldmDli1lpbpwdTOMFmkGvZuO81ZglONVHMxDaI/o90RozDBZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246191; c=relaxed/simple;
	bh=wt63rm3j0CrDy8DEwlr4ZwY01zZZ43Xz+NQ4JMo063g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaBq7lhTOF0rjsF/DfcBJRWa+qBucS/MBAfitDUL1kDZU84aCJ7mv20AJoDeRKL0ZYWV4Rke/lBsAmbqtSWAmFUL3d3KHqEKnKQWfxKgDdbU+lPO9MhG3XbxRFRyPM4/cKCwxLiUlLdXUuFhm0D1SeZXEkflTgcAv0AbjzXnqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 56B931F7A4;
	Mon, 24 Jun 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 504741384C;
	Mon, 24 Jun 2024 16:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vP+WE2ydeWbcLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:08 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/11] btrfs: pass a btrfs_inode to is_data_inode()
Date: Mon, 24 Jun 2024 18:23:08 +0200
Message-ID: <695069ce1c56709962da6cb0131553eb5b88a522.1719246104.git.dsterba@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 56B931F7A4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Pass a struct btrfs_inode to is_data_inode() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c         | 2 +-
 fs/btrfs/btrfs_inode.h | 4 ++--
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/subpage.c     | 4 ++--
 fs/btrfs/zoned.c       | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e3a57196b0ee..f59b00be26f3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -29,7 +29,7 @@ struct btrfs_failed_bio {
 /* Is this a data path I/O that needs storage layer checksum and repair? */
 static inline bool is_data_bbio(struct btrfs_bio *bbio)
 {
-	return bbio->inode && is_data_inode(&bbio->inode->vfs_inode);
+	return bbio->inode && is_data_inode(bbio->inode);
 }
 
 static bool bbio_has_ordered_extent(struct btrfs_bio *bbio)
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b0fe610d5940..8b45d7e85d86 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -418,9 +418,9 @@ static inline bool btrfs_is_free_space_inode(const struct btrfs_inode *inode)
 	return test_bit(BTRFS_INODE_FREE_SPACE_INODE, &inode->runtime_flags);
 }
 
-static inline bool is_data_inode(const struct inode *inode)
+static inline bool is_data_inode(const struct btrfs_inode *inode)
 {
-	return btrfs_ino(BTRFS_I(inode)) != BTRFS_BTREE_INODE_OBJECTID;
+	return btrfs_ino(inode) != BTRFS_BTREE_INODE_OBJECTID;
 }
 
 static inline void btrfs_mod_outstanding_extents(struct btrfs_inode *inode,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0ec87ccb372b..c7a9284e45e1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -860,7 +860,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 		/* Cap to the current ordered extent boundary if there is one. */
 		if (len > bio_ctrl->len_to_oe_boundary) {
 			ASSERT(bio_ctrl->compress_type == BTRFS_COMPRESS_NONE);
-			ASSERT(is_data_inode(&inode->vfs_inode));
+			ASSERT(is_data_inode(inode));
 			len = bio_ctrl->len_to_oe_boundary;
 		}
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 1a4717bcce23..8ddd5fcbeb93 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -74,7 +74,7 @@ bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space
 	 * mapping. And if page->mapping->host is data inode, it's subpage.
 	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
 	 */
-	if (!mapping || !mapping->host || is_data_inode(mapping->host))
+	if (!mapping || !mapping->host || is_data_inode(BTRFS_I(mapping->host)))
 		return true;
 
 	/*
@@ -283,7 +283,7 @@ void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 	bool last;
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
-	is_data = is_data_inode(folio->mapping->host);
+	is_data = is_data_inode(BTRFS_I(folio->mapping->host));
 
 	spin_lock_irqsave(&subpage->lock, flags);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 992a5b7756ca..8a99f5187e30 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1723,7 +1723,7 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 	if (!btrfs_is_zoned(fs_info))
 		return false;
 
-	if (!inode || !is_data_inode(&inode->vfs_inode))
+	if (!inode || !is_data_inode(inode))
 		return false;
 
 	if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE)
-- 
2.45.0


