Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE174A198
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 17:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjGFPyI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjGFPyH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 11:54:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C671C9D
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 08:54:06 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579d5d89b41so10668587b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1688658846; x=1691250846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buOFeO4C8hHCHNrbkga0N98i1H87grsRQEVPsc9r15Q=;
        b=RWoTF899Tf7f533nmsHk0okZvRKwMSVJ10dSFf8RUKL4lCrWM3VSjNa/M5ANPterqY
         NvYpkYNZLoS8kFHCI1WDkKSfB9W4JSVcW6VVUXqo218V7E1Cvc0dunwvy2ZXuCuV0V9+
         Rx6p91/edgTBtwKK7O8xAMlZnx4Zvh19dryZQmLbWgjMnutSaXEGh3uRxaB5lew9H7q7
         +hlTzM9xfLNC2ZpswXPq89RjKIoJdCVdqi8iYCBJPtUrfDWLcGmrL8WdqVtF7zD3DihH
         UiQveom+eiov5lZAud0Ee4LGsqXoR/sGwl64MTut3fPccFI6aaQ90j/U/LInyveivvc8
         ey1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688658846; x=1691250846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buOFeO4C8hHCHNrbkga0N98i1H87grsRQEVPsc9r15Q=;
        b=IpsVFrYiZKKJJnlK+CJb897DaAwP/nGZerWNAdIhJJO2PsaQs5XZFDqRCNfZ8R8e5E
         mbVx07UIhqcpLJ7g0SZz2wWY7L5N3MGUF7rvxzV6Vpaxfr+FHte2LNint6UIlpyJ/U1u
         /eRYGXLaZ6xut/Ze+yB8EZKNeykh0lGWJyOeA/Q369gz3bTCQcNyP6jZL97O2NRWpoKt
         RJSV+IsYmy7BRTDtksC0j5b4WwwtoJsaoRVG+kkKSWbZgP1AvO14wyGe6DAJuyN3ondY
         514z6m3s9btPr4//9K8/0TDxbf8boJI3kLMdJolk08djcbSTzMFsINKL/FHB6rfb+v9z
         ww0g==
X-Gm-Message-State: ABy/qLZ2aQyeDvk+ESP2RvCSCLqIo9cW0UrzGrl40rGA2pWaoi2A18tR
        dkkLJN6mDW7DeYXMo7ajwgV8iO1XlDWW05rLnXNCyQ==
X-Google-Smtp-Source: APBJJlGoVzVqsSSKN9n+lmaVJrfLMyvlIUGdWiuAC02eC7zTLZE8E2ShKczQkolRTfZH4yVPlJK2Xg==
X-Received: by 2002:a81:4e46:0:b0:577:42be:1804 with SMTP id c67-20020a814e46000000b0057742be1804mr2539545ywb.29.1688658845625;
        Thu, 06 Jul 2023 08:54:05 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t1-20020a81c241000000b00545a08184e0sm417828ywg.112.2023.07.06.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 08:54:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs-progs: print out the correct minimum size for zoned file systems
Date:   Thu,  6 Jul 2023 11:53:59 -0400
Message-ID: <d4a3973e50ab59cc063327252121edd1260024a8.1688658745.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688658745.git.josef@toxicpanda.com>
References: <cover.1688658745.git.josef@toxicpanda.com>
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

While trying to get the ZNS testing running I ran into a problem with
making a small file system for one of the tests, but the error output
didn't make sense because it said the minimum size was 114294784 bytes,
and I was trying to make a file system of size 419430400 bytes.  The
problem here is that we were spitting out min_dev_size, which isn't the
minimum size for the ZNS configuration.  Add a helper for calculating
the minimum zoned fs size, and use that for the error output.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 972ed111..8d94dac8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -79,6 +79,17 @@ struct prepare_device_progress {
 	int ret;
 };
 
+/*
+ * 2 zones for the primary superblock
+ * 1 zone for the system block group
+ * 1 zone for a metadata block group
+ * 1 zone for a data block group
+ */
+static u64 min_zoned_fs_size(const char *filename)
+{
+	return 5 * zone_size(file);
+}
+
 static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
 				struct mkfs_allocation *allocation)
 {
@@ -1436,17 +1447,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			min_dev_size);
 		goto error;
 	}
-	/*
-	 * 2 zones for the primary superblock
-	 * 1 zone for the system block group
-	 * 1 zone for a metadata block group
-	 * 1 zone for a data block group
-	 */
-	if (opt_zoned && block_count && block_count < 5 * zone_size(file)) {
+	if (opt_zoned && block_count && block_count < min_zoned_fs_size(file)) {
 		error("size %llu is too small to make a usable filesystem",
 			block_count);
 		error("minimum size for a zoned btrfs filesystem is %llu",
-			min_dev_size);
+			min_zoned_fs_size(file));
 		goto error;
 	}
 
-- 
2.41.0

