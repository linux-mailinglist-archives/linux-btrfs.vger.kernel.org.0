Return-Path: <linux-btrfs+bounces-2507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0985A401
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 14:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44221F246D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7F36103;
	Mon, 19 Feb 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj9/MjyP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F72D610
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347626; cv=none; b=rblldqZpjI5w73P/z7aGvnVvkKnO9ksx/RAdoTXQXJmuw2/8owzsmtX+Pcx5r+UEro3JsWx7PZy+G/ohE3ihyrhjhbOqReFDLg94QcUA1p75ibKRGtbVG6iWaoXpDbm1CtXt8d3ruFMtvchtGkpR8G63Cj/a0SrAgJ9hTNhCbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347626; c=relaxed/simple;
	bh=NzeZqjfaIdjEslxrlIu+CejDkPjWCbaNa6NtOm2B3OI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XZpnaLFPs+adXsh00bBwm65x20vkhxjjb5phhVzb4ZcL1F8KmliaFY2toG2KuHR/NLr29NSougL9f8eoJoPUyPt8sexSN/B23E9D7xhaUn6RD23dxhfH3pt7I1e2wNjugVaEpoTnUxYbJtDu+ZY3QzmWE0I0NUqtYjHa2/wBBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj9/MjyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B71C43390
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708347626;
	bh=NzeZqjfaIdjEslxrlIu+CejDkPjWCbaNa6NtOm2B3OI=;
	h=From:To:Subject:Date:From;
	b=Dj9/MjyPoB2dyqtMI+jMoguP7qLqf0Ai7mDMQ4m+llF+gOfNCzTgi3rPWI9qxUCEB
	 JNRUd8Yewzp7q2sB2xF58VBhC/1j9gzaDVYxI1iYXIYYJU4phDBn0C0B0g1R+0Qo/l
	 mp7VAVQ7zKmLq+Snd9/uN0sHmpFUmSVOWAwKMQYoXVI4yrAN/uzamOEYBuNLnrCLPf
	 +RxAVs7E4lVOQbZ/nZaMx275NyolnlZhzyi0GyfXVev7PDedP98s7YzyHwkXKkkB7l
	 1qnohk7KThQnrbaBHCTg8Fs+Kw1x+slZLmuJN6S16kGOY/mT/6D6gl/BdnSV/AIN+T
	 kg4c9/DE1zQcg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid unnecessary ref initialization when freeing log tree block
Date: Mon, 19 Feb 2024 13:00:22 +0000
Message-Id: <06acd07b61968eaecded7c22d07cd72030fbef6b.1708347488.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_free_tree_block(), we are always initializing a delayed reference
to drop the given extent buffer but we only use if it does not belong to a
log root tree. So we are doing unnecessary work here and increasing the
duration of a critical section as this is normally called while holding a
lock on the parent tree block (if any) and while holding a log transaction
open.

So initialize the delayed reference only if the extent buffer is not from
a log tree, avoiding unnecessary work and making the code also a bit
easier to follow.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0d72d0f7cefc..beedd6ed64d3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3458,16 +3458,17 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			   u64 parent, int last_ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_ref generic_ref = { 0 };
 	struct btrfs_block_group *bg;
 	int ret;
 
-	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
-			       buf->start, buf->len, parent, btrfs_header_owner(buf));
-	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
-			    root_id, 0, false);
-
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
+		struct btrfs_ref generic_ref = { 0 };
+
+		btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
+				       buf->start, buf->len, parent,
+				       btrfs_header_owner(buf));
+		btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
+				    root_id, 0, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
 		BUG_ON(ret); /* -ENOMEM */
-- 
2.40.1


