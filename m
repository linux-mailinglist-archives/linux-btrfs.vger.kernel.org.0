Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20355B90C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiINXFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiINXE7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:04:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA451B49A
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j8so2000331qvt.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=UADlMrHDNH0hUq4O5HDQdynvEN6RLY8d64k8+p/9VPU=;
        b=oagoNLRq81qG1Rcl0RFQaGqgrSlgGv/t9JgsI3gilv/5p0uIDGrcJkoE+b/A7YkYni
         HuoUEUju7xpxMCoAj8OJLX9D5yUu6TQOnCtN3BoS8368j7rQhW1mTBY4JiJCRwjFEWn6
         SzMgrDFDFdB0daCmcdBknM/JGGp1X+Bf66y/8k5Z7ATMSMQOlGm7aZpV8ZS8T0dSlq5p
         n09qWl4hCIs1Dtt8vquORiRsL3/0kKQdOBVnC+PFzTQJlB3D3X4CoWJcZfbJMsUH6Jrz
         BZ1FZQb8Caea5euwKOrW3eTaS1pV7BHFJH3BtZ96BFvtczbzp1r7WMzV+PMWnF7NjRcp
         5sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UADlMrHDNH0hUq4O5HDQdynvEN6RLY8d64k8+p/9VPU=;
        b=1UKeiAkWwaV3+Km+EkHaGbGDwRvgbw3GvNeFqL2/ATzhhUDpYLsf1e2xSNLT3oEXJl
         uBD24Q7z3b2hamsFw6ML0jlgvem9NLNXOxtD9JpZFGc3/KG43dN6vmANvg9ek0Mr1w6k
         0XK/ilbzeidU7ZlLXTsPdcAqVqA4jOzEmNC94IFcxzka6kfCMgYXbQzAgI5xO3ojDswx
         QemYMeaaWXaKdVI1Po5S1Z08UopCsiXAlOG6jG9nEyvbU/V3i1HR1whGZohSafZYbRNK
         wpm+segcFk+HFLP24DGO+3ANnkT/hF1SBViqUVESwX6tvh3M00Rfr5lZ3iSKgSmLdwGS
         02QQ==
X-Gm-Message-State: ACgBeo32HYAdgzTJjfPzq2KLHnKYoTZC1GKJDFwdN+A9rzZKKBdItjsg
        eSw2+RY5PURN2X6G6/4KL8ETz92KVmVNyQ==
X-Google-Smtp-Source: AA6agR6tnuVPDiPuuvj2bNEzBO/VDKujeZBfx5c9j0gCvFJQSd04Am8gxFcXbe2ZActAircc1Rp2+g==
X-Received: by 2002:ad4:5dea:0:b0:4ac:6ffc:74b2 with SMTP id jn10-20020ad45dea000000b004ac6ffc74b2mr31032138qvb.78.1663196694478;
        Wed, 14 Sep 2022 16:04:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h185-20020a37b7c2000000b006b9264191b5sm2649204qkf.32.2022.09.14.16.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:04:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/15] btrfs: move btrfs_caching_type to block-group.h
Date:   Wed, 14 Sep 2022 19:04:37 -0400
Message-Id: <84da2b1e0670313091a6ff604c105b09f3f18879.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

This is a block group related definition, move it into block-group.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h | 7 +++++++
 fs/btrfs/ctree.h       | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index e34cb80ffb25..558fa0a21fb4 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -57,6 +57,13 @@ enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
 };
 
+enum btrfs_caching_type {
+	BTRFS_CACHE_NO,
+	BTRFS_CACHE_STARTED,
+	BTRFS_CACHE_FINISHED,
+	BTRFS_CACHE_ERROR,
+};
+
 struct btrfs_caching_control {
 	struct list_head list;
 	struct mutex mutex;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8271b3dccf16..725c187d5c4b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -180,13 +180,6 @@ struct btrfs_free_cluster {
 	struct list_head block_group_list;
 };
 
-enum btrfs_caching_type {
-	BTRFS_CACHE_NO,
-	BTRFS_CACHE_STARTED,
-	BTRFS_CACHE_FINISHED,
-	BTRFS_CACHE_ERROR,
-};
-
 /*
  * Tree to record all locked full stripes of a RAID5/6 block group
  */
-- 
2.26.3

