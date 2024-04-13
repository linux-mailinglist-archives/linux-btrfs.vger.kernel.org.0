Return-Path: <linux-btrfs+bounces-4226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FA8A3FB0
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17C8281FC7
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DBD5A4E0;
	Sat, 13 Apr 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LBll697t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EA58AA9
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052430; cv=none; b=COsMQN6gGg8hC1H7oLIr6KLVAXOkstLFDfhQQX14H5FGDyu34fciZ6rxpaAedINSNGaAcFCnck685VpVrEWV+BtDXZ6/D6NwCvvSijL76MU3nhksIpbZRTaMzPxwhPCy76KvoPmUgHwserVvLGGAmmbMAQacM8VUC1X6rjggQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052430; c=relaxed/simple;
	bh=u6O5ZVbbV4PhOWLhbgNhHqGRNs8NSlOZSwcZ9/D8pc8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNr7ybg1rwteQXbedCqfNvsov1ozbRI3h4rNpUCQ1lMVNmYFFUADvAuATkymqyoKYqLGJsuBbr6kEiXf8Ud65gld+S2Y29o9BRDEtD/RiPRiTvRe4mikrir41D7vIZVIcT5KZ8uPQLogMuSlEp+XVT5bcS2e+QhZi6dFcQ/AoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LBll697t; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d683c469dso182854585a.1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052427; x=1713657227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ysr/iT4jpbQPXbfJHxUV1SAhXTSGV1i+C1rLovaFk3s=;
        b=LBll697t+UDTIuJA01RXvFFvEd4KnnO7JlGp/JM2Uh4EL0v7ZcEBW0CpFHWJRLL8wG
         CLc4XWPXDUd0l0pGWaBAPVe97h6+KCdZ6yCwMoKb+LqRAls67DHE9CSldv8Cd9YNDXS5
         79+Q4dVCSriFUACaNAaKVZGvl8ByW6AyKOoSVCEQcXqa1pAeiB3idWjWPgnUnelZD/bC
         h+MZJK93j3rDckFB5ok5m19kG6+dM9RRz+RPtDna4n+D5P2oobxXy05h+tag2JzKTIdw
         3RDH7UKxY1576Ef1NbVncQCiaBxGzJ2iE+xSihKVrPPxElTRsKVPtDwzc5bKtuchZJDj
         8dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052427; x=1713657227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ysr/iT4jpbQPXbfJHxUV1SAhXTSGV1i+C1rLovaFk3s=;
        b=OY9WMtMSd6VxzsOc2ZqMhBllSlxaEHv9/W5DjKXUpwhZPulU1izPpbStbJPa+jV+dL
         2/6Hf1JI/ND6PUbBiYncKLPIUXQOE5x3vafz+IOje1IB6Ydv+h/AhlXxkSnw3wNVvESG
         DoLfzJyUb+5Vm5k33rfv64Df7oMCinfhxMvpTu+qVbyrjUxhN1F8vKPQvw3On3st2Xph
         TvGm5IVpEPnNqwMYLcrCLfCbIlGaqotRgkeiF2nVeklIzXnH3vhycwxChsuSOwjJQll8
         zdbS8hbAKkIvFVvEVEuZXLPwuA+HzC7i1Q/mH4WSBLPdHVxiqSPsAgf4zWtuWc3+SKLj
         Rv9A==
X-Gm-Message-State: AOJu0YysT23gaO9L6X3ez/lV0Z/sTaJWsDk7KQxGCJ7U6f+W+uLiJayx
	CudTcBAZx/IyQWpvWNenQyZzI9Yb9BRXkpNl8c/DjWihPHg4rKhVMdMUZU4IEVtGowMu7PjXW7I
	W
X-Google-Smtp-Source: AGHT+IE1pd2t9WYpLTj3aqHq7qjcJM0uTWc2mXM6gxA0bJ8rmMtTIE2ZeHSRtxZ7TM474SPOdudPTw==
X-Received: by 2002:ad4:4f88:0:b0:69b:7204:92f with SMTP id em8-20020ad44f88000000b0069b7204092fmr341563qvb.9.1713052427337;
        Sat, 13 Apr 2024 16:53:47 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e5-20020a056214162500b0069b739e195csm29894qvw.120.2024.04.13.16.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 13/19] btrfs: make __btrfs_inc_extent_ref take a btrfs_delayed_ref_node
