Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAB946551C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352241AbhLASUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352188AbhLASUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:44 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325FC061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:23 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d2so31943491qki.12
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FPMZiIUukGoAhWjf9kofCFi0oyiXOwzbciV86nJNAPc=;
        b=LI35VM2M++YlUGkgjgg1qZfmP0xiEjO12nkexonwNYGmp2Gwkk0D63xZXuYdUIQ/ZL
         1wgudQtR2PpB0yB2WaZHKAh494Rcn1/YrgU1Njbs8b2sSZOnTeW0p1U9NXlPa5Mmf5AC
         A+sc6CJ2hfL5cM+yixmtbAh19hh/scskOiy8rjW65BSzZ9rNeC+fBwdzJb+tSjApJC0+
         uMEQ6wj406Ae8RDuc7K03DEtVVqtOOTZTqXkXcrmYDj1LSomfQfL8w2urModggWF7Tec
         Du+2QDwPgCUsSg2vd6tHyJ2+j25d4OUDGmHT9An3w9syv0WXA/gR7hq5Ann6GHCXzDm9
         gnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPMZiIUukGoAhWjf9kofCFi0oyiXOwzbciV86nJNAPc=;
        b=2l8wnifdQX9W4NqmP6mO+ByItROQHUfOIsadB4aXPe7BO85BYANYJ0SI+lKK4A5hQu
         h5gRq2+cu2utyeITNuGyWWnlsXIddrwa4Br+9VqfhvVJSLRCkrF8q9Nq9L6N9gP06CLA
         vaDrKhwsiobkBTKAlXfneC/BIU4ZHXWDbgoEGUGvqj0TmjUYqqnUaXoVP4j7EP6bQ/ZR
         b/qx1s2qzA9aV9SEVJo3HRRXz2P9KDsVFL2lbeF0/E2nQVrXdhRkFcjEseK1dtL9TfV2
         jwGJad4fO/WVyHBIXbyeH9eWcPWvLq6W1tbfJDJRyBoFm8i64rGFtbh/iYSBJldDBW/k
         sKRg==
X-Gm-Message-State: AOAM533C1O18OClKLPkT03OssC1+orIKktDLABkBlvogWcbpPoTalc0k
        9GmFynZE891GACZTARJRA5t8rOuzcjt7uw==
X-Google-Smtp-Source: ABdhPJxi7Xbu8wVTM0a5ELZRQqiGP9ujfNIg216pF1US8bl0//TY/1Xapon9T2eyFJzMstX3eMLIrA==
X-Received: by 2002:a05:620a:c11:: with SMTP id l17mr7975595qki.493.1638382641964;
        Wed, 01 Dec 2021 10:17:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k18sm290527qta.24.2021.12.01.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/22] btrfs-progs: add on disk pointers to global tree ids
Date:   Wed,  1 Dec 2021 13:16:57 -0500
Message-Id: <2885ee70b934ee809c7c3ddc8045938112b957fd.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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

