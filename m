Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB5646411
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLGW2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLGW2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:20 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9AF5B5B1
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:20 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id y15so17350594qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W1ynQebnKH4VSeXjmhH7rt8v41FiS+6N7Vz+CoRsSg=;
        b=gQHaGS82cTcYh0ahrdR0tSL6c24Nwxh+9+OiydTgX4/qe2NM7jcgps29EGS/oQkBrH
         vQEBxpbFK28BN8dUf9KJb3E+wM5pIeH5H8UkqoZUn1PQ90pk7WgHxK33VtTTv61qRbrC
         kmT2xDmfTDZWLwnneTuimXP1oaCB6IRORaZfPaeguFegNe2/9NQW/DYuVIxi+nqp3MuT
         iwOIUXQC3a6Tsxj71k5o/447XdTjTbkT3oEeAdf6wM+NjjKAGsTvt9jbX4jd3I2Uk6VN
         BfSV3UL11KoulSa29KCclrl5MURXyCCX3otF800u/pVWM7b2CYTtA8rcwyIUr1pSwOoD
         e8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W1ynQebnKH4VSeXjmhH7rt8v41FiS+6N7Vz+CoRsSg=;
        b=NZtFFzw6qROr7T32qZU6e446ud47RkxmcvP5a+TaQCsVFPxZvr3pUmV480p1gdi90o
         xurCzEXrjBgNOu3qbeMpnLOjSqeKPMRHQXZ3nzk4ExgTbMDF4xGoi14tp2IWKuCAst+B
         SPAGjtLqClgmRy7joEtSQew0K29H6UPki+FqiL1LQ+Q/9R7idOGIXxwJZ4Puc5liweJZ
         wvDrt2eCWqb4mm/+mdr2p1S3opjIqN6NDMDCzwL5xjK7t50Tfxk8tz45L1fG5OIk2b/N
         DvOYHMb79VN8H0KGmQZQECTB+deODLs66OSa6luV6fcPhDh5x4YMhk62D3s9CEioRvQS
         hLDA==
X-Gm-Message-State: ANoB5pnoDEVLm3KgCh+ZSy0C5taiMGoRLmpx0bpe/CvPXFGJcMrQG0rt
        2oYGZLpU1H51WpRnC99g+Kw+bb4U0TImSKl0
X-Google-Smtp-Source: AA0mqf6Jetuy8HMcwtxDNg1OjoIdjBN49iTfXtwHDVfHqhMUNsnpBaz4xjGVR/deh4nQaNmodBVVvw==
X-Received: by 2002:a05:622a:a1a:b0:3a7:e426:2892 with SMTP id bv26-20020a05622a0a1a00b003a7e4262892mr1719589qtb.28.1670452098825;
        Wed, 07 Dec 2022 14:28:18 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fp38-20020a05622a50a600b00343057845f7sm14047861qtb.20.2022.12.07.14.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: do not set the header generation before btrfs_clean_tree_block
Date:   Wed,  7 Dec 2022 17:28:06 -0500
Message-Id: <8f9b14a270b3e2e9445ece62962a1f7ee3eae555.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were doing this before to deal with possible uninitialized pages
which was reported by syzbot.  Now that btrfs_clean_tree_block no longer
checks the header generation simply remove this extra init.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c85af644e353..971b1de50d9e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4897,9 +4897,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	    !test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state))
 		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
 
-	/* btrfs_clean_tree_block() accesses generation field. */
-	btrfs_set_header_generation(buf, trans->transid);
-
 	/*
 	 * This needs to stay, because we could allocate a freed block from an
 	 * old tree into a new tree, so we need to make sure this new block is
-- 
2.26.3

