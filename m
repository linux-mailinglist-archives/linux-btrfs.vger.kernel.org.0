Return-Path: <linux-btrfs+bounces-1480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B582F359
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55DD285878
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004681CD12;
	Tue, 16 Jan 2024 17:43:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C161CABA
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426991; cv=none; b=d0+ysnxDVHhqgMwf85QUncix2SwUIbQGwVnDYPocgAjbeDG9KUHmvy6tBFgsXs/1dGRzVC1Diczf0q/bHG7qzBIfR9NstgvVb5KH6ziCOYzpTeBw+JHmoIsL0eYdCgbrkAa23b9KUqUWjxgPfv3p/FF01YLM5InA5rtAbpGEE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426991; c=relaxed/simple;
	bh=j11RYQ2mUdz2M68CJO4gtXfYYAiuHbsEFwI/cnQ5s/A=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=dlT8O43pn7FwK1Tl25UmL6IKB69a2d3bJDIJ+9iAuaJMy6lbpGHp6yheeAylpwnAo1/0WmHVI+c/5VPiDOSybsUlkQFEFV97vAn+8rgDgQVWVUwsG+0F64lI/2vFOQYDCkRxiYCbqjFnvIURcP7lhU70pS4YWOF9lNoFsqL1eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C62CD1FD55;
	Tue, 16 Jan 2024 17:43:07 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BED34133CE;
	Tue, 16 Jan 2024 17:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JzWVLivApmUhNAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 16 Jan 2024 17:43:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] brtfs: handle errors returned from unpin_extent_cache()
Date: Tue, 16 Jan 2024 18:42:50 +0100
Message-ID: <ff9b5bf4be2fa57e19339425ec2915b9eb7bd7d8.1705426614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1705426614.git.dsterba@suse.com>
References: <cover.1705426614.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C62CD1FD55
X-Spam-Flag: NO

We've had numerous attempts to let function unpin_extent_cache() return
void as it only returns 0. There are still error cases to handle so do
that, in addition to the verbose messages. The only caller
btrfs_finish_one_ordered() will now abort the transaction, previously it
let it continue which could lead to further problems.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c | 10 +++++++++-
 fs/btrfs/inode.c      |  9 +++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b61099bf97a8..f170e7122e74 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -291,6 +291,10 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
  * Called after an extent has been written to disk properly.  Set the generation
  * to the generation that actually added the file item to the inode so we know
  * we need to sync this extent when we call fsync().
+ *
+ * Returns: 0	     on success
+ * 	    -ENOENT  when the extent is not found in the tree
+ * 	    -EUCLEAN if the found extent does not match the expected start
  */
 int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 {
@@ -308,14 +312,18 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 "no extent map found for inode %llu (root %lld) when unpinning extent range [%llu, %llu), generation %llu",
 			   btrfs_ino(inode), btrfs_root_id(inode->root),
 			   start, len, gen);
+		ret = -ENOENT;
 		goto out;
 	}
 
-	if (WARN_ON(em->start != start))
+	if (WARN_ON(em->start != start)) {
 		btrfs_warn(fs_info,
 "found extent map for inode %llu (root %lld) with unexpected start offset %llu when unpinning extent range [%llu, %llu), generation %llu",
 			   btrfs_ino(inode), btrfs_root_id(inode->root),
 			   em->start, start, len, gen);
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 	em->generation = gen;
 	em->flags &= ~EXTENT_FLAG_PINNED;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7199670599d9..39eb005cd88d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3127,8 +3127,13 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	unpin_extent_cache(inode, ordered_extent->file_offset,
-			   ordered_extent->num_bytes, trans->transid);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+
+	ret = unpin_extent_cache(inode, ordered_extent->file_offset,
+				 ordered_extent->num_bytes, trans->transid);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
-- 
2.42.1


