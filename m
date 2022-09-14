Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6A5B90C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiINXFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiINXFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E230F4D
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d1so12959881qvs.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=6/+FvguIdqol8RCnWn5nWzFmHS/lrZsutBVOa6sDSgY=;
        b=kU35khlAdRfQA6H+PH7F9vJlnR7OWiEX24vo7iuEKl8Z/KLSJd29oCEDcyeA9pGH/Q
         kUtT5W9qN1cyLq4CnIqhlN/ULcza4bHL+6TxSVmyxlkGhX8J8vyKQiZ2SWojaFJ8K+mC
         At+HMfMA/JLtjLmbW32CRoW89Yik3P83lfPdpFk4XjL4oEwn/FSd6r4KPKG5dsvS2qJE
         2ljnA82lcvMNgrkFEbFO8JXssaEit2ymZeK4om+Dr2jAc/pZ6qf5jMMtjWIk46pxLAOR
         GoJtaiLbvUbwc9ML/BUse00b2Z3Bgf7T2CUoSM0zMDIejYxOC3j9PRr8zoBdG0t7+wL5
         T/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6/+FvguIdqol8RCnWn5nWzFmHS/lrZsutBVOa6sDSgY=;
        b=0/G8WWrUXXVo5fp29aFtCaCHDfSijR+dMUZCy4kNQqS+tklPuhCO/kvO2+ZXd6+DwW
         4XdxI4Alo4L1X9+YqJDfW/j0MPIYK41HmoQ/LBoATJ8PifP10UtQdrjGVfDLLvBREPbJ
         ORfq0C89kQ8/1KkDPzVGRV9ok2XS//C3TPnqg1A/cI4B5qAdHvRINf0d3byAZ+3D2iLN
         1oCkgXUiZwdQy3tkE2IbEw3o+fVWU8ooN8FuNQYbJPkywN6vdbVUBmKCPPxwV8Z3YYvv
         k2s8Gdn+mz5UpDHLdBNtyho5YBiwDwr603gGlqQ8WcNeu3oMx0Rr+rTG+hT8vQObQL2U
         q8Rw==
X-Gm-Message-State: ACgBeo1PdOgA8S1RlMmRoYU4pYZnWQk7YLpQqKM6yyXzHZ2QMUt1tiQS
        f7DONVsm0bKigp/5jtiLsaYnWAPncxfJpg==
X-Google-Smtp-Source: AA6agR5nBYVv1+IDgmXWs291SvPTax+voUoehkRKz4q0xOqCVjqtODI9GnCGY0QsMK0Anja8C+lFRQ==
X-Received: by 2002:a0c:8081:0:b0:496:7822:c55a with SMTP id 1-20020a0c8081000000b004967822c55amr34201792qvb.87.1663196698963;
        Wed, 14 Sep 2022 16:04:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006af0ce13499sm2934228qkb.115.2022.09.14.16.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:04:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/15] btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
Date:   Wed, 14 Sep 2022 19:04:40 -0400
Message-Id: <4cddba7a242f71c09a9cedd03fe726482ab90c5f.1663196541.git.josef@toxicpanda.com>
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

This is defined in volumes.c, move the prototype into volumes.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 2 --
 fs/btrfs/volumes.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0c5a6ea2eeb3..36a473f05831 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -243,8 +243,6 @@ struct btrfs_swapfile_pin {
 	int bg_extent_count;
 };
 
-bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-
 /*
  * Exclusive operations (device replace, resize, device add/remove, balance)
  */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 96a7b437ff20..db4cf51134fd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -731,4 +731,5 @@ const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 unsigned long btrfs_chunk_item_size(int num_stripes);
+bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 #endif
-- 
2.26.3

