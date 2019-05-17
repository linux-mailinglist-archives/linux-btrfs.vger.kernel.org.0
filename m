Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5D21D2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfEQSNa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 14:13:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfEQSNa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 14:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E8D3AE9D
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 18:13:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA62CDA8DC; Fri, 17 May 2019 20:14:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.1
Date:   Fri, 17 May 2019 20:14:27 +0200
Message-Id: <20190517181427.25537-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.1 have been released. The version 5.0 has been skipped.

Changes:

  * check:
    * repair: flush/FUA support to avoid breaking metadata COW
    * file extents repair no longer relies on data in extent tree
    * lowmem: fix false error reports about gaps between extents
    * add inode mode check and repair for various objects
    * add check for invalid combination of nocow/compressed extents
  * device scan: new option to forget scanned devices
  * mkfs: use same chunk size as kernel for initial creation
  * dev-replace: better report when other exclusive operation is running
  * help: for syntax errors on command line, print only the relevant messages,
    not the whole help text
  * receive:
    * new option for quiet mode
    * on -vv print information about written ranges
    * fix endless loop with --dump on an invalid stream
  * defrag: able open files in RO mode (needs kernel support to work)
  * dump-tree: --block can be specified multiple times
  * libbtrfsutil: fix: don't close fd on error in btrfs_util_subvolume_id_fd
  * core:
    * add sync before superblock write
    * better error handling on the transaction commit path
    * try to find best copy when reading tree blocks
    * update backup roots on commit transaction
  * other:
    * fuzz tests pass and are enabled in CI
    * cleanups
    * new tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Adam Borowski (2):
      btrfs-progs: fix kernel version parsing on some versions past 3.0
      btrfs-progs: defrag: open files RO on new enough kernels

Alexander Kovtunenko (1):
      btrfs-progs: receive: set up max_errors count

Anand Jain (4):
      btrfs-progs: device scan: add new option to forget one or all scanned devices
      btrfs-progs: dev replace: check for no result before using results
      btrfs-progs: dev replace: gracefully handle the exclusive operation report
      btrfs-progs: scan: pass blkid_get_cache error code

David Sterba (29):
      btrfs-progs: device scan: constify path argument
      btrfs-progs: device scan: update help text
      btrfs-progs: device scan: update help text
      btrfs-progs: docs: add scan --forget
      btrfs-progs: device scan: update error messages
      btrfs-progs: device: update help texts
      btrfs-progs: help: add helper for unrecognized option error message
      btrfs-progs: help: update messages of argc constraint checkers
      btrfs-progs: help: use unknown command option helper
      btrfs-progs: help: don't print usage on wrong argument counts
      btrfs-progs: prop: let parsing helper return error to the caller
      btrfs-progs: prop: don't print full usage on invalid arguments
      btrfs-progs: prop: return only common error values
      btrfs-progs: find-root: use common usage helper for uknown option
      btrfs-progs: find-root: don't dump usage on wrong argument count
      btrfs-progs: find-root: use the common help infrastructure
      btrfs-progs: qgroup: report unknown option
      btrfs-progs: qgroup: remove unused option handling
      btrfs-progs: qgroup show: report errors while parsing sort string
      btrfs-progs: qgroup show: report unrecognized format of sort string
      btrfs-progs: qgoup: propagate errors from btrfs_qgroup_parse_sort_string
      Merge branch 'pull/qu/v2' into devel from Qu Wenruo (https://github.com/adam900710/btrfs-progs/tree/for_devel)
      btrfs-progs: tests: fix misc/026 to run on NFS
      btrfs-progs: tests: stream dump and max_error counts
      btrfs-progs: tests: update test number of bad-free-space-cache-inode-mode
      btrfs-progs: tests: disable misc-tests/035-receive-common-mount-point-prefix
      btrfs-progs: CI: enable fuzz tests
      btrfs-progs: update CHANGES for v5.1
      Btrfs progs v5.1

Filipe Manana (1):
      Btrfs-progs: receive, add debug information to write and clone commands

Jeff Mahoney (1):
      btrfs-progs: check: fixup_extent_flags needs to deal with non-skinny metadata

Lu Fengqi (2):
      btrfs-progs: lowmem: fix false alert about the existence of gaps in the check_file_extent
      btrfs-progs: tests: add case for inode lose one file extent

Nikolay Borisov (1):
      btrfs-progs: Remove get_argv0_buf

Omar Sandoval (1):
      libbtrfsutil: don't close fd on error in btrfs_util_subvolume_id_fd()

Qu Wenruo (29):
      btrfs-progs: Port kernel fs_devices::total_rw_bytes
      btrfs-progs: Unify metadata chunk size with kernel
      btrfs-progs: check: Fix false alert about uninitialized variable
      btrfs-progs: gitignore: Ignore hidden files
      btrfs-progs: Do metadata preallocation as long as we're not modifying extent tree
      btrfs-progs: inspect-dump-tree: Allow --block to be specified multiple times
      btrfs-progs: Update backup roots when writing super blocks
      btrfs-progs: Free bad extent buffer as soon as possible
      btrfs-progs: Use @fs_info to replace @root for btrfs_check_leaf/node()
      btrfs-progs: Use mirror_num start from 1 to avoid unnecessary retry
      btrfs-progs: Move btrfs_num_copies() call out of the loop in read_tree_block()
      btrfs-progs: disk-io: Try to find a best copy when reading tree blocks
      btrfs-progs: check/lowmem: Add inode mode check
      btrfs-progs: check/original: Add inode mode check
      btrfs-progs: check/lowmem: Repair invalid inode mode in root tree
      btrfs-progs: check/original: Repair invalid inode mode in root tree
      btrfs-progs: check/lowmem: Check and repair free space cache inode mode
      btrfs-progs: check/original: Check and repair free space cache inode item
      btrfs-progs: tests/fsck: Add test image for free space cache mode repair
      btrfs-progs: disk-io: Make super block write error easier to read
      btrfs-progs: disk-io: Flush to ensure super block write is FUA
      btrfs-progs: Don't BUG_ON() when write_dev_supers() fails
      Revert "btrfs-progs: Do metadata preallocation as long as we're not modifying extent tree"
      btrfs-progs: Remove the dead branch in btrfs_run_delayed_refs()
      btrfs-progs: Refactor btrfs_finish_extent_commit()
      btrfs-progs: Handle error properly in btrfs_commit_transaction()
      btrfs-progs: check/lowmem: Add checks for compressed extent without csum
      btrfs-progs: check/original: Add checks for compressed extent without csum
      btrfs-progs: tests: detecting compressed extent without csum

Steven Davies (1):
      btrfs-progs: receive: add option for quiet mode

Su Yanjun (4):
      Revert "btrfs-progs: Add repair and report function for orphan file extent."
      Revert "btrfs-progs: Record orphan data extent ref to corresponding root."
      btrfs-progs: check: fix wrong @offset used in find_possible_backrefs()
      btrfs-progs: check: Delete file extent item with unaligned disk bytenr

Su Yue (7):
      btrfs-progs: lowmem: add argument path to punch_extent_hole()
      btrfs-progs: lowmem: move nbytes check before isize check
      btrfs-progs: lowmem: fix false alert if extent item has been repaired
      btrfs-progs: lowmem: check unaligned disk_bytenr for extent_data
      btrfs-progs: lowmem: rename delete_extent_tree_item() to delete_item()
      btrfs-progs: lowmem: delete unaligned bytes extent data under repair
      btrfs-progs: fsck-test: enable lowmem repair for case 001

