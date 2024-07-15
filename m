Return-Path: <linux-btrfs+bounces-6454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8260930D87
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189C21F213D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3313B59B;
	Mon, 15 Jul 2024 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="edx5m8rn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SgQo2mp7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1214D2EE
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020954; cv=none; b=GSQEzDKOjPWeYJB1TJiCRqP/el2qhVzJpl4ubHV7YOnIo3UJrVopPZ4jaVdCnvb/bbn35WkBe1CH4jQtYtT5twYZ3glns/SXnGvkWmWgyvKhnDAWNbf7N7nqI3g9EIPXo9Px94Piau1e1o30piqwfA6FnXaf9oOp+QUv3abBvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020954; c=relaxed/simple;
	bh=Xt+5vsUGB7qqkoS9oP/wmmQ3mTBd9ta5fG2frFtaAAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwczw6tC94T9rRuWJ5lQwd5/8TO1S0sxwVHTPWBUKWcnd2seBZU6z++9cRBF5sFwmIqDKqZ2LL4l/mEb8ANrb6hVxOkjnVGL/+32PHNwnzILnDWiZa3p6jTtreKnvK9j8fJTx2bwhmx8SDTWh0l1Q/f93BXPQ9iT6IiLlWvaxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=edx5m8rn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SgQo2mp7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F171821A06
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDGiqqcCtFhY93gfc3sAm8m8hpDyi7hXqY6AgZgscvQ=;
	b=edx5m8rnuSOn+nc04aQZJCorBSQRdFSnNDXe7B2H/RHzk7Z1lq+cB8XlVCZk1FW/SJwNAQ
	yBpLzzE1Zeh6smsHd8I0SB+EEg6uVQBfk96jkpJ2evpx5fWsaqbAasRSFKqv84rV13fOD0
	KLF6nKdj39yh73Wtk1DvlEkshK13dTs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SgQo2mp7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDGiqqcCtFhY93gfc3sAm8m8hpDyi7hXqY6AgZgscvQ=;
	b=SgQo2mp7walNqGBIwwzMn9L5VYfKEJQGaH4GFnucUIV0qrv6RDfTDaPRwdDtSqIgyZv/2S
	3Zg4NaUE2OKAuvve+fIq4EmQZzfX6tIQji+hmOqHsEAUk+ZGfyeMpdqR/mxkLfv7mRAD3G
	5k3QDfLWI2GD+bSB/UpSapJ1d4YvmuQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21605134AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Jc6MxWylGZdRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs-progs: remove fs_info parameter from btrfs_create_tree()
Date: Mon, 15 Jul 2024 14:52:08 +0930
Message-ID: <aeae4d992187732b91392ee565c3fcdf0e2f5389.1721020730.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721020730.git.wqu@suse.com>
References: <cover.1721020730.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F171821A06
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

The @fs_info parameter can be easily extracted from @trans, and kernel
has already remove the parameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/disk-io.c         | 4 ++--
 kernel-shared/disk-io.h         | 1 -
 kernel-shared/free-space-tree.c | 2 +-
 mkfs/main.c                     | 8 ++++----
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 295bd50ad063..3e8cab1187f0 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2369,12 +2369,12 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 }
 
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
-				     struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key)
 {
-	struct extent_buffer *leaf;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *root;
+	struct extent_buffer *leaf;
 	int ret = 0;
 
 	root = kzalloc(sizeof(*root), GFP_KERNEL);
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 9f848635fd69..0047db5e7c3e 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -239,7 +239,6 @@ int write_tree_block(struct btrfs_trans_handle *trans,
 		     struct extent_buffer *eb);
 int btrfs_fs_roots_compare_roots(const struct rb_node *node1, const struct rb_node *node2);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
-				     struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
 int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 93806ca01162..81fd57b886d2 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1516,7 +1516,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	free_space_root = btrfs_create_tree(trans, fs_info, &root_key);
+	free_space_root = btrfs_create_tree(trans, &root_key);
 	if (IS_ERR(free_space_root)) {
 		ret = PTR_ERR(free_space_root);
 		goto abort;
diff --git a/mkfs/main.c b/mkfs/main.c
index b40f7432bb74..077da1e33fc6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -748,7 +748,7 @@ static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
 	char *name = "..";
 	int ret;
 
-	root = btrfs_create_tree(trans, fs_info, &key);
+	root = btrfs_create_tree(trans, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out;
@@ -870,7 +870,7 @@ static int create_uuid_tree(struct btrfs_trans_handle *trans)
 	int ret = 0;
 
 	UASSERT(fs_info->uuid_root == NULL);
-	root = btrfs_create_tree(trans, fs_info, &key);
+	root = btrfs_create_tree(trans, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out;
@@ -900,7 +900,7 @@ static int create_global_root(struct btrfs_trans_handle *trans, u64 objectid,
 	};
 	int ret = 0;
 
-	root = btrfs_create_tree(trans, fs_info, &key);
+	root = btrfs_create_tree(trans, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out;
@@ -1127,7 +1127,7 @@ static int setup_raid_stripe_tree_root(struct btrfs_fs_info *fs_info)
 		return ret;
 	}
 
-	stripe_root = btrfs_create_tree(trans, fs_info, &key);
+	stripe_root = btrfs_create_tree(trans, &key);
 	if (IS_ERR(stripe_root))  {
 		ret = PTR_ERR(stripe_root);
 		btrfs_abort_transaction(trans, ret);
-- 
2.45.2


