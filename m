Return-Path: <linux-btrfs+bounces-14373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3BDACAC8B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698333BB901
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD011FE45A;
	Mon,  2 Jun 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHEp5Y0K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780920C47A
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860405; cv=none; b=BYUyQdXw3tSrMrEK36KFXg6WaYt3OmxO9ozGSYJyhUHffC1xqL1QRL0mmxeih4ED87X8keXh+Zp2C9Tw75daIwHv4rUKoPCSloxmt13aqya8dJ4My3hIWd+cyYvZhLScwVT91yBBWOtWNP54PXSTCxoTx/2J6aW9SrZUXL9YkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860405; c=relaxed/simple;
	bh=CVcYhEV1xAiASlzCfJxYXCLPyFJnO9ZxhvCZxoI6y08=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqc8VYdb/6ffZ/YMzmQ2ekB+Pd5a6V+SFRUSqEJELFn3RlkbA558NkXfqpYRjHOhF3JyYEUCWAg9iCQ2VXx6Hkze9AhThxMmbY0+4yizh9nhHUwGNG4j+IDcIuKAZscG/hgTpvkAY7pdRMAlE7suSsOhxP5GnXtXSSX8ETxZzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHEp5Y0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF935C4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860405;
	bh=CVcYhEV1xAiASlzCfJxYXCLPyFJnO9ZxhvCZxoI6y08=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WHEp5Y0KrutmBAyWHjrAThQ0aG9ud1GcUnK6CefCzmTNH2eiOezQD5tXwJ78qSegJ
	 KeU7R3y/j78SXvURHCnRLWT/wkIlbahLsI6bk2tLKo6zBy9abtMy4aMA1FZ/SOOJYw
	 5ix3a62hcePCExQlDncaYE+1tYiUvH8fXqyEuoTZGEppTb2MLPefyN8QM2D0DfTCkn
	 knPM+FiW23DNLqtSUsplU3i8VEBtZd3//CDnkvl30WFiZVqaKXUYg7GF1kzW9tnU69
	 ee1DNceSQHhkxGyhUWPVF2k29QiLbe7RiFQ1PziF6REG2etaHITYYOPylVK0xVYDB4
	 5e66GJ5utvP9w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/14] btrfs: make btrfs_delete_delayed_insertion_item() return a boolean
Date: Mon,  2 Jun 2025 11:33:04 +0100
Message-ID: <1deedca73718540536da43079ac50701a98eebaf.1748789125.git.fdmanana@suse.com>
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

There's no need to return an integer as all we need to do is return true
or false to tell whether we deleted a delayed item or not. Also the logic
is inverted since we return 1 (true) if we didn't delete and 0 (false) if
we did, which is somewhat counter intuitive. Change the return type to a
boolean and make it return true if we deleted and false otherwise.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 4f9d7a436f16..6918340f4b38 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1540,8 +1540,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_delete_delayed_insertion_item(struct btrfs_delayed_node *node,
-					       u64 index)
+static bool btrfs_delete_delayed_insertion_item(struct btrfs_delayed_node *node,
+						u64 index)
 {
 	struct btrfs_delayed_item *item;
 
@@ -1549,7 +1549,7 @@ static int btrfs_delete_delayed_insertion_item(struct btrfs_delayed_node *node,
 	item = __btrfs_lookup_delayed_item(&node->ins_root.rb_root, index);
 	if (!item) {
 		mutex_unlock(&node->mutex);
-		return 1;
+		return false;
 	}
 
 	/*
@@ -1584,7 +1584,7 @@ static int btrfs_delete_delayed_insertion_item(struct btrfs_delayed_node *node,
 	}
 
 	mutex_unlock(&node->mutex);
-	return 0;
+	return true;
 }
 
 int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
@@ -1598,9 +1598,10 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (IS_ERR(node))
 		return PTR_ERR(node);
 
-	ret = btrfs_delete_delayed_insertion_item(node, index);
-	if (!ret)
+	if (btrfs_delete_delayed_insertion_item(node, index)) {
+		ret = 0;
 		goto end;
+	}
 
 	item = btrfs_alloc_delayed_item(0, node, BTRFS_DELAYED_DELETION_ITEM);
 	if (!item) {
-- 
2.47.2


