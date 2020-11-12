Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097EE2B0FF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKLVT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVT1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:27 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACEFC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:26 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so5234288qtp.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=roaHm0OnNuHxy9PLKzTAYgOxixPSNIfAuLjhNqB44JU=;
        b=cmysgenoFPPFrARTnpMGIb84EEqh63YPyvW2YQIRkNViETqVOgT49+DpdlOaOrFZHg
         UdXZ3xaGy0kn7Z8iLjkdoBafmb8ZPxml/Bsu1Kaf6CZ8HQyxjtUWgZlNPlh3n8N9InY+
         4irJ+kp9024JYrEpRK1rLRQ+CDtUJi4AweQWKwLH8P0Ub8f4j5Bvv60pKAtqEiy3WEe7
         q9U4mbdpr6pAQvItPktn3jItCEhdtDtDFQJq0fMPKxdqEQP52SSqgXvUoE0n0bewZQAD
         txlOp6OZ9nsDzfztS+fIheLCYaV6BNjy/Zw1/r11Ylzny5MFcJEveJp5XJOrRxN/PxOj
         9v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=roaHm0OnNuHxy9PLKzTAYgOxixPSNIfAuLjhNqB44JU=;
        b=bhctMWqYjorJfSVKtQZ3KZuuK0MNVjXWz9N2do8+uQzgheclEZIW4g1+GrEUDX80ck
         eVRiK7jurfNml+IxLjy+fjg0LbjmRf2mlgPmXFxlw+smyg3X7VrBJEV0nkAU2BLMa/wk
         JcMd3+hZZRs3CSvD4/4FW4YAuBf/CksGn98V2yuZooprfuuQgrHrrS+OmxJUXjbTp2qi
         XgWxhbcAcWJ0I2vupa/YdJiPvLWgZYzCivg4lp2nhEClFh9i75WGkEEG3ie8b1mkyKfa
         Wmh1q6nrs216iDTZBd4cfyZBH1niHfuP5+gYFwjvnGbIeHvgZ9/zdZUw94U50Sqk1pE2
         qdQA==
X-Gm-Message-State: AOAM533fahl7SNeKg72aWX6Jv16JvtTGNXVNq/nUiHhohQ+bJhWvet6r
        yQQoJ8R3yHbYG0RZZxGDrBhzmupsxY3ATw==
X-Google-Smtp-Source: ABdhPJzFCT506mjcXey6ITFgwwWQZEcbWScOtS9CT4NTR7bIe70sewOtPssCfhHmYiKfErLQYMgWFw==
X-Received: by 2002:ac8:679a:: with SMTP id b26mr1203213qtp.79.1605215965261;
        Thu, 12 Nov 2020 13:19:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 72sm5824025qkn.44.2020.11.12.13.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/42] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Thu, 12 Nov 2020 16:18:34 -0500
Message-Id: <14d4c25569edba083b604bc91b88a7df2852888a.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 51 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a94671199e8d..f5c562955690 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2025,8 +2025,35 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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
+		 * in the backref walking code.  The ASSERT() is to make sure
+		 * developers get bitten as soon as possible, proper error
+		 * handling is for users who may have corrupt file systems.
+		 */
+		ASSERT(root);
+		ASSERT(test_bit(BTRFS_ROOT_SHAREABLE, &root->state));
+		if (!root) {
+			btrfs_err(trans->fs_info,
+		"bytenr %llu doesn't have a backref path ending in a root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
+		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+			btrfs_err(trans->fs_info,
+"bytenr %llu has multiple refs with one ending in a non shareable root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
 			record_reloc_root_in_trans(trans, root);
@@ -2037,8 +2064,24 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-			BUG_ON(next->new_bytenr);
-			BUG_ON(!list_empty(&next->list));
+			/*
+			 * We just created the reloc root, so we shouldn't have
+			 * ->new_bytenr set and this shouldn't be in the changed
+			 *  list.  If it is then we have multiple roots pointing
+			 *  at the same bytenr, or we've made a mistake in the
+			 *  backref walking code.  ASSERT() for developers,
+			 *  error out for users, as it indicates corruption or a
+			 *  bad bug.
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

