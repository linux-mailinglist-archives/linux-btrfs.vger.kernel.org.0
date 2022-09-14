Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931F45B90D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiINXFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiINXFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601D5019C
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:15 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y2so12377224qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=obqgsjuuQyDcinAsjpgqKHw8Na5YVFKdP9e3Fam5DnM=;
        b=hBuTHVDur/oRx33hLdraEytECL/JTN2bZhv9xhOuYJjbOsueTKp04ZkBe2Mh/XmI+W
         HGX7PHBHk19aw84W/kcsaUf8yRLR1pO8TEErWdPVCJQy/lEfQuCeEZPwMQA6qFatFn8J
         5tcarE49cQ5nPQHZJ7rWvifk9cBjBk3oDQDivRCHxrRVlCTJBgEhvLjb6FdwzHDKmKWM
         f2BnZW/MXaPJNDpXrLINpnEgpmOQytrptAO6Og3aawdyQDjQ/XRM1xurisIOYEVp6vJH
         8DA3BXBdoy7p50re/o6ua3/I4r2Oeo+XIqsU+GoL6Tc6TfxgKiilcU8q2aoKr9jNDjJP
         OL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=obqgsjuuQyDcinAsjpgqKHw8Na5YVFKdP9e3Fam5DnM=;
        b=7GDuJqF9eh/6A5NQMRQOGvuBoI9fJWpwIKafQXM+U8rNFp1fmmIUxPFsH4o99xMLo9
         6wVteny2S6cFBScWhWHfi6NUTq0m2m3aW5+hDMPg0unkiGJYvkMSSRjf7D0vs1gaK+Ov
         dbOmgmMn7wFuaNhpo4mj4si4L0HzxO1TgZNbh7TUo1c7zdpzJ7EdlVEVm6UuNJeM4/LO
         8riFqDm5+z74DA8CY9oB8UB9/BbrUsN3Zow8GMHdRmcDqFLKQW/fRMtVLT940Ukn3GuU
         qpFxmmfiEPwjzKrTqxTBPeQuvkgAd0kLKHs1XEn91nf4Fb6bsOUMJy6P6vl0mndbM96N
         RrOw==
X-Gm-Message-State: ACgBeo0fhnFy6cCHjUe5+OO58gaPPqjiDnKsBuIMdjqmqzWwDttmeohi
        G6hMB2oK36LStMpgaDRk+lBp6slfP1ijkg==
X-Google-Smtp-Source: AA6agR7VY46TZ24JV7/26Q2LtmiLkIb2Aa4gPPsXLgIHaMJO5QENLHObwNRsjC7u/vRbvy94ugeIsw==
X-Received: by 2002:ac8:7d90:0:b0:35b:afd3:20aa with SMTP id c16-20020ac87d90000000b0035bafd320aamr17537694qtd.252.1663196714635;
        Wed, 14 Sep 2022 16:05:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b006cbcdc6efedsm2846755qkn.41.2022.09.14.16.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/15] btrfs: add struct declarations in dev-replace.h
Date:   Wed, 14 Sep 2022 19:04:51 -0400
Message-Id: <aea129f8e5420561d3f5fbeaa0de297b7122e815.1663196541.git.josef@toxicpanda.com>
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

dev-replace.h just has function prototypes for device replace, however
if you happen to include it in the wrong order you'll get compile errors
because of different structures not being defined.  Since these are just
pointer args to functions we can declare them at the top in order to
reduce the pain of using the header.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 3911049a5f23..6084b313056a 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -7,6 +7,10 @@
 #define BTRFS_DEV_REPLACE_H
 
 struct btrfs_ioctl_dev_replace_args;
+struct btrfs_fs_info;
+struct btrfs_trans_handle;
+struct btrfs_dev_replace;
+struct btrfs_block_group;
 
 int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info);
 int btrfs_run_dev_replace(struct btrfs_trans_handle *trans);
-- 
2.26.3

