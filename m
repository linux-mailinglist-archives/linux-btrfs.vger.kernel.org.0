Return-Path: <linux-btrfs+bounces-9001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2779A475F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9753287557
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 19:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07A205AA3;
	Fri, 18 Oct 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UI3RORSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPkpu5VO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17388204937
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280880; cv=none; b=jUZ3Z8StPnEF+l9wVQP4xdHwoQ+F7QvLiCTCKSXOUl4UOvsx0C7un55ctQHpIVVG1TD0u9rRTcJVre0QOQ4mo3Bde2LrsrcvHBtlnsmamCqHtKHw2l2a/G19rjNkd8DBmARCKE2WDtMPhcTlvqVhrrRSboo8bWmm6kpFUnWkDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280880; c=relaxed/simple;
	bh=1F+lSWvlIB8XsDvc05W2ALSbiofZZNUc2nzj7MSsaz4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h7xTvipC4nQMmN7OieT7ibQKLK0GDCotEt1cN+zYUwCC4sfgf5GS9k7SD3utdL12+K8SGJoGct+hOfxaUpvow4c4GANNEwMnSSqWGnQa4QyGmhlC3vPoaWlgQaYmsb2UIJkhecyocu1VqnlrQDofgb69TjMtRXwbf0Ekh0CL5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=UI3RORSh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPkpu5VO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 02F3B1380198;
	Fri, 18 Oct 2024 15:47:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 18 Oct 2024 15:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1729280876; x=1729367276; bh=J1Uf8NjoA5SB713Fwm9p4
	Wp5pSLwMysJnCekQtQVCCA=; b=UI3RORShOdHbUZQ7jtJMO+FyRb7cvDRba/kxd
	cWsJC7Pa/3wDxo1KFSAgCS1KeyCbb66lEGxOX0nuNKm0KKaaYISUbQk9Cgy5vi1C
	396C+7qSYIHUK6bPAaGENjzQkg2Kwl084BTo9NwR58B2mwv3tIWuqctrHSItFENL
	bduxo+BLNYNrtmrSsogxdc7k9BSk1Yq9CIURE+acaekplYtNIJcK70QfzzM7D079
	ajgAFhewfx13eccflvUpKM7fQP6n4nbUAOMOTPmHGfEzN9b+8U82fu+/OiHvL9sY
	Er6VLbO8JjlEVsZ0MT8WOg943m9TZA/CKoSnzO3RsT2BhtyQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729280876; x=1729367276; bh=J1Uf8NjoA5SB713Fwm9p4Wp5pSLw
	MysJnCekQtQVCCA=; b=gPkpu5VOYXaZqqkdEK4s72L6nmJ92alHHnttI6MX36lB
	2kTLa/9ifC53SAL5TIGtG3PhipIMMaT1CJ8Zdl+k0PkuFD26HwHDpp5E8nY2ha+I
	lPZ8COo5Q4/VfRMuZzhkSZpDSLjBc2NQQvkm+/ZfVVDVmDmqXErbQfZenGKuYN77
	EoI5lcu2MIl84yFHW+ToXyReNDqK0FOk8onl6YhE7RoSXYSRWVTYH8pIyBcK6wkf
	j8SGmFupwFA3zKHcTq8EMpAH4VZyDgt8w/B1EpkjktjCeyDb5aRdJ4PCm1CUr6DL
	bpPU8u2TlbKQ4Ug/k1JV0IM7FKgBU3+dAFi7EMvxYw==
X-ME-Sender: <xms:bLsSZ0MnGdSd4x-DvWx3llveAFLdj9ZNW47RUMZWYkRsDeNuIJHGLg>
    <xme:bLsSZ68FtnuPVxvCXn6BHn93liz0emDt3XgNl7Tq8WChShqPDIoj920Irx6ZXbk1h
    uZ18nVa6hvU0VdR57c>
X-ME-Received: <xmr:bLsSZ7T9Tywh8RNjNmndMnxoZd3T93_D48aNmzUZFXHl5zHX2huFcOBULRMgR9XZLRXeNPlK5fXYP_UloVN9SjwsTF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegs
    ohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffve
    elieefgfejjeeigeekudduteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgs
    thhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqd
    htvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:bLsSZ8sp0vrz07wzPmWQKwSYciqwDyF7FLHf0AJQGAOhx_eSmCxNLA>
    <xmx:bLsSZ8fxb2oISw-pAEKjN7-C32_q3r54eirKU3i8t0bLIXSgeSSusw>
    <xmx:bLsSZw1YPdtPE5oWY3dWJnKGEo97HZQFAhOL2VoI5lb7Vc3F_cuzmQ>
    <xmx:bLsSZw-901qrO1SsUqWDUkD7d880Zu-Lx9QKzfP1tDfUniU48Qxkxw>
    <xmx:bLsSZ9rQJoeoo4Bkhmmw_Zj6D74aEs9jxeo5g_vPlwYRQADVP0UPafzI>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 15:47:56 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: hold merge refcount during extent_map merge
