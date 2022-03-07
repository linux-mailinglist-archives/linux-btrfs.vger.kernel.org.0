Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30A74D0AD2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiCGWSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbiCGWSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:47 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E19C403E9
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:17:52 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o22so4955009qta.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzhWS7GfWJFhKp4vhtPK2sLQR8/iIMmCTohoLpN7t/M=;
        b=CJW/6gXgZt5acQYMdIO7CjRuoNaHyuwvr2WKANfCr8m4WAh5JC5NRW+mtXfVyzCynb
         U0Z7WgyY++S1gumHyD+nnHwV647OgmUa+aFBao32xMpzmj5j+f11czJoGagLURUdtlwL
         GwdUphW9HtFGvpMTVZqrk6C/vBhxG7kwzt17vpu31na6oyxAU40td39fSweUR5XG/Pfw
         f7kklxwyc455Gwh+6XWt5CtQs0FjIs1MwNtlqTRvjSESRvUXBwlf4LXDlJRYV1cT2R71
         0p85GMXqJPiuRdkdl2ZWNS7aHf3jL1YOPqLLpQSG6wA0GLYCKhuWuHZyaqlKXEMXLI+o
         0ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzhWS7GfWJFhKp4vhtPK2sLQR8/iIMmCTohoLpN7t/M=;
        b=uTqadq/IXU/uTSsGVJ6nJ3pjkBPEib1VtpNzISgMvOQzgI9E9Mgik4R4L4TeefGoKF
         rPY/6HA8n9YMbLJNtsgAVrF/V0UlRoDmqNMCbAAW+2/yxN9Yt71cIE2atcHX3zR0eQEm
         lEghX1i/8JHOBPv1M5TES8mQFcGo/CmRKMFdWJiYP04inUTeLs/nD5YO0mMgPCrCiYHp
         WskTecpaFyx5YcuffC3EeNaEUTxes1BZlOXLCL5kju2WNaZjMN17V9NS3zpZ/hUeOoia
         vWE9tTGJkhMEGp4fmBDoj5i11Y/DSYldTZ0jiDyQZlttoQzMxUZ1DB1lqV0SY1fywFUr
         3ZTg==
X-Gm-Message-State: AOAM532UJlB2DoU9bPCyBYYW25IwhK9oGSGEQOi3POLA0qqah2rxZYfO
        8Ia7PuNdidOtzza4wxPiP8BqltPOAkiHb5ST
X-Google-Smtp-Source: ABdhPJzUZqY0V9SqrBJGP4ZXUwaBGx8mb9qJX1YRdzgIxD7FWQcmyO2ZwQkzPvJcTiSERIr70ZgyJw==
X-Received: by 2002:a05:622a:4ca:b0:2de:91c4:3d7c with SMTP id q10-20020a05622a04ca00b002de91c43d7cmr11413074qtx.618.1646691471267;
        Mon, 07 Mar 2022 14:17:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j7-20020a375507000000b00663273f16d0sm6848126qkb.61.2022.03.07.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:17:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/15] btrfs-progs: initial snapshot_id support
Date:   Mon,  7 Mar 2022 17:17:34 -0500
Message-Id: <cover.1646691255.git.josef@toxicpanda.com>
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

Hello,

This is the less complicated portion of the snapshot_id support.  These patches
add the on-disk definitions to the btrfs_header and btrfs_root_item to keep
track of the snapshot_id.  This series does not include the extent tree changes
that will be needed as well, as those will require a lot of changes as well.
The complicated part of this is we're growing the btrfs_header size, so we've
had to adjust all of the accessors to take into account the new math.  This
passes xfstests with the btrfs-progs related patches.  Currently nothing
actually messes with the snapshot_id, as this will be handled later when I
re-instate snapshot support for extent tree v2.  Thanks,

Josef

Josef Bacik (15):
  btrfs-progs: use btrfs_item_nr_offset() in btrfs_leaf_data
  btrfs-progs: use item/node helpers instead of offsetof in ctree.c
  btrfs-progs: image: use the appropriate offset helpers
  btrfs-progs: mkfs: add a helper for temp buffer clearing
  btrfs-progs: move the buffer init code to btrfs_alloc_free_block
  btrfs-progs: fix item check to use the size helpers
  btrfs-progs: add snapshot_id to the btrfs_header
  btrfs-progs: make __BTRFS_LEAF_DATA_SIZE handle extent tree v2
  btrfs-progs: adjust the leaf/node math for header_v2
  btrfs-progs: setup the extent tree v2 header properly
  btrfs-progs: add new roots to the dirty root list
  btrfs-progs: delete the btrfs_create_root helper
  btrfs-progs: add a snapshot_id to the btrfs_root_item
  btrfs-progs: inherit the root snapshot id in the buffer
  btrfs-progs: add new COW rules for extent tree v2

 check/main.c                    |  14 ---
 convert/main.c                  |   2 +-
 image/main.c                    |   5 +-
 kernel-shared/ctree.c           | 166 +++-----------------------
 kernel-shared/ctree.h           | 199 +++++++++++++++++++-------------
 kernel-shared/disk-io.c         |  38 +++---
 kernel-shared/extent-tree.c     |  18 +++
 kernel-shared/free-space-tree.c |   1 -
 mkfs/common.c                   |  36 +++---
 mkfs/main.c                     |  21 ++--
 10 files changed, 207 insertions(+), 293 deletions(-)

-- 
2.26.3

