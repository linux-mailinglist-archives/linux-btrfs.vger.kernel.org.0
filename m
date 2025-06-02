Return-Path: <linux-btrfs+bounces-14376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6974ACAC8E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C57A189F9C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C520C49E;
	Mon,  2 Jun 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCPnPeOy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74B20E32D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860408; cv=none; b=AQigNnM98tIa4yf2IGXIgdszQjv/5tapN7xjWfbZ4AY0qcRGO3XxJEx+d1OWgEeQOqv8g/3QE09/s6K1ZSj6X3FJF1k6CQ2wWOuO8e817+XuE+ix8o2zmEInIfxZ1DTFC9QMjwqPZ/fmR8Xw2cSBp/kNp4WIndsTarc0x8z2nrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860408; c=relaxed/simple;
	bh=FLwlBlNwRagCU9h2JXfbTifHD+FqZP+DCocPPP4MSwM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HenSfoLWm5YtXO0m8okeHD234q8leYxqDAKVfIgshNgpt73U2UwkKK1NaulXBGl/8m2bhdQqPPkufuet/pLhPgOstRZL7iRWOyeWYdCb4zqjj71KkKbT591vgELqIH/+JAhLUx6buqfETwaC0yll2MJOFICJzUVgsoU8DlMdKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCPnPeOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72ABC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860408;
	bh=FLwlBlNwRagCU9h2JXfbTifHD+FqZP+DCocPPP4MSwM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sCPnPeOyfPkwZqrWvPPCL1QOKlboDhM+uli5SR9s1x9v3jm3YX5+v+csYlGtVDesl
	 eN4DqS8EmSpdzUAf6fXHyroEKy8TBMARedrByb1xzKHajSBRqKAD5D5HGZKggQJts7
	 glelp2H/Vx+3yFXTMK0Ou24GiGwCR/t2yX8X6+5vJtGPFZmW2Io3cyGnPABwpb0mD+
	 3NWh6nfKiNpm1ScfQX53ZjAxxnTlYZ7gpFuALfdXQRurakZVTYzrJx0Ib3FNkyf2Wd
	 WIiH7TBVZTMSL+0UZMOGo01qwSahVQzwYERGkBsKnK5I38Xe+mfgjuUcLKI9zgIi6Y
	 T1mrYRWBq427Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/14] btrfs: make btrfs_readdir_delayed_dir_index() return a bool instead
Date: Mon,  2 Jun 2025 11:33:07 +0100
Message-ID: <c2a158a38348d960331efc0b9f925242db28326f.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to return errors, all we do is return 1 or 0 depending
on whether we should or should not stop iterating over delayed dir
indexes. So change the function to return bool instead of an int.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 14 +++++++-------
 fs/btrfs/delayed-inode.h |  4 ++--
 fs/btrfs/inode.c         |  3 +--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 050723ade942..0f8d8e275143 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1753,15 +1753,14 @@ bool btrfs_should_delete_dir_index(const struct list_head *del_list, u64 index)
 /*
  * Read dir info stored in the delayed tree.
  */
-int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
-				    const struct list_head *ins_list)
+bool btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
+				     const struct list_head *ins_list)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_delayed_item *curr, *next;
 	struct btrfs_key location;
 	char *name;
 	int name_len;
-	int over = 0;
 	unsigned char d_type;
 
 	/*
@@ -1770,6 +1769,8 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 	 * directory, nobody can delete any directory indexes now.
 	 */
 	list_for_each_entry_safe(curr, next, ins_list, readdir_list) {
+		bool over;
+
 		list_del(&curr->readdir_list);
 
 		if (curr->index < ctx->pos) {
@@ -1787,17 +1788,16 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 		d_type = fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di->type));
 		btrfs_disk_key_to_cpu(&location, &di->location);
 
-		over = !dir_emit(ctx, name, name_len,
-			       location.objectid, d_type);
+		over = !dir_emit(ctx, name, name_len, location.objectid, d_type);
 
 		if (refcount_dec_and_test(&curr->refs))
 			kfree(curr);
 
 		if (over)
-			return 1;
+			return true;
 		ctx->pos++;
 	}
-	return 0;
+	return false;
 }
 
 static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 73d13fac8917..e6e763ad2d42 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -151,8 +151,8 @@ void btrfs_readdir_put_delayed_items(struct btrfs_inode *inode,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
 bool btrfs_should_delete_dir_index(const struct list_head *del_list, u64 index);
-int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
-				    const struct list_head *ins_list);
+bool btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
+				     const struct list_head *ins_list);
 
 /* Used during directory logging. */
 void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 890d20868250..777f9507f180 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6170,8 +6170,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	if (ret)
 		goto nopos;
 
-	ret = btrfs_readdir_delayed_dir_index(ctx, &ins_list);
-	if (ret)
+	if (btrfs_readdir_delayed_dir_index(ctx, &ins_list))
 		goto nopos;
 
 	/*
-- 
2.47.2