Date: Fri, 18 Oct 2024 12:47:22 -0700
Message-ID: <04478f1919b69f470f1c56bae80512491c97a8b1.1729277554.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In debugging some corrupt squashfs files, we observed symptoms of
corrupt page cache pages but correct on-disk contents. Further
investigation revealed that the exact symptom was a correct page
followed by an incorrect, duplicate, page. This got us thinking about
extent maps.

commit ac05ca913e9f ("Btrfs: fix race between using extent maps and merging them")
enforces a reference count on the primary `em` extent_map being merged,
as that one gets modified.

However, since,
commit 3d2ac9922465 ("btrfs: introduce new members for extent_map")
both 'em' and 'merge' get modified, which introduced the same race and
need for refcounting for 'merge'.

We were able to reproduce this by looping the affected squashfs workload
in parallel on a bunch of separate btrfs-es while also dropping caches.

The fix is two-fold:
- check the refs > 2 criterion for both 'em' and 'merge'
- actually refcount 'merge' which we currently grab without a refcount
  via rb_prev or rb_next.

The other option we considered, but did not implement, was to stop
modifying 'merge' as it gets deleted immediately after. However, it was
less clear what effect that would have on the racing thread holding the
reference, so we went with this fix.

Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_map.c | 92 +++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d58d6fc40da1..108cd7573f61 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -215,6 +215,16 @@ static bool can_merge_extent_map(const struct extent_map *em)
 
 	if (em->flags & EXTENT_FLAG_LOGGING)
 		return false;
+	/*
+	 * We can't modify an extent map that is in the tree and that is being
+	 * used by another task, as it can cause that other task to see it in
+	 * inconsistent state during the merging. We always have 1 reference for
+	 * the tree and 1 for this task (which is unpinning the extent map or
+	 * clearing the logging flag), so anything > 2 means it's being used by
+	 * other tasks too.
+	 */
+	if (refcount_read(&em->refs) > 2)
+		return false;
 
 	/*
 	 * We don't want to merge stuff that hasn't been written to the log yet
@@ -333,57 +343,69 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info, struct extent_map
 	}
 }
 
-static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
+static int try_merge_one_map(struct btrfs_inode *inode, struct extent_map *em,
+			     struct extent_map *merge, bool prev_merge)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_map *merge = NULL;
-	struct rb_node *rb;
+	struct extent_map *prev;
+	struct extent_map *next;
 
+	if (prev_merge) {
+		prev = merge;
+		next = em;
+	} else {
+		prev = em;
+		next = merge;
+	}
 	/*
-	 * We can't modify an extent map that is in the tree and that is being
-	 * used by another task, as it can cause that other task to see it in
-	 * inconsistent state during the merging. We always have 1 reference for
-	 * the tree and 1 for this task (which is unpinning the extent map or
-	 * clearing the logging flag), so anything > 2 means it's being used by
-	 * other tasks too.
-	 */
-	if (refcount_read(&em->refs) > 2)
-		return;
+	* Take a refcount for merge so we can maintain a proper
+	* use count across threads for checking mergeability.
+	*/
+	refcount_inc(&merge->refs);
+	if (!can_merge_extent_map(merge))
+		goto no_merge;
+
+	if (!mergeable_maps(prev, next))
+		goto no_merge;
+
+	if (prev_merge)
+		em->start = merge->start;
+	em->len += merge->len;
+	em->generation = max(em->generation, merge->generation);
+	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+		merge_ondisk_extents(prev, next);
+	em->flags |= EXTENT_FLAG_MERGED;
+
+	validate_extent_map(fs_info, em);
+	refcount_dec(&merge->refs);
+	remove_em(inode, merge);
+	free_extent_map(merge);
+	return 0;
+no_merge:
+	refcount_dec(&merge->refs);
+	return 1;
+}
+
+static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
+{
+	struct extent_map *merge = NULL;
+	struct rb_node *rb;
 
 	if (!can_merge_extent_map(em))
 		return;
 
 	if (em->start != 0) {
 		rb = rb_prev(&em->rb_node);
-		if (rb)
+		if (rb) {
 			merge = rb_entry(rb, struct extent_map, rb_node);
-		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
-			em->start = merge->start;
-			em->len += merge->len;
-			em->generation = max(em->generation, merge->generation);
-
-			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-				merge_ondisk_extents(merge, em);
-			em->flags |= EXTENT_FLAG_MERGED;
-
-			validate_extent_map(fs_info, em);
-			remove_em(inode, merge);
-			free_extent_map(merge);
+			try_merge_one_map(inode, em, merge, true);
 		}
 	}
 
 	rb = rb_next(&em->rb_node);
-	if (rb)
+	if (rb) {
 		merge = rb_entry(rb, struct extent_map, rb_node);
-	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
-		em->len += merge->len;
-		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-			merge_ondisk_extents(em, merge);
-		validate_extent_map(fs_info, em);
-		em->generation = max(em->generation, merge->generation);
-		em->flags |= EXTENT_FLAG_MERGED;
-		remove_em(inode, merge);
-		free_extent_map(merge);
+		try_merge_one_map(inode, em, merge, false);
 	}
 }
 
-- 
2.47.0