Date: Sat, 13 Apr 2024 19:53:23 -0400
Message-ID: <c927df817dc837de0678790446568f03b054feda.1713052088.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713052088.git.josef@toxicpanda.com>
References: <cover.1713052088.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're just extracting the values from btrfs_delayed_ref_node and passing
them through, simply pass the btrfs_delayed_ref_node into
__btrfs_inc_extent_ref and shrink the function arguments.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.h | 16 ++++++++++++++++
 fs/btrfs/extent-tree.c | 41 +++++++++--------------------------------
 2 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 3e7afac518ac..0bc80ed8b2c7 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -426,6 +426,22 @@ btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
 	return container_of(ref, struct btrfs_delayed_ref_node, data_ref);
 }
 
+static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
+{
+	if ((node->type == BTRFS_EXTENT_DATA_REF_KEY) ||
+	    (node->type == BTRFS_SHARED_DATA_REF_KEY))
+		return node->data_ref.objectid;
+	return node->tree_ref.level;
+}
+
+static inline u64 btrfs_delayed_ref_offset(struct btrfs_delayed_ref_node *node)
+{
+	if ((node->type == BTRFS_EXTENT_DATA_REF_KEY) ||
+	    (node->type == BTRFS_SHARED_DATA_REF_KEY))
+		return node->data_ref.offset;
+	return 0;
+}
+
 static inline u8 btrfs_ref_type(struct btrfs_ref *ref)
 {
 	ASSERT(ref->type != BTRFS_REF_NOT_SET);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0e42c8bddc0c..6a8108e151d7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1462,34 +1462,12 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
  * @node:	    The delayed ref node used to get the bytenr/length for
  *		    extent whose references are incremented.
  *
- * @parent:	    If this is a shared extent (BTRFS_SHARED_DATA_REF_KEY/
- *		    BTRFS_SHARED_BLOCK_REF_KEY) then it holds the logical
- *		    bytenr of the parent block. Since new extents are always
- *		    created with indirect references, this will only be the case
- *		    when relocating a shared extent. In that case, root_objectid
- *		    will be BTRFS_TREE_RELOC_OBJECTID. Otherwise, parent must
- *		    be 0
- *
- * @root_objectid:  The id of the root where this modification has originated,
- *		    this can be either one of the well-known metadata trees or
- *		    the subvolume id which references this extent.
- *
- * @owner:	    For data extents it is the inode number of the owning file.
- *		    For metadata extents this parameter holds the level in the
- *		    tree of the extent.
- *
- * @offset:	    For metadata extents the offset is ignored and is currently
- *		    always passed as 0. For data extents it is the fileoffset
- *		    this extent belongs to.
- *
  * @extent_op       Pointer to a structure, holding information necessary when
  *                  updating a tree block's flags
  *
  */
 static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 				  struct btrfs_delayed_ref_node *node,
-				  u64 parent, u64 root_objectid,
-				  u64 owner, u64 offset,
 				  struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_path *path;
@@ -1498,6 +1476,8 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
+	u64 owner = btrfs_delayed_ref_owner(node);
+	u64 offset = btrfs_delayed_ref_offset(node);
 	u64 refs;
 	int refs_to_add = node->ref_mod;
 	int ret;
@@ -1508,7 +1488,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 
 	/* this will setup the path even if it fails to insert the back ref */
 	ret = insert_inline_extent_backref(trans, path, bytenr, num_bytes,
-					   parent, root_objectid, owner,
+					   node->parent, node->ref_root, owner,
 					   offset, refs_to_add, extent_op);
 	if ((ret < 0 && ret != -EAGAIN) || !ret)
 		goto out;
@@ -1531,11 +1511,11 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 
 	/* now insert the actual backref */
 	if (owner < BTRFS_FIRST_FREE_OBJECTID)
-		ret = insert_tree_block_ref(trans, path, bytenr, parent,
-					    root_objectid);
+		ret = insert_tree_block_ref(trans, path, bytenr, node->parent,
+					    node->ref_root);
 	else
-		ret = insert_extent_data_ref(trans, path, bytenr, parent,
-					     root_objectid, owner, offset,
+		ret = insert_extent_data_ref(trans, path, bytenr, node->parent,
+					     node->ref_root, owner, offset,
 					     refs_to_add);
 
 	if (ret)
@@ -1604,9 +1584,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		if (!ret)
 			ret = btrfs_record_squota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
-		ret = __btrfs_inc_extent_ref(trans, node, parent, node->ref_root,
-					     ref->objectid, ref->offset,
-					     extent_op);
+		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, href, node, parent,
 					  node->ref_root, ref->objectid,
@@ -1764,8 +1742,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		if (!ret)
 			btrfs_record_squota_delta(fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
-		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
-					     ref->level, 0, extent_op);
+		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, href, node, parent, ref_root,
 					  ref->level, 0, extent_op);
-- 
2.43.0


