Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29FD2568
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfJJI7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 04:59:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388632AbfJJI7i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 04:59:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 536D5B197
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 08:59:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: [PULL REQUEST] btrfs-progs: For next merge window
Date:   Thu, 10 Oct 2019 16:59:32 +0800
Message-Id: <20191010085932.39105-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/for_next
Which is based on devel branch, with the following HEAD:

commit d928fcabc8aed32b5ccab71220abcff9bffac377 (david/devel)
Author: David Sterba <dsterba@suse.com>
Date:   Mon Oct 7 18:23:52 2019 +0200

    btrfs-progs: add BLAKE2 to hash-speedtest

Please note that, for some binary test images, the patch from patchwork
doesn't apply correctly and would cause empty files. Not sure if it's
abug of patchwork.

This patchset contains the following changes:

- image
  * Proper error message for chunk tree build
  * Fix error message for restore
  * Reduce memory usage for compressed image restore
  * Speed up chunk tree build for restore

- check
  * check and repair bad inode mode in subvolume trees
  * check and repair inode generation

- receive
  * Fix receiving clone from duplicate subvolume

- tests
  * Check kernel and btrfs-progs support for zstd for zstd related tests

For receive and tests part, they are just unmerged patches.

For image, most of the patches from the btrfs-image data dump patchset,
but they are independent from data dump. So they are included in this batch.

For check, those patches are just result of user reports triggered by
tree-checker, all include report and repair functionality and test images.

The following selftests pass (with my tsukkomi):

- fsck
  The fastest test, and everyone loves fast tests.

- mkfs
  Ordinary but good tests.

- convert
  Slow and boring. But A good test of one's patience.

- misc
  The most thrilling tests. No one notices a regression until this test
  fails.

- fuzz
  It can always catch you unexpectedly.

Johannes Thumshirn (1):
  btrfs-progs: fix zstd compression test on a kernel without ztsd
    support

Omar Sandoval (3):
  btrfs-progs: receive: remove commented out transid checks
  btrfs-progs: receive: don't lookup clone root for received subvolume
  btrfs-progs: tests: add test for receiving clone from duplicate
    subvolume

Qu Wenruo (15):
  btrfs-progs: image: Output error message for chunk tree build error
  btrfs-progs: image: Fix error output to show correct return value
  btrfs-progs: image: Don't waste memory when we're just extracting
    super block
  btrfs-progs: image: Allow restore to record system chunk ranges for
    later usage
  btrfs-progs: image: Introduce helper to determine if a tree block is
    in the range of system chunks
  btrfs-progs: image: Rework how we search chunk tree blocks
  btrfs-progs: check: Export btrfs_type_to_imode
  btrfs-progs: check/common: Introduce a function to find imode using
    info from INODE_REF item
  btrfs-progs: check/common: Make repair_imode_common() to handle inodes
    in subvolume trees
  btrfs-progs: check/lowmem: Repair bad imode early
  btrfs-progs: check/original: Fix inode mode in subvolume trees
  btrfs-progs: tests/fsck: Add new images for inode mode repair
    functionality
  btrfs-progs: check/lowmem: Add check and repair for invalid inode
    generation
  btrfs-progs: check/original: Add check and repair for invalid inode
    generation
  btrfs-progs: fsck-tests: Add test image for invalid inode generation
    repair

 check/main.c                                  | 104 +++--
 check/mode-common.c                           | 262 +++++++++++-
 check/mode-common.h                           |  17 +
 check/mode-lowmem.c                           | 115 ++++++
 check/mode-original.h                         |   1 +
 cmds/receive.c                                |  43 +-
 image/main.c                                  | 382 +++++++++++++-----
 .../039-bad-inode-mode/.lowmem_repairable     |   0
 .../bad_free_space_cache_imode.raw.xz}        | Bin
 .../bad_imodes_in_subvolume_tree.img.xz       | Bin 0 -> 2956 bytes
 .../.lowmem_repairable                        |   0
 .../bad_inode_geneartion.img.xz               | Bin 0 -> 2012 bytes
 tests/misc-tests/025-zstd-compression/test.sh |  10 +
 .../test.sh                                   |  34 ++
 14 files changed, 790 insertions(+), 178 deletions(-)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable
 rename tests/fsck-tests/{039-bad-free-space-cache-inode-mode/test.raw.xz => 039-bad-inode-mode/bad_free_space_cache_imode.raw.xz} (100%)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/bad_imodes_in_subvolume_tree.img.xz
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.xz
 create mode 100755 tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh

-- 
2.23.0

