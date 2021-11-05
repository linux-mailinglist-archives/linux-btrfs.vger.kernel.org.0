Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE741446A08
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhKEUtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhKEUtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:49:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76FC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id br39so9870664qkb.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y0qNrY3DW0nvGwiPS7nrp7Su0O1y6/0J6EOiclGaKHo=;
        b=A+2U9OI/1LA7VhguvJjdS8g+3RIhx5ifdY5hisxItZ2t26HbSWnUSXu0yyZRxhSwdS
         dKozbeLNwwI+svgX/MvyKfwe2/gRfyRoDxasYYb7bqpSqGvHN5wHOXVoq5FyE5ML1HCt
         MsiTuvqjZ/+x30XBbvWxva/mOTxPiCmyEPhKiHM4YnFSUQNyJNXjY7Nt+4C3xIGlHkCu
         upUGJ+6h83IKHHzMRR28k37ekM1NwiMejn/Je9HUi7Dp4Qaf/f8v7yszhV5FtsZ1ZSim
         /fRuPpO/CJ5emsmGPjAKG+WVrHTABL8OlbJP9pXDz6eWxKknm9CHH5trj/dF1dsq/C/x
         b3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0qNrY3DW0nvGwiPS7nrp7Su0O1y6/0J6EOiclGaKHo=;
        b=RaYSltdYfgeODLsVGw8buSODKIDxID6tp0wn7azOZ8GjTTJ1qsJjo1WgtNDRapvOml
         uCW6nlRe1GsCCnO025ZD9EwTgbXLqnggKEjhJvc7f7ZQgcVS235352l7t3YtNQu3x4u5
         IlaXv3T48hxPhDTI8mptEAPq0Y1UiKqOp6rdYcxeaI+T9E0qNO8DK8mpziMwMo4JaQrf
         twOa5dxHOlL9XNab9ZaKP0XyAM2upEKIFvLqD9bdiAK2dc/AVhqZ97s6eNxkga7ky15D
         VMBQWYwYSGVFlQ76wbQOecJNq+buIfx46tZE5wuWGdjeipUBv6ltuqTUicEeGysXKiRf
         gIvw==
X-Gm-Message-State: AOAM532SjQkx7BuHj3Z0KKsrhRNOt4jAv95bDaVIs57PdxTfLBGnbJCJ
        ozpMvF+rAhbdWQl3KvdoXr/rcbGzwqMMCg==
X-Google-Smtp-Source: ABdhPJyKw4aSZWaGUdUpIprk1UleLot1K+rxYbYNUZqslUzyI4xBgeqP7iVgAdPqSpfLQgZVzMHfSg==
X-Received: by 2002:a37:9b17:: with SMTP id d23mr4628719qke.333.1636145180843;
        Fri, 05 Nov 2021 13:46:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s7sm6461863qta.3.2021.11.05.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/25] btrfs: fix csum assert to check objectid of the root
Date:   Fri,  5 Nov 2021 16:45:46 -0400
Message-Id: <279415dd30710ef468ac51e844c5d8ed8e2d8b45.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the future we may have multiple csum roots, so simply check the
objectid is for a csum root instead of checking against ->csum_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file-item.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d1cbb64a78f3..359f3a047360 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -801,7 +801,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 	const u32 csum_size = fs_info->csum_size;
 	u32 blocksize_bits = fs_info->sectorsize_bits;
 
-	ASSERT(root == fs_info->csum_root ||
+	ASSERT(root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID ||
 	       root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
 
 	path = btrfs_alloc_path();
-- 
2.26.3

