Return-Path: <linux-btrfs+bounces-4618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A28B59FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DA11C20DBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018867441C;
	Mon, 29 Apr 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WQELTgJC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0ED77F32
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397417; cv=none; b=RiRZuPA9zvaE39QqOoybdJXwz6mtOy98Srvk3pm1GHCbqun3+YFDWPwsdxzEVM3dRWD+4iLh+76JvahLFdRumBfVXjCJaMwBQsDybK8WbrEy/n/08kW4w8V61BLKPKiwTNz9fNdON0X/Cnz9cvWMqZ9TH46CbB5W5JmcY+3FPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397417; c=relaxed/simple;
	bh=qyM8xE7c/E514bzc8/od50cOasXQ2ay6Di/2rAb9tx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQodL+NDDjpsu7YQzieXIYPZxl+8ZZlPwnoRGT6G+6NyqGNxmocoTdeifRyG8eXIhyQg/cDDJHpim+Di2Bu2hsZwe7hjcvLT9so1z7Q65IndG8Vxa9CVPmtwLkghVf+uGowFosbMLlw1vklBdh/9hIEQcr2moJIiIvrdoclExII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WQELTgJC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43ae9962c17so2569601cf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397414; x=1715002214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weF39kzj282bIU9FlIoq2hp9HHOmUmWiD3HL/WDHSgY=;
        b=WQELTgJCIqCi742KI09fMFqcTRIfAi0MsLgy7/5yC/Q6mhrwFk0YqhBkg/6y3hHvgH
         kbnGb/W4l14ZdRqI8inXwIlliI6cARdr6LX6PqDhvc4bbPH5O/56bL+44v2XoEtuTS7A
         5fRTuI7i9ZqNDatFxIxm4I73uF6A/4alPTj7MH4u7MjXXcygSlUxTR5VS1+DqAajpP7f
         Y71lZmr9C6+NdI93C1UFlm3OW+uiL876Dn6NLX660YD2pLqjXy6nzdlsx0gM8XYvZkAJ
         3uQJjrAczaZj03q71DSfmeD4OXTT0UBhQrfMkJVOzHbe1SP3l1Hl2biDq0HHBxwMM9wc
         7CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397414; x=1715002214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weF39kzj282bIU9FlIoq2hp9HHOmUmWiD3HL/WDHSgY=;
        b=sMSCFr2Mr33o2qRHqbN4m6eTZ2HcdnFAuPNCP2mucyatQs9DailS+fGEEjCe+WefiM
         peHSqqhUswCRW7FXtOs4UFPxYE5f/+/VYtV4nTEMdJvzKdf9nsOkelK9EDg9ZNHBpZfk
         rPiU5vGwuL0r70hQeDe6bSWlGX5DLM3RDAyiY6Uf9zaYEWcsuviF+QxyJmvWX8PYgfrj
         vgp0j/5Ig7bMjuDAVgq9UZX34cm5BNHJ+0AVibxL8CWdKbHAxqHms6tn+xDLN7wliy+l
         Q2syOaxVpPu9nsJM67Suw5bmI0+nlzX49pkiitghL4GMB0dmyQEf6HXLukkZwCdG4qDt
         dLMg==
X-Gm-Message-State: AOJu0Yz3IjFGc/G92NFiljfAZFpFF80SUZKvoh8fuWydgihFJNWsM4Jn
	Iay13qCem2ZQJODhMNbNGrgki8q83owyyoxxdo5yTqKrOyHuIwDJgkurrBtu+JqH9B+6/dvsyNe
	V
X-Google-Smtp-Source: AGHT+IEJhggAuLBqYmxn9D09AdBb8Xwr8EP1eBjoc9nphK3ZL1Ck+0fhV2z/vHFYAm5pv2A7orISFQ==
X-Received: by 2002:a05:622a:1909:b0:43a:f9c7:617d with SMTP id w9-20020a05622a190900b0043af9c7617dmr2078748qtc.38.1714397414367;
        Mon, 29 Apr 2024 06:30:14 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85485000000b00439cccb91b2sm6544368qtq.73.2024.04.29.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 15/15] btrfs: add documentation around snapshot delete
