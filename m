Return-Path: <linux-btrfs+bounces-5929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E636F91538E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A155D285F9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD8719E822;
	Mon, 24 Jun 2024 16:23:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44E19E804
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246194; cv=none; b=NwmhiPZydqYyM8HHYWeNftMk+rVaiYBdL7wwaCZ8aTG8CELlsgXUqgFVuIy0Ii/fBNjvfzGMSV31COW36GgZGsnI/uZigkLz5krvyU5ubfzKGTc/xviIiG64z7uY2jvPu86Itx3pYtDQlptM1iB7vYr586tWJDmpESsPcFBZ6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246194; c=relaxed/simple;
	bh=NCEtgbSh8DxCJxm7eugCF+K3RwqtiSsVSMmd94MPG9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDn0Ru69OAOhFPe/DoLzSqeHHp2uzKcssHhi2js8I3urrSohx+5R2iD+idPLlrnkZxSFIeB59KKkG2Gz1Mixed/MCd9pldvKyo3iZx8Qmy5ASFhPOG8kehXlPn/5F82wqP1jrLtZoDJm/jwiXZQ5phqyGeQ1iQDS34amb5Wi4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B57A421963;
	Mon, 24 Jun 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF0501384C;
	Mon, 24 Jun 2024 16:23:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OiG4Km6deWbhLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/11] btrfs: switch btrfs_block_group::inode to struct btrfs_inode
Date: Mon, 24 Jun 2024 18:23:10 +0200
Message-ID: <bf12a6ddd428a2bee3988fed0c5de38d4399f581.1719246104.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B57A421963
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

The structure is internal so we should use struct btrfs_inode for that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c      | 4 ++--
 fs/btrfs/block-group.h      | 2 +-
 fs/btrfs/free-space-cache.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9f1d328b603e..6a9d895add25 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4327,13 +4327,13 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 		spin_lock(&block_group->lock);
 		if (test_and_clear_bit(BLOCK_GROUP_FLAG_IREF,
 				       &block_group->runtime_flags)) {
-			struct inode *inode = block_group->inode;
+			struct btrfs_inode *inode = block_group->inode;
 
 			block_group->inode = NULL;
 			spin_unlock(&block_group->lock);
 
 			ASSERT(block_group->io_ctl.inode == NULL);
-			iput(inode);
+			iput(&inode->vfs_inode);
 		} else {
 			spin_unlock(&block_group->lock);
 		}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 85e2d4cd12dc..084f117550f8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -115,7 +115,7 @@ struct btrfs_caching_control {
 
 struct btrfs_block_group {
 	struct btrfs_fs_info *fs_info;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	spinlock_t lock;
 	u64 start;
 	u64 length;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ae1a987fe518..c29c8ef9bd6a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -137,7 +137,7 @@ struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
 
 	spin_lock(&block_group->lock);
 	if (block_group->inode)
-		inode = igrab(block_group->inode);
+		inode = igrab(&block_group->inode->vfs_inode);
 	spin_unlock(&block_group->lock);
 	if (inode)
 		return inode;
@@ -156,7 +156,7 @@ struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
 	}
 
 	if (!test_and_set_bit(BLOCK_GROUP_FLAG_IREF, &block_group->runtime_flags))
-		block_group->inode = igrab(inode);
+		block_group->inode = BTRFS_I(igrab(inode));
 	spin_unlock(&block_group->lock);
 
 	return inode;
-- 
2.45.0


