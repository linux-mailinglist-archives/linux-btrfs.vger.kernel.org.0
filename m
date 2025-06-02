Return-Path: <linux-btrfs+bounces-14374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4039ACAC8C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE29D3BBB97
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432CD20DD7D;
	Mon,  2 Jun 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZkO8Okz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883FA20C489
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860406; cv=none; b=Pmh7u+vpEkV2TAHjDCQiGYNgfwU5yddX8z498wC0nyfegZ0god9PWrzvTcwL+ewgFdvWpD8QgDf9YQ3dmSbchnXrhqdU1uvKOkyJoi+rhb0mN1FxlYQezcgZ12wPISh5ukYCi56CTDNlXNiaMdno41WQqNswzxTH4E3qOgRnP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860406; c=relaxed/simple;
	bh=CG46I01Sn8JZAlZrayuqDBXMOGr7Rd+ahwy3VsUlp0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfJUKQswgGwQQEtR+RWWWmMFM3wFlwmsBwgV3lmnhifzoZzI9sn1EHShZ++zKlAYXfwHDcdh1ApP88+0+p1BPoSkqEnIVr4iBrfnVXPhLttxqA2e0r3za1Z6IqaQTDyDZToBmVAR1hYE8zuhHOLF7NV0tnr0gmlk4bGBFarlEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZkO8Okz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D748DC4CEED
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860406;
	bh=CG46I01Sn8JZAlZrayuqDBXMOGr7Rd+ahwy3VsUlp0E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VZkO8OkzvpB63tBIIvYVJUDfRAVcs/Qz0j/pTKQG3yf4KUtVY72TCiEOFBgwobZ74
	 ECA7Ju8lnz7wEolfBkvHz0G6dpOaJITGF+wBPX5m7f0F1ELipnSNPbTsoVOBw58zYz
	 O/M+sEhy8z+U/rDeI7hgNY0REXH96lBIogY++wxXNa1QqMyxOIjGC/FFzxVPzNJOZQ
	 SfQQSGht43W6i+nQ25qGyw98Dx4c0DSEw9ipNUoXI4UH7rStw0llPyc5Tg1ydJBvdi
	 jOzJA1l49egJ/6tqMc0DdhwVLxlNtz+8pEMV+AIrAXcbQm8IZfk9ShWiqIVifqsIha
	 kv6jwnChpIUuQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/14] btrfs: add details to error messages at btrfs_delete_delayed_dir_index()
Date: Mon,  2 Jun 2025 11:33:05 +0100
Message-ID: <4366183ebe680ab6f8fb75cc1db9034daa6450e9.1748789125.git.fdmanana@suse.com>
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

Update the error messages with:

1) Fix typo in the first one, deltiona -> deletion;

2) Remove redundant part of the first message, the part following the
   comma, and including all the useful information: root, inode, index
   and error value;

3) Update the second message to use more formal language (example 'error'
   instead of 'err'), , remove redundant part about "deletion tree of
   delayed node..." and print the relevant information in the same
   format and order as the first message, without the ugly opening
   parenthesis without a space separating from the previous word.
   This also makes the message similar in format to the one we have at
   btrfs_insert_delayed_dir_index().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6918340f4b38..1e9bec6d24f7 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1618,7 +1618,8 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	 */
 	if (ret < 0) {
 		btrfs_err(trans->fs_info,
-"metadata reservation failed for delayed dir item deltiona, should have been reserved");
+"metadata reservation failed for delayed dir item deletion, index: %llu, root: %llu, inode: %llu, error: %d",
+			  index, btrfs_root_id(node->root), node->inode_id, ret);
 		btrfs_release_delayed_item(item);
 		goto end;
 	}
@@ -1627,9 +1628,8 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	ret = __btrfs_add_delayed_item(node, item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
-			  "err add delayed dir index item(index: %llu) into the deletion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-			  index, btrfs_root_id(node->root),
-			  node->inode_id, ret);
+"failed to add delayed dir index item, root: %llu, inode: %llu, index: %llu, error: %d",
+			  index, btrfs_root_id(node->root), node->inode_id, ret);
 		btrfs_delayed_item_release_metadata(dir->root, item);
 		btrfs_release_delayed_item(item);
 	}
-- 
2.47.2


