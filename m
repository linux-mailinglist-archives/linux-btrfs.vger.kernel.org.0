Return-Path: <linux-btrfs+bounces-4227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C88A3FB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504211F21A89
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C535A7B9;
	Sat, 13 Apr 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bu+PHRxN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF45A4C4
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052430; cv=none; b=TxETls3B0AmUqbpfo1AOGxZu11XFBbRwX+6ePIdoNbCg36CDeY3jOvBG5JcnNfml9eQBhPn35t0aNEAD5JEADxqxsc1VXD+Wbj+LUJPEGzn7I8SfLNMS3K8S1TMAvkpSLMQfAcMWfyysa7Mx74CpL+BfdamB7f/YjzRsG+7AirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052430; c=relaxed/simple;
	bh=aqa5Rtb85YTuZppApnvbnQDugdEmU8CVWVd96jzZLHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZkO90zbGpLtZMcKhc7pDcXrykfp6Jbn+V9isfT2pUwNIz+PR20W5ePFA+bKWaYrW8KJnV+sYSy6m3Yse31mclVtcTf1nZBqMu4AwJOpg5enDLIpbdHtoDSa0VTMlCYwI9m1/O2n8a9sjMDfyt6ALfJUNw2jeZ3WJbiRQnK9q5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bu+PHRxN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d5e80bc42so171645185a.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052428; x=1713657228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7/PB9UzeYKt3zn0EzbTwPORO+pCPFrRCx4aZA3Q5Fs=;
        b=bu+PHRxNceCDMZpyLJ0VCLKQr8gRSBwfDgZgT7WqHpsdQXU+qBsJNPXQjYo4s2I0Ma
         RORI3lZkIZDFVPpm3tyn+tYEDTpHkrRESzlOzFjojxYZQku6/fb0ixed1T7h22RGgT7K
         6pA0I9+yHeIiEUQHRRRruXReDuKIH7jtfZ0n93HpR9ux19KP373fY7q0qICd+9frCw1c
         O2P86JehHEVU1oO6QGgseXk5Eutsqq3r6YVg8ViQBXGAa8XEpZqE737ePQEKIGwt8Cyx
         yOeKEANRPd9WzixCSD7YHZLkxwr7hs0x70PdmShJWRabqYR6Uu+jYdjPcgW95XF1C+/l
         QrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052428; x=1713657228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7/PB9UzeYKt3zn0EzbTwPORO+pCPFrRCx4aZA3Q5Fs=;
        b=n22nATkx8F79pLCvBDcomsubXDn0IyqKYX9PaXEpzKZlmEwRm2UoaYRO+fKibrvbSo
         n3th9ILdSMHDcfeoG13H3QIkfGe8gnIyU06ADVTfOI+MhCCwYzqwR+k5E3q1n/spAA0d
         xYqhV0fWnwILAKRHiunq3LMe6vXLbfv9Ju7uAVokd59k2V9Qi1rK3KZsVRiC4soC5WZk
         uAFxCrX413ZvjFvIGfUUfI+fmE3yajYuoQSIwmSpNkMe8uhdfQPzCHUaLDIQJxWxm4in
         NyuRihD6K/yCv6e6Ib8z/m2De2xYcnffd25QqudoHzpw/uOObS0JX03RH+Y7pp62wkV0
         y8rA==
X-Gm-Message-State: AOJu0Yy/NwgLrfYUjxCYw0PME6h0RdXPeByy9w81Lvtrq8CdPgulY1Dt
	Dt0LvEtCnP26W+l8Vx5h1SRTSkM7gYhMZE3W9eYpwjFJHT0Wqs5FkbvRUllsmxfv7MTOoQT0hvf
	O
X-Google-Smtp-Source: AGHT+IHUIRcUOtF/M9c+tfQBEKx5lfwJCeGp/uqs3dproFf4aAt+ZwUwPw/TQCtPodKTb5h4y0PdZA==
X-Received: by 2002:a05:620a:4482:b0:78e:ddf9:5f5d with SMTP id x2-20020a05620a448200b0078eddf95f5dmr1738894qkp.18.1713052428291;
        Sat, 13 Apr 2024 16:53:48 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id da8-20020a05620a360800b0078d5af15c4csm4347652qkb.38.2024.04.13.16.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 14/19] btrfs: drop unnecessary arguments from __btrfs_free_extent
Date: Sat, 13 Apr 2024 19:53:24 -0400
Message-ID: <6a421fc3d13c9a6520e7e5c041ddb199116c91e6.1713052088.git.josef@toxicpanda.com>
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

We have all the information we need in our btrfs_delayed_ref_node, which
we already pass into __btrfs_free_extent.  Drop the extra arguments and
just extract the values from btrfs_delayed_ref_node.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6a8108e151d7..540dadcefb92 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -46,9 +46,7 @@
 
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_head *href,
-			       struct btrfs_delayed_ref_node *node, u64 parent,
-			       u64 root_objectid, u64 owner_objectid,
-			       u64 owner_offset,
+			       struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extra_op);
 static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 				    struct extent_buffer *leaf,
@@ -1586,9 +1584,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
-		ret = __btrfs_free_extent(trans, href, node, parent,
-					  node->ref_root, ref->objectid,
-					  ref->offset, extent_op);
+		ret = __btrfs_free_extent(trans, href, node, extent_op);
 	} else {
 		BUG();
 	}
@@ -1710,11 +1706,9 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 {
 	int ret = 0;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_delayed_tree_ref *ref;
 	u64 parent = 0;
 	u64 ref_root = 0;
 
-	ref = btrfs_delayed_node_to_tree_ref(node);
 	trace_run_delayed_tree_ref(trans->fs_info, node);
 
 	if (node->type == BTRFS_SHARED_BLOCK_REF_KEY)
@@ -1744,8 +1738,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
-		ret = __btrfs_free_extent(trans, href, node, parent, ref_root,
-					  ref->level, 0, extent_op);
+		ret = __btrfs_free_extent(trans, href, node, extent_op);
 	} else {
 		BUG();
 	}
@@ -3077,9 +3070,7 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
  */
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_head *href,
-			       struct btrfs_delayed_ref_node *node, u64 parent,
-			       u64 root_objectid, u64 owner_objectid,
-			       u64 owner_offset,
+			       struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
@@ -3099,6 +3090,8 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 refs;
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
+	u64 owner_objectid = btrfs_delayed_ref_owner(node);
+	u64 owner_offset = btrfs_delayed_ref_offset(node);
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
 	u64 delayed_ref_root = href->owning_root;
 
@@ -3124,7 +3117,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		skinny_metadata = false;
 
 	ret = lookup_extent_backref(trans, path, &iref, bytenr, num_bytes,
-				    parent, root_objectid, owner_objectid,
+				    node->parent, node->ref_root, owner_objectid,
 				    owner_offset);
 	if (ret == 0) {
 		/*
@@ -3226,7 +3219,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	} else if (WARN_ON(ret == -ENOENT)) {
 		abort_and_dump(trans, path,
 "unable to find ref byte nr %llu parent %llu root %llu owner %llu offset %llu slot %d",
-			       bytenr, parent, root_objectid, owner_objectid,
+			       bytenr, node->parent, node->ref_root, owner_objectid,
 			       owner_offset, path->slots[0]);
 		goto out;
 	} else {
-- 
2.43.0


