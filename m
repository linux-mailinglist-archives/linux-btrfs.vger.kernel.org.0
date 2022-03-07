Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608804D0B38
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiCGWiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbiCGWiE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:04 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647366158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:09 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id o22so4994204qta.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jc2lKD3GExblAvYhzK1tzqevf4M+pt4CaObbEDG2WQQ=;
        b=Mj9/GRSSxMAU87+TSugVg+YoOXmMwqbWyPOL3syon1qSpXSdm2C6xXwIwqjzHgZDF+
         55RxQ1OOkOBU+TkBq67goLMc1g+XYWurD8bKwtL3TQ/EC4m2c5CKSLe7UMeUTve0VT3D
         OVlk0BX4iI19tn8j0tyv2UJyNdx9rVxZwViE4lDOHdsTx92FxIHUsmJTp5eaF+IIFrdf
         RgNC76QmW8GEN95SJ6q7ccU8ifWfoMZ5dUNX7pl14/H5QSbN6lMBNaxFJ0XqE+MPHvG9
         eRHAxoOK8tetBzNe7odxt9EekYYm9Pewaz36kjoG93YSwuwRSrC+gE0XIeWIm0SsvEcu
         m0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc2lKD3GExblAvYhzK1tzqevf4M+pt4CaObbEDG2WQQ=;
        b=t8B9ePGzwj6rtkirPdy6wNmZ7LhbdADDAs3zJdY/9Dgf9VyPgZAw30K0n1CBB87joH
         AFV4Pvg0td9BugbuuyuBFoOIFvwaP4QPAlxR/WK0PK7XHjJTCpY6Y9KyEoOTGIH82Wou
         VbL1nIAa2AcpxQwpCxBBotsHnOzwFmwoGdzWeX1xEymyDnTpqcD0dYZjyksl37V1Q5Z+
         t+rRA4H/fS5Lyt0uL8KfA63c4YB6iMQAEms8D5H6wRi2s7IV6wxWtP3dn+vh6kxQ9vSl
         r31dljgUw7ULnYvtaH71z4YKRImH21XuxSi1+FAqq9NhKnlMup723DZXokmc6nxrIadM
         QFoA==
X-Gm-Message-State: AOAM532pQ/aXlsGj2wP0I3rcBDydAkELQumIC362Mv2RiHtuH5AzVGjc
        9DjcOMVM07yZVcJF7auNHZ2huUaMgphlVRYM
X-Google-Smtp-Source: ABdhPJyJdrkO7TMUe3dwlRmNnWvsdgjboYOZeIBhJe4vL8O7MM7S90r3HfbiHlx0NWZY1FICTBi6HA==
X-Received: by 2002:ac8:578d:0:b0:2e0:6374:3bb9 with SMTP id v13-20020ac8578d000000b002e063743bb9mr7689575qta.359.1646692628332;
        Mon, 07 Mar 2022 14:37:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n7-20020a05622a040700b002ddea69efb8sm9573367qtx.56.2022.03.07.14.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/11] btrfs: handle the new snapshot_id field properly
Date:   Mon,  7 Mar 2022 17:36:54 -0500
Message-Id: <ade3cbf9444c384974d815873f69f695eaa13cdc.1646692474.git.josef@toxicpanda.com>
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

With new blocks we'll be setting the snapshot_id to the root's current
snapshot_id.  The COW rules are extended to make sure that if the
block's snapshot_id is < the root's snapshot_id we know we need to cow
the block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       | 13 ++++++++++++-
 fs/btrfs/extent-tree.c |  7 +++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6e8c02eec548..e634eeab89a7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -521,6 +521,16 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
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
@@ -546,7 +556,8 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 	    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
 	    !(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
 	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
-	    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
+	    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state) &&
+	    !should_cow_block_v2(root, buf))
 		return 0;
 	return 1;
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 309d8753bf41..504c6f152780 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4874,6 +4874,13 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_set_header_owner(buf, owner);
 	write_extent_buffer_fsid(buf, fs_info->fs_devices->metadata_uuid);
 	write_extent_buffer_chunk_tree_uuid(buf, fs_info->chunk_tree_uuid);
+
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_set_header_snapshot_id(buf,
+				btrfs_root_snapshot_id(&root->root_item));
+		btrfs_set_header_flag(buf, BTRFS_HEADER_FLAG_V2);
+	}
+
 	if (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID) {
 		buf->log_index = root->log_transid % 2;
 		/*
-- 
2.26.3

