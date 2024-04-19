Return-Path: <linux-btrfs+bounces-4453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423D8AB4FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B501F211CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451EB13D257;
	Fri, 19 Apr 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="STuaWApr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916A13D246
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550655; cv=none; b=ALvAo4fxRTtQn+Idi4E5/rChA9VN3f66YkjzKIh2XYhY/5aNDROwfa6paJj3ETcGbi1FYIqKFZ10lzmaAnzyLbN3/c9+cwqs/nZtuaBVrD/QgyegPjL1lF3nQkCvtOiVzfPVx2Qi+I3ICnfTR1bYlNU0F4f+aSSoXCGTsD5DB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550655; c=relaxed/simple;
	bh=ReeWvP5uMAIh35C4wvBNEaAZX4+zA90ZGFbTWPRZ434=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkeXpnffNsHE+kN5hOqoNvKjVDsGSls2YgPubxYGn5bCNdCn9zlCVJ6j5JckYTmd9gGzAq5MlSwsS3TMfQuMA1MEmdNKcDm7/n/UwV2YMfFwmYW3ks0pERydtNJGs6gMo0jaOJahY349FYDKZREAE6OvdyDeR+3fEGmX+Ze08zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=STuaWApr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78efd1a0022so162612685a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550653; x=1714155453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tI5PnXeuUMCrMlzsmarziyIL4iNGvtZYhcWqRvcIj0U=;
        b=STuaWAprsy3nWUkSyTwaMRdl/zhHboidESawskkeJmaNM6cOzP7dXIISVZxUmEHaRa
         YKaBZZFPB+HBN2PBlMjqMMNZGUEZedXZgbVaKZX6cle5esdA5Z5l3U+Yc2THJw9KOhHd
         +m4XrVKcOOcQRnuUR3OlviVKn59qf9jXZ9YO0jlej/TQF70YOy/nzhxvp/mkxBuitcME
         YGvX3MAl8EJ7xY4jxp0qubv1wA1Me5w8uzvf08Waf9PnCuIubALtYUpm+/IyZJIPnatx
         q/ZmBM5MME5Nu6Hngv9xA2Tq+k+FwgmVYf0vfPUzEUX90a/SK+ULUdPoLbpgxdgfRO9K
         TeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550653; x=1714155453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI5PnXeuUMCrMlzsmarziyIL4iNGvtZYhcWqRvcIj0U=;
        b=grRXVw3fJkOhX59796y+lcmXvddObjvPPYDpUuCTAfIDnwUkzYLzFjxfEQ38IUWZjg
         c2YSy1ig49XwumfCKAP78XPx8bSXf4D95TUOGJvBxWQDgWyWwqnmEklhpgQXs6/jSqrv
         J4yj7PvIs8DsW9R0a/+7/5cICVjCGeR75xUnMGJ825qWXo2+aNLGMfLn2wfbbYxZtmb6
         g7qRpDFEDUvVE7RKY+xDHWp1rjcdrW2ptGIoNVakEQsqe+NBNgPz4Z41GvvltLrJ18U/
         ZO+ZufgKkQrBM4r5stHrI2uZ+/bODqXot3bihIVwhbnohKq4L1e8+7RzbbsQW+69CXJy
         NHpw==
X-Gm-Message-State: AOJu0YyN3vJcKh3MqO6HsFwbrqMc2xvXo3rGj3kX4QQStc7xzG0rqZ60
	lea9RJ77H2XF0BjwVhtAopYamiv9S2ki3erdFR6tsBWXIERdsC4KrZP55TBsEBByosYeFRbh8mt
	5
X-Google-Smtp-Source: AGHT+IHgNDuCBLQ6YbN3/mPsdvsr3JVE71hjwC+aoUoE8SgHBeIRGsAfadd6du4WlsHynaxshxGFwQ==
X-Received: by 2002:a05:620a:1998:b0:78b:e7ed:2a08 with SMTP id bm24-20020a05620a199800b0078be7ed2a08mr4110926qkb.41.1713550652743;
        Fri, 19 Apr 2024 11:17:32 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a084a00b0078a04882ac2sm1797625qku.53.2024.04.19.11.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 15/15] btrfs: add documentation around snapshot delete
Date: Fri, 19 Apr 2024 14:17:10 -0400
Message-ID: <f48cd89a627a52b9b03cc7b04554198ef2512051.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
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
index 0f59339aac5d..83be60f60422 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5224,7 +5224,20 @@ struct walk_control {
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
@@ -5855,6 +5868,27 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
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
@@ -5887,6 +5921,24 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
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


