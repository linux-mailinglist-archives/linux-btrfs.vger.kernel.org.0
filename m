Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A002B202F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKMQXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQXx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:53 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BAAC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:53 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id a15so2686324qvk.5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+EfuqM3ShkQNBFihIYKXDYuwqavMlTo+i2lZanBxzBI=;
        b=TLqJAvJDcf5c2Xn3fh7jxN51DEWJ6TuXgmIIMt0qqUsQZAiRYF+djU80+nwVtXzKsd
         gndNFYm9xgHuoc4L/Fo3jf5TykKSc18A10THCDV4kdYxvzwQ6U6O3LbXNlYR0Isuf181
         0Djxt7x4FRYCWFZzf96QpmvphT3LdLR88ccPMH/oJ6pI/zkKyx6k9K3P23u2L9XzKoLr
         NNdxGOCXZZXXeoGumL3JL6NWUuqPQKIM2OHlGIhF/IDDvG9IWg3gFBg5NkCPFJYlLwQ3
         GOVHilhVPvWM1uqh4jTL4/uIFCzrLst4q0GZ9s5YeBmn6//tsjA3mhCPNn0ipvYQWsRM
         jSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EfuqM3ShkQNBFihIYKXDYuwqavMlTo+i2lZanBxzBI=;
        b=kzGXRuRgkShqoCUG9JsDI8xMP66pxggIRHGS/acQlU0OoemoMuDLhk9d6hET3Sa5AK
         mAmZ8vUwhCzxasU3Cx4M9T5M+I5qdaA+KSY31EKfLCQWmW0Eppe3vZ21aWd8aByjWx7r
         4WWmTTv1lhHqKTg/+rK4RGw8/cxVrGbiwUOdlUm/0wm+TDu9ekeX6+8JzwwwnzwJj6Zl
         TYj5v16oVqsPj7GgEImrd0LiGbNX2uVkl9cSO5gofmOaUwGEtvva7MpUgSHKobXY3OND
         7VCivYpqHvp+/gujqHKGifDUnoOoX6cFGZssVQ3naGm+SVezfxz/WNFsO1+4yE3i77Kn
         kbCQ==
X-Gm-Message-State: AOAM530yLWIKItN5rFbU6cqstzLt8twmeS8WM1yvY1vY10EKAt73o8/u
        PgsraB5o6Je9SGugIHLukHLwGzd4SsD82A==
X-Google-Smtp-Source: ABdhPJx336v/++/k5n12HoGm3hmw4qJP0dG3sQeJZr99sjYwxVl4CnVvmcKwfbxAVNVZM71eYkNZ5g==
X-Received: by 2002:a05:6214:366:: with SMTP id t6mr3233025qvu.58.1605284627503;
        Fri, 13 Nov 2020 08:23:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k3sm6714539qtj.84.2020.11.13.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/42] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Fri, 13 Nov 2020 11:22:57 -0500
Message-Id: <22863a8ebd80f96176a46c143c2bb6ed1068f573.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
index 89e9253846cc..78bed3c4d635 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2006,8 +2006,35 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -2018,8 +2045,24 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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

