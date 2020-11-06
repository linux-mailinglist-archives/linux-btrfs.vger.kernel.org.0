Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428922A9F12
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKFV1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKFV1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:49 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE97C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:49 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 12so2455737qkl.8
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5eQXna34yyhkyGpHuzKvpUosJJv+fxJvVO6C2WBaF/o=;
        b=ZGFK6CTYfxM+eTJImph5OBFK+LPOmM7FilRkYyQX+9hEuqXuvVUzSnTsQRXyy+SSN+
         QFvH8Fw1ssM6CvAFWWDtR25TtRoss41AUOAJP8/X0VmGtvLHYFwPyEd9l6BsoEwOx6Rn
         /SScvNE2PRQPWNIievwqFJYXgAOSTDmeImHLWWd8Bli41W2CAtP+7exW2KUErP6ZDtdY
         BiVeHDo2SxrJc9NKHkET/RAEEgekkZ2S1BWA8F/E9A9M3pOphK7yYH2tF4M9qYMmPnAC
         Coep2DU5ttmK0c254r6Nhr+eKfSSa72MkUjR97z2IEHa0zpC1DEJxyBQPFZthEB/SCa2
         oagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eQXna34yyhkyGpHuzKvpUosJJv+fxJvVO6C2WBaF/o=;
        b=Mz6M7QWGStb28nJfx8NlafXkbUauzKS0ArbpFYD8sUSWCwQQgNPF2qqec3zsLB39ly
         id26Da7tYD/hReg5PCeeST/7zjsKnmJkLaGsWp2Dm16eQwWmHzDLONxl0yX8thuEaLLn
         /6YIRBC5iHbLSdooe2fWamJAB5kXuliW9eWXf/t5edjG5PSMvbrVOL0rMxfwGu6kLiJo
         POmPnSe0ZHQRgw4ApSTLiC0g5Qyn+yDxQ4MykQZZNTkT36FC5Br3eGIGROT1puDyKTLJ
         jiUNkDZE2R2SZEP/YgCTiKe7fMhFLSExcoTGttZNXDZSk4Vg6PRUB7uh5Cl9qxYXiOzm
         kBBg==
X-Gm-Message-State: AOAM532k6nC9GiGd/trIdlSqOpi22eL5cEbQppmpxLsfTPjDCmNCe2wQ
        e1sxMxjoAwua6kycjsDmkoT+UeJB5O1+s+0Z
X-Google-Smtp-Source: ABdhPJwBOJgVxb1V0gy5GduulmHPuZCN5XsWeHQrxkA8MN06qlEqCTIHFp3YLCCiL7JWqTQea3y7Cg==
X-Received: by 2002:a05:620a:576:: with SMTP id p22mr3482114qkp.67.1604698067731;
        Fri, 06 Nov 2020 13:27:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p8sm1448922qtc.37.2020.11.06.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: remove __btrfs_read_lock_root_node
Date:   Fri,  6 Nov 2020 16:27:33 -0500
Message-Id: <295a64e139b18fdbedd872f2be8c4688d9f18364.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We no longer have recursive locking, so remove this variant.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 2 +-
 fs/btrfs/locking.c | 5 ++---
 fs/btrfs/locking.h | 8 +-------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cdd86ced917a..ef7389e6be3d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2588,7 +2588,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 		 * We don't know the level of the root node until we actually
 		 * have it read locked
 		 */
-		b = __btrfs_read_lock_root_node(root, 0);
+		b = btrfs_read_lock_root_node(root);
 		level = btrfs_header_level(b);
 		if (level > write_lock_level)
 			goto out;
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 9b66154803a7..c8b239376fb4 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -185,14 +185,13 @@ struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root)
  *
  * Return: root extent buffer with read lock held
  */
-struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
-						  bool recurse)
+struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
 {
 	struct extent_buffer *eb;
 
 	while (1) {
 		eb = btrfs_root_node(root);
-		__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, recurse);
+		btrfs_tree_read_lock(eb);
 		if (eb == root->node)
 			break;
 		btrfs_tree_read_unlock(eb);
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index f8f2fd835582..91441e31db18 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -94,13 +94,7 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
 struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
-struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
-						  bool recurse);
-
-static inline struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
-{
-	return __btrfs_read_lock_root_node(root, false);
-}
+struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root);
 
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
-- 
2.26.2

