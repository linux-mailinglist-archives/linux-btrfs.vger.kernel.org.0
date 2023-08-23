Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5247859C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbjHWNvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjHWNvr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621E8CDF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso5279567276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798704; x=1693403504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTD75cbGvsFTGfLe81aUPA88BvmxDgaEPTwKLkYau18=;
        b=nxQNWdMmH/jCfgme5Y0OpxtYWMkvdbgsJIsSX97ju2ADUkAJfs0vbemNZqkxERYebm
         omAFHWYLH+euqFZEP0BQouI3BPHnF0lQPVru/YtHlXVu7RcGkJijU1vaTkhWSRdBbJqV
         45vRHC3CdTMfHJz4z92O1MrjIkZvInYp3RvI7FZA57v9p5SoC+x9FsZSaHBZoxrRDOO2
         Q6OKErcobKZEzc5BS+2yrL8Qcc5Bef83QKhLj56Q2vJ5U0IYCDCl5qm3sJlUUk9fHfb6
         j2kj+kFCjXzH0JW7e0ovVuFHzs3V7H+YN9MDteUnR/7Oj+U+BAL1E5g4ablZtLub2wFh
         hMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798704; x=1693403504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTD75cbGvsFTGfLe81aUPA88BvmxDgaEPTwKLkYau18=;
        b=AUypXy3vHGlYPhIfOj58eBKIIF6VQOySfW5mgCfXTGUWx5Xjc5xeJ7kGyvp4z1ICnc
         5CyMyJ9GiZRxuev1qJ2SBg/qdKdRB5kKVk68kIXjpy15pScX5bSwDvipv5uASknZIJKe
         DLq1eFFKFdfQb8KzH6iXf5r2f5uQGOMxaeDVar0+VgLgUJnCnpJGAI0tqFsseKsTUhC+
         DTPE0Hmu7j05GB7ChfpN0dIw3NTPfn4OeAV/OZI2xRrrd45t+Htq83N9qf/0MpIN7BL/
         JBHL907nVVLcO4PxXSjUs6lQiq0pDHhvlfzFuXeDX4znck28jOTJwUzbvanWR53nZ8PP
         qSaQ==
X-Gm-Message-State: AOJu0YwKYNbWbewmT7AcWrTkHezY18CysrYVlroqyHRwq20J6PCGPyT1
        uCbc94NCMXFULskB3Za41iguGgAA0mNojbEgfcE=
X-Google-Smtp-Source: AGHT+IGK2wNyWgxPiwTxTJi65BUgRr3DTiE4h16oJxJwsYNRCo9qmuNyEr8j6YkP9ze7JGAN2UlRqA==
X-Received: by 2002:a25:3620:0:b0:d0f:ea4b:1dff with SMTP id d32-20020a253620000000b00d0fea4b1dffmr12488278yba.8.1692798704440;
        Wed, 23 Aug 2023 06:51:44 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o131-20020a257389000000b00d749efa85a1sm1784926ybc.41.2023.08.23.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/11] btrfs: ctree.[ch] cleanups
Date:   Wed, 23 Aug 2023 09:51:26 -0400
Message-ID: <cover.1692798556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While refreshing my ctree sync patches for btrfs-progs I ran into some oddness
around our crc32c related helpers that made the sync awkward.  This moves those
helpers around to other locations to make it easier to sync ctree.c into
btrfs-progs.

I also got a little distracted by the massive amount of includes we have in
ctree.h, so I moved code around to trim this down to the bare minimum we need
currently.

There's no functional change here, just moving things about and renaming things.
Thanks,

Josef

Josef Bacik (11):
  btrfs: move btrfs_crc32c_final into free-space-cache.c
  btrfs: remove btrfs_crc32c wrapper
  btrfs: move btrfs_extref_hash into inode-item.h
  btrfs: move btrfs_name_hash to dir-item.h
  btrfs: include asm/unaligned.h in accessors.h
  btrfs: include linux/crc32c in dir-item and inode-item
  btrfs: include linux/iomap.h in file.c
  btrfs: add fscrypt related dependencies to respective headers
  btrfs: add btrfs_delayed_ref_head declaration to extent-tree.h
  btrfs: include trace header in where necessary
  btrfs: remove extraneous includes from ctree.h

 fs/btrfs/accessors.h        |  1 +
 fs/btrfs/async-thread.c     |  1 +
 fs/btrfs/btrfs_inode.h      |  2 ++
 fs/btrfs/ctree.h            | 52 -------------------------------------
 fs/btrfs/dir-item.h         |  9 +++++++
 fs/btrfs/extent-tree.c      |  6 ++---
 fs/btrfs/extent-tree.h      |  1 +
 fs/btrfs/file.c             |  1 +
 fs/btrfs/free-space-cache.c |  9 +++++--
 fs/btrfs/inode-item.h       | 11 ++++++++
 fs/btrfs/locking.c          |  1 +
 fs/btrfs/props.c            |  1 +
 fs/btrfs/root-tree.h        |  2 ++
 fs/btrfs/send.c             |  6 ++---
 fs/btrfs/space-info.h       |  1 +
 fs/btrfs/tree-checker.c     |  1 +
 16 files changed, 45 insertions(+), 60 deletions(-)

-- 
2.41.0

