Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF7339837
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhCLU0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbhCLUZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:43 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7DC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:43 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l13so4848175qtu.9
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oDj99o19CgBraoO9woQ83s+5ydPsfk+90Aj1I+n3hRQ=;
        b=I5AUtnSfbj+1NxsAluMUK3lEXnXyG+7ric4LSR3R2jzKTh+qZOHy8drneEYQvc473d
         T8voIUyGKO+BduX1UwSKBY96mcl2wgx/HXmTFLlWzSpUXj41eTq+M+9cP2Vx9/Lo3dVs
         8V5jp5FrxtBxx1p4Ipq0QSwa4Aqq9pH/XPncAjJFJaSR65TYNkuxvI4Gl6AkJsb9HrPm
         vm4Pohc0zEdVlV4oTJj53kJPj4+fXys8J69v9wb2eyfxNbmhQa+3fNo6uorQJgWv2WPU
         46jtrOG2SANRymd2PgUaDXrG73hYZ8+kLdsVZqCH5c2krYzVFA9P40/dSL57YfTbkB1d
         +tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDj99o19CgBraoO9woQ83s+5ydPsfk+90Aj1I+n3hRQ=;
        b=XQWbTvtJW8cKdcsu4bP5jc6P6esT13qsoamwTh1gs3IhCs1jQdOUQH16R79/+GwnxG
         WqoD7g7iBRI854GwkGFYgbm3EZJHSHujSmEUbVKqHPW1hh4A8zfUjtIOIKyqVGNSg9jC
         Kuciy3FUNbrgnfST2xkfqVJS6QPbqjpBp2yFo5CB+v53ElJikJcyptTK5Q+nyfQ6eq2A
         wu83YvJiyihvybXaKGnNEaxgPflufrUhsN6ldQr/oIBTqmA5znU5CJZktz/h1Mu0IpXe
         FEAQHu5VMO8ztxpHeYvjz/edCi9mZ+/Fc0wEh18DsCNR3rh5knd23kOhytjQ42XGPN7l
         a/fA==
X-Gm-Message-State: AOAM530juRJqv0FRD1zOGIjr7LNWi1qu5NZDqOdXeEdA79nbN5S0eAx7
        MhivydRtkElIueGaAibfe5bGA30bc1CGcJnq
X-Google-Smtp-Source: ABdhPJyqMycniVMATHyT5CKfxvUvwMdQJ6SLrx1sgi5zo7aO1MFNFS9E29Mgsb5DrnN9iaEqArG2jw==
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr13714756qtw.52.1615580742608;
        Fri, 12 Mar 2021 12:25:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 21sm5191033qkv.12.2021.03.12.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 04/39] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Fri, 12 Mar 2021 15:24:59 -0500
Message-Id: <d8e459a9b1a547a456689b90af1e9e87da9e2fc1.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 097fea09e2d2..0f2ecf61696e 100644
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

