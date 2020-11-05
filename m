Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03A92A8281
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgKEPpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731435AbgKEPpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:33 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB0AC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:33 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id s14so1529976qkg.11
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dxuwocR6MmBPUUghM0P+C6FMRSWgjk+JAj7Plkxd/8Q=;
        b=OQc09R00uIHve6w+DhLQIO08h32MZELPQL5xTrR8QHLRF+KtIDbFoYtPrQ4Vdd1D5v
         9UKk5LdqUnmQhCz3J/HkQkKMQgwyTCBvsQifYxlIYzJPChPDseDyB2JlGhbiRImfPwGL
         sCd5xeTNjDLXuu8QhU1DZxOWZ3ysJ5KbfMlEJcZcLBsoSYvamOQu4syBpyrvXhMZuZJl
         eZgtfXxNraKQx3chx/VSPjRMIjR4AtF+TKcB1NI0sqFkIiUVNSj19tRX7KGLbfQkw0Kw
         2+CLBiE3vlGL0tcrJxJx39I98IUIetn+Suwg+6MwdEvvort0jvjrxSsbfAVuYGB4Gqav
         CKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxuwocR6MmBPUUghM0P+C6FMRSWgjk+JAj7Plkxd/8Q=;
        b=XaP/JkPXO9AbKwk20EAN6464WZn6NLL2L8ZkjsOXXzbZeU/jofC+M6dZ+g00R4PtDW
         SXHpgeK8idDuHS2kxVWsQV8fkaAQDhs9ZbtRRhBsRWV5DfE4VJpfykddqSoQ8Kc8sQOs
         ZFwY4FCXQKAdSoknFNTivTOW9Xtt2Dq5j68E9oUMP+FoylVqPvV7bXIFFYDZzl1jFomh
         ixvoXdVMsSuVyuUu6UlDReCo/pcchwk8JrRsSORXVbCKsNq1Fw5r6BYrFGe/kpdgezsq
         yHZtkQ1gocAtYJ/A3uO7co5I+pH385BL+2rWk2oDED0W1XaHkeSW4/LXJGGRm4w030Er
         AIyw==
X-Gm-Message-State: AOAM53188Mzh749mSyXBaJUn3yeiuC2EsCXybuG26chtkUDUkE5xvNPI
        ZyxpauBcaWeveN7NWNKYcZELni71XpNFQ9LE
X-Google-Smtp-Source: ABdhPJynQHag0AYXpD1MZM71nC8Bo4d+LfxqBD9trvOZw1A/Z2wyWdlPDPR60Gw9xvxdMGpYcItaew==
X-Received: by 2002:a37:8846:: with SMTP id k67mr2516497qkd.132.1604591132446;
        Thu, 05 Nov 2020 07:45:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 69sm1267627qko.48.2020.11.05.07.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/14] btrfs: use btrfs_read_node_slot in do_relocation
Date:   Thu,  5 Nov 2020 10:45:12 -0500
Message-Id: <673095c14fc04a76cb5b189505d23bf33003b5ce.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open coding btrfs_read_node_slot in do_relocation, replace this
with the proper helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d327b5b4f1cd..4d5cb593b674 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2191,7 +2191,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			 struct btrfs_key *key,
 			 struct btrfs_path *path, int lowest)
 {
-	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
 	struct btrfs_backref_node *upper;
 	struct btrfs_backref_edge *edge;
 	struct btrfs_backref_edge *edges[BTRFS_MAX_LEVEL - 1];
@@ -2199,7 +2198,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb;
 	u32 blocksize;
 	u64 bytenr;
-	u64 generation;
 	int slot;
 	int ret;
 	int err = 0;
@@ -2209,7 +2207,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	path->lowest_level = node->level + 1;
 	rc->backref_cache.path[node->level] = node;
 	list_for_each_entry(edge, &node->upper, list[LOWER]) {
-		struct btrfs_key first_key;
 		struct btrfs_ref ref = { 0 };
 
 		cond_resched();
@@ -2282,17 +2279,10 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 		}
 
 		blocksize = root->fs_info->nodesize;
-		generation = btrfs_node_ptr_generation(upper->eb, slot);
-		btrfs_node_key_to_cpu(upper->eb, &first_key, slot);
-		eb = read_tree_block(fs_info, bytenr, generation,
-				     upper->level - 1, &first_key);
+		eb = btrfs_read_node_slot(upper->eb, slot);
 		if (IS_ERR(eb)) {
 			err = PTR_ERR(eb);
 			goto next;
-		} else if (!extent_buffer_uptodate(eb)) {
-			free_extent_buffer(eb);
-			err = -EIO;
-			goto next;
 		}
 		btrfs_tree_lock(eb);
 
-- 
2.26.2

