Return-Path: <linux-btrfs+bounces-19145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD42C6E94E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96A2E3A513B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749533596EB;
	Wed, 19 Nov 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOZq421x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851E3559C9
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556145; cv=none; b=jHuwijl4zLjQ4ucxM3oHOqVsSD8XvHkHRM9yCWYUW+CWHhInF1lX6GHOsH2kDmjcihxZjwkO0FuZNsBMwaHqsem/fSk0rCxNYxJ+8YzFW4m1Da70b/ioC15nVPW5yclSJ3RKKOuBpZ4A+tWqBwLguqfazM+diS6X6kh01GesQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556145; c=relaxed/simple;
	bh=4+1xoWmkX5QbeqmCotrccysMzURPLoQQqY3HlMmRjvw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SPAOUE27IgQJkEGcqF227o8CdR1Qvk/0y/YaNQd5UDegpFLN/hKMs/QpE5M+TJworpKeV9irsQpBha6GRBe67NrbChcU2GxsggvA0nRrGGXuBa3F1GCyV4YE5NP2yUJuQW3GJaZPir7oMxH8TxWPJoNxT+RV5cpPjke57Ad/jWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOZq421x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A789AC19422
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763556145;
	bh=4+1xoWmkX5QbeqmCotrccysMzURPLoQQqY3HlMmRjvw=;
	h=From:To:Subject:Date:From;
	b=pOZq421xUVKWM0gEe9fcnYOPdPxk8g+tFhECUPTiPP5sKJolLwf9DDxylpegrIU8e
	 RarwirLV/po/+C26zBw5e72yBanTOxWfP3D1cyJOgb06f+EzZpT7EE1qe/MWrVFfhf
	 P+fgMrPbcwOJIbRw68hqSGyyZXKphUvCyDfAk2an3ExVvHkFqLbmz/XYNawSkfzVVG
	 Tj+XARudkt/Y/HnhK/NtR5RKM6OcmHuYMHGzbHSZqAaYWeQiEYcwEjc5pLMMUhWOYh
	 Z1Gb6+pI799copRTAolKpweWhWcHLYGMxpe2driUqQiiK5RQrYf8NF/J6IZBJzLj13
	 ncqFjZUNm9/9Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use test_and_set_bit() in btrfs_delayed_delete_inode_ref()
Date: Wed, 19 Nov 2025 12:42:19 +0000
Message-ID: <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of testing and setting the BTRFS_DELAYED_NODE_DEL_IREF bit in the
delayed node's flags, use test_and_set_bit() which makes the code shorter
without compromising readability and getting rid of the label and goto.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e77a597580c5..ce6e9f8812e0 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -2008,13 +2008,10 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	 *   It is very rare.
 	 */
 	mutex_lock(&delayed_node->mutex);
-	if (test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags))
-		goto release_node;
-
-	set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags);
-	delayed_node->count++;
-	atomic_inc(&fs_info->delayed_root->items);
-release_node:
+	if (!test_and_set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags)) {
+		delayed_node->count++;
+		atomic_inc(&fs_info->delayed_root->items);
+	}
 	mutex_unlock(&delayed_node->mutex);
 	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
-- 
2.47.2


