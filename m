Return-Path: <linux-btrfs+bounces-1762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC30183B3C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D68C1F27111
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F7135A48;
	Wed, 24 Jan 2024 21:19:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF41353EF
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131157; cv=none; b=gD++6iCBmewXjsQaPToVo1v6VTtMC3zec38vbKxREwDFQAu3tstUdETpIB/KTHSHfT3LpvcgfeM5TB1tc2VasTzRwHc9jT2eusM79fxklVJTjArVEVpkASFvfQO16LCW4eJqqWuYn6b84bEFqdBcCikH95AEyKcKV90eq45IAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131157; c=relaxed/simple;
	bh=yM3vy2wHp7BfzpXlEqRrGSBZnEIOgEMp+3PNQKE+To8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwuVOdxo+ZAthw4unPEGl3ezKv36dlaxVByk1dnFsBe6NtJyf4XWAmXRlbd6X1bBROXXUxDisjEtrIsBu/tmTTsCCdU7KK4h81WI6bHurbdBgbXTTZRT7lMWP8K7u4VAt4so9JuOmsKHsUpGU/TABpvqNp9zvxBy21RQ9qkcQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0603C21F9B;
	Wed, 24 Jan 2024 21:19:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2F2713786;
	Wed, 24 Jan 2024 21:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6D1NO9J+sWX/dwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:19:14 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 20/20] btrfs: move transaction abort to the error site btrfs_rebuild_free_space_tree()
Date: Wed, 24 Jan 2024 22:18:53 +0100
Message-ID: <f1ac2e31b3976021b580d96b634d5889d210b6d4.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0603C21F9B
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The recommended pattern for transaction abort after error is to place it
right after the error is handled. That way it's easier to locate where
it failed and help debugging.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index bdc2341c43e4..90f2938bd743 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1328,8 +1328,11 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 	set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
 
 	ret = clear_free_space_tree(trans, free_space_root);
-	if (ret)
-		goto abort;
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	node = rb_first_cached(&fs_info->block_group_cache_tree);
 	while (node) {
@@ -1338,8 +1341,11 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
 		ret = populate_free_space_tree(trans, block_group);
-		if (ret)
-			goto abort;
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
 		node = rb_next(node);
 	}
 
@@ -1350,10 +1356,6 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 	ret = btrfs_commit_transaction(trans);
 	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
 	return ret;
-abort:
-	btrfs_abort_transaction(trans, ret);
-	btrfs_end_transaction(trans);
-	return ret;
 }
 
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
-- 
2.42.1


