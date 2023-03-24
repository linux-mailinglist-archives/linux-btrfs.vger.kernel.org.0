Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F486C754F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCXCKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXCKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:10:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351011666;
        Thu, 23 Mar 2023 19:10:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id ix20so596612plb.3;
        Thu, 23 Mar 2023 19:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679623823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YA5tqeQZN5rIb5Yd0dxP1FKIh8+sCL54B5X5FV19fyM=;
        b=c3o/PCDZb//e5yCMPbg0H4OGUUxBNKrow2cHhqJcU3DYUcWx1Bi6tZLnqPrYnW31lf
         PMbz0ki8dNKUf9kCUwBypzFp2zT3ZUJCiV4Zs43voDGHXfG2yJHSmdP7JuDpaerFv2mi
         GaxtnHRbj7IbYIedQurXC8CUZSUlKi3Ir1IAqTBD8+c+O5mLpWqUpWpbpa03PsFSAcgW
         MltkyvEcjxHv9athA3QhTSxjqpExCAfQZfTr9HcHkstpzz7sydq1/AhRRSv3LwWHGcjR
         s0JiYqFdpjmB6O1O9qNJDWroNhT7gkTR7QvQkiGrjfYVy/Fit8UmLErr2iJxS8mvsPeU
         ACnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679623823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YA5tqeQZN5rIb5Yd0dxP1FKIh8+sCL54B5X5FV19fyM=;
        b=eoxBwys8j62aUpOTDRT2uRZCXq7xhpixylFniq6NQiAZvJzvty2Qrx81rd7ffhElzv
         W0hAljeWASH2pmd/pKN+X/2QrBjRiFtQEIky242ejOuWWqjgW9pK8En6CBna60PQTOlk
         zhsQ/driypoMowWYLUNsx1+MaG3iavA812ZZ+I57bzSCKemp0Pyt0pBSTR3gHJy012Yb
         XoPgcgURZiUceVHFcGEVHqG+CLY17WTAvLq60dRJRZepsHpn0KAgSD3lGqFiBSxSL0q+
         ytAQUYEaM40A5Bj7whLusiRpoMyvrsy+LLbFaK8jC4eIPr07pbT2AxzWV3bZ07F71ElL
         jCJQ==
X-Gm-Message-State: AO0yUKUHEcuogJ6w3hrdGgjDtOF7C504Sw3vkqH4g0usCPNDF2+a32IN
        9qAHTdNgveFvMUmv9t+BusI=
X-Google-Smtp-Source: AK7set9+wWE9thrh633jxSz+/O/KwuXWj8/LPIynCW0lsCkj6BVegWZeilrQwim0ydyZRAG3gN5Ecw==
X-Received: by 2002:a05:6a21:3286:b0:da:cde6:ad75 with SMTP id yt6-20020a056a21328600b000dacde6ad75mr4881944pzb.22.1679623822829;
        Thu, 23 Mar 2023 19:10:22 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id h11-20020a62b40b000000b005da23d8cbffsm12545772pfn.158.2023.03.23.19.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 19:10:22 -0700 (PDT)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] btrfs: fix uninitialized variable warning
Date:   Fri, 24 Mar 2023 10:08:38 +0800
Message-Id: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

compiler warning:

../fs/btrfs/volumes.c: In function ‘btrfs_init_new_device’:
../fs/btrfs/volumes.c:2703:3: error: ‘seed_devices’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 2703 |   btrfs_setup_sprout(fs_info, seed_devices);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

../fs/btrfs/send.c: In function ‘get_cur_inode_state’:
../include/linux/compiler.h:70:32: error: ‘right_gen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   70 |   (__if_trace.miss_hit[1]++,1) :  \
      |                                ^
../fs/btrfs/send.c:1878:6: note: ‘right_gen’ was declared here
 1878 |  u64 right_gen;
      |      ^~~~~~~~~

Initialize the uninitialized variables.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 fs/btrfs/send.c    | 2 +-
 fs/btrfs/volumes.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e5c963bb873d..af2e153543a5 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 	int left_ret;
 	int right_ret;
 	u64 left_gen;
-	u64 right_gen;
+	u64 right_gen = 0;
 	struct btrfs_inode_info info;
 
 	ret = get_inode_info(sctx->send_root, ino, &info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7823168c08a6..7163c98e47be 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2609,7 +2609,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct block_device *bdev;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_fs_devices *seed_devices;
+	struct btrfs_fs_devices *seed_devices = NULL;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
-- 
2.25.1

