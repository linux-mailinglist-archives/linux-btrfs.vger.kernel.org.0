Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943A7E2F72
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjKFWIq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjKFWIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:46 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E4ED47
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:39 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ce31c4a653so3234983a34.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308519; x=1699913319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehBDfIuN7LiSpCRECNrlmwLyhaoGnDe/cfSCFvX9BgQ=;
        b=v/RPI4Wnk/tEB6JRsCewvwq3vXTbPDvjuCPPhwSABEkdX6Q+UmeAUtdIC07xWPWz1y
         r6qUnsVRXeIKy0EaCp2GxrAb0y2trKdqJd1p1N/VNzZz523BMtk0lK440y7E3rHVz6Sz
         VqSeOqcGHFCCwyxVgYjZ/kgc392JD0I3LY/DqOk+USe1oa9RAssxhJeHbs5QAe/pULoY
         OyDJouLfXMk73T5grfbJABODTHDCaZqLvRd2sGHgNm+mdYVMUZm709++bLOVd3bRHIds
         2X6WiAebuZFPOVEg56jAOwXkonH8q/oYa2ZGsATOre24+hPM1LZtvaWu5SpjkfOCCmFZ
         CoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308519; x=1699913319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehBDfIuN7LiSpCRECNrlmwLyhaoGnDe/cfSCFvX9BgQ=;
        b=bsVYpt4gtAqS9GDKtevsx69LCcZ0VE9t+P9DAMPEIOE4PUHW7Q7uBvkFLJe3OSW2wN
         d+AvEEx6h/U8HOl/1g0aXEdMiYnYKgTKbIVDfd2OZdYRAPv3h+nywktAdRHAOWapC+nR
         TAHDbXwR56tMT53w+p4lUNvgIHhjIGBOhASF3/RQlwWXobT8eKQJRBtO1FdAmn6bSBvS
         01CB3THISSh0n5+DLjA4F+0FfQTWzHYcLaI7sWUg0OyL+9eMKwlkr4AYdgSO00A41xsy
         J4lftXMumS7dEuhs/9EIs1bj3Hj9y6ulZscvnSrcM5hvGWVfVLmLvTJJcqDzZThpFpsS
         ha6g==
X-Gm-Message-State: AOJu0YyNP3vWdsfGrJx5h5dVwF5Q7S51MoluJxJBNpQrpwXWs7DFMv9C
        SenEu18L9Ynu3l37dMGPc14DStwQA6GQeXHdLNF+2w==
X-Google-Smtp-Source: AGHT+IEgVlaYx/dgmuA2Odvi4lyhjcsKk7FPEE0yixJN6mnEoCCGvYnaMWr/hfwhHvssqOsQvuG5FA==
X-Received: by 2002:a9d:4e91:0:b0:6cc:fff0:8eb1 with SMTP id v17-20020a9d4e91000000b006ccfff08eb1mr31502509otk.23.1699308518798;
        Mon, 06 Nov 2023 14:08:38 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w20-20020ac87194000000b0041969bc2e4csm3792331qto.32.2023.11.06.14.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 03/18] btrfs: set default compress type at btrfs_init_fs_info time
Date:   Mon,  6 Nov 2023 17:08:11 -0500
Message-ID: <2945ad89590218391019572440f2ec620725ebe3.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the new mount API we'll be setting our compression well before we
call open_ctree.  We don't want to overwrite our settings, so set the
default in btrfs_init_fs_info instead of open_ctree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 350e1b02cc8e..27bbe0164425 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2790,6 +2790,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
 
+	/* Default compress algorithm when user does -o compress */
+	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
+
 	fs_info->max_extent_size = BTRFS_MAX_EXTENT_SIZE;
 
 	spin_lock_init(&fs_info->swapfile_pins_lock);
@@ -3271,13 +3274,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
 
-	/*
-	 * In the long term, we'll store the compression type in the super
-	 * block, and it'll be used for per file compression control.
-	 */
-	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
-
-
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
 	sectorsize = btrfs_super_sectorsize(disk_super);
-- 
2.41.0

