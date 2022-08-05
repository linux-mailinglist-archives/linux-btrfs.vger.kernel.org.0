Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B1E58AC40
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiHEOPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbiHEOPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB645B7B4
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:09 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id mk9so1807149qvb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zPAERh5PKVzP4IMDM9RG80tYsQKkWjMXr4WF/iPhzSQ=;
        b=5PpigyZRa9ZRw6+dq+BL+l+2mE8+fB2NmQkSaEGJT/MjdvZdNFbI4qfkT1d3KKCbo0
         MgKNKCGVw18dN2OqZ8ou5RmG7k6/J862Z5gBUW9aFExOOcRwFbmp4PaZjaushTOZC+8v
         kn2jVZcwiIuFkrKSs+7WZHU+GhJkmHj8PLOkaHkt9JUue+wUD5VQjVAGWoUbjM2VeAIx
         EkW/9BAmtujTjdgeygbGCK/Ob6K4RYyZrNOHl4J3x/xmy+TzQwWqSjeVy9nlsgZUd5m1
         tzSOAYbUtcT3XK3SbzGlgG7DQMNBR/vwGLE8lab4doJiX6QzucOS6SkneMukdeW6KtzN
         3ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPAERh5PKVzP4IMDM9RG80tYsQKkWjMXr4WF/iPhzSQ=;
        b=gxDql6659dra7cnz9Z9EFjDQ2VUJc72ulRawrbFrloouk23gtK4LBHXZtKohMxiMle
         vZLpqesyNe9TOrfjB5BLANEgRhVJv2Xl32t8+V8l4iDQk/NUCJ8yV3BsWTVqasxVDETB
         T/sj2IkALXQfSptdoNS5tn+80xyNVA15VE2JwCrSXdnkZb+oao362mUkQJ0O7jzdRuFc
         0eDu4qFjpOkqlcse09SM2nE1eVf32L3Zde1ZPQSSVkRKY8SMcAlGxfeE5nhbiQZiL2N6
         b2y/pRLy+4YfU+V7wEk2uw/GT9BEtt27kEAP2BKnCtsu5FumuFdxCJR09NsnBNiY81Iz
         F79A==
X-Gm-Message-State: ACgBeo0GqoAA8jeYpoRU9AHSfwNaUoSSlKmeiKCZctpe9ItBlOn4oGqP
        hbUpkXye2PUqNdCqMeyDvPUUJu8u2sKWTg==
X-Google-Smtp-Source: AA6agR7BDN3OBPBavyuHMu8Mwe9bYq4K9BT5dxURykhCEWLlEzqiy86SYKZ+/aiklp5OqRmmOKcmfw==
X-Received: by 2002:ad4:5c4b:0:b0:474:7aa4:b0ba with SMTP id a11-20020ad45c4b000000b004747aa4b0bamr5813483qva.49.1659708908551;
        Fri, 05 Aug 2022 07:15:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q8-20020a05620a0d8800b006b8cf08d37bsm2995501qkl.130.2022.08.05.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/9] btrfs: remove block_group->lock protection for TO_COPY
Date:   Fri,  5 Aug 2022 10:14:56 -0400
Message-Id: <43147dace77ecc3e88dc2d5d034bfa6f1f5ba4c4.1659708822.git.josef@toxicpanda.com>
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

We use this during device replace for zoned devices, we were simply
taking the lock because it was in a bit field and we needed the lock to
be safe with other modifications in the bitfield.  With the bit helpers
we no longer require that locking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c | 5 -----
 fs/btrfs/scrub.c       | 3 ---
 fs/btrfs/volumes.c     | 2 --
 3 files changed, 10 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f85bbd99230b..488f2105c5d0 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -545,10 +545,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 		if (!cache)
 			continue;
 
-		spin_lock(&cache->lock);
 		set_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
-		spin_unlock(&cache->lock);
-
 		btrfs_put_block_group(cache);
 	}
 	if (iter_ret < 0)
@@ -610,9 +607,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 	}
 
 	/* Last stripe on this device */
-	spin_lock(&cache->lock);
 	clear_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
-	spin_unlock(&cache->lock);
 
 	return true;
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b7be62f1cd8e..14af085fe868 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3764,14 +3764,11 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		}
 
 		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
-			spin_lock(&cache->lock);
 			if (!test_bit(BLOCK_GROUP_FLAG_TO_COPY,
 				      &cache->runtime_flags)) {
-				spin_unlock(&cache->lock);
 				btrfs_put_block_group(cache);
 				goto skip;
 			}
-			spin_unlock(&cache->lock);
 		}
 
 		/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4de09c730d3c..8a6b5f6a8f8c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6150,9 +6150,7 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 
 	cache = btrfs_lookup_block_group(fs_info, logical);
 
-	spin_lock(&cache->lock);
 	ret = test_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
-	spin_unlock(&cache->lock);
 
 	btrfs_put_block_group(cache);
 	return ret;
-- 
2.26.3

