Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745B82DC433
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgLPQ2i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgLPQ2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:37 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1CC0617A7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id y15so17586499qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/BDcdy5VY4Xg0QOPj7UvOhTBKSZwTZcS0NwFAeBbLc=;
        b=BGxW5R11GZ5cLz2ufFKn55RBzP1hV9/I1+zXrDl2pV5K0GpkwZ1DGBbbxTmhxQSXFi
         91O2sdBaVSfn69MaAQ1ctnxAMvSkNE7nX0CSEqHrix3wTSq7SQ1WX4OvCBh511RxwBQ6
         46HWsajvfAFbswtHe5vlUU+dTNjBB6Kh6DI+20jrlZeSYqQA0V64wfsXnzk8h52jxU82
         5tHfLtFMlwGKmVoyb8MMckNZmIXm461ELrrp+gmibprcxm7e73O/Wh6jw2dGcapf7p4s
         NvBqgn671tclwpIXDX0qdUsTEIEv3qFwWik/TmCV90lNvdvpv+a+GWqKOjhQBZ9FdiQB
         CRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/BDcdy5VY4Xg0QOPj7UvOhTBKSZwTZcS0NwFAeBbLc=;
        b=nDQcLrZ/2ZfFg5VkzLxK33cNEAENmjnJiYMBPQBkU5Tgky6n7i3WTXBkIIHMKVqWZw
         Wa/8bBBkwGbNGWoY1Fu2Fd0HE7FbvJADNodCQBdFf1s3+imlzx3euJmKaxGtc8cNAlut
         8TafHx28gWrGJWpg/zB77ha6WqIaj0oWn83EpRBuu1SIQQGq1L59uJ+Kqsi0YKJbvfWX
         uqXNno+5NfnlNy1Sf6U7Q8qJ0T1bVWNsieC2k1zSZLRw6UKeppEEKUDiJudtAByzYMMI
         ncMHCkxW1dECV4PdEV1cLeh7pNtzxyiL6a5FivatwqJa3CUI/QzVQz4qdc17NIH3ZBO1
         OIYw==
X-Gm-Message-State: AOAM531xUGP2zhUHz/Otl3DvZX/IDcXpozRGEe09YdFsBjbKaII1RKyz
        jDBCshfhOit4Hg9Z7u+vXTmHZiOfqjMKvVbb
X-Google-Smtp-Source: ABdhPJxi8lWJXwrmt0g/j2+jP4rw7INLEmzMFnFjNt2QFzAC9H/JNw8TvAHdXSwSLAeuom7JYwgojg==
X-Received: by 2002:ac8:7141:: with SMTP id h1mr42321689qtp.211.1608136063658;
        Wed, 16 Dec 2020 08:27:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h125sm1363614qkc.36.2020.12.16.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 27/38] btrfs: handle btrfs_cow_block errors in replace_path
Date:   Wed, 16 Dec 2020 11:26:43 -0500
Message-Id: <e86a1288079d8981e905324741f70370448a65fc.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we error out cow'ing the root node when doing a replace_path then we
simply unlock and free the buffer and return the error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 574ae3f43e33..d43603ae5570 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1232,7 +1232,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	if (cow) {
 		ret = btrfs_cow_block(trans, dest, eb, NULL, 0, &eb,
 				      BTRFS_NESTING_COW);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_tree_unlock(eb);
+			free_extent_buffer(eb);
+			return ret;
+		}
 	}
 
 	if (next_key) {
@@ -1292,7 +1296,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				ret = btrfs_cow_block(trans, dest, eb, parent,
 						      slot, &eb,
 						      BTRFS_NESTING_COW);
-				BUG_ON(ret);
+				if (ret) {
+					btrfs_tree_unlock(eb);
+					free_extent_buffer(eb);
+					break;
+				}
 			}
 
 			btrfs_tree_unlock(parent);
-- 
2.26.2

