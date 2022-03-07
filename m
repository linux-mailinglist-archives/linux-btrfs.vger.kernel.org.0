Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719B4D0B33
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiCGWiO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343847AbiCGWiF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:05 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17816158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:10 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id o69so813426qke.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O6nM+yt4VAu/KqtWTpBDb2EQwscM0ETh1gHZ9IeYHQY=;
        b=L8/3QvWigNu+6u8ZSS9b61hHgFWf4SWhDfsRJp33AQ+cNN2gjDL0aFiiB3qKhIN7/z
         fXy4HyvUUl2qdoOZjfOpzP8HWxws4SBN8CGsIHodtwQ6Lle3K6GpE46lI9t/AosH/hb1
         DlrwuLLLDv7Z5sZD7l9zcc+9+CqaNYuxRqya833z5n5Ev8NaauCORHZ1KIoSgKm4Dnj9
         WqLh432VDNdpn0e5/twDE4VS3BCT+Hxrx5X0uXEuV1VoVk2Y0d/3P5qmeM7jkjaX5yIc
         cR9g/xQsWDJDdn38e67U6EKkdh7EObJZdkRkShIsxuOoJ1sMDST3Uckmnoi8nn0+wAur
         P8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6nM+yt4VAu/KqtWTpBDb2EQwscM0ETh1gHZ9IeYHQY=;
        b=cus8ODZrd8rPkSq2xgNPwIf66NNxxKR80wmswLO++9cAr5ugJPP48umjAHFRv/6X/M
         rg62+agbJCdZM4AEp7cb5Etg0BYLtseRlSK2rsiDhxLCixLKRqB4VgpwCsFYn1pcMeo1
         kimrlEIZq+DIb+2dfWCoXa3y0bFcbx9y8/4HE238czT+4WVcUu5svfV4t3RH7bMy8Nyu
         a17IpICDej2NJ8cMRooZ2Mjfjtl+NrZYsjiUbCUrUTexE7Qpa/PTR1lN/Y940ARb8D4v
         kSVpDNFnPSGXz1Ht7T1SVee4nLFqkLaVnum8iZhhEBeq/0D0ymveFZhh+NK5VqBSQ3YT
         GiXg==
X-Gm-Message-State: AOAM531UwgaLk2X9GiRlojGB8dJm884hhaY2a9TF2yAChtecfbUVKx96
        yqmlAT/pJeUnNrx6hV3Wzd3APmDLVK7qcH4b
X-Google-Smtp-Source: ABdhPJzQYj2/vPXDTZFr9aSseb7LnDBdAtQc8yl3RQPyPgqn6Av4Kjwwd7EgxCZt0EnLtnom2U8fFA==
X-Received: by 2002:a37:845:0:b0:47e:c3fb:b11c with SMTP id 66-20020a370845000000b0047ec3fbb11cmr8462781qki.92.1646692629789;
        Mon, 07 Mar 2022 14:37:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r13-20020ac85c8d000000b002de72dbc987sm9575541qta.21.2022.03.07.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/11] btrfs: add a sanity checker for the header flags
Date:   Mon,  7 Mar 2022 17:36:55 -0500
Message-Id: <97c4484a58168c521d1f3c8d66feb0ea76deef51.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
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

Make sure that we don't have HEADER_FLAG_V2 set on !V2 file systems, but
we do have it set on V2 file systems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f0aabda9fd94..41b7fbf67e97 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1578,6 +1578,27 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_header_flags(struct extent_buffer *buf)
+{
+	struct btrfs_fs_info *fs_info = buf->fs_info;
+
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		if (unlikely(!btrfs_header_flag(buf, BTRFS_HEADER_FLAG_V2))) {
+			generic_err(buf, 0,
+				"no HEADER_FLAG_V2 set on a V2 file system");
+			return -EUCLEAN;
+		}
+	} else {
+		if (unlikely(btrfs_header_flag(buf, BTRFS_HEADER_FLAG_V2))) {
+			generic_err(buf, 0,
+				"have HEADER_FLAG_V2 set on a !V2 file system");
+			return -EUCLEAN;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1644,6 +1665,9 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 	u32 nritems = btrfs_header_nritems(leaf);
 	int slot;
 
+	if (unlikely(check_header_flags(leaf)))
+		return -EUCLEAN;
+
 	if (unlikely(btrfs_header_level(leaf) != 0)) {
 		generic_err(leaf, 0,
 			"invalid level for leaf, have %d expect 0",
@@ -1807,6 +1831,9 @@ int btrfs_check_node(struct extent_buffer *node)
 	u64 bytenr;
 	int ret = 0;
 
+	if (unlikely(check_header_flags(node)))
+		return -EUCLEAN;
+
 	if (unlikely(level <= 0 || level >= BTRFS_MAX_LEVEL)) {
 		generic_err(node, 0,
 			"invalid level for node, have %d expect [1, %d]",
-- 
2.26.3

