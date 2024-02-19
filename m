Return-Path: <linux-btrfs+bounces-2494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF085A1AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83C6B221C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017DE2C1A6;
	Mon, 19 Feb 2024 11:13:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01A2C1A0
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341215; cv=none; b=KSxXMOJJtXghiWK0N8AowR5alYVRZffLL+1MfEkDtWRn1hGUFtEAqFn4CJdGILD3NJoERwEgpuBtgrIe8QI3cVwVYjMDaW0RRWWN0KZCjx8mlnGHBBKoN048sodUEo0bko3B1zSjZXR0YwOXN2IwvfrSQuoem6Z6jJpbiCHQ9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341215; c=relaxed/simple;
	bh=Hd1VbZU4HB0J8/iqgBma1PP2phq3kvF9eyKnCmISFI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP7wmysepM2W3xu824rZC1lD0PZbejJAxBybfZpSeSJtvIzJAsyjFWRCD43zWOz5dv3/QRD9DuAgJRcjZVeurp2y6X+QX7yvW1OWOStGp5lcrqqnPPVhZybKzJFM/AI1L6jBe6Gn76lk6rpcVzVIGyoOKRJelBNtQFy/m9nSNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3594222301;
	Mon, 19 Feb 2024 11:13:32 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F6D9139C6;
	Mon, 19 Feb 2024 11:13:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ij+SC9w302WNZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/10] btrfs: uninline btrfs_init_delayed_root()
Date: Mon, 19 Feb 2024 12:12:57 +0100
Message-ID: <078d8fb0a771a36a95c65236393774891b0e9f48.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 3594222301
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

This is a simple initializer and not on any hot path, it does not need
to be static inline.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 11 +++++++++++
 fs/btrfs/delayed-inode.h | 13 +------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index efe435403b77..920225658fb1 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -43,6 +43,17 @@ void __cold btrfs_delayed_inode_exit(void)
 	kmem_cache_destroy(delayed_node_cache);
 }
 
+void btrfs_init_delayed_root(struct btrfs_delayed_root *delayed_root)
+{
+	atomic_set(&delayed_root->items, 0);
+	atomic_set(&delayed_root->items_seq, 0);
+	delayed_root->nodes = 0;
+	spin_lock_init(&delayed_root->lock);
+	init_waitqueue_head(&delayed_root->wait);
+	INIT_LIST_HEAD(&delayed_root->node_list);
+	INIT_LIST_HEAD(&delayed_root->prepare_list);
+}
+
 static inline void btrfs_init_delayed_node(
 				struct btrfs_delayed_node *delayed_node,
 				struct btrfs_root *root, u64 inode_id)
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 3870a4bf7189..64e115d97499 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -106,18 +106,7 @@ struct btrfs_delayed_item {
 	char data[] __counted_by(data_len);
 };
 
-static inline void btrfs_init_delayed_root(
-				struct btrfs_delayed_root *delayed_root)
-{
-	atomic_set(&delayed_root->items, 0);
-	atomic_set(&delayed_root->items_seq, 0);
-	delayed_root->nodes = 0;
-	spin_lock_init(&delayed_root->lock);
-	init_waitqueue_head(&delayed_root->wait);
-	INIT_LIST_HEAD(&delayed_root->node_list);
-	INIT_LIST_HEAD(&delayed_root->prepare_list);
-}
-
+void btrfs_init_delayed_root(struct btrfs_delayed_root *delayed_root);
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
 				   struct btrfs_inode *dir,
-- 
2.42.1


