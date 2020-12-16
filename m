Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA52DC422
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgLPQ1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgLPQ1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:27:44 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181FC0617B0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:03 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 2so7750402qtt.10
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I711wKf496QPXYtatYNw2NmJZyOAIyKrwNlVnuL+q/o=;
        b=MA1OsGl2v9Mmh9CxcHVAEJuiJqW9byULv9nkXBZ+FHvDn9BgV3QvQnYfzoAtgvXiA1
         ktW5eFyIMexfHHFS4hLOZQGZ8kqRf/+KE8RiB8EPcf0ZYQlP8lmG8yfxADIW1ww+7MB3
         zYa1cZ5C0NJBo6FGuGhEmS2XsfmSQSiUvangB9ZNUOBfYzihp9TPa+r+kq1mWz+80GVj
         1ucnkBUOcV7pmAZC8c/Nbk4hdxCeTQJWLwQVoxqBoASWWx9yIEOPikD2HGNaWrQmygJD
         He+LHNOBNnSNXJZQyOTS1HrQQoc3kGC3uDqzzGPyj0jxLPUTviYuiAi6vSgbdXu7ddWp
         ljzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I711wKf496QPXYtatYNw2NmJZyOAIyKrwNlVnuL+q/o=;
        b=iPD8noO7ZUBiCLybZh5YHjSEClyfg13vQKyvd+nzRGVsj8onPli1fTn9/tTENreh+O
         IiQKhD4QMy/dxM7DRKzqv2lecUST03A0io9/Qu2eSv/iv9yjQLknPHev/cgjo8y7bgZO
         CV0ZfvA7Dr54K9jnP5YdWVL2C0bEV793Ej/wYi7n0MdN6oy4WETmD+QEBvOO/HvOXZQD
         miYBiQPU8wqlsK88a2m2Z+rnmJpY9TqZfmLJKHwyT+ymGEdlHf7ZqpJ+eNtZMB1A7lGy
         C4HwuhNMMjdKwL6zxJ4RsPVtvQYlEnYPacjf/0t76NPezNB9PKpkUAKja0413F2dpB/H
         5itw==
X-Gm-Message-State: AOAM530iebzEelHTiCJ1RvpfC/STQD0v0o4ESCJ6GdjcSXWL7PyqyBKA
        WIHhSoA7U+9yB7MRN0u7Byp8Ea/VOXEpQWbB
X-Google-Smtp-Source: ABdhPJw/Urf//cS4inNdK7rxzDk22BfikgRJjMLkr6gMg1sEPrp5PlOO/iuLdWjtoXOZKAPlzGzX+g==
X-Received: by 2002:ac8:5a01:: with SMTP id n1mr23311256qta.227.1608136022717;
        Wed, 16 Dec 2020 08:27:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o21sm1417818qko.9.2020.12.16.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 04/38] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Wed, 16 Dec 2020 11:26:20 -0500
Message-Id: <f284fc867116ac8b7d7529c4c4fc3e9afe2da626.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index 741068580455..2a0f3c0dbbc0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1994,8 +1994,33 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -2006,8 +2031,22 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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

