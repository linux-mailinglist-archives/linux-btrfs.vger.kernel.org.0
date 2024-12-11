Return-Path: <linux-btrfs+bounces-10251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505BF9ECF57
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1F9188B006
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370491D63F9;
	Wed, 11 Dec 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzq/bdtd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07F1AA1C4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929523; cv=none; b=rwA5KmYwVY+g9ZgpRts4tPq3oZqfcP1VsAH6HRuuu531MODY/Pgk/GFUM/uWL38hDSeWh0nuuQZRHY6T+sRBD9fUxrmDmoDLEbrPPcvBvVlKr31zd3iDUYzkHOpXKLq/Nfzwn1xTxOVkpxaj7eFqliUI3W9zjl0Hm4MMO2ACt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929523; c=relaxed/simple;
	bh=lyylCpMnPWd8cxqGJQy1DhvFdCfY03ZvFNciJeweZdE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aey7nLGEB1RV/QLxkm/Tfl10SEOpXCIoYpeiJJXPxZUxEDLNQmlAxiXEB9rQ1Yu9cqtoI8iJbHIwgwn4CMCqWbIQcHv/AZAsp0nPPr+1SJiCF6ifpahmQHEk/YQ2akIsbL0OmBF9Zybwd7+T6y5MhBuD06Q2W1gcdQvAEhh2JcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzq/bdtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE535C4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929523;
	bh=lyylCpMnPWd8cxqGJQy1DhvFdCfY03ZvFNciJeweZdE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Nzq/bdtd8TPwzEZTtluQlKTDdu2rRi2Mp5ezG5imuVB5IGEDFOgc7ocS8Pjd7lEp4
	 IEGRo4Do51h9A/A4Rm4JQqGUeekd0AuhEq4UHJK2n/+H7z5xuHKXkWXOrN+It1aafU
	 S6HbNImxGX5Gtqa27zIsBk+qAHC6VhYzZDTuthlmgVjZYJbR1PsojZ1Cy7aDAwEUtC
	 X1goWnVvl/VF5+1KiUvk+eCE8iUBTBDxtHcWGIgR2OEgR09kqhZChbhg4N5AkL1/et
	 bYYGdMRYjBQzPnwVF0KDFx3xJ6GbqddRIYfTG+L+zBXzDSw0ZObTJsOFz+ip87xVR5
	 UjnPxxq8yZ2Uw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/11] btrfs: add assertions and comment about path expectations to btrfs_cross_ref_exist()
Date: Wed, 11 Dec 2024 15:05:08 +0000
Message-Id: <4d5d175428bb38d17fc2214f8f31f511298ba67f.1733929328.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We should always call check_delayed_ref() with a path having a locked leaf
from the extent tree where either the extent item is located or where it
should be located in case it doesn't exist yet (when there's a pending
unflushed delayed ref to do it), as we need to lock any existing delayed
ref head while holding such leaf locked in order to avoid races with
flushing delayed references, which could make us think an extent is not
shared when it really is.

So add some assertions and a comment about such expectations to
btrfs_cross_ref_exist(), which is the only caller of check_delayed_ref().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
 fs/btrfs/locking.h     |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index bd13059299e1..0f30f53f51b9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2426,6 +2426,31 @@ int btrfs_cross_ref_exist(struct btrfs_inode *inode, u64 offset,
 		if (ret && ret != -ENOENT)
 			goto out;
 
+		/*
+		 * The path must have a locked leaf from the extent tree where
+		 * the extent item for our extent is located, in case it exists,
+		 * or where it should be located in case it doesn't exist yet
+		 * because it's new and its delayed ref was not yet flushed.
+		 * We need to lock the delayed ref head at check_delayed_ref(),
+		 * if one exists, while holding the leaf locked in order to not
+		 * race with delayed ref flushing, missing references and
+		 * incorrectly reporting that the extent is not shared.
+		 */
+		if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
+			struct extent_buffer *leaf = path->nodes[0];
+
+			ASSERT(leaf != NULL);
+			btrfs_assert_tree_read_locked(leaf);
+
+			if (ret != -ENOENT) {
+				struct btrfs_key key;
+
+				btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+				ASSERT(key.objectid == bytenr);
+				ASSERT(key.type == BTRFS_EXTENT_ITEM_KEY);
+			}
+		}
+
 		ret = check_delayed_ref(inode, path, offset, bytenr);
 	} while (ret == -EAGAIN && !path->nowait);
 
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 35036b151bf5..c69e57ff804b 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -199,8 +199,13 @@ static inline void btrfs_assert_tree_write_locked(struct extent_buffer *eb)
 {
 	lockdep_assert_held_write(&eb->lock);
 }
+static inline void btrfs_assert_tree_read_locked(struct extent_buffer *eb)
+{
+	lockdep_assert_held_read(&eb->lock);
+}
 #else
 static inline void btrfs_assert_tree_write_locked(struct extent_buffer *eb) { }
+static inline void btrfs_assert_tree_read_locked(struct extent_buffer *eb) { }
 #endif
 
 void btrfs_unlock_up_safe(struct btrfs_path *path, int level);
-- 
2.45.2


