Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B16152C9
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKAUME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKAUMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859421C91F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:11:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C7FD336C4;
        Tue,  1 Nov 2022 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=V5sB2JBV/AMmJSfmdz+HYPvx2sdCZTU7Q0rchZd6ib0=;
        b=ZIyVg/QxKWFse5pfix/GVh5D4Vak0ko3wcYuTL8SOiwLiYI5jL+PSuNAROtSvV37+02oF0
        Eo6Xsxh85yM6i54eEU2WNG3vGtZwrM53977i6q0/2BYHbS3K2CUaWB4827W9aiCWFGqXAi
        Dam592GZjy8ZmNuv+T/xb+GdWjFUiCY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 340D32C141;
        Tue,  1 Nov 2022 20:11:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7140DA79D; Tue,  1 Nov 2022 21:11:40 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/40] Parameter and type changes to btrfs_inode
Date:   Tue,  1 Nov 2022 21:11:40 +0100
Message-Id: <cover.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Many patches but also quite short, switching struct inode to struct
btrfs_node for structures and related functions in the io path, removing
some indirect function calls and typedefs.

David Sterba (40):
  btrfs: change how repair action is passed to btrfs_repair_one_sector
  btrfs: drop parameter compression_type from
    btrfs_submit_dio_repair_bio
  btrfs: change how submit bio callback is passed to btrfs_wq_submit_bio
  btrfs: simplify btree_submit_bio_start and btrfs_submit_bio_start
    parameters
  btrfs: switch async_submit_bio::inode to btrfs_inode
  btrfs: pass btrfs_inode to btrfs_submit_bio_start
  btrfs: pass btrfs_inode to btrfs_submit_bio_start_direct_io
  btrfs: pass btrfs_inode to btrfs_wq_submit_bio
  btrfs: pass btrfs_inode to btrfs_submit_metadata_bio
  btrfs: pass btrfs_inode to btrfs_submit_data_write_bio
  btrfs: pass btrfs_inode to btrfs_submit_data_read_bio
  btrfs: pass btrfs_inode to btrfs_submit_dio_repair_bio
  btrfs: pass btrfs_inode to submit_one_bio
  btrfs: pass btrfs_inode to btrfs_repair_one_sector
  btrfs: switch btrfs_dio_private::inode to btrfs_inode
  btrfs: pass btrfs_inode to btrfs_submit_dio_bio
  btrfs: pass btrfs_inode to btrfs_truncate
  btrfs: pass btrfs_inode to btrfs_inode_lock
  btrfs: pass btrfs_inode to btrfs_inode_unlock
  btrfs: pass btrfs_inode to btrfs_dirty_inode
  btrfs: pass btrfs_inode to btrfs_add_delalloc_inodes
  btrfs: switch btrfs_writepage_fixup::inode to btrfs_inode
  btrfs: pass btrfs_inode to btrfs_check_data_csum
  btrfs: pass btrfs_inode to __unlink_start_trans
  btrfs: pass btrfs_inode to btrfs_delete_subvolume
  btrfs: drop private_data parameter from extent_io_tree_init
  btrfs: switch extent_io_tree::private_data to btrfs_inode and rename
  btrfs: pass btrfs_inode to btrfs_merge_delalloc_extent
  btrfs: pass btrfs_inode to btrfs_set_delalloc_extent
  btrfs: pass btrfs_inode to btrfs_split_delalloc_extent
  btrfs: pass btrfs_inode to btrfs_clear_delalloc_extent
  btrfs: pass btrfs_inode to btrfs_unlink_subvol
  btrfs: pass btrfs_inode to btrfs_inode_by_name
  btrfs: pass btrfs_inode to fixup_tree_root_location
  btrfs: pass btrfs_inode to inode_tree_add
  btrfs: pass btrfs_inode to btrfs_inherit_iflags
  btrfs: switch async_chunk::inode to btrfs_inode
  btrfs: use btrfs_inode inside compress_file_range
  btrfs: use btrfs_inode inside btrfs_verify_data_csum
  btrfs: pass btrfs_inode to btrfs_add_delayed_iput

 fs/btrfs/btrfs_inode.h           |  29 +-
 fs/btrfs/compression.c           |   6 +-
 fs/btrfs/defrag.c                |  12 +-
 fs/btrfs/delayed-inode.c         |   4 +-
 fs/btrfs/disk-io.c               |  52 ++--
 fs/btrfs/disk-io.h               |  15 +-
 fs/btrfs/extent-io-tree.c        |  35 ++-
 fs/btrfs/extent-io-tree.h        |   6 +-
 fs/btrfs/extent_io.c             |  35 +--
 fs/btrfs/extent_io.h             |  11 +-
 fs/btrfs/file.c                  |  48 ++--
 fs/btrfs/free-space-cache.c      |   4 +-
 fs/btrfs/inode.c                 | 445 +++++++++++++++----------------
 fs/btrfs/ioctl.c                 |  10 +-
 fs/btrfs/ordered-data.c          |   2 +-
 fs/btrfs/reflink.c               |   4 +-
 fs/btrfs/relocation.c            |  11 +-
 fs/btrfs/tests/btrfs-tests.c     |   2 +-
 fs/btrfs/tests/extent-io-tests.c |   4 +-
 fs/btrfs/transaction.c           |   4 +-
 fs/btrfs/tree-log.c              |  24 +-
 fs/btrfs/volumes.c               |   3 +-
 include/trace/events/btrfs.h     |  27 +-
 23 files changed, 393 insertions(+), 400 deletions(-)

-- 
2.37.3

