Return-Path: <linux-btrfs+bounces-12742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EDAA78530
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF52189065A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D334621ADAE;
	Tue,  1 Apr 2025 23:18:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B381EE00C
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549528; cv=none; b=fW4ls2rvCcUxjbTXxXUXtwgZhWEAN6c9Pssu+AmVDfUgqI9wsq7eaWyXPQp56Y7lYfKUmBRMbP8hzRetOlPXyl/OntjTDDnUNfJJPw+KBt/GY4s4MxYZHptZhWsnwRw133GY5Y0B3LGcIvhzmuu2sBUSsuv88h2gaA2E/Ul5A7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549528; c=relaxed/simple;
	bh=uOGflCyDHOrmAJMW/CM+uxfSJzVbVj7h3p59DKsKGGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN+R/5IkYrj22au0FTlDxleAcIQsVky5qI7Zee3pz2QjZ2/l4VAuOCI58AruSGyZETJmyZvTv9dXVoRpGRZSVwN56Bs6ZkPuk4KQ5nBwMrMVwErf8YGkDEa84zVzgsgV6cSGZgce3/274lr/KGCH/h0Kif2MANGu9hABbZQO/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C1592119D;
	Tue,  1 Apr 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5502313691;
	Tue,  1 Apr 2025 23:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7rG/FEt07Ge/ewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 7/7] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_inode_extref()
Date: Wed,  2 Apr 2025 01:18:12 +0200
Message-ID: <5af9faa81edec6f60713392c420a3e842576cf99.1743549291.git.dsterba@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1743549291.git.dsterba@suse.com>
References: <cover.1743549291.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5C1592119D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode-item.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b920250e9e8ff7..a61c3540d67bad 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -252,7 +252,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	int ret;
 	int ins_len = name->len + sizeof(*extref);
 	unsigned long ptr;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 
@@ -271,13 +271,13 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 						   path->slots[0],
 						   ref_objectid,
 						   name))
-			goto out;
+			return ret;
 
 		btrfs_extend_item(trans, path, ins_len);
 		ret = 0;
 	}
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	ptr = (unsigned long)btrfs_item_ptr(leaf, path->slots[0], char);
@@ -290,9 +290,8 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	ptr = (unsigned long)&extref->name;
 	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
-out:
-	btrfs_free_path(path);
-	return ret;
+
+	return 0;
 }
 
 /* Will return 0, -ENOMEM, -EMLINK, or -EEXIST or anything from the CoW path */
-- 
2.48.1


