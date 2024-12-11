Return-Path: <linux-btrfs+bounces-10238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A429ECF16
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FFF284CE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D91A0BED;
	Wed, 11 Dec 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiWWDuFB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF11A2872
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928823; cv=none; b=q1CIQaFLtKn/hu+OtfQwwrOG/3H2J9BXq+sRUFBcvKIgBuM+OXyuB32b8oBpn1QYdjHMFUXIfa81h+hhsVMxIQPibv1owWtMCDcU1zqL4d3ap6mjJQ67gIVc7AKM8HLXXv182DlkiagZCSfd+QyEvNGJGYrJBVgvG57/vR2aQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928823; c=relaxed/simple;
	bh=BBqgylXidZCr8p9bv7e8+j3t3kEn9oqjUjJMKDpQkXE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IU3zIlKFIZTlsGGPJDoxJdQb1BmdPnSzNWi38O8/b0L9xkuuVtlHnBcgiSLZl+TBwNg2mSREY49DuHy8gcQa7oqcWkD23HWTPM04YpFuzkho2Rf6RDJsdaWayXg9Mkw74/bJU/HE2xesG1+eTz3Jse9RnfVjaB5oMOKArtr5o0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiWWDuFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5271AC4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928822;
	bh=BBqgylXidZCr8p9bv7e8+j3t3kEn9oqjUjJMKDpQkXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PiWWDuFBYPapoFZKmM/i+mEPncgLA/Yf1M4Fg7pFmRNO5AOFNuIOKFIL3SS7XRvoR
	 +7eEbbZeUuUvjZvlJWn73oF/XILMVxhG8Z3g3MgdHf/k8nGjUypJhEU/UKvVgPXW/f
	 PieWN1LuOj9CTO/7sen2z7rw2n+YBjMeKdC5RY440QTGMk9VA1c7g8T7sqn93OqPJD
	 DVeqTrabca6wRnCUvqTs7vYcqC82j2pVBcdXznv8zmjfrfWMj4SmYp1IrojrHfWib9
	 oozN8w41pz7EhrkVDeaOJZA2BdgT/bd5B9WlBoUhJpO0uPLrPotw77Yj5rZch6F2Qv
	 /kWJFFIDy+ujA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: add assertions and comment about path expectations to btrfs_cross_ref_exist()
Date: Wed, 11 Dec 2024 14:53:28 +0000
Message-Id: <f277d8f454d88f3fbdb742e7c961fa69f30a3c6c.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
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
index 3dea8ce87bf7..7ef07ae0c895 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2425,6 +2425,31 @@ int btrfs_cross_ref_exist(struct btrfs_inode *inode, u64 offset,
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


