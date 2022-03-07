Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03194D0ADF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbiCGWTD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343719AbiCGWTA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:19:00 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA643490
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:05 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b13so13255525qkj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f931GGcEdNKjih9LsadYaYxWWFOeN0gs5JYsHti2I/k=;
        b=VJplP4FYYtO/KGCHdmJB9jU5zD2prAYH/t5VSG0Tz2pNUUwiYB4OwEZtNnsKZikxyo
         gXs3rTUNpdDnlp+LT8S9pmDcR/fPjvNtVstvQjIZ6RVlZ6eyUVnaIoySU+3ceYNHYEka
         IQP90hx4soD9IS21XOqzSdTlSmKd79e8AOTmBU+TudYfSxiGHXMmhqzVhxiYE9KlBQ76
         YZ0CE59C7Hik7m9f4g/zZqt3GdVKkmycn5JMrhs35R3eOwTH9lH1bXjTd6TQK7JmryT+
         MRTaaHfySM5nSg0URvEL8hQ9iu4/QH1X/ybH70QC7leJ+Ecuf9rlalST3itmCIkC9fUx
         yDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f931GGcEdNKjih9LsadYaYxWWFOeN0gs5JYsHti2I/k=;
        b=3weJzQ0z4zMjJ9FCfCxltlDASWYc/YW7mApwYWINpthRdrO/bBkdpTCq9mzsDie1s6
         ZSoB0hWnxD+y3RY8/J4yFs6xdGQGmAqTVhedGFGvozpFYGzqkOQ/kUxJVpPLjLwZyjAC
         DhRWJKQ1jWDJ+g7CCghZnAnifKnCuNAXOzJwqorU3S07I4thcQI7bvdkWDKBfxQUZ1S7
         tOb5IdY5rV7b5YtMhGaz4DCRErpUCxAWPV2CPmt3rw076ca92DqPDLrbbzlBfzPKwY1g
         JqTJtkqSR8XYtOURQ6UgQ3TcipePE792SxhLLhEGtu6kAe5IdUv3USTDCBdMFFic5309
         piPg==
X-Gm-Message-State: AOAM530iWiZL9vu2f/9nKonbGG6dPkBorYt3n5ehIIjrJRgS7RCbOyDd
        wDOx8Iwh66aFxbHMxCSTGwrR4Kxpt7jnTroZ
X-Google-Smtp-Source: ABdhPJz66NlmjrQXAlA/7fGc9+2AJkFYPdPoZXxlEmD2XsKz5yzi6fE4Fk9fBcJwDXKHnooJk+mxxw==
X-Received: by 2002:a37:45d8:0:b0:62c:e5a5:34cf with SMTP id s207-20020a3745d8000000b0062ce5a534cfmr8480649qka.367.1646691484806;
        Mon, 07 Mar 2022 14:18:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r13-20020ac85c8d000000b002de72dbc987sm9549564qta.21.2022.03.07.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/15] btrfs-progs: setup the extent tree v2 header properly
Date:   Mon,  7 Mar 2022 17:17:44 -0500
Message-Id: <853f25da362b95b73f5dfd9b9e85578c15c69e54.1646691255.git.josef@toxicpanda.com>
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

Now that all the helpers handle the larger header properly, set the
correct flag and snapshot_id for blocks if we have extent tree v2
enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 8 +++++++-
 mkfs/common.c               | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 0361ec97..8f8617b3 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2588,7 +2588,13 @@ struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
 	}
 	btrfs_set_buffer_uptodate(buf);
 	trans->blocks_used++;
-	memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header));
+	if (btrfs_fs_incompat(root->fs_info, EXTENT_TREE_V2)) {
+		memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header_v2));
+		btrfs_set_header_snapshot_id(buf, 0);
+		btrfs_set_header_flag(buf, BTRFS_HEADER_FLAG_V2);
+	} else {
+		memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header));
+	}
 	btrfs_set_header_level(buf, level);
 	btrfs_set_header_bytenr(buf, buf->start);
 	btrfs_set_header_generation(buf, trans->transid);
diff --git a/mkfs/common.c b/mkfs/common.c
index 652484f6..8c1c3073 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -460,6 +460,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	/* create the tree of root objects */
 	memset(buf->data, 0, cfg->nodesize);
 	buf->len = cfg->nodesize;
+
+	if (extent_tree_v2) {
+		btrfs_set_header_snapshot_id(buf, 0);
+		btrfs_set_header_flag(buf, BTRFS_HEADER_FLAG_V2);
+	}
+
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_ROOT_TREE]);
 	btrfs_set_header_generation(buf, 1);
 	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
-- 
2.26.3

