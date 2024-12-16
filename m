Return-Path: <linux-btrfs+bounces-10412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28069F374F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F636188EFF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB2206F03;
	Mon, 16 Dec 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeXsYko9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97B2066D8
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369449; cv=none; b=MKXFtJ0EGWVuoFMtnXJhjYCcR1AcbtMximwUMt/Enp6MadqGM+S4F0gu26SO1yFU0na0FyPvbobZrQvo+5O/EeNOjweZSd8ZnwmaahRibhwmdXlJfj4P9Xp9Ipa8r3/OIaiioSlyvG14INGGoYqTiNJurQq6zau/U+pc84oVbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369449; c=relaxed/simple;
	bh=Xyd6aPrGGEfG+FrodIgUFQcK0eeWL7TsbJ89e+b9R38=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ls67AYIMnDRxuFPc5ZkXr0B8zyADi4XknDbdWe25u+/4KbVrIhOUhP0NNkzjJgqMDoK3dolFUOB81RHzUsKr9Ku1Xpd5mwzlqMlpdL68k4NVd3X1UFEuuCigJF43UKKM+5QEQSUmGcKyhB9ewKR/4TXASRShfdtwWLKLRScrdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeXsYko9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CECC4CEE0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369448;
	bh=Xyd6aPrGGEfG+FrodIgUFQcK0eeWL7TsbJ89e+b9R38=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WeXsYko900qEaiKUSrchgSzLd1G0wKcX2Rf3N9UTPXujafH+0SZXRd3MqFem4wGQM
	 cPiDn+yH7XwKSQKZG7uqa1UKUBOYbuYBb44MqT7ubFObIhKyj/UcyT1M2wH5E4oW3S
	 7KlLMNFm9IHi+CUbOrsW+2IpMZLTmcsHOyCVtOXlrYmkcwrqJI05Htznkolz3XvQTi
	 glRWKZAlePMVmRE5WzSDV2FLzqu038wWVb5seqZpTPigi/nb9Trd8HDlRpUVUh7b9b
	 QvMBxJT3zUBsT6qB+G134LfU6OZOs8vpDdn5aCILpzGGwMJaNnyFm7Ym7Og+5IN4w5
	 wXAfNQR+s/gPA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: move abort_should_print_stack() to transaction.h
Date: Mon, 16 Dec 2024 17:17:16 +0000
Message-Id: <4854187df58426b3435f576eb63fd3f87a479ffe.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function abort_should_print_stack() is declared in transaction.h but
its definition is in ctree.c, which doesn't make sense since ctree.c is
the btree implementation and the function is related to the transaction
code. Move its definition into transaction.h as an inline function since
it's a very short and trivial function, and also add the 'btrfs_' prefix
into its name.

This change also reduces the module size.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1783148	 161137	  16920	1961205	 1decf5	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1782126	 161045	  16920	1960091	 1de89b	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c       | 16 ----------------
 fs/btrfs/transaction.h | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 185985a337b3..99a58ede387e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -225,22 +225,6 @@ noinline void btrfs_release_path(struct btrfs_path *p)
 	}
 }
 
-/*
- * We want the transaction abort to print stack trace only for errors where the
- * cause could be a bug, eg. due to ENOSPC, and not for common errors that are
- * caused by external factors.
- */
-bool __cold abort_should_print_stack(int error)
-{
-	switch (error) {
-	case -EIO:
-	case -EROFS:
-	case -ENOMEM:
-		return false;
-	}
-	return true;
-}
-
 /*
  * safely gets a reference on the root node of a tree.  A lock
  * is not taken, so a concurrent writer may put a different node
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 184fa5c0062a..9f7c777af635 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -227,7 +227,21 @@ static inline void btrfs_clear_skip_qgroup(struct btrfs_trans_handle *trans)
 	delayed_refs->qgroup_to_skip = 0;
 }
 
-bool __cold abort_should_print_stack(int error);
+/*
+ * We want the transaction abort to print stack trace only for errors where the
+ * cause could be a bug, eg. due to ENOSPC, and not for common errors that are
+ * caused by external factors.
+ */
+static inline bool btrfs_abort_should_print_stack(int error)
+{
+	switch (error) {
+	case -EIO:
+	case -EROFS:
+	case -ENOMEM:
+		return false;
+	}
+	return true;
+}
 
 /*
  * Call btrfs_abort_transaction as early as possible when an error condition is
@@ -240,7 +254,7 @@ do {								\
 	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
 			&((trans)->fs_info->fs_state))) {	\
 		__first = true;					\
-		if (WARN(abort_should_print_stack(error),	\
+		if (WARN(btrfs_abort_should_print_stack(error),	\
 			KERN_ERR				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
 			(error))) {					\
-- 
2.45.2


