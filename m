Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41088629EA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiKOQQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiKOQQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:25 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714EB29804
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:24 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id w10so10096622qvr.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJNf8w/rMB3B3mjqeX4p/xYGKvLvKUIcYyjTYXY9EY8=;
        b=6yi/SJ7tqAefxyN8bl0IfBwyvzC8ygdqCV/Wt6u5O06wFl4oeBhOZYs5ydQT8I36fP
         bqwf8y95K2H/3W45Zt/QeorEOpnVxmw3Gq+lxzYCax/2qArYwSshQkKFnDB/v0sBmxfh
         40GUNWB4Yb4DMO7l8FMDKL/HnFwsSNUWjzgZKRzqw/yfo1/UvNI+lDiWQn3S7qyRyyIq
         ppCP8H4+F4ESMfMzsZ9eL7PTKUAltmh0iBby0RmOLQanhbHSJLrViVf3/julkgq6lGvd
         T2Ac2Ki/Ao2OkDeYbvNkskya6tOTP8iXBbu0gmDx0tUuUpTveHfzWkLHdS3PThkQzLek
         4vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJNf8w/rMB3B3mjqeX4p/xYGKvLvKUIcYyjTYXY9EY8=;
        b=znDS2QpQdcvriTgqyZ5s3qXYlrUgZwglu6JfxWHhzgshcdwdmuT804hbG71ElWy07Z
         ofr/9RzbBVqvkFtQHtJ0kK0xNOgg7y4bSeJHOiGokjxPwK1omFXCPPLQBhrOQRF+0Fx7
         JWlo3YdQ1V/diKdkUwOyH2UqdyxwwhTQLlYmMlWMkbIwwGLoq4gBEfi8+CyKLEJyUfcn
         YNo2FVn5Dek2xqseC15AJ/ND7IMXCHEX+CMYtOq+fC+FpeGNInWxDhOOhnsxJHC/2mfp
         pRSIk5Q2QurvL0S+I3p37wJNUmkBJL14Rb9Gazr+6PR2SBtB6XLH0xDrPz4UMTVaWw/J
         Ge3w==
X-Gm-Message-State: ANoB5pkXTY1kpECLvu1b6JXQcco581iDQUyMtRWQxukHwDGxBLXmSMUS
        QJnf8QYilLzvdMt30D2fmF9c3gn4aWeFgw==
X-Google-Smtp-Source: AA0mqf49p4BxMdjuYwnLXIwJrPB5Cq3eGbn6f5gME9ifp2m/fNhZLromQt/2jJynpe0UGV1Xp0K4sw==
X-Received: by 2002:a05:6214:3d8f:b0:4b7:5b6f:2b7a with SMTP id om15-20020a0562143d8f00b004b75b6f2b7amr15586845qvb.26.1668528983167;
        Tue, 15 Nov 2022 08:16:23 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bp44-20020a05620a45ac00b006f956766f76sm8380412qkb.1.2022.11.15.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/11] btrfs: a variety of header file cleanups
Date:   Tue, 15 Nov 2022 11:16:09 -0500
Message-Id: <cover.1668526429.git.josef@toxicpanda.com>
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

While syncing accessors.[ch] I ran into a variety of oddities between what we do
in the kernel vs what we do in btrfs-progs.  Some of these things are just
differently named helpers, some are helpers we need in progs but don't have in
the kernel, and some of these are extent tree v2 stuff that was done in
btrfs-progs but not yet merged into the kernel. I kept the v2 stuff very simple,
it's mostly just updating helpers to take an extent_buffer.

Additionally I cleaned up how we do leaf manipulation, because those helpers are
a little wonky and you have to understand how the leaves are laid out.  I'm not
in love with what I came up with, but it makes the code a little cleaner, and
then it made the cleanups easier as there are only 4 sites that needed to be
updated instead of 32.

I made these changes in tandem with the btrfs-progs sync of accessors.[ch], and
then sync'ed the copy based on these changes.  I can obviously update them both
if there are changes required, but this is why the accessors.h looks different
in my btrfs-progs patchset, because it's actually a copy of that file with these
changes applied.  Thanks,

Josef

Josef Bacik (11):
  btrfs: move root helpers back into ctree.h
  btrfs: move leaf_data_end into ctree.c
  btrfs: move file_extent_item helpers into file-item.h
  btrfs: move eb offset helpers into extent_io.h
  btrfs: move the csum helpers into ctree.h
  btrfs: pass the extent buffer for the btrfs_item_nr helpers
  btrfs: add eb to btrfs_node_key_ptr_offset
  btrfs: add helpers for manipulating leaf items and data
  btrfs: remove BTRFS_LEAF_DATA_OFFSET
  btrfs: add nr_global_roots to the super block definition
  btrfs: add stack helpers for a few btrfs items

 fs/btrfs/accessors.c            |   2 +-
 fs/btrfs/accessors.h            | 124 ++++++++----------
 fs/btrfs/ctree.c                | 218 ++++++++++++++++++++------------
 fs/btrfs/ctree.h                |  63 ++++-----
 fs/btrfs/extent_io.c            |  10 +-
 fs/btrfs/extent_io.h            |  33 +++++
 fs/btrfs/file-item.h            |  34 +++++
 fs/btrfs/tree-checker.c         |   5 +-
 fs/btrfs/tree-mod-log.c         |   4 +-
 include/uapi/linux/btrfs_tree.h |   3 +-
 10 files changed, 295 insertions(+), 201 deletions(-)

-- 
2.26.3

