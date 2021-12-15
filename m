Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637E476269
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhLOT75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 14:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhLOT75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 14:59:57 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86B3C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:56 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id t11so23065663qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FPMZiIUukGoAhWjf9kofCFi0oyiXOwzbciV86nJNAPc=;
        b=LA+bajCZ8j52siTSVFVu8+w6GjBg82kLuG6dfjCaZFXqzRnB5/xZ/3HhiQD9q8y/2F
         DpnzfISlCEvcnVOANnvfpFLRPCAjLZAzEtDwf+Y7cVfrLxxSQksPU6CwLorC5I1zMVRu
         xscw0ULiOja527106Y+PfZUxS1j4ix4/429c0wz5G8LoiMUNyGY7ucmMwtMWHqN8S+lZ
         hmGNFc16HFDHwwMXwnX99aET9kGrmV8YbEYDL8KstbBv4hJx49XtWQoguaUVJpzkkngE
         J4TmS+fksJrl/jmJRd1d9MvNeSu4xAJT0ruIXhSw3LTssSUNB+i9K4BNKCDyVR48xDSN
         bohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPMZiIUukGoAhWjf9kofCFi0oyiXOwzbciV86nJNAPc=;
        b=od5XwQ4wMrW/bi3XcbTDRGWfyBLxnYWo9Cgy+83Qg3uMCTsmKSxJbNVGHh7j5c6HbM
         8J0UA9FV4OV+CJON4xQDD0F5ePII8hzcKsowuL6fUhI7a7tVp0KwX1f8XKsGY3BUuSv3
         iZ9wBzRBpJ4vK7pIhoIPaEyNWGMmnUvMuZn9cLcXloPve2wTPPzO9mhRiOn/dtt54xIM
         RRvKzJ+t727gRrtb9zH2D4BrmJNJPwQbYIAj1f2OPY0oc/ZHJ3fCDF443JvOnrkCGlih
         IRl7mFDJdlNZqMnwnDCgpE88XSKt3L7IQ1F6JlwLHxIHHbyzbv+zHDc3nWEvLwN6IaSv
         EFWA==
X-Gm-Message-State: AOAM5315mlfwgypoOxtKmeId2XvrRZ1HmhDiKaTJna4W6fxDrm+hhIk6
        7tlRppzP4WTpFzVDB3aA/6ZaSFGEa2rgig==
X-Google-Smtp-Source: ABdhPJxBVBRZeTQp/nMQ9qiTjqyzycXCi8UAeEYO4xnlmswe4cBULtFFT2fUFPTXIgrdMaU2M54hcQ==
X-Received: by 2002:a05:622a:1102:: with SMTP id e2mr13922501qty.194.1639598395487;
        Wed, 15 Dec 2021 11:59:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de40sm1597514qkb.99.2021.12.15.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:59:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 03/22] btrfs-progs: add on disk pointers to global tree ids
Date:   Wed, 15 Dec 2021 14:59:29 -0500
Message-Id: <88fc7e0159141657d5c3354ae74bc4b83ddf7c30.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to start creating multiple sets of global trees, which at
the moment are the free space tree, csum tree, and extent tree.
Generally we will assign these at block group creation time, but Dave
would like to be able to have them per-subvolume at some point, so
reserve a slot for that as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index eb815b2d..6ca49c09 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -830,7 +830,13 @@ struct btrfs_root_item {
 	struct btrfs_timespec otime;
 	struct btrfs_timespec stime;
 	struct btrfs_timespec rtime;
-        __le64 reserved[8]; /* for future */
+
+	/*
+	 * If we want to use a specific set of fst/checksum/extent roots for
+	 * this root.
+	 */
+	__le64 global_tree_id;
+        __le64 reserved[7]; /* for future */
 } __attribute__ ((__packed__));
 
 /*
@@ -1717,6 +1723,12 @@ BTRFS_SETGET_FUNCS(block_group_flags,
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
 
+/* extent tree v2 uses chunk_objectid for the global tree id. */
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_global_tree_id,
+			 struct btrfs_block_group_item, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(block_group_global_tree_id, struct btrfs_block_group_item,
+		   chunk_objectid, 64);
+
 /* struct btrfs_free_space_info */
 BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
 		   extent_count, 32);
-- 
2.26.3

