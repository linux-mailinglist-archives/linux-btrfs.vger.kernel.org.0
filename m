Return-Path: <linux-btrfs+bounces-9138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3069AEBE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85D51C21CB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06351F8906;
	Thu, 24 Oct 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgPMKl5Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2F1F80CB
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787079; cv=none; b=AapT40LNw0szO2aGf4w+a6oNikBuPDgJZ2UlmezcKEwUpjJliVOUFnqNXvh779O/LtqzwFCOwKzp45FcZi2qJ+lEOx96gCYbhXxqRwuFJBVAM1j8cvW5WjK5Odo5Dlv80MQQTdT0Qw7IQ3cKEQMmvg06MQlSUdCdfYTFFbR0PqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787079; c=relaxed/simple;
	bh=7d5LUESd+DOElFD1B8mbHNTwd/K8rHoNMvoa0pfHiDg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2vGlaJ+/wX0RPi+/0oSF45xJMSE+SU1krmHMMuEfQ6Js5c6mN5b/PDfFBAwBgvh5JqOCcx3hT2GIm1YZiSdZ8Aaoe5WgZZt653p3FTj7rSIYyp7E40UYyMaVMNEE6jLOECpbAEGpnZ2YQg9ZVIg5UlLS7PbNd1UUTiRp42Xw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgPMKl5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F865C4CEC7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787079;
	bh=7d5LUESd+DOElFD1B8mbHNTwd/K8rHoNMvoa0pfHiDg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IgPMKl5ZP0yM/g9Jhle2Z/l2zF80XQJ/FrlIOEOpWz59GoeghtVjqdqoOogQ8vXVa
	 tgpCnOPUzgxpc0gQ+A15PeF6oC3sb/HvGdRw/OFWf1f8MYw18RJ/L+qmEr2Ct0K4e1
	 +iwOGuhsp4mLXHnLb1YQ4hFdmllrPUAF+ZDKC3Q9qhPwf7Uwm4Y8VUePm9qPfcFZZn
	 aesvOvwH+HmX32wV3C9pbvYeeIYWI9vh+82wueL75v4JamPx6QH3mofMOloN+mY+Pj
	 lM1t7uGekoCkjFxnGP2J6czg8gCES1ta39lba5m3FRIyx4wWCVQ3ZjJySoF/wMdpeb
	 Fiu1wXDcKTWRg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/18] btrfs: simplify obtaining a delayed ref head
Date: Thu, 24 Oct 2024 17:24:17 +0100
Message-Id: <c40a406e59ea50a899f917fdec65051263b499d2.1729784713.git.fdmanana@suse.com>
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

Instead of doing it in two steps outside of delayed-ref.c, leaking low
level details such as locking, move the logic entirely to delayed-ref.c
under btrfs_select_ref_head(), reducing code and making things simpler
for the caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 27 ++++++++++++++++++++++-----
 fs/btrfs/delayed-ref.h |  2 --
 fs/btrfs/extent-tree.c | 35 +----------------------------------
 3 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 2bfece87bcda..9174c6dbbce5 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -431,8 +431,8 @@ static struct btrfs_delayed_ref_head *find_ref_head(
 	return NULL;
 }
 
-bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
-			    struct btrfs_delayed_ref_head *head)
+static bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
+				   struct btrfs_delayed_ref_head *head)
 {
 	lockdep_assert_held(&delayed_refs->lock);
 	if (mutex_trylock(&head->mutex))
@@ -561,8 +561,9 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 		struct btrfs_delayed_ref_root *delayed_refs)
 {
 	struct btrfs_delayed_ref_head *head;
+	bool locked;
 
-	lockdep_assert_held(&delayed_refs->lock);
+	spin_lock(&delayed_refs->lock);
 again:
 	head = find_ref_head(delayed_refs, delayed_refs->run_delayed_start,
 			     true);
@@ -570,16 +571,20 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 		delayed_refs->run_delayed_start = 0;
 		head = find_first_ref_head(delayed_refs);
 	}
-	if (!head)
+	if (!head) {
+		spin_unlock(&delayed_refs->lock);
 		return NULL;
+	}
 
 	while (head->processing) {
 		struct rb_node *node;
 
 		node = rb_next(&head->href_node);
 		if (!node) {
-			if (delayed_refs->run_delayed_start == 0)
+			if (delayed_refs->run_delayed_start == 0) {
+				spin_unlock(&delayed_refs->lock);
 				return NULL;
+			}
 			delayed_refs->run_delayed_start = 0;
 			goto again;
 		}
@@ -592,6 +597,18 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 	delayed_refs->num_heads_ready--;
 	delayed_refs->run_delayed_start = head->bytenr +
 		head->num_bytes;
+
+	locked = btrfs_delayed_ref_lock(delayed_refs, head);
+	spin_unlock(&delayed_refs->lock);
+
+	/*
+	 * We may have dropped the spin lock to get the head mutex lock, and
+	 * that might have given someone else time to free the head.  If that's
+	 * true, it has been removed from our list and we can move on.
+	 */
+	if (!locked)
+		return ERR_PTR(-EAGAIN);
+
 	return head;
 }
 
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 04730c650212..956fbe5d6984 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -369,8 +369,6 @@ void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
 struct btrfs_delayed_ref_head *
 btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 			    u64 bytenr);
-bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
-			    struct btrfs_delayed_ref_head *head);
 static inline void btrfs_delayed_ref_unlock(struct btrfs_delayed_ref_head *head)
 {
 	mutex_unlock(&head->mutex);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 95d749cec49e..f5320a9cdf8f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1933,39 +1933,6 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
-					struct btrfs_trans_handle *trans)
-{
-	struct btrfs_delayed_ref_root *delayed_refs =
-		&trans->transaction->delayed_refs;
-	struct btrfs_delayed_ref_head *head = NULL;
-	bool locked;
-
-	spin_lock(&delayed_refs->lock);
-	head = btrfs_select_ref_head(delayed_refs);
-	if (!head) {
-		spin_unlock(&delayed_refs->lock);
-		return head;
-	}
-
-	/*
-	 * Grab the lock that says we are going to process all the refs for
-	 * this head
-	 */
-	locked = btrfs_delayed_ref_lock(delayed_refs, head);
-	spin_unlock(&delayed_refs->lock);
-
-	/*
-	 * We may have dropped the spin lock to get the head mutex lock, and
-	 * that might have given someone else time to free the head.  If that's
-	 * true, it has been removed from our list and we can move on.
-	 */
-	if (!locked)
-		head = ERR_PTR(-EAGAIN);
-
-	return head;
-}
-
 static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 					   struct btrfs_delayed_ref_head *locked_ref,
 					   u64 *bytes_released)
@@ -2072,7 +2039,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	do {
 		if (!locked_ref) {
-			locked_ref = btrfs_obtain_ref_head(trans);
+			locked_ref = btrfs_select_ref_head(delayed_refs);
 			if (IS_ERR_OR_NULL(locked_ref)) {
 				if (PTR_ERR(locked_ref) == -EAGAIN) {
 					continue;
-- 
2.43.0


