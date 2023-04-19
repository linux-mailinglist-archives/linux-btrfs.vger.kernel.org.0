Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AAD6E8389
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjDSVWg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjDSVWc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:22:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B98A53
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:21:59 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id bb13so600513qtb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939254; x=1684531254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSw4rmUOXRn7OYhfT9BRUMA3Zbn3jxs/ofC6YnIL8Rs=;
        b=5FDdk/+6NOWIUzZj+SA1/O3eJ9I6FCaJVz4mXJS0qyTlsYZCcP7V65fF3riPYGybwW
         htUsfQ6+5Ujz+kT1qrppe8tgvJkb1ME4oMop6XzMTFGcgThVPd2wy4Yf+eVkGpVSdvgL
         eveDp1S88fMiHuuTFM0e4QnIrbF6F8t3pp9U1EvQ0Ry1jLKyURmsalm33Ir/sx8UD8KE
         20nLYlPNeJ6bX6t0J0qiApdIUGdFArnmSyn32FT4O1yHcnZVz7x4u4UCIrTEkV4/rBSG
         f9wFUAsdnysWvbCc7cw0KVx2YCsy3PA/RShVheFdGuS8TbC18n6GkbwlnpCrhqWeus1I
         cAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939254; x=1684531254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSw4rmUOXRn7OYhfT9BRUMA3Zbn3jxs/ofC6YnIL8Rs=;
        b=G5jF5p6IgGd4V5oHQqRpvNSzhIwk0F0mGf+XEqNE2Ok46X8mSkYA+s8/MNxDSOFekC
         CBZHOaRQR/FcDZXh3xYQKo+9aGsXoxRKp2qRUfPF3mUMwnkWj9Lu8A/Ulc9XB+AgpoGv
         +UHCBIRdC6Ht2zgzuqAd6vUILQ+MvDcmlaDr/CBYIMWQHwqJt16pwnbSFn4OvQRH7+WG
         QgH4WMZzXjoim//MkqU6Xf/kbUXEciI5Mp960qWT1xCg+tz6KBDNaHZfzfqpmfs/uSBw
         7A4TJHepFjhgzg5FICQniUV/g3cnFvVpCDzzqCBiJnDSPVnTAV/U9n8QP2nZvKmm78kX
         vhRg==
X-Gm-Message-State: AAQBX9dKKYEaC5b8NQTTym5QPEEJw0fmyP6DPJ02+kdR+SfQY5JFHdPr
        kE5mvk731gIXbuEYRlEY6Snq9/7LpFU0I81I9W+mTA==
X-Google-Smtp-Source: AKy350YEym1KORpL6Z2P7L0T0gRQyrH/xJ+jAq7Tps76+EBYD7z2HnTyYXO2z0D7znaCqLfFRYnxEg==
X-Received: by 2002:ac8:5acb:0:b0:3ef:414e:fb6a with SMTP id d11-20020ac85acb000000b003ef414efb6amr7098688qtd.55.1681939253796;
        Wed, 19 Apr 2023 14:20:53 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c11-20020ac853cb000000b003d5358ffa83sm33672qtq.62.2023.04.19.14.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:20:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/10] btrfs-progs: prep work for syncing ctree.c
Date:   Wed, 19 Apr 2023 17:20:40 -0400
Message-Id: <cover.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
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

These patches update a lot of the different ctree.c related helpers that have
diverged from the kernel in order to make ite easier syncing ctree.c directly.
This also syncs locking.[ch], but this is to just stub out the locking.  This
will make it easier to sync ctree.c as well since there's locking in the kernel
that didn't exist when we had this in btrfs-progs.

This series depends on

	btrfs-progs: prep work for syncing files into kernel-shared
	btrfs-progs: sync basic code from the kernel

Thanks,

Josef

Josef Bacik (10):
  btrfs-progs: const-ify the extent buffer helpers
  btrfs-progs: bring root->state into btrfs-progs
  btrfs-progs: rename btrfs_alloc_free_block to btrfs_alloc_tree_block
  btrfs-progs: sync locking.h and stub out all the helpers
  btrfs-progs: add btrfs_locking_nest to btrfs_alloc_tree_block
  btrfs-progs: add some missing extent buffer helpers
  btrfs-progs: rename btrfs_set_block_flags ->
    btrfs_set_disk_extent_flags
  btrfs-progs: cleanup args for btrfs_set_disk_extent_flags
  btrfs-progs: rename clear_extent_buffer_dirty =>
    btrfs_clear_buffer_dirty
  btrfs-progs: make __btrfs_cow_block static

 Makefile                    |   1 +
 check/main.c                |   7 +-
 cmds/rescue-chunk-recover.c |   4 +-
 cmds/rescue.c               |   2 +-
 include/kerncompat.h        |   4 +
 kernel-shared/ctree.c       |  72 +++++-----
 kernel-shared/ctree.h       |  82 ++++++++++--
 kernel-shared/disk-io.c     |  33 +++--
 kernel-shared/extent-tree.c |  28 ++--
 kernel-shared/extent_io.c   |  28 ++--
 kernel-shared/extent_io.h   |  15 ++-
 kernel-shared/locking.c     |  22 +++
 kernel-shared/locking.h     | 258 ++++++++++++++++++++++++++++++++++++
 kernel-shared/transaction.c |   4 +-
 14 files changed, 464 insertions(+), 96 deletions(-)
 create mode 100644 kernel-shared/locking.c
 create mode 100644 kernel-shared/locking.h

-- 
2.40.0

