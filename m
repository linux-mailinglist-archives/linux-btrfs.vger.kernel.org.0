Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA65B90C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiINXFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiINXFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39062E68E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:02 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k12so12049039qkj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Dv8DgU+7UxG1m3f3Lr8paJvfeq9zC1Hm5GVzJFlxd4Q=;
        b=iWhYQ/QN6FmOZETdOIGIRJHvFdfC04zvpGLiIO3I91reJRFLm6Y1CgvPpqRopn2yJO
         Nf4e2bZ/1ebF2VJYjH8x/XNhiZxIGHvcthGb+NIA4rrgqZmQ+QSHczRfqXsg3uTlXcZa
         O1NBltrKhoczDCUg8WJN6ov/Fu3ibmpufFf8XuwhBQRnmI5DEzyVkkfS37GVF75jUejj
         BjwOt3e8g2mpEU8QO3rxTK48NOxSqhefH/1m+YfYKfQutq+oxA1s+BLAhJOhl6XZCLNN
         5YgkM4o0RJV1ta8pAKmIx7QuTa+dvS3D2uclB4C5hfgF87yGShpz6MqwcuFqAthYsK+8
         3dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Dv8DgU+7UxG1m3f3Lr8paJvfeq9zC1Hm5GVzJFlxd4Q=;
        b=TvI6mwwVTlZg7sym3nVIyX9dNJk+9+uj3BZ4JL1Z7rsHO+RQ/o6SATB56uQfwYOx7d
         PDrn9kxOSStk2jItse1wnqYnIkVUhjQfKRWaprpJkW6BLwv4fwWEXKgah84DkAlep82L
         gubcEwhEWniXdx370bR5hoAoOmPhPj1u2mZwQ1uZXwbQMxeKCXHUbdk+Xt+3F+uvzbdo
         0IUqDMgFwC00hr6n7DJYN+wKwvoaTqgFD9tWjOVHIZT7vwnCLH9+MR5uYn8Wg8DSeXF9
         IzeV7K7ttbVT+WBnokQMZkz2NZMMMrX70/fDCwEDZ9o/Kznov7XTveMhe9NY7tttu0rz
         QLew==
X-Gm-Message-State: ACgBeo1KI7erQqxXq7B5XUyPnfBZzuQwIbds38sg8sYw5OWGIeoKDn5C
        i+FthiH1D4v9UCshEJe4YOjOLJEF+c/6og==
X-Google-Smtp-Source: AA6agR70NI9xO6W5MQRTOZXDUtsNSInIFqGr/exGRCu3f3Cblu0dArgrlc3U8fP3LKapcIhdftWXZA==
X-Received: by 2002:a05:620a:b0c:b0:6ce:61a2:3f20 with SMTP id t12-20020a05620a0b0c00b006ce61a23f20mr8255452qkg.551.1663196701647;
        Wed, 14 Sep 2022 16:05:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8774d000000b00339163a06fcsm2338782qtu.6.2022.09.14.16.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/15] btrfs: move static_assert() for btrfs_super_block into fs.c
Date:   Wed, 14 Sep 2022 19:04:42 -0400
Message-Id: <6b462dc4d7ceffe2ba9141f46bf28350be7c7f4a.1663196541.git.josef@toxicpanda.com>
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

We shouldn't have static_assert()'s in header files in general, but
especially since btrfs_super_block isn't defined in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 1 -
 fs/btrfs/fs.c    | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a790c58b4c73..3cb4e0aca058 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -56,7 +56,6 @@ struct btrfs_ioctl_encoded_io_args;
 
 #define BTRFS_SUPER_INFO_OFFSET			SZ_64K
 #define BTRFS_SUPER_INFO_SIZE			4096
-static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
 /*
  * The reserved space at the beginning of each device.
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index a95d86679d14..c54ee0f943ce 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -106,3 +106,5 @@ int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 	disk_super = fs_info->super_copy;
 	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
 }
+
+static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
-- 
2.26.3

