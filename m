Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D991260E8CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiJZTML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiJZTLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29ACFAA47
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a5so11383232qkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVn/TQM5mOfuR9dKDVUurM4AWpzIj7M+MLmZTTaA6ck=;
        b=7TKM2ZMGEUpK27eaigtb6xw7LWbjAs/azFwqGSbv3Y0+uBpsqw/JDiUlQKttS1DO1I
         zylGd2mDrk44Rv2YzbGoP2Ceq2AloXz9OLquPkgV6gpzmtMAmXxadIjQ4ilP8DOEaX9v
         nE+4G9ZaZcJAqJRs14c6f2vGZ4D5+996ebx2rMpx6w2644RFACRHaxhN0ngB3WxoJ04T
         lMosJVvs/LgBjJNjhj22wvwt2v1u9LmwQb3RMzCVSVQBNR/fi4NJVOZl7WMEa0eMPZFf
         aSWmcpzk6OYz6q0fHhIlWkIHUPRwuroHQt93diw0GfpuYRmnET/SZxLADeq03eyoMB05
         KT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVn/TQM5mOfuR9dKDVUurM4AWpzIj7M+MLmZTTaA6ck=;
        b=RqPSR4xPsPZpBcLCMRj+4idIaM6lLrymf5uqTJEVaTLS4I7/3zL58SpTxtOYmsC+/w
         gG8sje2AVmT8TNzNK/Y3XwF441smJm6RDbXVNORaciIuGkXoQMA5GHLL5Ex0TpxFAafi
         6oFhEWNyzBhKHMvB5hQLWrX4RiTt6lHlIqyfoi9kT2Y/PvIlXs6Klx6QT3z4Bg5uKfsp
         WdIkhs9Ig2SB+yh7/6wwvaKEsvtt1phpcJvpz8p7xulKfPUF18oD2JPpILTPgcQkI8+j
         XfXsFUNNF3FKfllE8p4ywZHm1WpdcEtaCy708ZXJ+fjRKeKdJveUykCabkN3AiSea2vR
         AVcQ==
X-Gm-Message-State: ACrzQf0UlfsIk7Hw/gR0MUd4WiYtNg3CUe2dDSe9cy3m696hedHlmbrA
        aynyZ5JiFL7jdH62kONMVp+ttU5Oje+0gg==
X-Google-Smtp-Source: AMsMyM4sp1MKWlvzwhh8/mxL8aYDIVqSDBIznSXvFPK7RfyqxgagIqNXEggs3/pFD4ztmC+cQBwcPw==
X-Received: by 2002:a37:8d06:0:b0:6f1:7aa:13c0 with SMTP id p6-20020a378d06000000b006f107aa13c0mr19034432qkd.68.1666811353227;
        Wed, 26 Oct 2022 12:09:13 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bl23-20020a05620a1a9700b006bbc09af9f5sm4421708qkb.101.2022.10.26.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/26] btrfs: move dev-replace prototypes into dev-replace.h
Date:   Wed, 26 Oct 2022 15:08:36 -0400
Message-Id: <1229df1f96a18c6f6990bc12c671e59252396e5f.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already have a dev-replace.h, simply move these prototypes and
helpers into dev-replace.h where they belong.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 9 ---------
 fs/btrfs/dev-replace.h | 8 ++++++++
 fs/btrfs/extent_io.c   | 1 +
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f3facc10646c..84bc33ff003f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -732,15 +732,6 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 #define EXPORT_FOR_TESTS
 #endif
 
-/* dev-replace.c */
-void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
-void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
-
-static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info)
-{
-	btrfs_bio_counter_sub(fs_info, 1);
-}
-
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 6084b313056a..675082ccec89 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -25,5 +25,13 @@ int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
 bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 				      struct btrfs_block_group *cache,
 				      u64 physical);
+void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
+void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
+
+static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info)
+{
+	btrfs_bio_counter_sub(fs_info, 1);
+}
+
 
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e5287c4cd97f..e27a6f1b33bb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -34,6 +34,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "file.h"
+#include "dev-replace.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
-- 
2.26.3

