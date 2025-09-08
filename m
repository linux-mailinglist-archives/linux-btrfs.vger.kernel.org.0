Return-Path: <linux-btrfs+bounces-16711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FEEB48925
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452C918815B1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DAD2F999F;
	Mon,  8 Sep 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWB2F5uR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D12F1FFB
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325226; cv=none; b=maBCvMntKV8KHvEIkKIrI9o1ZEVUO2AXnQC8hr9tUTRvWPAzT21amBtQ9WUwwAPi8CRCM3YScaN8M69nZUjZsx4GEAS5ltsyXF5vJoX7b/FUHpRI/bOjyrgF/kgb5Ps2r09nHtGSGJbDHWhsgSOYd+oe7zBTpWpWv+Jb/YRds+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325226; c=relaxed/simple;
	bh=88VYrWowrpf7y5bGNATAKEK0CFEofvLmTmU0mTsP1WA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdWN7Pys5tGElz09KXFeVX29yCXCmTeq4aC9NgXf/05zQUbwYlullQQWEbpjNe3Oq0zCetFB9aKNL3syxN9MoFQVyqroCWGUX4V+WzecxVa8aRAZjjD9Uy19z5AgN8Fxqyc9sXhRwtsKMxQB2QaKoRYQX1l9D/zFjNTGps4jfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWB2F5uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DFFC4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325225;
	bh=88VYrWowrpf7y5bGNATAKEK0CFEofvLmTmU0mTsP1WA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eWB2F5uROvNMJUoF2P4BnqDxc2ufP520hYx4wSsVuoYpCypDAeI4Bhciv2wTQDhJT
	 7Gdxq5IkuxNaKT+j4Dggy836jNCqqlumH4awjAlg2yvtPLTcVPGForbqOlOF9Q84XV
	 RfVBUQOVkvk7K/Trdw+SZCciyb629065bStfaJWCdSQ0ZNME7ocjBTsU2qylOVh0d1
	 R8E+pNbeQm4nG2XlXgxSN+pR6NPqcD2sl5S4gF6iqIBDvQwsjHm+SB5lpCwuF+U3p2
	 8qWajXN8+VtUL3/MYxD9l2Z2Yss/KnjiH4c1XmNtQZa6OvG3IHJQoKS/IE4+3d+Qnn
	 3bYV1h81XthQQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/33] btrfs: pass walk_control structure to replay_one_dir_item() and replay_one_name()
Date: Mon,  8 Sep 2025 10:53:10 +0100
Message-ID: <17a321c099c891dd3d2c8f058ef3481e6cb2328e.1757271913.git.fdmanana@suse.com>
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

Instead of passing the transaction and subvolume root and log tree as
arguments, pass the walk_control structure as we can grab all of those
from the structure. This reduces the number of arguments passed and it's
going to be needed by an incoming change that improves error reporting
for log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2ec9252115fd..c4c2fbf291a1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1961,13 +1961,14 @@ static int delete_conflicting_dir_entry(struct btrfs_trans_handle *trans,
  * Returns < 0 on error, 0 if the name wasn't replayed (dentry points to a
  * non-existing inode) and 1 if the name was replayed.
  */
-static noinline int replay_one_name(struct btrfs_trans_handle *trans,
-				    struct btrfs_root *root,
+static noinline int replay_one_name(struct walk_control *wc,
 				    struct btrfs_path *path,
 				    struct extent_buffer *eb,
 				    struct btrfs_dir_item *di,
 				    struct btrfs_key *key)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	struct fscrypt_str name = { 0 };
 	struct btrfs_dir_item *dir_dst_di;
 	struct btrfs_dir_item *index_dst_di;
@@ -2107,8 +2108,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 }
 
 /* Replay one dir item from a BTRFS_DIR_INDEX_KEY key. */
-static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
-					struct btrfs_root *root,
+static noinline int replay_one_dir_item(struct walk_control *wc,
 					struct btrfs_path *path,
 					struct extent_buffer *eb, int slot,
 					struct btrfs_key *key)
@@ -2120,7 +2120,7 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
 	ASSERT(key->type == BTRFS_DIR_INDEX_KEY);
 
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
-	ret = replay_one_name(trans, root, path, eb, di, key);
+	ret = replay_one_name(wc, path, eb, di, key);
 	if (ret < 0)
 		return ret;
 
@@ -2156,12 +2156,12 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
 
 		fixup_path = btrfs_alloc_path();
 		if (!fixup_path) {
-			btrfs_abort_transaction(trans, -ENOMEM);
+			btrfs_abort_transaction(wc->trans, -ENOMEM);
 			return -ENOMEM;
 		}
 
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
-		ret = link_to_fixup_dir(trans, root, fixup_path, di_key.objectid);
+		ret = link_to_fixup_dir(wc->trans, wc->root, fixup_path, di_key.objectid);
 		btrfs_free_path(fixup_path);
 	}
 
@@ -2709,7 +2709,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 
 		if (key.type == BTRFS_DIR_INDEX_KEY &&
 		    wc->stage == LOG_WALK_REPLAY_DIR_INDEX) {
-			ret = replay_one_dir_item(trans, root, path, eb, i, &key);
+			ret = replay_one_dir_item(wc, path, eb, i, &key);
 			if (ret)
 				break;
 		}
-- 
2.47.2


