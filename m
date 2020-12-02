Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955492CC714
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbgLBTwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgLBTwt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:49 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519FC061A4F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:39 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id d5so1999105qtn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LZKtow7fEFdlMHA5nRCkAD1l/THJHrm+aeUBLA6vY08=;
        b=PUusj4/Db1fKiFu9RPUPEOGT/+xHRC/XnxVa6Spc54h0KhjomKlD4nl2XEW3TrXFcO
         g4ql+1ASJiw4eQF7yTLxGvZgb3hbBvU6Yyc7RjzxHFLc8O943R79ZcJRrOr89DKyYi8a
         nkC8u+6o/xqzgE0Wj/1jzrkdIGsh2AYVaNP41242JLojouFBUTlVSTFUCLOt2Ecqsjho
         lK+p91V/agMi/f25toHMpmb8cSuYSdzHBWTma21e7DMdUtvfOu8QAt/YTCPXwgF6tD7/
         0jRoPtWnZOLTxAEsW+fO8++P0T3vbnskKfNo07rFVai6jPL2T07ZDieIKse7gPWnZgQX
         MfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZKtow7fEFdlMHA5nRCkAD1l/THJHrm+aeUBLA6vY08=;
        b=ekTfWS22PBlc9IKHVcG00d9Xwt2GdtqeRPRLrVQokCeCMMzQWaimEoTBUGap2G712U
         2oEwfyoFYhjpyQxhsMngpYMjHE1cABZnEDPui371g8gf4s/SF1xEIKwYeigV3x6IqTAE
         Gba3TWQ2B0m7vCBi2xcVqyi/K2S/BveG7eGzH5w3D51ni7VjQYxgeL4/Ch4ZgJBQANpJ
         UPi7lYgjftwTB5FvXdfgXx1kBizXs38KPV8dbNmsIQjwgudnEzkflNEGLijfHhYP9yk8
         /EX9i42ZLWUyjc7+NSc07TT9mpbJI3/H9BWE7zBZwN8JDBQZDleCjNdoEN1qoAf/6zmA
         TSwA==
X-Gm-Message-State: AOAM532D/9b4oGtaOuwDLtuI5lSHwn0rWPC34kj41i1GQL2Bohm8OBZH
        ojjN6klqYViDP6ogCdywad8zPDA0iRnBMg==
X-Google-Smtp-Source: ABdhPJydhq78TBKDuGGl1DS4VOpkDgpMGUIt5SSO7QXTLnNQ+BOUrog1oYCL+T3LMpI6MU5ShYdqvA==
X-Received: by 2002:ac8:6d0:: with SMTP id j16mr4328585qth.106.1606938698175;
        Wed, 02 Dec 2020 11:51:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5sm2660462qkf.133.2020.12.02.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 14/54] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Wed,  2 Dec 2020 14:50:32 -0500
Message-Id: <a9346ccd6f5de1a6cac12918ccace014b7f3bd6c.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index 66515ccc04fe..bf4e1018356a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1996,8 +1996,35 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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
+		if (!root) {
+			ASSERT(root);
+			btrfs_err(trans->fs_info,
+		"bytenr %llu doesn't have a backref path ending in a root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
+		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+			ASSERT(test_bit(BTRFS_ROOT_SHAREABLE, &root->state));
+			btrfs_err(trans->fs_info,
+"bytenr %llu has multiple refs with one ending in a non shareable root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
 			record_reloc_root_in_trans(trans, root);
@@ -2008,8 +2035,24 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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

