Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09F85B90CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiINXFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiINXFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85925A819
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s13so12907244qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=YkYpwOZ3ipijD5TV2M7lqztPnS1fiH1tauIgb8biVpQ=;
        b=j+w7r+/sncW5MKWNRf4ANBc5DEoB/wVZ0oy0pnavHNztMxI8o6a+pNdlXPAvMZ5+bw
         VPugZ0jtaCw3i+dUzbTJFb9fRQmB5cziniXtD4+gX1rc2WZesjpS0exT8y2DLaGBWhY6
         f2jzeYL8510EjBGogdcWzW97mZFOKBnEJ0HPhiunU9VbVtVM00hoA9pdLgMOSE/MV6gE
         hro7nXzibC+ulAaHySxaJGYBe8UYPR361rHRtUBL5JxN9euRks69svizitzrv0BdpRoQ
         6Uyn9LI1fUd6w4osyRsSeUm65DJnrsN2j8SWJWLXi/2CfTX8EHkDQrgq4L8SB7nzcm0H
         dXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YkYpwOZ3ipijD5TV2M7lqztPnS1fiH1tauIgb8biVpQ=;
        b=p/5B4K4Cy7bBAtnJkAsVpC07y8vFrV3EAeullxH3avhs/5dcFvQMWHdUASnIa3RcZM
         IVffQMbWCKoyoR97HpLwbLzUnkFA01ORvOLa7hm3xANa+qTSGRtOLpoCPJo/qFJQVmz/
         2qYpu7Dd99lxfV2aoSiO5THy2oGCjuK2nYz/6ycAI0N7t/q+U4ZQYT55JZIBR7z5H40s
         /Ja7PT0axFwLUA/yhukCA3dCa0rXOZXQKGJzUOgYYpFkiRgCG/tx2WIGOok9ZIghSRxy
         ZsS6Y0YuAE9JETJ2uCGeZlPOJ7xKpt/LMQ8eT3JSLLS50dRaHVcoJfjXYOVZoo9RA+PJ
         dbGA==
X-Gm-Message-State: ACgBeo0LzlpZXb2FY2ie29R5mT7yDkreJAEKHZ95eO/bJzMP41C2MKBC
        0xOMgFpP+l9w84jxdhY9PbGsoDiC0Z4ckg==
X-Google-Smtp-Source: AA6agR6J8ujVQXfZM/6t3KVP3GpS4BRxU9L2LLDMMBNlA5M8vfLckynlcJhsx63bTDSi/UxDSCSxSg==
X-Received: by 2002:a05:6214:20e3:b0:4a7:618d:44d8 with SMTP id 3-20020a05621420e300b004a7618d44d8mr33820963qvk.47.1663196713028;
        Wed, 14 Sep 2022 16:05:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d21-20020ac86695000000b0035bbb0fe90bsm2360895qtp.47.2022.09.14.16.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/15] btrfs: use a runtime flag to indicate an inode is a free space inode
Date:   Wed, 14 Sep 2022 19:04:50 -0400
Message-Id: <d8e32fa383bfa555cf49c9b184c45699bdc84ea3.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

We always check the root of an inode as well as it's inode number to
determine if it's a free space inode.  This is problematic as the helper
is in a header file where it doesn't have the fs_info definition.  To
avoid this and make the check a little cleaner simply add a flag to the
runtime_flags to indicate that the inode is a free space inode, set that
when we create the inode, and then change the helper to check for this
flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h | 10 +++-------
 fs/btrfs/inode.c       |  5 +++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 44edc6a3db6b..530a0ebfab3f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -65,6 +65,8 @@ enum {
 	 * on the same file.
 	 */
 	BTRFS_INODE_VERITY_IN_PROGRESS,
+	/* Set when this inode is a free space inode. */
+	BTRFS_INODE_FREE_SPACE_INODE,
 };
 
 /* in memory btrfs inode */
@@ -301,13 +303,7 @@ static inline void btrfs_i_size_write(struct btrfs_inode *inode, u64 size)
 
 static inline bool btrfs_is_free_space_inode(struct btrfs_inode *inode)
 {
-	struct btrfs_root *root = inode->root;
-
-	if (root == root->fs_info->tree_root &&
-	    btrfs_ino(inode) != BTRFS_BTREE_INODE_OBJECTID)
-		return true;
-
-	return false;
+	return test_bit(BTRFS_INODE_FREE_SPACE_INODE, &inode->runtime_flags);
 }
 
 static inline bool is_data_inode(struct inode *inode)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 62dc3dcf835b..1f38d9b98132 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5731,6 +5731,11 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	BTRFS_I(inode)->location.offset = 0;
 	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
 	BUG_ON(args->root && !BTRFS_I(inode)->root);
+
+	if (args->root && args->root == args->root->fs_info->tree_root &&
+	    args->ino != BTRFS_BTREE_INODE_OBJECTID)
+		set_bit(BTRFS_INODE_FREE_SPACE_INODE,
+			&BTRFS_I(inode)->runtime_flags);
 	return 0;
 }
 
-- 
2.26.3