Date: Mon, 29 Apr 2024 09:29:50 -0400
Message-ID: <97706f9ea53a824b446e3149588895bd8430eec0.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Snapshot delete has some complicated looking code that is weirdly subtle
at times.  I've cleaned it up the best I can without re-writing it, but
there are still a lot of details that are non-obvious.  Add a bunch of
comments to the main parts of the code to help future developers better
understand the mechanics of snapshot deletion.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9228cdfc1cba..be60bc2e10ae 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5223,7 +5223,20 @@ struct walk_control {
 	int lookup_info;
 };
 
+/*
+ * This is our normal stage.  We are traversing blocks the current snapshot owns
+ * and we are dropping any of our references to any children we are able to, and
+ * then freeing the block once we've processed all of the children.
+ */
 #define DROP_REFERENCE	1
+
+/*
+ * We enter this stage when we have to walk into a child block (meaning we can't
+ * simply drop our reference to it from our current parent node) and there are
+ * more than one reference on it.  If we are the owner of any of the children
+ * blocks from the current parent node then we have to do the FULL_BACKREF dance
+ * on them in order to drop our normal ref and add the shared ref.
+ */
 #define UPDATE_BACKREF	2
 
 /*
@@ -5859,6 +5872,27 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	return -EUCLEAN;
 }
 
+/*
+ * walk_down_tree consists of two steps.
+ *
+ * walk_down_proc().  Look up the reference count and reference of our current
+ * wc->level.  At this point path->nodes[wc->level] should be populated and
+ * uptodate, and in most cases should already be locked.  If we are in
+ * DROP_REFERENCE and our refcount is > 1 then we've entered a shared node and
+ * we can walk back up the tree.  If we are UPDATE_BACKREF we have to set
+ * FULL_BACKREF on this node if it's not already set, and then do the
+ * FULL_BACKREF conversion dance, which is to drop the root reference and add
+ * the shared reference to all of this nodes children.
+ *
+ * do_walk_down().  This is where we actually start iterating on the children of
+ * our current path->nodes[wc->level].  For DROP_REFERENCE that means dropping
+ * our reference to the children that return false from visit_node_for_delete(),
+ * which has various conditions where we know we can just drop our reference
+ * without visiting the node.  For UPDATE_BACKREF we will skip any children that
+ * visit_node_for_delete() returns false for, only walking down when necessary.
+ * The bulk of the work for UPDATE_BACKREF occurs in the walk_up_tree() part of
+ * snapshot deletion.
+ */
 static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct btrfs_path *path,
@@ -5891,6 +5925,24 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 	return (ret == 1) ? 0 : ret;
 }
 
+/*
+ * walk_up_tree is responsible for making sure we visit every slot on our
+ * current node, and if we're at the end of that node then we call
+ * walk_up_proc() on our current node which will do one of a few things based on
+ * our stage.
+ *
+ * UPDATE_BACKREF.  If we wc->level is currently less than our wc->shared_level
+ * then we need to walk back up the tree, and then going back down into the
+ * other slots via walk_down_tree to update any other children from our original
+ * wc->shared_level.  Once we're at or above our wc->shared_level we can switch
+ * back to DROP_REFERENCE, lookup the current nodes refs and flags, and carry
+ * on.
+ *
+ * DROP_REFERENCE. If our refs == 1 then we're going to free this tree block.
+ * If we're level 0 then we need to btrfs_dec_ref() on all of the data extents
+ * in our current leaf.  After that we call btrfs_free_tree_block() on the
+ * current node and walk up to the next node to walk down the next slot.
+ */
 static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root,
 				 struct btrfs_path *path,
-- 
2.43.0


