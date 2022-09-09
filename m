Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B85B41B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiIIVyF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIVyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB310300F
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 3so1822255qka.5
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=pP3dhZ+ZmPQsVzNojbnTAghRS+VVB3ge1tStzWbVoNU=;
        b=03oWBACHNozXHNsspaWwOsvSfbINB5jVFL1Nf4stxFGozIk4cg6bmaO4vheKS0RQ/s
         3VmHHIQCj1PntcF7pPek2IX3IDviiZk5mAfzKquB+MSEM6gdBQZDp+EHOHoFXw+xM4k5
         2zXncNe0vJGA7kBddQq7lwJrNI9+jG+Prtc9ePz0Ezv5zYuQkZt6Jb/49eOcpVPfxM6r
         Qdl8eSev6LwxRpT1Jg2dtG/x+E5FIyAuswkRanozbTARLjZxJlZHD3krN63oRCALXDk+
         APqrIWHAaFiRLXt3wdEloMKYmRncmUEAObIic7yuoDdRk4vaMDWzyZvQOEerax3wy7/w
         KX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pP3dhZ+ZmPQsVzNojbnTAghRS+VVB3ge1tStzWbVoNU=;
        b=C+tI6J1zN5uYOrQNb68xPGLj2pnlgLBfxF1kRAtE6mYW01I/zyOhWDXKh4z+4x9g9G
         33/SnB2LfjPIFpb7p+mZdDIIVfr28wxu3/IMlBh5+O27Qp9WbfU62IWtJACeFQEVs6Ib
         rrvQNql6M2B6CTmK0Yn7wFCr5JbYdxg9SHwWgKVvVMw9Efp9NL0dgu8/VRohhZzEagQZ
         9t8KdqD8vkpcZ6B72B4JoEs1cDXui5m1/jNhxcE6hb7fWy/DHwvzwHd+pm7c0rtAU0Hm
         iOcE9Mre44OT7sS9Ao2cR7rUTgvdpF2nv1nqeYLaauw25JBFTsiKIIFhqqYfQcVluxXa
         pOXA==
X-Gm-Message-State: ACgBeo2ghmOpsDsP7UXiucTTqP3xMq8wNYM1G60adW90NW4iH25D0QCH
        vsO85uhsx/or+1FpMy1xwNIopNefz9bYKQ==
X-Google-Smtp-Source: AA6agR74Q+uc6mKMHfTPvwV2XNh93wtfFPkJQwq6Bq6L7CqxCHAHSLip5wGBeoHtWMhYL2tELX70BQ==
X-Received: by 2002:a05:620a:122c:b0:6c9:cefa:f6d2 with SMTP id v12-20020a05620a122c00b006c9cefaf6d2mr11600107qkj.313.1662760441440;
        Fri, 09 Sep 2022 14:54:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 4-20020ac85744000000b00342f8984348sm1295926qtx.87.2022.09.09.14.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/36] btrfs: temporarily export alloc_extent_state helpers
Date:   Fri,  9 Sep 2022 17:53:20 -0400
Message-Id: <0a21adef99bb0f2bb90d0c7032c007fdcba2bd77.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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

We're going to move this code in stages, but while we're doing that we
need to export these helpers so we can more easily move the code into
the new file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h | 3 +++
 fs/btrfs/extent_io.c      | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6c2016db304b..8e7a548b88e9 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -250,4 +250,7 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
 int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 			   struct page *page, unsigned int pg_offset);
 
+struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc);
+struct extent_state *alloc_extent_state(gfp_t mask);
+
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 35811d40e2f1..412dabccb1f4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -339,7 +339,7 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 	spin_unlock(&tree->lock);
 }
 
-static struct extent_state *alloc_extent_state(gfp_t mask)
+struct extent_state *alloc_extent_state(gfp_t mask)
 {
 	struct extent_state *state;
 
@@ -710,8 +710,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	return next;
 }
 
-static struct extent_state *
-alloc_extent_state_atomic(struct extent_state *prealloc)
+struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
 {
 	if (!prealloc)
 		prealloc = alloc_extent_state(GFP_ATOMIC);
-- 
2.26.3

