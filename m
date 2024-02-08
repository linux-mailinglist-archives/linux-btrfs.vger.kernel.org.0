Return-Path: <linux-btrfs+bounces-2237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D684DC3D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840CB1C26B1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656BD6BFB2;
	Thu,  8 Feb 2024 09:00:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56E6BFA9
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382842; cv=none; b=ZW/yyu1Yzjs68dh/6jxDElna6NVaRx9EJFDj1/jB06SLNILcUnHFf5R+3Z0ZuDoQpffNjLwqs//xmN6z8YjyLDNSZw2eenDyuhvIU0E6T0CW4C1r0OXinCM9KBUtiIfaWDPijKTgN7Aok2HMI1qzR4LJwsFKOXEJpxKXS4YQWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382842; c=relaxed/simple;
	bh=6i4adDmcjAEF0lPe6PDGE+HTk1kYibUyDWk6ObIGKyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHUGBUsUg+S7qELZsWnZz8ZE/k3u8Rgn4Ov1/U9kpO2Cq7Hk2CbkkjEioDKKQZxC3n2Dzsg0RPEvroiZAZAIiU90e9YNeBX+f5IC/RIoh4KFe2HuPChh5P4Qd9LxujEm3a9ALiw3yoM2+YT0Y5v9fRddEYmbyp+diisHBfFOAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB72621E6F;
	Thu,  8 Feb 2024 09:00:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4C6C13984;
	Thu,  8 Feb 2024 09:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bOE5KDeYxGWqDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:39 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 13/14] btrfs: handle unexpected parent block offset in btrfs_alloc_tree_block()
Date: Thu,  8 Feb 2024 10:00:10 +0100
Message-ID: <89b72a65f0b33c1fee65d6b945d5e9c29e799318.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: AB72621E6F
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Change a BUG_ON to a proper error handling, here it checks that a root
other than reloc tree does not see a non-zero offset. This is set by
btrfs_force_cow_block() and is a special case so the check makes sure
it's not accidentally set by other callers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0d72d0f7cefc..3708f886d21a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5187,8 +5187,16 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 			parent = ins.objectid;
 		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
 		owning_root = reloc_src_root;
-	} else
-		BUG_ON(parent > 0);
+	} else {
+		if (unlikely(parent > 0)) {
+			/*
+			 * Other roots than reloc tree don't expect start
+			 * offset of a parent block.
+			 */
+			ret = -EUCLEAN;
+			goto out_free_reserved;
+		}
+	}
 
 	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
 		extent_op = btrfs_alloc_delayed_extent_op();
-- 
2.42.1


