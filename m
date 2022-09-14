Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED95B90C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiINXFB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiINXE7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:04:59 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51627DD7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y2so12376708qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=P1xK5E8PShPDKzyQsnVhoe35tO3hdK9matIhdx9urXo=;
        b=jmfSwfiqMa3mbrTYb3wUtSxlcPFh9D+iuqQVZOHagTngtfZ6BPDWF7HLAlwnW6NKWL
         bMikwcwAiU4oHyRKVBt6lmJblDIwrJ2jBHeJTBiwUk9EBwsonq6librC/SVvR3AcyjcD
         mxF9jxfTnJcTicVFzl6/aSpI0UNtUBNHXyqIw8RHYQ/hZrDAVY8df+KRivjBBSn/ChBr
         vD0zfSEKDljlavlFjS9ISu7fmXr+OlyuvbEdBk1lKeDEwYMtFuwJsvVRipRNMxak/ROR
         uwC62UrYkwyX0qhOrAHeHXYpFLvlXUoMcVneXhG4RR2Oj7jZzcXuDI7LNYSx7Bs+mxqP
         XViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=P1xK5E8PShPDKzyQsnVhoe35tO3hdK9matIhdx9urXo=;
        b=1LdCP31jf6ct4OmKNL8B51YKjaWX9cp53Dy5JziHVtrwgCnU2dXes6l8WYkBlOLCyL
         HX02grgNif7hsDzSdsi5jdB00LN5lnR7cg/Kr9GSasC8siOZ06p0FL3Xm2S3sMcwTH3p
         B6vg13Vtnmj18dzH7/Ws4MujGKLOD7Ze8vAd1QPLg4oe6ESTO7lle970bqgxynJlqRVN
         3YEpXwR8XgwxRePFRufDDZnwW+aRilNnHZMjZHxfiyEO9QZxjXkHzaQzwWQnx1S7Ea8V
         6PptB/LmKWmW7ayKR/cZ9FcAwDG9PNl2IH43ZNnCjbAtxzm+BRs+60yQ31EtJWEch3L6
         9FTA==
X-Gm-Message-State: ACgBeo0++aBXIsC0fanbUKLZM04HtnrAmbO6bePL9taHwUOJc3Q9pfgl
        cOmfscJuBVHdN30XRd9PgRUJ7U9M2YM5bw==
X-Google-Smtp-Source: AA6agR7ni4e4QYToSQIwBiVthyg8rTSUhuLh64X03w61kLl2wtAYV4afgowZt4TLFnjBCV9UPqHozg==
X-Received: by 2002:a05:622a:609:b0:35b:b6c4:e0e1 with SMTP id z9-20020a05622a060900b0035bb6c4e0e1mr14147116qta.591.1663196693029;
        Wed, 14 Sep 2022 16:04:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a16cc00b006a5d2eb58b2sm2537718qkn.33.2022.09.14.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:04:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/15] btrfs: strip out btrfs_fs_info dependencies
Date:   Wed, 14 Sep 2022 19:04:36 -0400
Message-Id: <cover.1663196541.git.josef@toxicpanda.com>
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

Part of the cleaning up of ctree.h is being able to move btrfs_fs_info out of
it.  This is actually pretty difficult because we essentially rely on ctree.h
being included before everything else, so all other header files have fs_info
defined for their helpers.

This series starts this work.  There are a variety of other small moves as well,
but the bulk is trying to pull any helpers that access fs_info members inside of
their header files into their respective c files, or alternatively reworking the
code to drop the dependency.  Thanks,

Josef

Josef Bacik (15):
  btrfs: move btrfs_caching_type to block-group.h
  btrfs: move btrfs_full_stripe_locks_tree into block-group.h
  btrfs: move btrfs_init_async_reclaim_work prototype to space-info.h
  btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
  btrfs: remove temporary btrfs_map_token declaration in ctree.h
  btrfs: move static_assert() for btrfs_super_block into fs.c
  btrfs: move btrfs_swapfile_pin into volumes.h
  btrfs: move fs_info struct declarations to the top of ctree.h
  btrfs: move btrfs_csum_ptr to inode.c
  btrfs: move the fs_info related helpers closer to fs_info in ctree.h
  btrfs: move btrfs_ordered_sum_size into file-item.c
  btrfs: delete btrfs_inode_sectorsize helper
  btrfs: delete btrfs_insert_inode_hash helper
  btrfs: use a runtime flag to indicate an inode is a free space inode
  btrfs: add struct declarations in dev-replace.h

 fs/btrfs/block-group.c  |   3 +-
 fs/btrfs/block-group.h  |  15 +++
 fs/btrfs/btrfs_inode.h  |  22 +---
 fs/btrfs/ctree.h        | 260 ++++++++++++++++------------------------
 fs/btrfs/dev-replace.h  |   4 +
 fs/btrfs/disk-io.c      |   4 +-
 fs/btrfs/extent_io.c    |   4 +-
 fs/btrfs/file-item.c    |  12 ++
 fs/btrfs/file.c         |  11 +-
 fs/btrfs/fs.c           |   2 +
 fs/btrfs/inode.c        |  13 ++
 fs/btrfs/ordered-data.h |  12 --
 fs/btrfs/space-info.h   |   1 +
 fs/btrfs/volumes.h      |  26 ++++
 14 files changed, 188 insertions(+), 201 deletions(-)

-- 
2.26.3

