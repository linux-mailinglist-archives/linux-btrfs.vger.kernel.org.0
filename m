Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4045F4D0ADA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbiCGWTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343731AbiCGWTI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:19:08 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF623427C0
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:12 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b13so13255765qkj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+KvqM0CkPE2mwCbjTrqIfGEAHHgCIFCwOAnw16f85go=;
        b=FG24tD2PzqhBFaNm2x0olP2DGVg3jS2RYsl9wBvmpEg+KSlLNlwzGQ46uThFJmaVOi
         7+j5y3kSwJrO1mRUL5upHrTLnwlMB6UcH8T9Wg0SE4Qz9g1X1w4QZCs0G02cRhs16zUQ
         ltbvgj3jA0rjmtNWO7yfUt4Sc/+jcrKgL6fmplhB0QLjaKT6hFICKoPtn6FvnQCLzbQW
         Vt4sS2nZlJ+ibOByU6GqQ75+rtehqgxyJzjo/8VRvxEecqp5IE9hfVJMvXkE6eTadhHg
         0W/d6CZxCBWU4VX4lmGaGiTEfQK98tMGw9E6nbaNp7F+Z1M9O8KG9qdtkrhq5oAWPD80
         /i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KvqM0CkPE2mwCbjTrqIfGEAHHgCIFCwOAnw16f85go=;
        b=49DOdjGXizqbNu9ZsZk519VaU3QmNqHkxpwO9zHxVJXfzgrktNbSPXSaTScwgDw6sn
         8WVG7+KOj6tTny56F3TAwYr0UqIZlrCs3W1x8dQ0QBiO0miLLpAx3ADEYrOq6bOgmKVr
         yrYdKLWDHTkZIGBsHlEm3oirKs89A5xc5epoO/SFMZGr+OmN3x7ljxv3zTqBc8AbmZ6w
         Yxk59MA/doqtcjjKGkX8QonweKj3iBxMZRefofQRFTMRGFQ4ncmY6OrfYIbI4W8YkLCh
         p4YJsXP8aAj1meKdoHajtlNwLT/2NXqbGHKHd12vTd6IPoWLJcps4XBux1G7dm/mkSol
         2HpA==
X-Gm-Message-State: AOAM533SGR8y3I2OFmYTw/bfhqFf/2l0+qw8isa/jguifWk2PbVAttPL
        hZaHOd960q2sqTz3rffxgf5EecCj4qDPGMpt
X-Google-Smtp-Source: ABdhPJwAE2odo0MLHq+Rv99OqCst6JsszNVC1hEjeWkQcfa10zKPz0qdpvGP3bm/maPpH6B0kvxGYg==
X-Received: by 2002:a05:620a:284d:b0:5ff:320d:c0a5 with SMTP id h13-20020a05620a284d00b005ff320dc0a5mr8423571qkp.681.1646691491645;
        Mon, 07 Mar 2022 14:18:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n143-20020a37a495000000b0067b12bc1d7bsm2826887qke.13.2022.03.07.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/15] btrfs-progs: add new COW rules for extent tree v2
Date:   Mon,  7 Mar 2022 17:17:49 -0500
Message-Id: <94b5b2608259c333dc4d98a8df74d5f9487c5a5a.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

All of the previous COW rules will apply, but with extent tree v2 we add
a new COW rule where we must COW if the snapshot id of the buffer is
less than the current snapshot id of the root.  If the root's snapshot
id has been increased we know that the block is now shared by a new root
and we must cow this block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index c6ce82b0..215c33ce 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -390,6 +390,16 @@ int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static inline bool should_cow_block_v2(struct btrfs_root *root,
+				       struct extent_buffer *buf)
+{
+	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_V2) &&
+	    (btrfs_root_snapshot_id(&root->root_item) >
+	     btrfs_header_snapshot_id(buf)))
+		return true;
+	return false;
+}
+
 static inline int should_cow_block(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct extent_buffer *buf)
@@ -397,7 +407,8 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 	if (btrfs_header_generation(buf) == trans->transid &&
 	    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
 	    !(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
-	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)))
+	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
+	    !should_cow_block_v2(root, buf))
 		return 0;
 	return 1;
 }
-- 
2.26.3

