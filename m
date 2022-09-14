Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2035B8B49
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiINPG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiINPGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B577756A
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:44 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id u28so8133438qku.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=rrY7fTDNuzgo2WskhU4SLkRpff8eSQTLzW3ZCc/6XyQ=;
        b=3L05OCx87ZjZ38rtiQHZU3/fQOPsryFE+v1mzHfKQbR2PxUAGfgqcImqgMnVAiul0W
         A7yVmWGKabKro24QiMJMfM02Zjr6U3Gzq+jFnKawXrPAaGpQ5JwnzQbBE/f7oIyJYNXT
         Y1VO9AfytVfCyARsIOcxkaNu/BGcxEatHiM//c9wU/EVmtB8K642PNrzT7diTFR607Ty
         m7FIpeMO0uU33OPkJKTqqoqRbP1PswcYPpkjNKle9bAh/I56+wlRyxzmv3Js9XrWPavY
         H2gdQaODok86xEL/5vAt+T01QH1vZpNYRA490R0X/oE9MV+bTAoQ9tmRHQwszv+nJRCy
         y1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=rrY7fTDNuzgo2WskhU4SLkRpff8eSQTLzW3ZCc/6XyQ=;
        b=KMIm5zoPOydReRQrJ+kHwGiJsQtXa9MrUEPkhetk0PhJRu8AZQWeKNXEx6Q2md3EAL
         StLIYkFwUbzx/kV+GRceD0IUupFtXAiev0DJaFr3iAm4JZx/mCnQnnzPVID6CtL/I7tE
         +IqrAeSurI+k0xYs+TBSqDAMc+uZqd4CnrQTLiVqfyj6mMskZVvQFg9JFPy8RzdbDAom
         O9sugydYMT6odD+KcH/FAnBjuDdRSnzFQxtsVs7xRj0PWsLtEyGIHNf89deGEuCcSwmQ
         LCu5t0dm1AexH1fAOH5RzViZve38IGogjEmgi1GEh+tbbopf3nmB/Lj5xv0MRAIJkGco
         Lcag==
X-Gm-Message-State: ACgBeo3SpW6Co6lrz9V7rHpbHJ8ywWp+YmoM43FNdl7tRAeEXXjLToCY
        whBUtFc/da2VjTRWNAfZlzdaNOPUWnZKFw==
X-Google-Smtp-Source: AA6agR4OOGgXk3YZTFjPg9EeiLsKNZDfJrqNIRo3aiJA12T4v6fIRxepIByKLNcc/2q36cytKe9IQA==
X-Received: by 2002:a05:620a:c51:b0:6bb:11fc:7c58 with SMTP id u17-20020a05620a0c5100b006bb11fc7c58mr25594543qki.274.1663168003064;
        Wed, 14 Sep 2022 08:06:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 62-20020a370741000000b006b9ab3364ffsm1856369qkh.11.2022.09.14.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/17] btrfs: initial ctree.h cleanups, simple stuff
Date:   Wed, 14 Sep 2022 11:06:24 -0400
Message-Id: <cover.1663167823.git.josef@toxicpanda.com>
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

This is the first part in what will probably be very many parts in my work to
cleanup ctree.h.  These are the smaller changes, mostly removing code that's not
used anymore, moving some stuff that's local to C files that don't need to be in
the header at all, and moving the rest of the on-disk definition stuff to
btrfs_tree.h.  There's a lot of patche here, but they're all relatively small,
the largest being the patch to move the on-disk definitions to btrfs_tree.h,
which is not very large compared to patches in the next several series.  This
has been built and tested, it's relatively low risk.  Thanks,

Josef

Josef Bacik (17):
  btrfs: remove set/clear_pending_info helpers
  btrfs: remove BTRFS_TOTAL_BYTES_PINNED_BATCH
  btrfs: remove BTRFS_IOPRIO_READA
  btrfs: move btrfs on disk definitions out of ctree.h
  btrfs: move btrfs_get_block_group helper out of disk-io.h
  btrfs: move maximum limits to btrfs_tree.h
  btrfs: move BTRFS_MAX_MIRRORS into scrub.c
  btrfs: move discard stat defs to free-space-cache.h
  btrfs: move btrfs_chunk_item_size out of ctree.h
  btrfs: move btrfs_should_fragment_free_space into block-group.c
  btrfs: move flush related definitions to space-info.h
  btrfs: move btrfs_print_data_csum_error into inode.c
  btrfs: move trans_handle_cachep out of ctree.h
  btrfs: move btrfs_path_cachep out of ctree.h
  btrfs: move free space cachep's out of ctree.h
  btrfs: move btrfs_next_old_item into ctree.c
  btrfs: move the btrfs_verity_descriptor_item defs up in ctree.h

 fs/btrfs/block-group.c          |  12 +
 fs/btrfs/block-group.h          |  11 +-
 fs/btrfs/btrfs_inode.h          |  26 ---
 fs/btrfs/ctree.c                |  26 +++
 fs/btrfs/ctree.h                | 388 ++------------------------------
 fs/btrfs/delayed-inode.c        |   1 +
 fs/btrfs/disk-io.c              |   7 +
 fs/btrfs/disk-io.h              |   8 +-
 fs/btrfs/free-space-cache.c     |  28 +++
 fs/btrfs/free-space-cache.h     |  11 +
 fs/btrfs/inode-item.c           |   1 +
 fs/btrfs/inode.c                |  57 ++---
 fs/btrfs/props.c                |   1 +
 fs/btrfs/relocation.c           |   1 +
 fs/btrfs/scrub.c                |  11 +
 fs/btrfs/space-info.h           |  59 +++++
 fs/btrfs/super.c                |  24 +-
 fs/btrfs/transaction.c          |  17 ++
 fs/btrfs/transaction.h          |   2 +
 fs/btrfs/volumes.c              |   7 +
 fs/btrfs/volumes.h              |   2 +-
 include/uapi/linux/btrfs_tree.h | 226 +++++++++++++++++++
 22 files changed, 476 insertions(+), 450 deletions(-)

-- 
2.26.3

