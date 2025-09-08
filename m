Return-Path: <linux-btrfs+bounces-16698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5DAB48917
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933D7174001
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF18A1E505;
	Mon,  8 Sep 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/uNCHhQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF882F28E3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325214; cv=none; b=YcZUrsQBw7Qsdc8VGvfqQ32g4/irFLMni7aHxju6NwsPawCQuL4DoP+IEyH4/MGRjTifSpVzO+kl/IVljhribSVQJ5p5vtYfGWfqYgxGIDOPl9CRTXO3p3vXWRms/uXIbkdcntZKmwkNOaK8e3iJvjSqr8xzAwW+yTXE3rMttm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325214; c=relaxed/simple;
	bh=BQgm3dGaBMtHQxePhPTmfj+OVHNni8ljkJlBrzyNEvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoPVPJLTlj3B1Bh/gi90z1BT8nW9bcTNVbIK77EjUu9dusq2CZMQ2oFNfwzHLaMU1WT1k+4lqi1lzcTWYMmSU35KqOB8K9Vq8lulawISAj6BFLE90P5Nh12pVLOTj2RYFomszZaZD2JVc/nOrJC1e5v+RJpGsb8skJ0+7/s55cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/uNCHhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F27FC4CEFA
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325213;
	bh=BQgm3dGaBMtHQxePhPTmfj+OVHNni8ljkJlBrzyNEvU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B/uNCHhQWqbN6f0yOgEaPVtfy4frEE1nmNYclnohALTRu/RooLQhsjFLjgcX0P1kE
	 tvQvV35u/W416+8r/NOeqVEOSRs5N17a0BIH/FnZtrNesSz53YvDj/Hk812cbXKkaT
	 IDpPPF7Ni+4H5X2BEhyprOjCRLt3DKujx6fkB05ZqlUVktWmtZxQgMoO0fElYw9/Dj
	 djdWOKvwZvusZgmBR8onX6xfeMm4zHz2Vsl7UYNsI7T/n4ITDSPnOuyoAp5rBOCkIq
	 aF35vpbY6GhUNvwLo0apLgGo948LGo1R1FdUfFnNyyeanRJlH6pARBauuKcpy8985Z
	 6DEFydBeZKL/w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/33] btrfs: rename replay_dest member of struct walk_control to root
Date: Mon,  8 Sep 2025 10:52:57 +0100
Message-ID: <7dce3a895db2f05a3be1dd232559c403974a0bc9.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Everywhere else we refer to a subvolume root we are replaying to simply
as 'root', so rename from 'replay_dest' to 'root' for consistency and
having a more meaningful and shorter name. While at it also update the
comment to be more detailed and comply to preferred style (first word in
a sentence is capitalized and sentence ends with punctuation).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c5c5fc05eabb..c0cc94efbcaa 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -330,8 +330,11 @@ struct walk_control {
 	 */
 	bool ignore_cur_inode;
 
-	/* the root we are currently replaying */
-	struct btrfs_root *replay_dest;
+	/*
+	 * The root we are currently replaying to. This is NULL for the replay
+	 * stage LOG_WALK_PIN_ONLY.
+	 */
+	struct btrfs_root *root;
 
 	/* the trans handle for the current replay */
 	struct btrfs_trans_handle *trans;
@@ -2575,7 +2578,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 		.level = level
 	};
 	struct btrfs_path *path;
-	struct btrfs_root *root = wc->replay_dest;
+	struct btrfs_root *root = wc->root;
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_key key;
 	int i;
@@ -7479,11 +7482,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			goto error;
 		}
 
-		wc.replay_dest = btrfs_get_fs_root(fs_info, found_key.offset,
-						   true);
-		if (IS_ERR(wc.replay_dest)) {
-			ret = PTR_ERR(wc.replay_dest);
-			wc.replay_dest = NULL;
+		wc.root = btrfs_get_fs_root(fs_info, found_key.offset, true);
+		if (IS_ERR(wc.root)) {
+			ret = PTR_ERR(wc.root);
+			wc.root = NULL;
 			if (ret != -ENOENT) {
 				btrfs_put_root(log);
 				btrfs_abort_transaction(trans, ret);
@@ -7510,8 +7512,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			goto next;
 		}
 
-		wc.replay_dest->log_root = log;
-		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
+		wc.root->log_root = log;
+		ret = btrfs_record_root_in_trans(trans, wc.root);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto next;
@@ -7524,9 +7526,9 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		if (wc.stage == LOG_WALK_REPLAY_ALL) {
-			struct btrfs_root *root = wc.replay_dest;
+			struct btrfs_root *root = wc.root;
 
-			ret = fixup_inode_link_counts(trans, wc.replay_dest, path);
+			ret = fixup_inode_link_counts(trans, root, path);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto next;
@@ -7546,9 +7548,9 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			}
 		}
 next:
-		if (wc.replay_dest) {
-			wc.replay_dest->log_root = NULL;
-			btrfs_put_root(wc.replay_dest);
+		if (wc.root) {
+			wc.root->log_root = NULL;
+			btrfs_put_root(wc.root);
 		}
 		btrfs_put_root(log);
 
-- 
2.47.2


