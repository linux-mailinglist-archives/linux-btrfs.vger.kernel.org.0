Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8E64640E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLGW2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGW2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:16 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85AF42F64
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:15 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a16so2206338qtw.10
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6SkrLxGmTwHc/9xquXgdyJgqY1jWxrIHkDYzW0NASw=;
        b=Edh3mU0yz2pIAbUnBusbi1a9olZ/aCuTFbiDzAf4byA1maYuolxt/hOUHekRIoNH5U
         9HmNSHTlEtCObi7rOECvV1mhk1indjrLxdaINqyR+Qreze4KbT6KlpgjnGkeB3LDEZ5C
         NYwlVeRUqfCUR+E9MBsqs2I1WyzFYxt7BuoiCOBxuMgTAIltEs8JlXH/Oar6hh7KdEO7
         yt5mdwHBruVccaQMeyA5bLt9vj62j1DuvcElHcck5oyUJs1vO/VpcNJb014UCzLLa3yP
         GyBy0sVk2nypYx2PC8EITvbyFABS1w83H8dnB5Yq/w6c2OwouRA6toOxpOwX4joPglpa
         PMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6SkrLxGmTwHc/9xquXgdyJgqY1jWxrIHkDYzW0NASw=;
        b=qRlB1wKtDnuizHkeaGLV4cjd861SqBgLk+fsNBR2YTTLaqKM2Nb5Hi9pHHgJD9/tBM
         EltkyrSwUCoW6wdlS0uJ75MEmC/YAI/ZKJOqQPHrkFsIVTIkIx45ObTv9mVqC9VW9CEU
         06iZrIrTrz9ZmgbvI5WnJmedk0kWMPeplPz3xobo5s+AY+fZf3SeXaXzxDAS+g/r13uN
         ojS7rb4Vee3W4snuH0BuNN53zWg9hOiNkReevHcpJf4E8efMog36nqlPAJma6jBxQ4ap
         AmwXxnVUEjIYEkD8kIX8tx2Q0M3IemNS1WoD3u97gKwvcjBe2tRGOAL2JUhU5JxKWIRZ
         dzjQ==
X-Gm-Message-State: ANoB5pn+Snci/uTLPWt5/HjVZkSs/flC9YdDUYRStSaeCB0dnEyyjS5/
        WNNoN0Nuz6KFwk2mPSKIiRbNSmlKZiJFT9lq
X-Google-Smtp-Source: AA0mqf5gY5BXMd97kWICdjNqqzvKL7Rn63+P3XfyAUtKabND932Snec0VHAPeYCshF1MyOK95m8Vpg==
X-Received: by 2002:a05:622a:a11:b0:3a7:eceb:f222 with SMTP id bv17-20020a05622a0a1100b003a7ecebf222mr1429469qtb.51.1670452094308;
        Wed, 07 Dec 2022 14:28:14 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a450300b006eea4b5abcesm18939037qkp.89.2022.12.07.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] extent buffer dirty cleanups
Date:   Wed,  7 Dec 2022 17:28:03 -0500
Message-Id: <cover.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Hello,

While sync'ing ctree.c to btrfs-progs I noticed we have some oddities when it
comes to how we deal with the extent buffer being dirty.  We have
btrfs_clean_tree_block, which is sort of meant to be run against extent buffers
we've modified in this transaction.  However we have some other places where
we've open coded the same work without the generation check.  This makes it kind
of confusing, and is inconsistent with how we deal with the
fs_info->dirty_metadata_bytes.

So clean this stuff up so we have one helper we use for setting the extent
buffer dirty (btrfs_mark_buffer_dirty) and one for clearing dirty
(btrfs_clear_buffer_dirty).  This makes everything more consistent and clean
across the board.  I've additionally cleaned up a random writeback thing we had
in tree-log that I noticed while doing these cleanups.  Thanks,

Josef

Josef Bacik (8):
  btrfs: always lock the block before calling btrfs_clean_tree_block
  btrfs: do not check header generation in btrfs_clean_tree_block
  btrfs: do not set the header generation before btrfs_clean_tree_block
  btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
  btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
  btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
  btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
  btrfs: remove btrfs_wait_tree_block_writeback

 fs/btrfs/ctree.c           | 16 +++++++--------
 fs/btrfs/disk-io.c         | 25 +++++-------------------
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/extent-tree.c     | 12 ++++--------
 fs/btrfs/extent_io.c       | 18 +++++++++--------
 fs/btrfs/extent_io.h       |  2 +-
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/qgroup.c          |  2 +-
 fs/btrfs/tree-log.c        | 40 ++++++++++++++------------------------
 10 files changed, 47 insertions(+), 74 deletions(-)

-- 
2.26.3

