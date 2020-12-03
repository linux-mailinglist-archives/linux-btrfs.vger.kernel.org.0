Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DDB2CDD5E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbgLCSYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbgLCSYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:33 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93012C08E862
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:23 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r6so2066106qtm.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vx6FQGPAtVmSplymEMoDA9sA2iSVI0CL70LRafsPBms=;
        b=RJIVeATXaJuz1161UtnuwLlJYTbms7FzkVSyNUy2h4JKN+INTkXJ9/pqfLdWoYNC36
         vWvU3mKEnX+OzINMhwPbT4cJZanBVRyu+oQ8/Zdl99+ArXqrNt8XfeH84rEJnqdLsiCI
         dIy/+SlWe5mSMjnON2Lkhbe0Kcr5zgrIU9TsdnetzNQx5p6GQ9lvhMVYG7oL3YoJSdOB
         SAdN6f6cWaKPktmwOSSe3XyiX9zW/qbcIxIxUUpPkJTZUQuL46zJ5aODa3zY1ZOliXLz
         cJ3nWPQqVJc0e1n6Fy2Yj1Psnf3f1ejjsWorqnBS7d/JT8C5IhF/yFRSV4c8aLdiaWQU
         ZGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vx6FQGPAtVmSplymEMoDA9sA2iSVI0CL70LRafsPBms=;
        b=dBsLlgBy9KHJTMirRJbAjeRe7NvvaKMNGYuZm4V+I/9bZroBTGEM2ugAY9lgaoiuwM
         mZ+m94Rx+UXP1sBumdZXelAFuOUwE6tUnpKSdBQcELX+OMeiWnfkz8DfWPzs0CTAgI9n
         jOOKrm94/g01uCr47LsSjGN83LgJWgi0Hq5m76WxnDdgNCthXokmS6KGLvjCY6Rmu/r4
         caSgJCZTCZWwFaRnRH8PmBExTRdUhNdTuxUO/te2g9b93HmUsPcq5o4Bm+TfyrrfiBpo
         +0QWeVzuUmxTLkpoUxlgCaZWoGteByiCXb8DWdEsnVscBtJfqk2aY6+6fk/tH3Llgk/U
         mzRw==
X-Gm-Message-State: AOAM530dlwwFQt3Y6+QgzHKPCp43xnWSzP/nqS8eU5wMjG3zW5N8+1U9
        4ctaJwiUDyu/TMs/hgCVKkNHGkmzvWjmt2ok
X-Google-Smtp-Source: ABdhPJysD9FibAcmsPz+wKGgyJCOU/vBXubGfhcDUk98jhclG6Yvyeo0roF93ap/gCU/0kRsiYFEwg==
X-Received: by 2002:ac8:4a92:: with SMTP id l18mr4595166qtq.212.1607019802511;
        Thu, 03 Dec 2020 10:23:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e10sm1977783qkn.126.2020.12.03.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 12/53] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Thu,  3 Dec 2020 13:22:18 -0500
Message-Id: <9d163d83ab27b126c6940ca48fb0bcc71cdea0ae.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a couple of BUG_ON()'s in relocate_tree_block() that can be
tripped if we have file system corruption.  Convert these to ASSERT()'s
so developers still get yelled at when they break the backref code, but
error out nicely for users so the whole box doesn't go down.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d0ce771a2a8d..4333ee329290 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2456,8 +2456,28 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
 	if (root) {
 		if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
-			BUG_ON(node->new_bytenr);
-			BUG_ON(!list_empty(&node->list));
+			/*
+			 * This block was the root block of a root, and this is
+			 * the first time we're processing the block and thus it
+			 * should not have had the ->new_bytenr modified and
+			 * should have not been included on the changed list.
+			 *
+			 * However in the case of corruption we could have
+			 * multiple refs pointing to the same block improperly,
+			 * and thus we would trip over these checks.  ASSERT()
+			 * for the developer case, because it could indicate a
+			 * bug in the backref code, however error out for a
+			 * normal user in the case of corruption.
+			 */
+			ASSERT(node->new_bytenr == 0);
+			ASSERT(list_empty(&node->list));
+			if (node->new_bytenr || !list_empty(&node->list)) {
+				btrfs_err(root->fs_info,
+				  "bytenr %llu has improper references to it",
+					  node->bytenr);
+				ret = -EUCLEAN;
+				goto out;
+			}
 			btrfs_record_root_in_trans(trans, root);
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
-- 
2.26.2

