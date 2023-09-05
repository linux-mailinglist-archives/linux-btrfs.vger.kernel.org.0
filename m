Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D473E792AC4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbjIEQmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347352AbjIEQRt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 12:17:49 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5914A198A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 09:17:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414b0bdea1cso18040851cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693930531; x=1694535331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmYmqap4MEl+WNijUh97ca11ozjINI/sVf8zC35dAHQ=;
        b=Td7UCP7EYU9J5MA2c+KmxyDGNoKSw/EeI6ccHIn784nZwus9QYay7tmiWWOts0i4QX
         HjBQL+5PpX4VnGx9SXJfCvjWm0HK0kXuiH+n7E6/LnED3it8xMdsf9HiGPxIqW3Jcp2S
         DJDpfBUVy9o3lz3rsZZUAeQWBhJJxUih4oad3Cf8HKIcW1yAirN63MrHWidaL8oRZ/Bh
         ALGtlkkfmCwI1I/piBDqmSnl7aK0JK3lcXJH3hhd6X72DgaPVasTEoVrVUZb/m02pTyf
         UTeMIm/Q4K51y7k8tYMO3rXhjW2i5lrqVUT3wJOws77b/ika6Do4uLtCK80dXv9QeK0r
         sj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693930531; x=1694535331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmYmqap4MEl+WNijUh97ca11ozjINI/sVf8zC35dAHQ=;
        b=UOqBK1ekIZeYXSkZvU9zGT9wY9RFNqVq/K1Pa+tSBvOK/BCRFYc6vPh0MWUrw/uaz9
         jkpEvHeauViuA6dMQUZ3kQqAOqLs8bjMRbqZrhyhSsYk2sCF7RjKfLLfAzfGm4r6O3O7
         SyqsYyl6ca05/tcSx5De9VudDuURQur9ZgAbUaYW4MQCiWoi9k92zwXyFt93SN86pSP3
         WMjuhUbUhrV8XOttZx9xxESz/xp+wviLREcVPXcdtgimE/tqt6N/rjUUIxfB0OlKZH7V
         EODyqsa2OsCPqtxIJ3dDDFkIltcGrVs/ZC55DW3ZyHjj7pUflA2b+jKLu5B95TyV6y1a
         TheA==
X-Gm-Message-State: AOJu0Yxuu+UsDm1r252s+RNwfOY8GH5t5v5AbHFUDK0ASxZGqnaB/KB1
        Ps5IVgkeoSHULrIDdur+fQaL1emUASjpcs24klU=
X-Google-Smtp-Source: AGHT+IFk6SEm7uudHruaBpP8y06xQTuQBuSup9Cvaw17FKPGXlFwLpkj+6uqvFl0PeAObCnp7L3WEQ==
X-Received: by 2002:ad4:4582:0:b0:64a:157:1d01 with SMTP id x2-20020ad44582000000b0064a01571d01mr12340062qvu.4.1693930530989;
        Tue, 05 Sep 2023 09:15:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e1-20020a0ce3c1000000b0063d2a70dff5sm4567134qvl.72.2023.09.05.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:15:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] btrfs: initialize start_slot in btrfs_log_prealloc_extents
Date:   Tue,  5 Sep 2023 12:15:24 -0400
Message-ID: <e0192694760936031cae7b4633ba738506eacdc1.1693930391.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693930391.git.josef@toxicpanda.com>
References: <cover.1693930391.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jens reported a compiler warning when using
CONFIG_CC_OPTIMIZE_FOR_SIZE=y that looks like this

fs/btrfs/tree-log.c: In function ‘btrfs_log_prealloc_extents’:
fs/btrfs/tree-log.c:4828:23: warning: ‘start_slot’ may be used
uninitialized [-Wmaybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/tree-log.c:4725:13: note: ‘start_slot’ was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~

The compiler is incorrect, as we only use this code when ins_len > 0,
and when ins_len > 0 we have start_slot properly initialized.  However
we generally find the -Wmaybe-uninitialized warnings valuable, so
initialize start_slot to get rid of the warning.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d1e46b839519..cbb17b542131 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4722,7 +4722,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int slot;
 	int ins_nr = 0;
-	int start_slot;
+	int start_slot = 0;
 	int ret;
 
 	if (!(inode->flags & BTRFS_INODE_PREALLOC))
-- 
2.41.0

