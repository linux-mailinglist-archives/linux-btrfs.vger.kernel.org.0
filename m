Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7862CDD6F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501989AbgLCSY4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbgLCSY4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:56 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DD8C08E9AA
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:28 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so3021988qkq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DQmnmJJRzCO1HJNP9kj80ZUMjn3DX6w29lkFoMNs1+c=;
        b=VDz3rWSllZT/Ocou7PTeiy7n2UcQZdYZSPUx6CfxrNEYHuYp0Jo5+fRCF7z3wnIlTa
         7wtwgmRuYWvJZvWKjRmNzeSX77KiEkyNrFbC+F2qZXvmB6NA655nRkxVRlYAcMMAArQC
         hrg1Gm5+JYEThgXDIRSq+EsmnkHb08Gr3IvumwhuZr3b9Waq/a/aMtIFHc9MZN9v8fqM
         zCxFMgnXemHWiCRQLnVipkeZVIKGK8QfQG4+Jlk7/k+CrqPpPjDxcdadykrqOgFKI6jv
         AVNFmoCpn1NHHR+Mm/djgKtLkH41S13VAs/eoNiei6xuHhF/6RCVazDcZkzVxWqkXdpL
         OytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQmnmJJRzCO1HJNP9kj80ZUMjn3DX6w29lkFoMNs1+c=;
        b=JIKlKWfoedyZfyuvHSiaPNvTYDJNoenEKgpwwZnAIrhu1bwzQG/69lfBe8cJDJvOyr
         d/lFXPykP0Cz6X3EVVgxHwPr5oMOvueOcwCgtcALVrDYkGBJPoQm/yiUQeFBP5S9hsvG
         2ZP/jP/9XFQUhSGQBvMer2wtxxXQd/CNjPi4mY55+WDDkk7gmTECjMwmnQzgK71VberK
         HTRsXy6P48jla4JCwzH+y4Ko0E6ywdyXOYgDOpcCX73zhYSkwwztnvYxNNFQzpc8NqAc
         l9+AmkcjpQsUDQuHi86bu6VbFcihsvIfGDQFFCpxmaSOM9dh53sLw/Xq1R4dOWFdjrYT
         yWkQ==
X-Gm-Message-State: AOAM532aAs8s92Aibq0InkXqHWnAB33zmU5D+SE47Og47Lvr+JM814rz
        nKLyOjAW/AajjCOw3FGZTX50xdCDn82rLOLS
X-Google-Smtp-Source: ABdhPJxla79PgrPKvCjPKHTu0GKXqeCe89ZPNyUyFxXyW48Z3AyW5SdPtMd/2d1jvSNba2qRcPGNEQ==
X-Received: by 2002:a37:7cd:: with SMTP id 196mr4240048qkh.246.1607019807863;
        Thu, 03 Dec 2020 10:23:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o22sm2214171qto.96.2020.12.03.10.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 15/53] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Thu,  3 Dec 2020 13:22:21 -0500
Message-Id: <6f12922c8edd64c9df4b09068a1ac15159523d3a.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have several BUG_ON()'s in select_reloc_root() that can be tripped if
you have extent tree corruption.  Convert these to ASSERT()'s, because
if we hit it during testing it really is bad, or could indicate a
problem with the backref walking code.

However if users hit these problems it generally indicates corruption,
I've hit a few machines in the fleet that trip over these with clearly
corrupted extent trees, so be nice and spit out an error message and
return an error instead of bringing the whole box down.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 47 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 66515ccc04fe..05b80b9ab1e1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1996,8 +1996,33 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		cond_resched();
 		next = walk_up_backref(next, edges, &index);
 		root = next->root;
-		BUG_ON(!root);
-		BUG_ON(!test_bit(BTRFS_ROOT_SHAREABLE, &root->state));
+
+		/*
+		 * If there is no root, then our references for this block are
+		 * incomplete, as we should be able to walk all the way up to a
+		 * block that is owned by a root.
+		 *
+		 * This path is only for SHAREABLE roots, so if we come upon a
+		 * non-SHAREABLE root then we have backrefs that resolve
+		 * improperly.
+		 *
+		 * Both of these cases indicate file system corruption, or a bug
+		 * in the backref walking code.
+		 */
+		if (!root) {
+			ASSERT(0);
+			btrfs_err(trans->fs_info,
+		"bytenr %llu doesn't have a backref path ending in a root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
+		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+			ASSERT(0);
+			btrfs_err(trans->fs_info,
+"bytenr %llu has multiple refs with one ending in a non shareable root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
 			record_reloc_root_in_trans(trans, root);
@@ -2008,8 +2033,22 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-			BUG_ON(next->new_bytenr);
-			BUG_ON(!list_empty(&next->list));
+			/*
+			 * We just created the reloc root, so we shouldn't have
+			 * ->new_bytenr set and this shouldn't be in the changed
+			 *  list.  If it is then we have multiple roots pointing
+			 *  at the same bytenr which indicates corruption, or
+			 *  we've made a mistake in the backref walking code.
+			 */
+			ASSERT(next->new_bytenr == 0);
+			ASSERT(list_empty(&next->list));
+			if (next->new_bytenr || !list_empty(&next->list)) {
+				btrfs_err(trans->fs_info,
+"bytenr %llu possibly has multiple roots pointing at the same bytenr %llu",
+					  node->bytenr, next->bytenr);
+				return ERR_PTR(-EUCLEAN);
+			}
+
 			next->new_bytenr = root->node->start;
 			btrfs_put_root(next->root);
 			next->root = btrfs_grab_root(root);
-- 
2.26.2

