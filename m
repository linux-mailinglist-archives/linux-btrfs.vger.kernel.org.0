Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC024C048B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiBVW0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiBVW0w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:26:52 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E3B10B5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:25 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bm39so1960108qkb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJ/8mhxzpCF+QjBDMcRkgieOuhX2kuGAFc+6MDc1P/Q=;
        b=ekHl56b7k8Alr4iIYJN3aWsemxyDiU4wr441+KrVEBYnoDJ0Y91TuyKT/6j9omykXY
         iC3hnWiIzTUnMF5oNjUtNBdVk8LeIOre5gRW+9Ki1s5kqliOYE6VQskSxZqZyQF2Ba6V
         ZBsMBDVqHcbNrIk1/uo1QQSzxU2l+vZRkC2kprsO5H8ArizmNx2kpdiVlCcdWNkVqS88
         Tx0Glger+O3H5iv3iT+F/fGJnVnkEohxLwPit5/zOgnetVo+oKxpKKtEIY2sU2JnD4px
         ycCqNMZw4SPFqjUFvHKNXjf3onoXxcrqH3jWnN6Slku23UtTNkwvDs37G3KvtwvE4zBd
         i69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJ/8mhxzpCF+QjBDMcRkgieOuhX2kuGAFc+6MDc1P/Q=;
        b=VBWz/iCCORyZN+8NpOoelI8da2fRtqndEBzerUISal6NtanUVdOgQfF9JBpuIShCMA
         EObK62R1iifH92lnkF6k/9GbGXn6kwDvQR4/Fw9Wr/+uUEvPAqfh07kbv8UZC6uXfWv9
         GDFb5Ed5xNa7uXMfgQkA+BLqpXmt0P1xMS8w6RHK7rr/eiZ/RwKtkkIKQFlEs84euY+J
         eN0y5e/OeUzPuIz/cZTOVUNapfxDM6NNimdf3ibpnNbRq4VQbXClo3huKT+gYsgkl59u
         PE44298vDA+zax/vfb/R/FMSeyOKWKIJ+jAuXhoay7xmbzyETU67r5iIn1o42kpth0uE
         6a/Q==
X-Gm-Message-State: AOAM533YUUo5CKwj+Fs7OWNWWfihVdmyEax6KF37Fzwj1KxRDlqcXXVd
        GobC0q7KPBQH99RnSVywBHXfu9vb4elZaYfs
X-Google-Smtp-Source: ABdhPJwPYhJ0lP6BX/Q1gn/W+tGC8auGpHrK4FCx7zdZjSmD9wBTFRxqAht8DkltLhGAv0GkHcn0Mg==
X-Received: by 2002:a37:a014:0:b0:4b2:8a7c:eca7 with SMTP id j20-20020a37a014000000b004b28a7ceca7mr16388056qke.516.1645568784751;
        Tue, 22 Feb 2022 14:26:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l6sm725392qtk.34.2022.02.22.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/13] btrfs-progs: cleanup btrfs_item* accessors
Date:   Tue, 22 Feb 2022 17:26:10 -0500
Message-Id: <cover.1645568701.git.josef@toxicpanda.com>
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

This is prep work for me adjusting the size of the btrfs_header.  This is a
mirror of the work that was already merged into the kernel.  The only extra work
that I've done here is add some compiler switches that I used to help me catch
all the different users of the helpers to make sure I didn't make any mistakes.
Thanks,

Josef

Josef Bacik (13):
  btrfs-progs: turn on more compiler warnings and use -Wall
  btrfs-progs: store LEAF_DATA_SIZE in the mkfs_config
  btrfs-progs: store BTRFS_LEAF_DATA_SIZE in the fs_info
  btrfs-progs: convert: use cfg->leaf_data_size
  btrfs-progs: reduce usage of __BTRFS_LEAF_DATA_SIZE
  btrfs-progs: btrfs_item_size_nr/btrfs_item_offset_nr everywhere
  btrfs-progs: add btrfs_set_item_*_nr() helpers
  btrfs-progs: change btrfs_file_extent_inline_item_len to take a slot
  btrfs-progs: rename btrfs_item_end_nr to btrfs_item_end
  btrfs-progs: remove the _nr from the item helpers
  btrfs-progs: replace btrfs_item_nr_offset(0)
  btrfs-progs: rework the btrfs_node accessors to match the item
    accessors
  btrfs-progs: make all of the item/key_ptr offset helpers take an eb

 Makefile                    |   3 +
 btrfs-corrupt-block.c       |  17 ++-
 check/main.c                |  90 +++++++--------
 check/mode-common.c         |  12 +-
 check/mode-lowmem.c         |  37 +++---
 check/qgroup-verify.c       |   2 +-
 cmds/inspect-tree-stats.c   |   3 +-
 cmds/rescue-chunk-recover.c |   4 +-
 cmds/restore.c              |   7 +-
 convert/common.c            |  33 +++---
 convert/main.c              |   1 +
 image/main.c                |  31 +++--
 image/sanitize.c            |   4 +-
 kernel-shared/backref.c     |  10 +-
 kernel-shared/ctree.c       | 219 ++++++++++++++++--------------------
 kernel-shared/ctree.h       | 110 ++++++++----------
 kernel-shared/dir-item.c    |  10 +-
 kernel-shared/disk-io.c     |   1 +
 kernel-shared/extent-tree.c |  12 +-
 kernel-shared/file-item.c   |  12 +-
 kernel-shared/inode-item.c  |  14 +--
 kernel-shared/print-tree.c  |  29 +++--
 kernel-shared/root-tree.c   |   2 +-
 kernel-shared/uuid-tree.c   |   4 +-
 kernel-shared/volumes.c     |  10 +-
 mkfs/common.c               |  52 ++++-----
 mkfs/common.h               |   1 +
 mkfs/main.c                 |   1 +
 28 files changed, 333 insertions(+), 398 deletions(-)

-- 
2.26.3

