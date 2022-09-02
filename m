Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542B05AB957
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiIBURV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIBURM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B9D1245
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:11 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id l5so2241670qvs.13
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=B41h4t1fWN6ZCZvrgNTNPCpobaQCPA3fMj1ZGefNfK0=;
        b=GzFUBkcZdGdY3PuZxOl9xPKYQFm882U80a0xingsxMvvc2/DmiA2Nt3rl66ueqpua4
         2fCCFMAavnzdHNKKX8g8n8p+vi5gBO+UZpihZWR9E+YxrEs58jm7KC6r6E2y+Rf4S5Zd
         6NJ8hEoMqvEx626MKA0rH0G+l2rPcEmKZyYmqhQT3ToPrSyligk/gLatzL2ujYEx9ZJn
         xcHh/vjvz3Z/bxQjYZeUHt/HrQZ2Hmx2Tssl8v6rK0HqxS8mtD/oLdhrZYnKfCSdGc2k
         eyhKurHZpVcBvS5eBcxuzTKT7q/YZCz6UyPafsqzfClm3jNAaVDNJOfTFCklZKG+RSBC
         GyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B41h4t1fWN6ZCZvrgNTNPCpobaQCPA3fMj1ZGefNfK0=;
        b=Ivf4BFMGFNTejwtkNadmwMW5cWwPwvocM4n4gciqEefNHFsbBXX97McGKjqMuPIMeP
         GP1pfBwfwhhRh3Qh6C921rAGalQTbXS5135ixbPFtfd8LjCNzdxy2cg8zrxosjw7QEjL
         ciQCjhBpB32getqEXLvGkArpeZ91BDGrPD3U9r90NuNJrYYZmgO6As9VKkCWKijz0hrH
         72gJNXx+DmcebRdgcFGLSyBv0liexzmYl1du9Rq/LacfBFkpbuHsTuOVjsUGrhDVFwLS
         yep2T+kutroxNnthwkcBQPcU+hXmDnTzZ1jm86EcQNB+RRyNuYVRiA2DnvcFQGaoSjYU
         V1TA==
X-Gm-Message-State: ACgBeo2tP6/FiLS8P+uV8sNKwalxFVrfFCQ3t8UA8jfn+r0V5Kdhl3v/
        lCpAQQFwAWYCkgLxRce9NMmFYIl2qwyiSg==
X-Google-Smtp-Source: AA6agR56NUx77QbfOKFM9VUJpRwdSJOaZsl/IPW5XCq8aOWza0dXPrCFedpIoHXQBfAehsXX0AtRrQ==
X-Received: by 2002:a0c:f242:0:b0:498:f3ff:d9e8 with SMTP id z2-20020a0cf242000000b00498f3ffd9e8mr29169974qvl.18.1662149830363;
        Fri, 02 Sep 2022 13:17:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006bb82221013sm2321106qki.0.2022.09.02.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/31] btrfs: use next_state/prev_state in merge_state
Date:   Fri,  2 Sep 2022 16:16:23 -0400
Message-Id: <6596fa73ebb4edcb1db79b0c099da17ca7d26275.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

We use rb_next/rb_prev and then get the entry for the adjacent items in
an extent io tree.  We have helpers for this, so convert merge_state to
use next_state/prev_state and simplify the code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 49 ++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 9bf82c7146a8..bd015f304142 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -366,40 +366,31 @@ static void merge_state(struct extent_io_tree *tree,
 		        struct extent_state *state)
 {
 	struct extent_state *other;
-	struct rb_node *other_node;
 
 	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
 		return;
 
-	other_node = rb_prev(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->end == state->start - 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->start = other->start;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
+	other = prev_state(state);
+	if (other && other->end == state->start - 1 &&
+	    other->state == state->state) {
+		if (tree->private_data && is_data_inode(tree->private_data))
+			btrfs_merge_delalloc_extent(tree->private_data,
+						    state, other);
+		state->start = other->start;
+		rb_erase(&other->rb_node, &tree->state);
+		RB_CLEAR_NODE(&other->rb_node);
+		free_extent_state(other);
 	}
-	other_node = rb_next(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->start == state->end + 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->end = other->end;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
+	other = next_state(state);
+	if (other && other->start == state->end + 1 &&
+	    other->state == state->state) {
+		if (tree->private_data && is_data_inode(tree->private_data))
+			btrfs_merge_delalloc_extent(tree->private_data, state,
+						    other);
+		state->end = other->end;
+		rb_erase(&other->rb_node, &tree->state);
+		RB_CLEAR_NODE(&other->rb_node);
+		free_extent_state(other);
 	}
 }
 
-- 
2.26.3

