Return-Path: <linux-btrfs+bounces-9137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596CD9AEBE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E32285E0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEA81F81B9;
	Thu, 24 Oct 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duFZ41rU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11A1F8197
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787078; cv=none; b=YVFK1zKbtltYxqcAwC3oRgVwYFhXS+gdXDimSeySIKSUj1IPZCP60WIf4J/47FtbIsFGNc6Bif33eZ2eTyATzbnbsdWUQsoHKzCRcdCX4xaEpZ7L3JnTBIHPddn1w34BCFlL6oyMn85TR69vmvH88H28grNtzyTbY3pmwzhNhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787078; c=relaxed/simple;
	bh=WqOCq8l+5NWaTE6JNmbmNUl2tRP4V8bCYgzT8F8jzoU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCmM0FJHjOiBKqVPFeVShLOC3ap0xF4znm4CARhQrV3GTtqAr2l6Tq1auReeg+fXlSawn6hCqvq5uUTOhEkflHqk+yLAlUMlM9qDrffeIgWAeaxKTmSF9qjjxc9F43HfUOsifCeQfTUwI52LmtqKc+OchDrRW9h9tiv658i+2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duFZ41rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E7AC4CEC7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787078;
	bh=WqOCq8l+5NWaTE6JNmbmNUl2tRP4V8bCYgzT8F8jzoU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=duFZ41rUYlvg+e89ijiCc5GO5R/Jdha+fm2Jlnka9F5Zw+of2x3/FbsUqdqkM4d97
	 Eq7KYJaumsQh/egp2g6OUJUwSS11tGka/v9HJ5/81rSjPzEc45tl7fNO/V3B53cyAT
	 md4QZcnLRnRELWouHCtmRTYW6/1VxY/uUmjG6YoJyRrTSNvU1Jin83jt7uR0kdxSYn
	 dmE7v68zXxFH1hydHBCDYDnpo3dn43BtXTpTs9/3gDfQK6oyxSgCz3IX0TNQ6/WmGp
	 f/Iy4RjFeiHBTpD7DZWoJ/DdfJ8TkLKt2FHIq1GEEUQoS6AnSLFDjdhZpbAydSjoEu
	 OVnXIhzI6g6eA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/18] btrfs: change return type of btrfs_delayed_ref_lock() to boolean
Date: Thu, 24 Oct 2024 17:24:16 +0100
Message-Id: <b106c13e329a608a025b2a63c667eb7c745d2f56.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function only returns 0, meaning it was able to lock the delayed ref
head, or -EAGAIN in case it wasn't able to lock it. So simplify this and
use a boolean return type instead, returning true if it was able to lock
and false otherwise.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 12 ++++++------
 fs/btrfs/delayed-ref.h |  4 ++--
 fs/btrfs/extent-tree.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 2e14cfcb152e..2bfece87bcda 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -431,12 +431,12 @@ static struct btrfs_delayed_ref_head *find_ref_head(
 	return NULL;
 }
 
-int btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
-			   struct btrfs_delayed_ref_head *head)
+bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
+			    struct btrfs_delayed_ref_head *head)
 {
 	lockdep_assert_held(&delayed_refs->lock);
 	if (mutex_trylock(&head->mutex))
-		return 0;
+		return true;
 
 	refcount_inc(&head->refs);
 	spin_unlock(&delayed_refs->lock);
@@ -446,10 +446,10 @@ int btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
 	if (RB_EMPTY_NODE(&head->href_node)) {
 		mutex_unlock(&head->mutex);
 		btrfs_put_delayed_ref_head(head);
-		return -EAGAIN;
+		return false;
 	}
 	btrfs_put_delayed_ref_head(head);
-	return 0;
+	return true;
 }
 
 static inline void drop_delayed_ref(struct btrfs_fs_info *fs_info,
@@ -1250,7 +1250,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 		if (!head)
 			break;
 
-		if (btrfs_delayed_ref_lock(delayed_refs, head))
+		if (!btrfs_delayed_ref_lock(delayed_refs, head))
 			continue;
 
 		spin_lock(&head->lock);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index a97c9df19ea0..04730c650212 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -369,8 +369,8 @@ void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
 struct btrfs_delayed_ref_head *
 btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 			    u64 bytenr);
-int btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
-			   struct btrfs_delayed_ref_head *head);
+bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
+			    struct btrfs_delayed_ref_head *head);
 static inline void btrfs_delayed_ref_unlock(struct btrfs_delayed_ref_head *head)
 {
 	mutex_unlock(&head->mutex);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9b588ce19a74..95d749cec49e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1939,7 +1939,7 @@ static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
 	struct btrfs_delayed_ref_root *delayed_refs =
 		&trans->transaction->delayed_refs;
 	struct btrfs_delayed_ref_head *head = NULL;
-	int ret;
+	bool locked;
 
 	spin_lock(&delayed_refs->lock);
 	head = btrfs_select_ref_head(delayed_refs);
@@ -1952,7 +1952,7 @@ static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
 	 * Grab the lock that says we are going to process all the refs for
 	 * this head
 	 */
-	ret = btrfs_delayed_ref_lock(delayed_refs, head);
+	locked = btrfs_delayed_ref_lock(delayed_refs, head);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
@@ -1960,7 +1960,7 @@ static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
 	 * that might have given someone else time to free the head.  If that's
 	 * true, it has been removed from our list and we can move on.
 	 */
-	if (ret == -EAGAIN)
+	if (!locked)
 		head = ERR_PTR(-EAGAIN);
 
 	return head;
-- 
2.43.0


