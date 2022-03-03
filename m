Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080354CC9EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiCCXUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiCCXUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A143BA6F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q11so6136851pln.11
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dDQptnmnXM+eagiPJmnEv3pr4ajcDowzXB7b89WVcE=;
        b=PZZA856OEIWMR6WeVQHWYmC95MzYPoO1C1KQoM8/0r3EQKtwI1i5u+a1pYECBFzvQ0
         Col1y7kfklCg2gPRlYDwdgWkp9TdUrAKoJaHeaLaWUNGgWCRRivL+/AvAHGbjCyYFG/c
         qJ9s+psvZszUZcXd2oXvjpkzDQ0Wt6yW8gsS92pn+yeUJcBR9iOiMDWugusub1tJm5i6
         I7SrquooETfBf7i6HdTev5+1tXjULbVDpsy+dYRq0zWpQXxfZkbI64xYiAnDKTV6Nir8
         PS1dR+GG2a46ngACDYcYNjCc53r9DAgX1JQYe27u6yopZe3llSaFmb6mY1GYuyX4368z
         JSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dDQptnmnXM+eagiPJmnEv3pr4ajcDowzXB7b89WVcE=;
        b=c8xfF0JzlkpXFvGLLAK4HZ7rHAplFSu6RKFlRaSF3btlvajhPH0ifU2NtI+44fmtyV
         wamKwWDJXodv1M0sIWLdkJ78xIEZp/MZW2CSsJd6e/titZfxZPJkCy+Sk4lKrn9fEzSz
         gp2/IPo4jkWdclLHL3h7yW1YGzosiEU+qp7xWn+Q5dXaFI2VNjgRvzgIrRQy+xCnLxLt
         /qbboRT39QbIJh7NswxxoFI6WU5fTXcQrddnvPmkoHZdIMC0E163y+wyER6xY06yjLX2
         QcO3vnXUXnzXCgkdO8R0Aco8WzTagUR/5GSU76s9oleHjHpzE75SuzrekB7KRiAGFNBK
         M/gg==
X-Gm-Message-State: AOAM531P7K6MaDS0pC6JKyCXnK0YRLSSJgqtGZ5bvFXLuzPbDj5nnisC
        JR7eQDqpjPUTKWG9hLuWq4DBjP08FCjMyg==
X-Google-Smtp-Source: ABdhPJx1ousVG7WnJEGiukJCRV8u+m5HOb9KA6ULB8r4lzRGqLtlVhuNLdMZnlAjRyUCApk6Oa5mOQ==
X-Received: by 2002:a17:90a:8b82:b0:1b8:9624:2bab with SMTP id z2-20020a17090a8b8200b001b896242babmr7817278pjn.177.1646349561333;
        Thu, 03 Mar 2022 15:19:21 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:21 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 01/12] btrfs: reserve correct number of items for unlink and rmdir
Date:   Thu,  3 Mar 2022 15:18:51 -0800
Message-Id: <689484459053d8d48db99275dc01be8d8cf52686.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

__btrfs_unlink_inode() calls btrfs_update_inode() on the parent
directory in order to update its size and sequence number. Make sure we
account for it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e7143ff5523..2fb8aa36a9ac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4212,8 +4212,9 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
 	 * 1 for the dir index
 	 * 1 for the inode ref
 	 * 1 for the inode
+	 * 1 for the parent inode
 	 */
-	return btrfs_start_transaction_fallback_global_rsv(root, 5);
+	return btrfs_start_transaction_fallback_global_rsv(root, 6);
 }
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
-- 
2.35.1

