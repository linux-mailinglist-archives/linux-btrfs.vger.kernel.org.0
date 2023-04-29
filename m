Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885476F2632
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjD2UHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjD2UHf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF10F7
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:34 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso1661373276.2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798854; x=1685390854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ8dPfa8SZadkp5O/gW+kS1g7e8Idqo0ltCe5k3dcd4=;
        b=gZsN4PVFapzZ7OP6hK/oFivsveGLx2JwBMxuCKMqAsOu6LvMZJnDc7cud8JYmM6t7l
         fZH0rOYRwKiIgaadZaGQHBZqjTxLU0ljs8L1B+uozaT31lfObEEcsWYpZlhtrodbxB+A
         dEX/qd3YrA4v7gkQ1mWtm0bCokvzMlcMt+oICDtOc6cLY+ectEPUzJBbWZzA/B+pJSE9
         gHgsBOC2BELVyTz8su89DPPbdHrp9mODZBHLCNkLEa/r3zSFVm2ZrO9/ABjZmoRt40KL
         3vWMtVCBYmn/6GbvTwXelFDs08AzYE0ETQ1+bE9GxwvHBP7dYGMByMXaFPpqQQMNdRz6
         Y5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798854; x=1685390854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ8dPfa8SZadkp5O/gW+kS1g7e8Idqo0ltCe5k3dcd4=;
        b=fXIPbCyM0lOz2VGcR72wNcIbtNb2iXk043P9V8ZlaDTnsBWdB/0ntkjyvL67p9LFJ3
         EMw2mYgLB06M9LQG26C/hiVnuv0YnZZLeggP8vAEiKGRiqz+uhtkAGPUH7S0nyx/De9U
         Lgyj/7oyDEWSDPsltuB4KltblTiWIYsYgHCDs50Sq7ZFbDVOV1zftNSYmEgUJ9q15QNK
         2cJsJpvaSL9wOIce88CBmG+yFQ8cMJ0u3dP4kCuKk0MMpWFc9EU1px2ud741sfKuA/KI
         nRQkZmrts2nZbpZsCAdf1bJA4dW7AL3mVS53bYK+bAY2fh15OdMFUDXo+Z0BOnU5t5hj
         Nx9w==
X-Gm-Message-State: AC+VfDwiQcGlVthnmC0Vs5ZFrOuf49YX7LSfsYNUoXVTPHiNUf+ahYP1
        QzU0hBe2u8ai48g2MiygIe9vDUISgLotFQ3V6wk8zw==
X-Google-Smtp-Source: ACHHUZ5xXjbHTeQzlJ5wYg9K3Qt+zyJdeCRBqwwFD4fPdnrFu5fnIJyvG7Fr0+2QLCPavURLnIxfpA==
X-Received: by 2002:a25:6d4:0:b0:b92:2940:ac60 with SMTP id 203-20020a2506d4000000b00b922940ac60mr7154874ybg.25.1682798853787;
        Sat, 29 Apr 2023 13:07:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d15-20020a25eb0f000000b00b8f52b11de6sm5838935ybs.42.2023.04.29.13.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/12] btrfs: add btrfs_tree_block_status definitions to tree-checker.h
Date:   Sat, 29 Apr 2023 16:07:13 -0400
Message-Id: <d748a7c5d28648aafbe1e24b81b6db0e0ed4647c.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

We use this in btrfs-progs to determine if we can fix different types of
corruptions.  We don't care about this in the kernel, however it would
be good to share this code between the kernel and btrfs-progs, so add
the status definitions so we can start converting the tree-checker code
over to using these status flags instead of blanket returning -EUCLEAN.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 48321e8d91bb..5e06d9ad2862 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -40,6 +40,18 @@ struct btrfs_tree_parent_check {
 	u8 level;
 };
 
+enum btrfs_tree_block_status {
+	BTRFS_TREE_BLOCK_CLEAN,
+	BTRFS_TREE_BLOCK_INVALID_NRITEMS,
+	BTRFS_TREE_BLOCK_INVALID_PARENT_KEY,
+	BTRFS_TREE_BLOCK_BAD_KEY_ORDER,
+	BTRFS_TREE_BLOCK_INVALID_LEVEL,
+	BTRFS_TREE_BLOCK_INVALID_FREE_SPACE,
+	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
+	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
+	BTRFS_TREE_BLOCK_INVALID_ITEM,
+};
+
 int btrfs_check_leaf(struct extent_buffer *leaf);
 int btrfs_check_node(struct extent_buffer *node);
 
-- 
2.40.0

