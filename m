Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4B2D12C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLGN7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgLGN7Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:24 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50059C08E85F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:16 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id a13so1411957qvv.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DQmnmJJRzCO1HJNP9kj80ZUMjn3DX6w29lkFoMNs1+c=;
        b=yvY5GWrNSHpxaHlUQ5R1isWbLFoZvTpTiggiYKNrCE6q2Ulz6eHzCKqq2Co5RZVkwB
         yrMiFeGrE4J7ak7PY/Y00OBQeSEgNkrAT227t3bN7HVsnkng+O34jyG89N67iPik0gEV
         9Vo9Fh4mWuFQOjSze8Tu60Z0UZpM43Db9OEdDR156K7lIrEckIdmUkfbLJIi2Zp974cq
         WXqColKUOjuYqNZdMXGbBHmb5a3snV7nju2OoqpaP6wuEl6Jlw/T05vzFmGM1VzmTzrx
         gRcIPKX5Vq+FfHEHTM4N+wpT/gX39Ajrb4r1vI4oN7wZXDs6/88WG+Ts9dTt04fFoEcd
         alEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQmnmJJRzCO1HJNP9kj80ZUMjn3DX6w29lkFoMNs1+c=;
        b=jQ+Fh5hXhevJaJCURz3F3pN6aKtxXBr662FHUdFJ6GEJfNcnYy0YjmInz7ryGhrWgP
         elE7maxd2HcUChdyhmzXQFOE4ZRqeXYDLaWSf181/VEsyBb+4vSJtKG+8OqK9QOm6qgr
         tINyTArnvPGG0GqJOI8A4D4KF6ceLPhrLK01hSMSo4WF7FGHKHl5R2LBljwbWuULo1KT
         7cIvUPgLtzeewmMSwhCtl+SlBJczFq+M0ocKs5GNDGZ2YQ9vWk58LPe05B+v1oVrV50W
         TJx7FnMkdod/J7SEo5GJ3xQDvgkXyzfbOTcbUAa1+VNNY9VGPQGDTT0RAsFhImEb2vjD
         sfrA==
X-Gm-Message-State: AOAM531Yj2PJl8eNCqQdDY8oKIkkmuVrmgR9DElKvn/YOyolnd5/hCah
        ZfNR4KO6TOBdWEvNM5hIeV3k8mKpiCfaGPEB
X-Google-Smtp-Source: ABdhPJxGJzuOBsWWitFWbX9SvhWOU/pjIf/rF76k4hBgN1q02+RV7JYtu4SsF7HLnl7ajimTSVfkJQ==
X-Received: by 2002:a05:6214:768:: with SMTP id f8mr21614601qvz.1.1607349494844;
        Mon, 07 Dec 2020 05:58:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v137sm4200331qka.110.2020.12.07.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 14/52] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Mon,  7 Dec 2020 08:57:06 -0500
Message-Id: <b0b6cd2ab51ba5823d647d7ec9d654d94ae34287.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

