Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E34574091
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiGNAeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 20:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiGNAeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 20:34:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2AB13CDF
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y3so309108qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4sZk9ImGcgZsckL8DvpO+BlGcQUJPcenPlE0icQ45I=;
        b=DH8/SA/RzzM9tjqsQZicKGBqNztQhtZv53jLgVm21w3HC7AI+kWGULXkcZROnC0lKr
         mXVPj7fNwjlLw7R83Gau/fUzzBeyQycNrXufeb2sxYmYkBVl4OGEFVzNc1O7P0DonAvx
         F48uht0I9BoVSO+CKD5FD0F57O02iQ4bdG6E2C8xzWiy8dpUQN7r5fdz/GOdoX8WjWlr
         nTsrAw0+2VstjaRVcGnm+j7jzEmm9zNe2ldKWMkMT/+t3a9HNwDwn5ICZWYNo8phQNci
         2QJcxF+8oUKo9AGSw0Am56qkbWjUZw8Lpch/HXiM9SnSpo7VBLe8XeLPRrekffDEp4i3
         uElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4sZk9ImGcgZsckL8DvpO+BlGcQUJPcenPlE0icQ45I=;
        b=dYEPqBq9kaNBV/uXaiACiRaRiSLH8M3BwagLDMTqxk4LRQ/9SRjptLBQS/kKZrKEyi
         kFTI7oG9R/KDqma1XbRFFLCQvDM4qcthqEJOPxIfsCSz+PXuu0WsydUjLtPrKHJjegCE
         9zvgwLKUbK+eQhDfPgjFfwYv0c4b++LkAGLK94ZL0QiXTfslRtRPWCgnusJRUBvRspz9
         WFMSTXrgOIyKip9RnDLUwXc4BYIkQdou6Yl2FPLucG8HKf3ZI4fcQwhl8LOfDIi4E3t0
         jRPM3goNNzlLtTGSzmW1cSeHGfJ8BA/HPp8R3i2hKC4On2XgqLAB5EpVmrihmrqdluUO
         2NFw==
X-Gm-Message-State: AJIora+FcRl1SjJo+nUxmSBzF2W5R1w5fLqtqDly7drslF0tRWodc17o
        YymfEmbS84N5Q3yRm0iYQygwb7a1EiwIjg==
X-Google-Smtp-Source: AGRyM1tz2PISuYWq0TRJPl+e8q6X4IHBWWi7+uQg+oD1m9JcGnJmHoinTxYKF0//WU9PtUtnQOPWsw==
X-Received: by 2002:a05:622a:1892:b0:31e:b892:1efc with SMTP id v18-20020a05622a189200b0031eb8921efcmr5954832qtc.512.1657758851063;
        Wed, 13 Jul 2022 17:34:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r1-20020ae9d601000000b006b5c061844fsm177493qkk.49.2022.07.13.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:34:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] btrfs: block group cleanups
Date:   Wed, 13 Jul 2022 20:34:04 -0400
Message-Id: <cover.1657758678.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

I'm reworking our relocation and delete unused block group workqueues which
require some cleanups of how we deal with flags on the block group.  We've had a
bit field for various flags on the block group for a while, but there's a subtle
gotcha with this bitfield in that you have to protect every modification with
bg->lock in order to not mess with the values, and there were a few places that
we weren't holding the lock.

Rework these to be normal flags, and then go behind this conversion and cleanup
some of the usage of the different flags.  Additionally there's a cleanup around
when to break out of the background workers.  Thanks,

Josef

Josef Bacik (5):
  btrfs: use btrfs_fs_closing for background bg work
  btrfs: convert block group bit field to use bit helpers
  btrfs: remove block_group->lock protection for TO_COPY
  btrfs: simplify btrfs_put_block_group_cache
  btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL

 fs/btrfs/block-group.c      | 95 ++++++++++++++++---------------------
 fs/btrfs/block-group.h      | 19 ++++----
 fs/btrfs/dev-replace.c      | 11 ++---
 fs/btrfs/extent-tree.c      |  7 ++-
 fs/btrfs/free-space-cache.c | 18 +++----
 fs/btrfs/scrub.c            | 16 +++----
 fs/btrfs/volumes.c          | 13 +++--
 fs/btrfs/zoned.c            | 30 ++++++++----
 8 files changed, 103 insertions(+), 106 deletions(-)

-- 
2.26.3

