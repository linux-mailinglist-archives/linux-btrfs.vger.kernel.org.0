Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6538A6E8395
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDSVYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDSVYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:35 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65783AD14
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id o7so1181430qvs.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939453; x=1684531453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1eog/+0Gv6upQZPOhuKESa2sYtjILgGbcrsJyszL3w=;
        b=ZucrY0Cx1UqTYHjtub1swu1I4bUdSWBqutW+avk1sAPAqtOv788271R4vJOA8k81Vk
         bKrnl8CJ7mg8tJh9SP41EALiY5D+j7zBSnW8ub6sQ751hruJXXpMpNFpnQ1t6iS6Sja0
         Z8VEDiKTLQLMnPJQfpitZbfAQdKUpGYJYixZUQIMao93nNzyrPCkc6reUcozPJ9kUWQU
         X3y5ymH9H87Dh0JCw4NrADCYRccRoMZYC7VDO1W2M1qXFGU7c4iZmJojE8x6YWm2o3HU
         X/0NAyzR4RT1qmN4n/oVhnijhjYmSNi2wR/ToOB/sjT7UsHEtJXqJ+78zn6b9kIRbIsF
         jSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939453; x=1684531453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1eog/+0Gv6upQZPOhuKESa2sYtjILgGbcrsJyszL3w=;
        b=ZKb44obcmQRveh+waF1GVX9qQvak0lDLXhcHb5QnhKO2z7DAdLJtuNvtverxXPz1F6
         FW6DCD7eYoU5Mv4V9chr9gPdxZmtMWov9dTpFyxP8Pi4580OYXtsdXugn8Do56dRU2aD
         9TWEu95KvV/5sLoyiyd0B8bq6oFMRq3Pjviy1VVzLvhsTP/RLQL1jXFQ8XF2y82gJndg
         u1N8NndMuB6HMqu9+HWs5dUYvunhCLzduQfMEa/QmhEohqT+EdrjYapyvQ2E0rQEE5kQ
         jP8OBqTrPvXVQqsnUx/OZfAfMKVL9lAOkeODafV75j0YxEu+M2XcFtIDevAVaEe6u8Lq
         NJVQ==
X-Gm-Message-State: AAQBX9dkWqff8qEDXPAappV04uxxXRCpDBHGa/ShVs09vC2bGmOlTAmn
        S+nZaFiMob8UDVGIy/sdZlTLLcEas1Cg2mjdfbVGZg==
X-Google-Smtp-Source: AKy350b9Myc2lv/ht4/HftStkrYOqtH9STrWwckA51RgI4Ak3VAU/dkMTiAzyNA9RwII7pWe4NC4qA==
X-Received: by 2002:ad4:5c43:0:b0:5be:cb17:90ab with SMTP id a3-20020ad45c43000000b005becb1790abmr37096079qva.40.1681939453239;
        Wed, 19 Apr 2023 14:24:13 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id n1-20020a0cdc81000000b005dd8b9345adsm540qvk.69.2023.04.19.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/18] btrfs-progs: more prep work for syncing ctree.c
Date:   Wed, 19 Apr 2023 17:23:51 -0400
Message-Id: <cover.1681939316.git.josef@toxicpanda.com>
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

These are a bunch of changes that sync various api and structure differences
that exist between btrfs-progs and the kernel.  Most of these are small, but the
last patch is sync'ing tree-checker.[ch].  This was mostly left intact, however
there's a slight change to disable some of the checking for tools like fsck or
btrfs-image.

This series depends on
	btrfs-progs: prep work for syncing files into kernel-shared
	btrfs-progs: sync basic code from the kernel
	btrfs-progs: prep work for syncing ctree.c

Thanks,

Josef

Josef Bacik (18):
  btrfs-progs: sync and stub-out tree-mod-log.h
  btrfs-progs: add btrfs_root_id helper
  btrfs-progs: remove root argument from free_extent and inc_extent_ref
  btrfs-progs: pass root_id for btrfs_free_tree_block
  btrfs-progs: add a free_extent_buffer_stale helper
  btrfs-progs: add btrfs_is_testing helper
  btrfs-progs: add accounting_lock to btrfs_root
  btrfs-progs: update read_tree_block to match the kernel definition
  btrfs-progs: make reada_for_search static
  btrfs-progs: sync btrfs_path fields with the kernel
  btrfs-progs: update arguments of find_extent_buffer
  btrfs-progs: add btrfs_readahead_node_child helper
  btrfs-progs: add an atomic arg to btrfs_buffer_uptodate
  btrfs-progs: add a btrfs_read_extent_buffer helper
  btrfs-progs: add BTRFS_STRIPE_LEN_SHIFT definition
  btrfs-progs: rename btrfs_check_* to __btrfs_check_*
  btrfs-progs: change btrfs_check_chunk_valid to match the kernel
    version
  btrfs-progs: sync tree-checker.[ch]

 Makefile                         |    1 +
 btrfs-corrupt-block.c            |    8 +-
 btrfs-find-root.c                |    2 +-
 check/clear-cache.c              |    5 +-
 check/main.c                     |   28 +-
 check/mode-common.c              |    4 +-
 check/mode-lowmem.c              |   31 +-
 check/qgroup-verify.c            |    3 +-
 check/repair.c                   |   13 +-
 cmds/inspect-dump-tree.c         |   12 +-
 cmds/inspect-tree-stats.c        |    4 +-
 cmds/rescue.c                    |    3 +-
 cmds/restore.c                   |   11 +-
 image/main.c                     |   25 +-
 include/kerncompat.h             |   10 +
 kernel-shared/backref.c          |    6 +-
 kernel-shared/ctree.c            |  222 +---
 kernel-shared/ctree.h            |   77 +-
 kernel-shared/disk-io.c          |   92 +-
 kernel-shared/disk-io.h          |   16 +-
 kernel-shared/extent-tree.c      |   33 +-
 kernel-shared/extent_io.c        |   26 +-
 kernel-shared/extent_io.h        |    4 +-
 kernel-shared/free-space-cache.c |    5 +-
 kernel-shared/print-tree.c       |    4 +-
 kernel-shared/tree-checker.c     | 2064 ++++++++++++++++++++++++++++++
 kernel-shared/tree-checker.h     |   72 ++
 kernel-shared/tree-mod-log.h     |   96 ++
 kernel-shared/volumes.c          |  136 +-
 kernel-shared/volumes.h          |    5 +-
 tune/change-uuid.c               |    2 +-
 31 files changed, 2521 insertions(+), 499 deletions(-)
 create mode 100644 kernel-shared/tree-checker.c
 create mode 100644 kernel-shared/tree-checker.h
 create mode 100644 kernel-shared/tree-mod-log.h

-- 
2.40.0

