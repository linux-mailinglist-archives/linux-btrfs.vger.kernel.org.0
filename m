Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2960E8B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiJZTLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiJZTLW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A769139C36
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:47 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x15so12427892qvp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vf3ffJ58wUc2bms0jVC3HwCsde5e0ztsxNQcD6JJZTE=;
        b=bIHKBzTkHZAjgaHAwX8HwRQqmUmSLHheh1FWjgZv8l7X8KfqvI+OsMU2Hby3ePcOVx
         d5J51Q/xVcGYaBycRu5jKfkcvpHOAB9xNrhDJoL7XLQSF3ZX8gjiQDsUQ+vG7RdgPcyG
         1Q1+WmNGf4wk81eZVl6kgdoTrOOuzxBRbWBe/iGFyM//Z3HPGj65ISi56OVzguX8SZaZ
         a6azDouuwgxoGKiPbu+rQy1v3+JbvU26hb6udLXN5LFNHjp/PaQigHsYFykc0DL5OV8+
         4pSQfiAIxnwTeylCRaG5n6bUMfdCOz59kMdOpsFba6CEcagDriBSgwdWObJY7N3bkmGl
         iN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf3ffJ58wUc2bms0jVC3HwCsde5e0ztsxNQcD6JJZTE=;
        b=nhCj9LlM0XibQoP07UpPIIQKdaC++6qssq4C+CRY5kIvsw2W3+KfqqNxPCwjtwRBdF
         XXfDwZbwOY9eMTXjdwRKCnOzi+L1LKeePACWJYuMehYbKmpp57BFExN6oN3A8xxV+RT3
         ZMN4SM0sTzXLOjZJh4gUVIOFtHyKxln4Flh96iheq7ztI2GmF67k8VnyQypptaCy6+RA
         7rzg8rUjxGfMxIs9i6Nb1uG1jL1PJdx/9Rijj9WWmZmJvbUbHhWABdU8dwPQH1AYEWyz
         qxOlguuPyxMZzSg7fpeuk1HjhDlvWlk6YBVOxI2n16kPCPhxCgbx6djQlZsf9/fZ8yKW
         pnUw==
X-Gm-Message-State: ACrzQf1I9wlro9Yuezbov7ElzCRYl4siQZ1ThsWp5cwbyzFJAfXuugAd
        /aS7t5Gxsl1vZInEYWu1rJkwhmWIC3eyYQ==
X-Google-Smtp-Source: AMsMyM7OYK94QEn/w+DfcP5k7Q32UR+Ix95/kLqbynaijqsJoULBveATdGml5EE0fMWmP2g/J0sR3A==
X-Received: by 2002:ad4:5f8d:0:b0:4bb:6d57:cfea with SMTP id jp13-20020ad45f8d000000b004bb6d57cfeamr15271610qvb.98.1666811326350;
        Wed, 26 Oct 2022 12:08:46 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b006ec9f5e3396sm4297066qkk.72.2022.10.26.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/26] btrfs: move btrfs_chunk_item_size out of ctree.h
Date:   Wed, 26 Oct 2022 15:08:17 -0400
Message-Id: <e1ec74ccbcedc5c9dc9cb8d82b3ffba387075afa.1666811038.git.josef@toxicpanda.com>
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

This is used by the volumes code and the tree checker code.  We want to
maintain inline however, so simply move it to volumes.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 7 -------
 fs/btrfs/volumes.h | 9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ee79a9e20ef9..0afd3b2dca0f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -54,13 +54,6 @@ struct btrfs_balance_control;
 struct btrfs_delayed_root;
 struct reloc_control;
 
-static inline unsigned long btrfs_chunk_item_size(int num_stripes)
-{
-	BUG_ON(num_stripes == 0);
-	return sizeof(struct btrfs_chunk) +
-		sizeof(struct btrfs_stripe) * (num_stripes - 1);
-}
-
 /* Read ahead values for struct btrfs_path.reada */
 enum {
 	READA_NONE,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d7f72b0a227c..cab1ba8f6252 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/btrfs.h>
 #include "async-thread.h"
+#include "messages.h"
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
@@ -605,6 +606,13 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 	}
 }
 
+static inline unsigned long btrfs_chunk_item_size(int num_stripes)
+{
+	ASSERT(num_stripes);
+	return sizeof(struct btrfs_chunk) +
+		sizeof(struct btrfs_stripe) * (num_stripes - 1);
+}
+
 void btrfs_get_bioc(struct btrfs_io_context *bioc);
 void btrfs_put_bioc(struct btrfs_io_context *bioc);
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
@@ -759,5 +767,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+unsigned long btrfs_chunk_item_size(int num_stripes);
 
 #endif
-- 
2.26.3

