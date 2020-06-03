Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5B1EC90D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgFCFzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:42366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgFCFzx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B534CAF9C;
        Wed,  3 Jun 2020 05:55:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 00/46] Trivial BTRFS_I removal
Date:   Wed,  3 Jun 2020 08:55:00 +0300
Message-Id: <20200603055546.3889-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

V2 with purely cosmetic changes in the line length of some patches' changelogs.

For the cover letter of substance for this series check v1 [0] cover letter.

[0] https://lore.kernel.org/linux-btrfs/SN4PR0401MB3598824C8AE02453F8ABD61A9B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com/T/#t

Nikolay Borisov (46):
  btrfs: Make __btrfs_add_ordered_extent take struct btrfs_inode
  btrfs: Make get_extent_allocation_hint take btrfs_inode
  btrfs: Make btrfs_lookup_ordered_extent take btrfs_inode
  btrfs: Make btrfs_reloc_clone_csums take btrfs_inode
  btrfs: Make create_io_em take btrfs_inode
  btrfs: Make extent_clear_unlock_delalloc take btrfs_inode
  btrfs: Make btrfs_csum_one_bio takae btrfs_inode
  btrfs: Make __btrfs_drop_extents take btrfs_inode
  btrfs: Make qgroup_free_reserved_data take btrfs_inode
  btrfs: Make __btrfs_qgroup_release_data take btrfs_inode
  btrfs: Make btrfs_qgroup_free_data take btrfs_inode
  btrfs: Make cow_file_range_inline take btrfs_inode
  btrfs: Make btrfs_add_ordered_extent take btrfs_inode
  btrfs: Make cow_file_range take btrfs_inode
  btrfs: Make btrfs_add_ordered_extent_compress take btrfs_inode
  btrfs: Make btrfs_submit_compressed_write take btrfs_inode
  btrfs: Make submit_compressed_extents take btrfs_inode
  btrfs: Make btrfs_qgroup_release_data take btrfs_inode
  btrfs: Make insert_reserved_file_extent take btrfs_inode
  btrfs: Make fallback_to_cow take btrfs_inode
  btrfs: Make run_delalloc_nocow take btrfs_inode
  btrfs: Make cow_file_range_async take btrfs_inode
  btrfs: Make btrfs_dec_test_first_ordered_pending take btrfs_inode
  btrfs: Make __endio_write_update_ordered take btrfs_inode
  btrfs: Make btrfs_cleanup_ordered_extents take btrfs_inode
  btrfs: Make inode_can_compress take btrfs_inode
  btrfs: Make inode_need_compress take btrfs_inode
  btrfs: Make need_force_cow take btrfs_inode
  btrfs: Make btrfs_run_delalloc_range take btrfs_inode
  btrfs: Make btrfs_add_ordered_extent_dio take btrfs_inode
  btrfs: Make btrfs_create_dio_extent take btrfs_inode
  btrfs: Make btrfs_new_extent_direct take btrfs_inode
  btrfs: Make __extent_writepage_io take btrfs_inode
  btrfs: Make writepage_delalloc take btrfs_inode
  btrfs: Make btrfs_set_extent_delalloc take btrfs_inode
  btrfs: Make btrfs_dirty_pages take btrfs_inode
  btrfs: Make btrfs_qgroup_reserve_data take btrfs_inode
  btrfs: Make btrfs_free_reserved_data_space_noquota take btrfs_fs_info
  btrfs: Make btrfs_free_reserved_data_space take btrfs_inode
  btrfs: Make btrfs_delalloc_release_space take btrfs_inode
  btrfs: Make btrfs_check_data_free_space take btrfs_inode
  btrfs: Make btrfs_delalloc_reserve_space take btrfs_inode
  btrfs: Remove BTRFS_I calls in btrfs_writepage_fixup_worker
  btrfs: Make prealloc_file_extent_cluster take btrfs_inode
  btrfs: make btrfs_set_inode_last_trans take btrfs_inode
  btrfs: Make btrfs_qgroup_check_reserved_leak take btrfs_inode

 fs/btrfs/block-group.c       |   3 +-
 fs/btrfs/compression.c       |  10 +-
 fs/btrfs/compression.h       |   4 +-
 fs/btrfs/ctree.h             |  14 +-
 fs/btrfs/delalloc-space.c    |  33 ++--
 fs/btrfs/delalloc-space.h    |  12 +-
 fs/btrfs/extent_io.c         |  32 ++--
 fs/btrfs/extent_io.h         |   2 +-
 fs/btrfs/file-item.c         |   4 +-
 fs/btrfs/file.c              |  73 ++++----
 fs/btrfs/free-space-cache.c  |   5 +-
 fs/btrfs/inode-map.c         |   3 +-
 fs/btrfs/inode.c             | 351 +++++++++++++++++------------------
 fs/btrfs/ioctl.c             |   8 +-
 fs/btrfs/ordered-data.c      |  38 ++--
 fs/btrfs/ordered-data.h      |  10 +-
 fs/btrfs/qgroup.c            |  49 +++--
 fs/btrfs/qgroup.h            |  12 +-
 fs/btrfs/reflink.c           |  11 +-
 fs/btrfs/relocation.c        |  32 ++--
 fs/btrfs/tests/inode-tests.c |  14 +-
 fs/btrfs/transaction.h       |  12 +-
 fs/btrfs/tree-log.c          |   4 +-
 23 files changed, 369 insertions(+), 367 deletions(-)

--
2.17.1

