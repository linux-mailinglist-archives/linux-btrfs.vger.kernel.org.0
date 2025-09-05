Return-Path: <linux-btrfs+bounces-16660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF4B45D93
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7559D1C802BC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103C30215A;
	Fri,  5 Sep 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMN91fDP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CB30B523
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088653; cv=none; b=QsggkUGJmiK+aAclscCeiSQ5fsVutfRaOgaoDNT0q32wrgW87EMPUWHMrVrdXFTySzaXrNzBlzkZyrNkZaPKTZFzB71paKF9L44GT1TxydF9Gk+LWdX0NaXQObjoFGKbXDLqiFg9LWm6eNQoUIkT7qnzW8tIzIf17Ho7oqYQ9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088653; c=relaxed/simple;
	bh=88VYrWowrpf7y5bGNATAKEK0CFEofvLmTmU0mTsP1WA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr0E0s7Q0Pg/q/3Ngg7+aiDscWmQNEcIv+WsxVmMWslJdQ0OOVzHlMAvCSV81kOvlFYapS1A4gWtUcaxG3vCRAThcbYIQyI53KqLem6HzD1nKCXbFFAB4E0R02easyQGO46dI1QUn//Vq+3Pss3QRMjUVN3oolw/U5zdsMhm3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMN91fDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBADC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088653;
	bh=88VYrWowrpf7y5bGNATAKEK0CFEofvLmTmU0mTsP1WA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pMN91fDPTmkkTltv0F405AJd2ub1ADIdf5N55RKPe4wDGeqa+0b6J2W95OH3zgI+K
	 5IIORU/v+3j2VpOk/7tq67vBBbU7nQprzrbbgI8LoePEIOtbf8XNScddWaAtf70Qf4
	 KDCljc9vxdBy0fCf17CjAFcC5xEyfilirUSsyNMVWZu+A9tAc1lvM/8aGDCzBSoS07
	 z54cXJPvVQzmE3ubdoX4juPJkwW3a3s/D0pM+21kxbxHuUdqu3npjeCRTvP/P8aR4w
	 zNVFStolOGackaJyTYs9OdVyGVvUme2OdZ4s/9A0dg2EIUoFVIN8cVf/fGtied//tY
	 WFDnU1yjp5izA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/33] btrfs: pass walk_control structure to replay_one_dir_item() and replay_one_name()
Date: Fri,  5 Sep 2025 17:10:04 +0100
Message-ID: <17a321c099c891dd3d2c8f058ef3481e6cb2328e.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
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


