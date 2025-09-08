Return-Path: <linux-btrfs+bounces-16708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA54B48922
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B691897891
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D972F8BC8;
	Mon,  8 Sep 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBESuMBR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D62F83B7
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325223; cv=none; b=k0dlTZsVOS/fPfr6mgMqrJrKCtqOlkunkirH/nA2a0UVGbAst9kns5OHB0k2G5G+yTUVH6AO6AqFprar39BevKqWI6zGzQ9ipSGzkuQfs43bd7rERZzgW9lm9qTyLZU2bKmo8TZsY7/nUhHm5W1sRU1ISdz+7aqL/gMHdt1/rME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325223; c=relaxed/simple;
	bh=HNXEshB/Foq8m88berxc5vXT22ngICPOmJuNWcFPWqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ8BgIrjEF/JvV43kWZx2vePdNc2xHLiY4X4JnAt6QslRX8mjDgK8BQ2P+xccHBFmRmaunCwaCMtlitG6TcGRjVfmGE4U4G2x44F/HgjqVKE5CFtkkvWger8vyoYZTMdXCJ7qCkCH+jz4LkF99oK5NR/kRJFVU3IW5gpsWLIv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBESuMBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70891C4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325222;
	bh=HNXEshB/Foq8m88berxc5vXT22ngICPOmJuNWcFPWqo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bBESuMBRBYCM1Pd5k5QL2kz4qYOagkGcSWDRjOY26wzIbx3CCj63W5l5xpVmM4TA6
	 82E4cb5scBNt0c+cEm1LaRnHTitL6P/y9ujnjJDFnddRgoohMdcjR2ixBlqAfX+0d1
	 lYgWfjld2uIWCBnfi4hrtLv7MRtXn62+4CgIG20qRlM+NEbCqGcG3jpGtvSaUcKELx
	 f9T4gTd0OAtonpEsuihSG3Yr0Uw4CCFKD2VbimBUZ44iqtcwE+OwTBaDid26KERfWn
	 Lo3/Dd/WScnqEjwmO0KrkANQpKfI66tr30j29iGYMN0NaiQGuT5CG4mdRnhg40sJBE
	 PRZcW7YvJJEvg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/33] btrfs: pass walk_control structure to check_item_in_log()
Date: Mon,  8 Sep 2025 10:53:07 +0100
Message-ID: <9a960dfee70d70c03d3fae980c49f4394897aa63.1757271913.git.fdmanana@suse.com>
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

Instead of passing the transaction and log tree as arguments to
check_item_in_log(), pass the walk_control structure as we can grab those
from the structure. This reduces the number of arguments passed and it's
going to be needed by an incoming change that improves error reporting for
log replay. Notice that a NULL log root argument to check_item_in_log()
makes it unconditionally delete a directory entry, so since the
walk_control always has a non-NULL log root, we add an extra boolean to
check_item_in_log() to tell it if it should unconditionally delete a
directory entry, preserving the behaviour and also making it a bit more
clear.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 460dc51e8c82..ca0946f947df 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2254,13 +2254,14 @@ static noinline int find_dir_range(struct btrfs_root *root,
  * item is not in the log, the item is removed and the inode it points
  * to is unlinked
  */
-static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *log,
+static noinline int check_item_in_log(struct walk_control *wc,
 				      struct btrfs_path *path,
 				      struct btrfs_path *log_path,
 				      struct btrfs_inode *dir,
-				      struct btrfs_key *dir_key)
+				      struct btrfs_key *dir_key,
+				      bool force_remove)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = dir->root;
 	int ret;
 	struct extent_buffer *eb;
@@ -2287,10 +2288,10 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (log) {
+	if (!force_remove) {
 		struct btrfs_dir_item *log_di;
 
-		log_di = btrfs_lookup_dir_index_item(trans, log, log_path,
+		log_di = btrfs_lookup_dir_index_item(trans, wc->log, log_path,
 						     dir_key->objectid,
 						     dir_key->offset, &name, 0);
 		if (IS_ERR(log_di)) {
@@ -2540,9 +2541,8 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 			if (found_key.offset > range_end)
 				break;
 
-			ret = check_item_in_log(trans, log, path,
-						log_path, dir,
-						&found_key);
+			ret = check_item_in_log(wc, path, log_path, dir,
+						&found_key, del_all);
 			if (ret)
 				goto out;
 			if (found_key.offset == (u64)-1)
-- 
2.47.2


