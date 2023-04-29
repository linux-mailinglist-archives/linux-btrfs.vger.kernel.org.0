Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9C6F2658
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjD2UUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjD2UU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:27 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266FC213B
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b983027d0faso1694232276.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799625; x=1685391625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcC2hnCsatnYMvrBn30F5bFpiqpYNore5TaVS9jo++M=;
        b=lKPTp6lyWQVJq+R0BG0MLA2P0rGb8z1o8hwkFCKkZulHIso2GXR/gMbqAu1pcyzmxr
         H+0qikrAWVQd4WA3morD9iTA8harSv2mgg9YASV7wThSn0pMYbiPCurN7DoP4QiPxHfP
         TyITNXIE2OwstnlTwQYhade9PkaFjthkDYwkb+e9IW1nRBYTHDYofe3oF7PgUgAtk7RZ
         YxZuwwmgmDr+2oWfGTvx+eTJJpXZ/NhSXoJKtUijrc4zDtMzJr/8NTkeiR5urehjg1pi
         WOnTp9neTwzy3lizDEN726l4RHS4c6RdW9lWhPfXJUAww//U8s9DKKN7Fs33dzyPZxib
         a8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799625; x=1685391625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcC2hnCsatnYMvrBn30F5bFpiqpYNore5TaVS9jo++M=;
        b=PcT+1GkmAW5PJQXqwq8hTiLc8YPpNpzPwxRsqfOvftHQciU0p52TBBoEGpZtlvXjj/
         ttoOBsx2loJSaH/SzlA4h/ClzZYPosq03Nq/poLoZNw7phhHLeElIg38FxQGWGp5qNtU
         kXKVjEK3QvtpOxUytS7yfyqXYlahbuuBlc/hmUebgLM+YeeLxQgUkqxDzMyeT/zKPUKZ
         K2eCNM6Ffuko8nNS/Jgx2VC7Th5kdds6hOqLwTXH7NUvu4l83Ppdc9nGkO0Y67rqXCb9
         b0UtSE4LBgt5BXwSEIF5g9AOwTlaS//u2tps7pI806pfbEZ1V5NOzwgoJ8sA7T9qK09R
         QD3w==
X-Gm-Message-State: AC+VfDxpMEmANaQwX6v6XRrnL4LnEXJH3JRr9pqNYEYF5EUMLdjb+6Yh
        FIgpSv+DJefHJR9JfQooJ4v9VKQcSuQy7p+jkBNfAA==
X-Google-Smtp-Source: ACHHUZ693cRZ45CqjAone0rvryV3yz3RrBFkFkuWXi2YguYOe+DZjiZC2LZSpQlkX2/gYKpcr8IyUA==
X-Received: by 2002:a25:d04c:0:b0:b95:5682:7db0 with SMTP id h73-20020a25d04c000000b00b9556827db0mr9227870ybg.13.1682799625075;
        Sat, 29 Apr 2023 13:20:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 130-20020a250f88000000b00b92426aba45sm5878572ybp.57.2023.04.29.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/26] btrfs-progs: don't set the ->commit_root in btrfs_create_tree
Date:   Sat, 29 Apr 2023 16:19:49 -0400
Message-Id: <4a64fa21d07392cb7f109b0c9a362a57e926ebcc.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

In btrfs_create_tree we set ->commit_root to the current node, however
we don't add the root to the dirty list, so this is never cleaned up.
This is a problem in btrfs-progs because the transaction commit stuff
clears the commit_root when we write the dirty root out, so if we try to
re-modify this root later we'll fail to start the transaction.  Fix this
by noting that we do this differently in the kernel, and drop the
assignment as we're inserting the root into the tree_root in this
function and thus don't need to update it again at transaction commit
time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index b7a98c4c..ec97ff08 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2384,7 +2384,14 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 
 	extent_buffer_get(root->node);
-	root->commit_root = root->node;
+
+	/*
+	 * MODIFIED:
+	 *  - In the kernel we set ->commit_root here, however in btrfs-progs
+	 *    confuses the transaction code.  For now don't set the commit_root
+	 *    here, if we update transaction.c to match the kernel version we
+	 *    need to revisit this.
+	 */
 	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 
 	root->root_item.flags = 0;
-- 
2.40.0

