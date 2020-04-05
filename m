Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888D719EDE6
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 22:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgDEUPt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 16:15:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgDEUPt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 16:15:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00A96ABCC
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Apr 2020 20:15:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F15BFDA726; Sun,  5 Apr 2020 22:15:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.6
Date:   Sun,  5 Apr 2020 22:15:10 +0200
Message-Id: <20200405201510.13790-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.6 have been released.

The version 5.5 got skipped to keep numbers in sync with kernel. The are some
new features, minor enhancements and fixes for bugs that were reported long
time ago. I'd like to get back to more frequent updates so at least the fixes
are not stalled behind the major release. There are many patches in the
mailinglist, as usual, reviews and merging will continue.

Changelog:

  * inspect logical-resolve: support LOGICAL_INO_V2 as new option '-o',
    helps advanced dedupe tools
  * inspect: user larger buffer (64K) for results
  * subvol delete: support deletion by id (requires kernel 5.7+)
  * libbtrfsutil:
    * support subvolume deletion by id
    * bump version to 1.2
    * library symbols are now versioned
  * dump-tree: new option --hide-names, replace any names (file, directory,
    subvolume, xattr) in the output with stubs
  * convert: warn if the filesystem is not mountable on the machine
  * fixes:
    * restore: proper mirror iteration on decompression error
    * restore: make symlink messages less noisy
    * check: handle holes at the begining or end of file
    * fix xxhash output on big endian machines
    * receive: fix lookup of subvolume by uuid in case it was already
      received before
  * other:
    * new and updated tests
    * add missing binaries in exported testsuite
    * docs updates
    * remove obsolete files
    * move files to more appropriate directories
    * fixes reported by valgrind
    * many typos fixed

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Adam Borowski (2):
      btrfs-progs: check: typo in an error message: "boudnary"
      btrfs-progs: lots of typo fixes (codespell)

Alex deBeus (1):
      btrfs-progs: props: fix typo in help text

Anand Jain (1):
      btrfs-progs: convert, warn if converting a fs which won't mount

David Sterba (22):
      btrfs-progs: docs: update scrub
      btrfs-progs: docs: clarify filesystem sync and subvolume cleaning
      libbtrfsutil: add list of exported symbols for version 1.1.1
      libbtrfsutil: bump version to 1.2
      btrfs-progs: docs: dump-tree, fix formatting of --dfs/--bfs
      btrfs-progs: dump-tree: rename to option to --hide-names
      btrfs-progs: remove hasher.c
      btrfs-progs: fix build of quick-test
      btrfs-progs: remove obsolete tool bcp
      btrfs-progs: move library-test.c to tests/
      btrfs-progs: move ioctl-test.c to tests/
      btrfs-progs: move delayed-ref.[ch] to kernel-shared/
      btrfs-progs: move free-space-tree.[ch] to kernel-shared/
      btrfs-progs: move common-defs to common/
      btrfs-progs: move name hashing functions to ctree.h and delete hash.h
      btrfs-progs: tests: add run_mayfail_stdout helper
      btrfs-progs: tests: check if subvolume delete by id is supported
      btrfs-progs: build: add target for check lowmem mode
      btrfs-progs: misc-tests/039: cleanup test
      btrfs-progs: README: list third-party source repositories
      btrfs-progs: update CHANGES for 5.6
      Btrfs progs v5.6

Goffredo Baroncelli (2):
      btrfs-progs: complete the implementation RAID1C34 definitions
      btrfs-progs: Add BTRFS_EXTENDED_PROFILE_MASK mask

Josef Bacik (3):
      btrfs-progs: fix check to catch gaps at the start of the file
      btrfs-progs: fix lowmem check's handling of holes
      btrfs-progs: fix hole error output in fsck

Long An (1):
      btrfs-progs: tests: fix path of btrfs-corrupt-block

Marcos Paulo de Souza (15):
      btrfs-progs: mkfs-tests: only check supported checksums
      btrfs-progs: misc-test: 034: Call "udevmadm settle" before mount
      btrfs-progs: Include btrfs-find-root and btrfs-select-super in testsuite
      btrfs-progs: tests: misc: find-root and select-super are internal commands
      btrfs-progs: mkfs-tests: skip test if truncate fails with EFBIG
      btrfs-progs: define IOC_SNAP_DESTROY_V2
      libbtrfsutil: add support for IOC_SNAP_DESTROY_V2
      btrfs-progs: subvol delete: add --subvolid argument to deletee by id
      btrfs-progs: tests: add subvolume delete by id
      btrfs-progs: tests: Add check for dm targets
      btrfs-progs: tests: mkfs/017: check dm target support
      btrfs-progs: tests: mkfs/005: check for dm-linear
      btrfs-progs: tests: skip tests if dmsetup is not available
      btrfs-progs: qgroup-verify: Remove duplicated message in report_qgroups
      btrfs-progs: restore: avoid SYMLINK messages by default

Michael Lass (1):
      btrfs-progs: qgroup: allow passing options to qgroup remove

Nikolay Borisov (2):
      btrfs-progs: tests: Extend metadata uuid testcase
      btrfs-progs: fix xxhash on big endian machines

Omar Sandoval (3):
      btrfs-progs: receive: remove commented out transid checks
      btrfs-progs: receive: don't lookup clone root for received subvolume
      btrfs-progs: tests: add test for receiving clone from duplicate subvolume

Qu Wenruo (11):
      btrfs-progs: disk-io: do proper error handling in in write_and_map_eb()
      btrfs-progs: dump-tree: Introduce --nofilename option
      btrfs-progs: restore: Do proper mirror iteration in copy_one_extent()
      btrfs-progs: check/lowmem: Fix access on uninitialized memory
      btrfs-progs: tests/common: Don't call INSTRUMENT on mount command
      btrfs-progs: check/original: Fix uninitialized stack memory access for deal_root_from_list()
      btrfs-progs: check/original: Fix uninitialized memory for newly allocated data_backref
      btrfs-progs: check/original: Fix uninitialized return value from btrfs_write_dirty_block_groups()
      btrfs-progs: check/original: Fix uninitialized extent buffer contents
      btrfs-progs: extent-tree: Fix wrong post order rb tree cleanup for block groups
      btrfs-progs: check: sanitize the return value for qgroup error

Stefan (1):
      btrfs-progs: docs: fix minor typos

Su Yue (10):
      btrfs-progs: handle error if btrfs_write_one_block_group() failed
      btrfs-progs: block-group: add rb-tree related memebers
      btrfs-progs: port block group cache tree insertion and lookup functions
      btrfs-progs: rename parameter for block group search mode
      btrfs-progs: factor out inserting new block group
      btrfs-progs: block-group: add dirty_bgs list related memebers
      btrfs-progs: pass @trans to functions working with dirty block groups
      btrfs-progs: reform block groups caches structure
      btrfs-progs: cleanups after block group cache refactoring
      btrfs-progs: misc-tests/034: reload btrfs module before running failure_recovery

Zygo Blaxell (7):
      btrfs-progs: ioctl-test: add LOGICAL_INO_V2
      libbtrfsutil: add LOGICAL_INO_V2
      btrfs-progs: add LOGICAL_INO_V2 to ioctl.h
      btrfs-progs: inspect: add support for LOGICAL_INO_V2 ioctl
      btrfs-progs: inspect: increase logical-resolve default buffer size to 64K
      btrfs-progs: inspect-internal: document new logical-resolve options and kernel requirements
      btrfs-progs: inspect: make sure LOGICAL_INO_V2 args are zero-initialized

