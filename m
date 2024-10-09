Return-Path: <linux-btrfs+bounces-8718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E95996DFE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C7F283796
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB8219D088;
	Wed,  9 Oct 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OtQoyW+l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OtQoyW+l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2445948
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484345; cv=none; b=klLjrVUM28MZ3pXAR//F+Q5omkuzh8vpya/z19BkxgYuVwG8cbkCw1b2N2w5gYcdp34Lk8R04Nh7hT9L11wiv4n5eAtu6Yba1UIlHKOmexh2I4Ba2KTXQZMIjl1DKR/5/n58ZbpZ9N6CAvuIchDO7KZ1zzMUHxXhIPo/9+9EwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484345; c=relaxed/simple;
	bh=OdgxQXj9zg/DcimDzlCiANcb4hIO/U7rxef24VUs8ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLGjTtlSdX4Lq9LBf8V9uUPFUK52KofW8octsPNv95dwmxwEIIzFQ7SZrBwNvw69ixW1vL5AfVNjqBDAAe5Z0hU7yMZMTmI80ZTzhNan7MLOUY3sySKpqusZ9qkix0CWmDTtwzYH8h9nreletpYVEplSsDaLVvtB0O5x3AZyaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OtQoyW+l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OtQoyW+l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C52B81F7C8;
	Wed,  9 Oct 2024 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfE8myydflxnDyJzGo1zSw4oD+zl7wIRVlkm981Yo3E=;
	b=OtQoyW+ltsDFKp+nm0kxpcFrd5ILiOWE1g20m5V9/NqBesmbryQ7BCL2fJjiJkeSv/bgqz
	Qfzmt08cunYN9O7912Hpqlkvme5eRkrzhxJ2BtnEufI6p9vb08tNRV8LBx6sagVTUwlWSY
	OgjjXTCDOZT82+GvvhKPDtEaPx5Zupg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfE8myydflxnDyJzGo1zSw4oD+zl7wIRVlkm981Yo3E=;
	b=OtQoyW+ltsDFKp+nm0kxpcFrd5ILiOWE1g20m5V9/NqBesmbryQ7BCL2fJjiJkeSv/bgqz
	Qfzmt08cunYN9O7912Hpqlkvme5eRkrzhxJ2BtnEufI6p9vb08tNRV8LBx6sagVTUwlWSY
	OgjjXTCDOZT82+GvvhKPDtEaPx5Zupg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE977136BA;
	Wed,  9 Oct 2024 14:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wRiGLvSTBmeORQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:32:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 23/25] btrfs: drop unused parameter transaction from alloc_log_tree()
Date: Wed,  9 Oct 2024 16:32:20 +0200
Message-ID: <6e5879eed07ea8c5f565d4d4153fb0a5c5193233.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The function got split in commit 6ab6ebb76042d3 ("btrfs: split
alloc_log_tree()") and since then transaction parameter has been unused.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 92c7dbeade1c..a4c8778dd651 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -917,8 +917,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	return ERR_PTR(ret);
 }
 
-static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
-					 struct btrfs_fs_info *fs_info)
+static struct btrfs_root *alloc_log_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
 
@@ -966,7 +965,7 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *log_root;
 
-	log_root = alloc_log_tree(trans, fs_info);
+	log_root = alloc_log_tree(fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
@@ -992,7 +991,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_inode_item *inode_item;
 	int ret;
 
-	log_root = alloc_log_tree(trans, fs_info);
+	log_root = alloc_log_tree(fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
-- 
2.45.0


