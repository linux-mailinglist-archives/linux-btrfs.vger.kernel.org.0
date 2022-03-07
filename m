Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B54D0B35
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiCGWiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343831AbiCGWiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:02 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED552E0B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:07 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t18so3716325qtw.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SorbZdvI9LC3JTFS7AolyaO/11tBSK2JAvVWkYN11hk=;
        b=4PsleUCqfwLZGTIsx/3gVG2RmBblYbCtUClDY5/V0uYwmqruo4zYVcxJnj75qirxgH
         xI4o8yRKuEQKcV5GOuWyxf72xfsjdhnrmFiAbOaplocaBk721Dum64Yu0q6TXSiz40hp
         TO7SUZG0NOwRavLXreFZD/exXICz1onOd3Xo/6DUfM7zYOVE3bGzVc2DvBQvfTH+FVQL
         gqM2HkVu/JBGlaQeiecYblmQiZhnt1+CMhyYUaNKlKaWOG8X+9X0AbYrbqfUNFI2wo/R
         E5dewoEKBBQKgW2g6SGRw+XiTKVWkLBdo04Dq3/OUFZLOJOGeWPiXeyDqBlt1iAMFrSJ
         o6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SorbZdvI9LC3JTFS7AolyaO/11tBSK2JAvVWkYN11hk=;
        b=7euSsa+Zg0AyoR32d5OzstIeRwCoKR30Gt+XrDlSu1yGJp3kZ1qEzfR3v4AA45GhcL
         Kxt0+V4UvJ4rNiu9sKkNiYbG6b0e6DxgNAIYn47owVBihHxzle9rnceC5++exwQtG5zn
         XZp/lMV0I/u+dc98AtTNP8M60xZXUtEP6bcBtmdA/VelkM6UmJXWr9gCFCtzhOvKxZwH
         mXQG6Adf4Nvz5BZljr59l4JgEIVW+oIU1fGCng9I1+Zg7Tbx6G4oLuLqE9ZQdKRIm8if
         IxmhSgFzD9VD46GRoXBCvUA9ViSqFZ05CyuniPeMxA/JtPdkfKrrdw94yqRoXypTQWdF
         BeYg==
X-Gm-Message-State: AOAM5314MNZyqkf7v89M3vgVJkYfa1LSdrF0MRaSha83v9dPUJ7Pa2qw
        KJHY/y/TDx0uuHv3/EcznTUQVvQOSH9mXsNc
X-Google-Smtp-Source: ABdhPJwE8yMoaKMilWoYFsqN5L3IZjc/zPtTyrKbViGOmyoGw0DBdfHvUeSSaxqY/+eoczCDoW2rAw==
X-Received: by 2002:ac8:5a0a:0:b0:2de:b81:24ca with SMTP id n10-20020ac85a0a000000b002de0b8124camr11276122qta.271.1646692626800;
        Mon, 07 Mar 2022 14:37:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n1-20020a05622a11c100b002dff3364c6esm9728205qtk.19.2022.03.07.14.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/11] btrfs: add snapshot_id to the btrfs_root_item
Date:   Mon,  7 Mar 2022 17:36:53 -0500
Message-Id: <b11dd3023680d84fea2c821dabea1f6fe40c824a.1646692474.git.josef@toxicpanda.com>
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

This will be incremented on every snapshot in order to keep track of
which blocks belong to which snapshots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                | 2 ++
 include/uapi/linux/btrfs_tree.h | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 222c5dda9079..6f446cdf05c2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2414,6 +2414,8 @@ BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
 			 rtransid, 64);
 BTRFS_SETGET_STACK_FUNCS(root_global_tree_id, struct btrfs_root_item,
 			 global_tree_id, 64);
+BTRFS_SETGET_STACK_FUNCS(root_snapshot_id, struct btrfs_root_item,
+			 snapshot_id, 64);
 
 static inline bool btrfs_root_readonly(const struct btrfs_root *root)
 {
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index cd62ca1950cb..91dd7feae9aa 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -686,7 +686,13 @@ struct btrfs_root_item {
 	/* If we want to use a specific set of global roots for this root. */
 	__le64 global_tree_id;
 
-	__le64 reserved[7]; /* for future */
+	/*
+	 * The current snapshot id of this root, increases every time we are
+	 * snapshotted.
+	 */
+	__le64 snapshot_id;
+
+	__le64 reserved[6]; /* for future */
 } __attribute__ ((__packed__));
 
 /*
-- 
2.26.3

