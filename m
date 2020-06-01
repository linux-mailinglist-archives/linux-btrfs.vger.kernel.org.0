Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987D91EA6FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgFAPhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFAPht (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CE23B1EF;
        Mon,  1 Jun 2020 15:37:48 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 00/46] Trivial BTRFS_I removal
Date:   Mon,  1 Jun 2020 18:36:58 +0300
Message-Id: <20200601153744.31891-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are 4 dozen patches that "bubble up" the usage of BTRFS_I from internal
functions towards the external interfaces. Still far away from a complete
cleanup but a step in the right direction. The primary goal is to unify the
internal interfaces by always taking btrfs_inode and only use vfs_inode where
it makes sense. Also reduce the clutter and line lenghts that BTRFS_I brings.

Despite being trivial I tested the series with xfstest and found no regressions
compared to current misc-next.

As a bonus, this series also results in a slight, overall, code decrease:

add/remove: 0/0 grow/shrink: 26/37 up/down: 301/-349 (-48)
Function                                     old     new   delta
btrfs_fallocate                             4371    4426     +55
btrfs_run_delalloc_range                    1201    1232     +31
writepage_delalloc                           325     345     +20
btrfs_dio_iomap_begin                       1838    1856     +18
cow_file_range_inline.constprop             1738    1753     +15
btrfs_truncate_block                        1246    1261     +15
btrfs_test_inodes                           2238    2253     +15
btrfs_submit_direct                         1249    1263     +14
__btrfs_write_out_cache                     1126    1140     +14
submit_compressed_extents                   1161    1174     +13
btrfs_qgroup_reserve_data                    718     729     +11
__btrfs_qgroup_release_data                  789     799     +10
btrfs_submit_compressed_write                854     863      +9
btrfs_finish_ordered_io                     1994    2003      +9
btrfs_submit_bio_start_direct_io              24      31      +7
btrfs_submit_bio_start                        23      30      +7
btrfs_evict_inode                           1324    1331      +7
btrfs_dio_private_put                        150     157      +7
btrfs_find_ordered_sum                       378     383      +5
cache_save_setup                             911     915      +4
btrfs_submit_bio_hook                        372     376      +4
btrfs_drop_extents                           128     132      +4
extent_clear_unlock_delalloc                 105     108      +3
compress_file_range                         2064    2066      +2
btrfs_dio_iomap_end                          295     296      +1
__UNIQUE_ID_file828                           26      27      +1
btrfs_reloc_clone_csums                      258     257      -1
btrfs_qgroup_check_reserved_leak.cold         42      41      -1
btrfs_punch_hole_range                      2048    2047      -1
btrfs_dec_test_first_ordered_pending         550     549      -1
btrfs_csum_one_bio                          1268    1267      -1
cluster_pages_for_defrag                    1896    1894      -2
btrfs_invalidatepage                         725     723      -2
get_extent_allocation_hint                   147     144      -3
btrfs_check_data_free_space                  154     151      -3
__btrfs_add_ordered_extent                  1378    1375      -3
btrfs_qgroup_check_reserved_leak             210     206      -4
btrfs_free_reserved_data_space                98      94      -4
btrfs_destroy_inode                          502     498      -4
btrfs_delalloc_reserve_space                 103      99      -4
__extent_writepage_io.cold                    48      44      -4
btrfs_create_dio_extent                      198     193      -5
btrfs_buffered_write.isra                   1898    1892      -6
prealloc_file_extent_cluster                 549     542      -7
btrfs_log_changed_extents.isra              2799    2792      -7
btrfs_dirty_pages                            677     670      -7
btrfs_delalloc_release_space                  65      58      -7
__extent_writepage_io                        893     885      -8
insert_reserved_file_extent.constprop        740     730     -10
fallback_to_cow                             1060    1050     -10
btrfs_save_ino_cache                        1600    1590     -10
__btrfs_prealloc_file_range                 1185    1175     -10
btrfs_free_reserved_data_space_noquota       642     631     -11
create_io_em                                 347     334     -13
btrfs_writepage_fixup_worker                 954     940     -14
btrfs_page_mkwrite                          1336    1322     -14
relocate_file_extent_cluster                1237    1221     -16
copy_inline_to_page                          742     724     -18
__endio_write_update_ordered                 333     313     -20
__btrfs_drop_extents                        3744    3720     -24
run_delalloc_nocow                          2538    2512     -26
__extent_writepage                          1022     992     -30
cow_file_range                              1034     996     -38
Total: Before=1080235, After=1080187, chg -0.00%

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

