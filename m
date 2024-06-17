Return-Path: <linux-btrfs+bounces-5755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50190ACDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 13:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330521C2309A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934B194AE0;
	Mon, 17 Jun 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAItpsD5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A24194AD7
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623447; cv=none; b=AiwZqdQDQhSIbjbV6uYkONxeOhyz3s7/1Wnx6bltVHknBuegvDhvIxgMZaO6C6OtlRJGdR2WHVRELMbUtVwDkSE+0UynU9R0S3H2Z7MelB4dkIrS+p2qvrnfiwP4PFdpI407ZEGQwRd45Egvl4f+eTco7F/nLa/rj7xogqk4ZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623447; c=relaxed/simple;
	bh=7OGS0CUJHTZ7s96Jxd5DGwp4VMB0EFWa/UWzRIU/GhY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dJ6lK7+KZDGHc60p5uUhfgAFKjHeX8u6eYaqGTBwe54OfQqQL+wpVa47G4dFredpLGMeXCAYzOVVt1BbjRPSfgQZK6703YCMx9xQHqw26FlIHgfqksGICtSsna5FNH4vHhlgXUb97Gu4MzFJk0xpDLKAaduCBljwwu9XQGT26cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAItpsD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5246DC2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718623446;
	bh=7OGS0CUJHTZ7s96Jxd5DGwp4VMB0EFWa/UWzRIU/GhY=;
	h=From:To:Subject:Date:From;
	b=cAItpsD5EyrtkRFXK57kQG/YPbuItWpv59ZwKWleQWGgBM7SIlWoQgxi6r3VAnfe7
	 jljB7jYxjmOriqQY33gQOaxEaW0eOpCKwK96EVXCh9rmwVVVR6YvWqpD8saIrgVe6z
	 YFri6jClMklz/vzuyd2rN4GQYO3Hv454GidapaVf6FJzWVoGshNB7AA/Af4MXj8esN
	 liZEmU4r2Qb5lRSd6hnFmwIKLNeXWS1qkoMc0fZ+ubCPzID94SU8O8kFKm0MNaVIa2
	 m6Pca46huyAV/EMCM1iAjizHuncJKKllTmHtJTzysh0auOEXEBYD6EtpGh6A8xIK7x
	 xP1Tf/PZJDmzg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use label to deduplicate error path at btrfs_force_cow_block()
Date: Mon, 17 Jun 2024 12:24:03 +0100
Message-Id: <e90b065e5a906581eaf604999504acb67371a8b7.1718623308.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_force_cow_block() we have several error paths that need to
unlock the "cow" extent buffer, drop the reference on it and then return
an error. This is a bit verbose so add a label where we perform these
tasks and make the error paths jump to that label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a155dbc0bffa..763b9a1da428 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -588,19 +588,15 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 
 	ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
 	if (ret) {
-		btrfs_tree_unlock(cow);
-		free_extent_buffer(cow);
 		btrfs_abort_transaction(trans, ret);
-		return ret;
+		goto error_unlock_cow;
 	}
 
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
 		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
 		if (ret) {
-			btrfs_tree_unlock(cow);
-			free_extent_buffer(cow);
 			btrfs_abort_transaction(trans, ret);
-			return ret;
+			goto error_unlock_cow;
 		}
 	}
 
@@ -612,10 +608,8 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
 		if (ret < 0) {
-			btrfs_tree_unlock(cow);
-			free_extent_buffer(cow);
 			btrfs_abort_transaction(trans, ret);
-			return ret;
+			goto error_unlock_cow;
 		}
 		atomic_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
@@ -625,20 +619,16 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
 		if (ret < 0) {
-			btrfs_tree_unlock(cow);
-			free_extent_buffer(cow);
 			btrfs_abort_transaction(trans, ret);
-			return ret;
+			goto error_unlock_cow;
 		}
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
 		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
 		if (ret) {
-			btrfs_tree_unlock(cow);
-			free_extent_buffer(cow);
 			btrfs_abort_transaction(trans, ret);
-			return ret;
+			goto error_unlock_cow;
 		}
 		btrfs_set_node_blockptr(parent, parent_slot,
 					cow->start);
@@ -648,19 +638,15 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		if (last_ref) {
 			ret = btrfs_tree_mod_log_free_eb(buf);
 			if (ret) {
-				btrfs_tree_unlock(cow);
-				free_extent_buffer(cow);
 				btrfs_abort_transaction(trans, ret);
-				return ret;
+				goto error_unlock_cow;
 			}
 		}
 		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
 					    parent_start, last_ref);
 		if (ret < 0) {
-			btrfs_tree_unlock(cow);
-			free_extent_buffer(cow);
 			btrfs_abort_transaction(trans, ret);
-			return ret;
+			goto error_unlock_cow;
 		}
 	}
 	if (unlock_orig)
@@ -669,6 +655,11 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(trans, cow);
 	*cow_ret = cow;
 	return 0;
+
+error_unlock_cow:
+	btrfs_tree_unlock(cow);
+	free_extent_buffer(cow);
+	return ret;
 }
 
 static inline int should_cow_block(struct btrfs_trans_handle *trans,
-- 
2.43.0


