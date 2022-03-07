Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABACF4D0B39
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiCGWiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbiCGWiA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:00 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263156158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:05 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p8so10295761qvg.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UpyFXUVM2OSnyGYkI2bHF05WShOGmOta/4CYEn0SD0k=;
        b=HtEULqRFJKue6GBc3Ny6FHgLaso34T922wuLbNc53I7BRlWQrUJww4pig7gknLZiBf
         YDcupAxmWmOaAadSzvKVD9hbllqQdNaSRxxuMheviEt6RwcN3fYaxkqCD5ruCyqdLO23
         WF7sWerOYQw9V7N7Mj5Rx+VyjlTonIoS0IO9/AMLFEv6JFPFFwtsdjK2d6kQZl4X2non
         7SnxJCY3vKSiS9JftZwjgCmdDjyAzdPLw+6gtmgI2IPUUgLMRugmzhZaHk1misA9ZicL
         RYjyGnFMCqfneR8H/U8sQizlMZoZsY2YUDn/JVCMe8k/QlIoAbto7/ZBD8Z1rrHDSyrx
         0+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpyFXUVM2OSnyGYkI2bHF05WShOGmOta/4CYEn0SD0k=;
        b=MYp4nlTINGScpWxWyXGUhjIDZYbHaW8dDSUEDgaFWO+KJX8GWSwIZ2cABTuD6ptxEy
         oHsg/8aCQCsbc16m95VwMugojL2tFJw/g39PChnGsoBXQA2ptl0KfoFjGXbS5q+DFiO8
         69wed9ueZs5eM11lEewfxugWh/4+VFvmeo/w+/712CFfMQ8U85hf87orBl7f0qvIChaN
         l2MD5TRpHCbqeDCfUyQwq1N2ByIj8TuHYkRZTsLCUBuZOTjKJNsLQkxRh2R+04myjwvp
         yu0/QRq2hAV4h86Lx7PSHGDIlCRh7YgPNrPFDtzYGRKL3Y2hBeocO3tPwrWny1KixSP3
         TE9w==
X-Gm-Message-State: AOAM530yXJ9rUoGzWnbjp2JilEgjO0EOkN+KVOZs3vOqUFZrTfpLVlze
        uzzaIFpdGQ+uZxNoGYGHS/e8aGeAQgdaYnk3
X-Google-Smtp-Source: ABdhPJwvn8kGP0qq5lLucJjf0G524d8HAAN/guc44xoZM/KrKCUHlVuVytK5k1mdOvvEgV+ErmcubQ==
X-Received: by 2002:a05:6214:411c:b0:435:9368:130b with SMTP id kc28-20020a056214411c00b004359368130bmr4328851qvb.12.1646692623970;
        Mon, 07 Mar 2022 14:37:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bm1-20020a05620a198100b0047bf910892bsm6701672qkb.65.2022.03.07.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/11] btrfs: take into account BTRFS_HEADER_FLAG_V2 in the item/node helpers
Date:   Mon,  7 Mar 2022 17:36:51 -0500
Message-Id: <a356aff2558d8be0ad29fc31df6afecd2088bf64.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
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

The size of the header is slightly larger for _V2, so return the
appropriate offset if the header has _V2 set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ec77871ad839..b1cc1d34944a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2073,6 +2073,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_key_generation, struct btrfs_key_ptr,
 static inline unsigned long btrfs_node_key_ptr_offset(const struct extent_buffer *eb,
 						      int nr)
 {
+	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_V2))
+		return offsetof(struct btrfs_node_v2, ptrs) +
+			sizeof(struct btrfs_key_ptr) * nr;
 	return offsetof(struct btrfs_node, ptrs) +
 		sizeof(struct btrfs_key_ptr) * nr;
 }
@@ -2128,6 +2131,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_item_size, struct btrfs_item, size, 32);
 static inline unsigned long btrfs_item_nr_offset(const struct extent_buffer *eb,
 						 int nr)
 {
+	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_V2))
+		return offsetof(struct btrfs_leaf_v2, items) +
+			sizeof(struct btrfs_item) * nr;
 	return offsetof(struct btrfs_leaf, items) +
 		sizeof(struct btrfs_item) * nr;
 }
@@ -2187,12 +2193,14 @@ static inline void btrfs_set_item_key(struct extent_buffer *eb,
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
 {
 
+	if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+		return info->nodesize - sizeof(struct btrfs_header_v2);
 	return info->nodesize - sizeof(struct btrfs_header);
 }
 
 static inline unsigned long BTRFS_LEAF_DATA_OFFSET(const struct extent_buffer *leaf)
 {
-	return offsetof(struct btrfs_leaf, items);
+	return btrfs_item_nr_offset(leaf, 0);
 }
 
 static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
-- 
2.26.3

