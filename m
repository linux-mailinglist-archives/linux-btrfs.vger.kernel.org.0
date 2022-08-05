Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9594958AC3A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbiHEOPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiHEOPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:13 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4B5C366
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:11 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id y11so1838774qvn.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0sjoeNK17wGi/2+ba6yI/ierfDGnAup5lWL1rQ4HndA=;
        b=JFJxmjgTiYAGGAT/6XrlWEFWIdnat2ukpga3oNePt8KRn08whnCcRRB3cgRQMf5ybA
         1hE8FYQwfdSkuBh+EYG/FRFyJ/Cyassjm1g6ZHOapfi2L+Tgu3i9Vh6aiga13anYQ41W
         raoOm5o6rp7Rqh5rIQ6qARH81SclmDqumjBkpJ6twwJp5k6hA/vWw1OHkLJHIfFe1HhU
         p1gxnObuWDoqIZmcX3CD0WUsClCnPdMy61KJiY5aQE7ptvhDb6n09wFAl9+bFBkWxVA9
         v5FFNdAC9MsuSZRWCuzaPp4ItmwY5YISlh84ge3poeL4pwkwt3yxAB/mL92Sp2mnGd7o
         WNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sjoeNK17wGi/2+ba6yI/ierfDGnAup5lWL1rQ4HndA=;
        b=QSD56WqHWsssPwCVGqEWimPtM2uYg1iOa7BYdlNASfSOaIkoPA/9pGW0E0PwHlICip
         WHgFofYbUw5hGli2RvnZyHLy3FyKqqXJ1NnyxG23RTihV8rcZe3zklqYHDXNxjQaOsKa
         bzI6flSGkEEuC9n015nA79Lc+NKFN/SGjjUHq8bIYfOH3cwBc2v8grseNDHQj0yo+h4n
         7CxTRyY4TeTctUp5z/dXfCRdjsURhLB/IAjEHBS0sVtg2W9DVlfBi21mWVlqxwp793Et
         x3zYv7gjgG4TxD6NHoRGEiwPJX5yRqSdXA2exFAC115vrvucMiAZcL8+Rl2NmArCNmv9
         ZOaA==
X-Gm-Message-State: ACgBeo3X8sQmfaYhyTET0JWqva4XFDN4yienlplI1mzXbdX/12lvy+EP
        tUPsbJdKhnpb+km/hDGNXN559f3i1D+6uQ==
X-Google-Smtp-Source: AA6agR6tbe6GOXTJan7xrkiwr05I2xG3y0KGlLzDc3g3LQZO7+zjIKXRae+HMqw1NZ5K+g4x6k0fyA==
X-Received: by 2002:a0c:f1c7:0:b0:474:725e:753e with SMTP id u7-20020a0cf1c7000000b00474725e753emr5781101qvl.49.1659708909821;
        Fri, 05 Aug 2022 07:15:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id fy11-20020a05622a5a0b00b0033d1ac2517esm2686256qtb.64.2022.08.05.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 6/9] btrfs: simplify btrfs_put_block_group_cache
Date:   Fri,  5 Aug 2022 10:14:57 -0400
Message-Id: <6416d8cd6a0a767f312093ebe586caa74656f2ca.1659708822.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1659708822.git.josef@toxicpanda.com>
References: <cover.1659708822.git.josef@toxicpanda.com>
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

We're breaking out and re-searching for the next block group while
evicting any of the block group cache inodes.  This is not needed, the
block groups aren't disappearing here, we can simply loop through the
block groups like normal and iput any inode that we find.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8fd54f4dd2de..b94aa8087d98 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3969,36 +3969,24 @@ void btrfs_reserve_chunk_metadata(struct btrfs_trans_handle *trans,
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_block_group *block_group;
-	u64 last = 0;
 
-	while (1) {
-		struct inode *inode;
-
-		block_group = btrfs_lookup_first_block_group(info, last);
-		while (block_group) {
-			btrfs_wait_block_group_cache_done(block_group);
-			spin_lock(&block_group->lock);
-			if (test_bit(BLOCK_GROUP_FLAG_IREF,
-				     &block_group->runtime_flags))
-				break;
+	block_group = btrfs_lookup_first_block_group(info, 0);
+	while (block_group) {
+		btrfs_wait_block_group_cache_done(block_group);
+		spin_lock(&block_group->lock);
+		if (test_and_clear_bit(BLOCK_GROUP_FLAG_IREF,
+				       &block_group->runtime_flags)) {
+			struct inode *inode = block_group->inode;
+
+			block_group->inode = NULL;
 			spin_unlock(&block_group->lock);
-			block_group = btrfs_next_block_group(block_group);
-		}
-		if (!block_group) {
-			if (last == 0)
-				break;
-			last = 0;
-			continue;
-		}
 
-		inode = block_group->inode;
-		clear_bit(BLOCK_GROUP_FLAG_IREF, &block_group->runtime_flags);
-		block_group->inode = NULL;
-		spin_unlock(&block_group->lock);
-		ASSERT(block_group->io_ctl.inode == NULL);
-		iput(inode);
-		last = block_group->start + block_group->length;
-		btrfs_put_block_group(block_group);
+			ASSERT(block_group->io_ctl.inode == NULL);
+			iput(inode);
+		} else {
+			spin_unlock(&block_group->lock);
+		}
+		block_group = btrfs_next_block_group(block_group);
 	}
 }
 
-- 
2.26.3

