Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD585B90DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiINXIE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiINXIB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081886C3A
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j8so2004692qvt.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=SL3kQOlJuvxxL2gD4th/N/EksG5qOqX5CpFfCBGXcho=;
        b=i8QAdfP6JtFvlNpi1KNNJvFJTbykp5cVEfFxdDiCVFgYEQ+iWZTBba6FyU4K6he4oH
         p1pqLGW6D4llFyKW3AYE5QbQ5hu7QMxNJF2JIaDozrItuwpteVg8i8mcvI/JmlzBHk2z
         Yw+GuG9Qr6glk064en7Xxo4ySXtTmru52JFJ3D6jZng5ly9kWkYC5A+DT86JlMqvlkxA
         mNRJvUDPju/3mKGDB5Ajo8IvUabTZp0FdDERnY6XyhZhoMBR+MMYmK3b9byLeNQHNB4q
         9UuI9zm4Ob2DOABNLt/Gr/Qp1rCpcsnOiXuN80RGyalbKT8kGoHnS89yycYP/fZ4zGEG
         +cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SL3kQOlJuvxxL2gD4th/N/EksG5qOqX5CpFfCBGXcho=;
        b=tYm61hnStxcY5etpcqBkuQGjPkqFDcuAgep2wyQHesFb00GuNy6DQmH2tl+ZgB0Wfa
         9MrduwnjEmDHGY1+NEAGWnPMl3Flo6hJ0kWT4R69aBVQMMwQxRgv7xI9K1CBuPAHVjJh
         6GMHq+ezeFsnMm2rdBUpCzt0+7bGTYnboGXo70BWjcBlCsDPC8x7SahVX7jcnQy1T+Sx
         bRprsJCYX6Wxt8O9pNQ7xg4Vmht+3TYNy/rk8wQ4aVGuvVe4vpwFmh7UHQUPKL+i72a3
         UGBPkU0angVsQrg9uJBRztqW9IH2zQfmVmBI+QN2uu+qcHjncWpmXDQgk+nUOJKH0KZo
         rjhw==
X-Gm-Message-State: ACgBeo3kHpEtc0d6yeIC0tng3L86WD8zRSsmMHs+Qd7O0qwbIN4WABv8
        eR77nQJXYeZxg9thpa3K27z7n+QQPHlA5A==
X-Google-Smtp-Source: AA6agR5qI743FdjPv4vtiw5sopyfvpIQY1f0xj3/E2b37uRkYL3dKx+JmXLYdSV5QKJYRVTQgzOG9w==
X-Received: by 2002:a05:6214:29ee:b0:4ac:8956:7ac0 with SMTP id jv14-20020a05621429ee00b004ac89567ac0mr24253672qvb.48.1663196878758;
        Wed, 14 Sep 2022 16:07:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y18-20020a05622a005200b0034305a91aaesm2557647qtw.83.2022.09.14.16.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:07:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/10] btrfs: move btrfs_zoned_meta_io_*lock to extent_io.c
Date:   Wed, 14 Sep 2022 19:07:45 -0400
Message-Id: <c9a72140be961732e8fbd473af3e3b0ec7126dda.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196746.git.josef@toxicpanda.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
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

This is only used in extent_io.c for locking during writeout.  Move this
out of zoned.h locally to extent_io.c, these functions use code not
defined in zoned.h so allows us to clean up the header file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 14 ++++++++++++++
 fs/btrfs/zoned.h     | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f5eb6c66911c..18b60304c97a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2945,6 +2945,20 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	return 1;
 }
 
+static inline void btrfs_zoned_meta_io_lock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_is_zoned(fs_info))
+		return;
+	mutex_lock(&fs_info->zoned_meta_io_lock);
+}
+
+static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_is_zoned(fs_info))
+		return;
+	mutex_unlock(&fs_info->zoned_meta_io_lock);
+}
+
 int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 0a1298afa049..af7eebe4f405 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -311,20 +311,6 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
-static inline void btrfs_zoned_meta_io_lock(struct btrfs_fs_info *fs_info)
-{
-	if (!btrfs_is_zoned(fs_info))
-		return;
-	mutex_lock(&fs_info->zoned_meta_io_lock);
-}
-
-static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
-{
-	if (!btrfs_is_zoned(fs_info))
-		return;
-	mutex_unlock(&fs_info->zoned_meta_io_lock);
-}
-
 static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
-- 
2.26.3

