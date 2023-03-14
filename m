Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1593D6B9C62
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCNQ77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCNQ7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3862D7B11C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BcjEzbtEYe+Ipj3b+3Rqt252o7K1fZlwoxt8sZ9a1B0=; b=oVzxC0CA2lChOjxLHTIZVWNdZr
        fhQAU3m2Q6EqrAzJOFJni8JGna2OS75cYkGtIFnOg5LF4dK+piBHL55aebDR1D+1mWkbxRje3mM7R
        GlJ5l1UluDbeah237xIjxgkYvKk0GX2XiH+LdjyGI4UzSK/WSJqyHTcP6JKmpyxncbIksmn9ovyX5
        gaAEMQsPw3XuPT64R7GXJBCBN8nJ1bcGd+MrlfjInoolrACVeGsqRJSNuZmAZw54f08Yq+01u4TMP
        xvLq9uU0DlJwROTh5ghcSU5YOJYsvtuNM/t9urLaBimv1Ql7DqY5mj8N8JJEavS/U6GaGe0zgTgeC
        vBvTpiVw==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc802-00Avrf-11;
        Tue, 14 Mar 2023 16:59:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: remove irq disabling for leak_lock
Date:   Tue, 14 Mar 2023 17:59:07 +0100
Message-Id: <20230314165910.373347-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
References: <20230314165910.373347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

None of the extent state leak tracking is called from irq context,
so remove the irq disabling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent-io-tree.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 29a225836e286e..caf11a10da71a0 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -21,20 +21,16 @@ static DEFINE_SPINLOCK(leak_lock);
 
 static inline void btrfs_leak_debug_add_state(struct extent_state *state)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&leak_lock, flags);
+	spin_lock(&leak_lock);
 	list_add(&state->leak_list, &states);
-	spin_unlock_irqrestore(&leak_lock, flags);
+	spin_unlock(&leak_lock);
 }
 
 static inline void btrfs_leak_debug_del_state(struct extent_state *state)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&leak_lock, flags);
+	spin_lock(&leak_lock);
 	list_del(&state->leak_list);
-	spin_unlock_irqrestore(&leak_lock, flags);
+	spin_unlock(&leak_lock);
 }
 
 static inline void btrfs_extent_state_leak_debug_check(void)
-- 
2.39.2

