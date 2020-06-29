Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7652A20E8EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgF2Wui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 18:50:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:32834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgF2Wui (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 18:50:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8507CABCE
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 22:50:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 235FADA732; Tue, 30 Jun 2020 00:50:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs pre-release 5.7-rc1
Date:   Tue, 30 Jun 2020 00:50:18 +0200
Message-Id: <20200629225018.29280-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a pre-release of btrfs-progs, 5.7-rc1.

The proper release is scheduled to Thursday, +3 days (2020-07-02).

Changelog:

  * check:
    * detect ranges with overlapping csum items
  * mkfs:
    * new option to enable features otherwise enabled at runtime, now
      implemented for quotas, 'mkfs.btrfs -R quota'
    * fix space accounting for small image, DUP and --rootdir
  * fi usage:
    * report correct numbers when plain RAID56 profiles are used
  * convert: ensure the data chunks size never exceed device size
  * libbtrfsutil: update documentation regarding subvolume deletion
  * build: support libkcapi as implementation backend for cryptographic
    primitives
  * core: global options for verbosity (-v, -q), subcommands -v or -q are
    aliases and will continue to work but are considered deprecated,
    default command output is preserved to keep scripts working
  * other:
    * block group code cleanups
    * build warning fixes
    * more files moved to kernel-shared
    * btrfs-debugfs ported to python 3
    * documentation updates
    * new tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Anand Jain (24):
      btrfs-progs: split global help HELPINFO_INSERT_GLOBALS
      btrfs-progs: add global verbose and quiet options and helper functions
      btrfs-progs: send: add global verbose and quiet options
      btrfs-progs: receive: add global verbose and quiet options
      btrfs-progs: subvolume delete: add global verbose option
      btrfs-progs: fi defrag: add global verbose option
      btrfs-progs: balance start: add global verbose option
      btrfs-progs: balance status: add global verbose option
      btrfs-progs: chunk-recover: add global verbose option
      btrfs-progs: super-recover: add global verbose option
      btrfs-progs: restore: add global verbose option
      btrfs-progs: inspect inode-resolve: add global verbose
      btrfs-progs: inspect logical-resolve: add global verbose option
      btrfs-progs: refactor btrfs_scan_devices() to accept verbose argument
      btrfs-progs: device scan: add global verbose option
      btrfs-progs: device scan: add global quiet option
      btrfs-progs: quota rescan: add global quiet option
      btrfs-progs: subvolume create: add global quiet option
      btrfs-progs: subvolume delete: add global quiet option
      btrfs-progs: balance start: add global quiet option
      btrfs-progs: balance resume: add global quiet option
      btrfs-progs: subvolume snapshot: add global quiet option
      btrfs-progs: scrub start, resume: add global quiet option
      btrfs-progs: scrub cancel: add global quiet option

David Sterba (22):
      btrfs-progs: docs: update 'fi us' examples
      btrfs-progs: build: add support for libkcapi as crypto backend
      btrfs-progs: move dir-item.c to kernel-shared/
      btrfs-progs: move file-item.c to kernel-shared/
      btrfs-progs: move inode-item.c to kernel-shared/
      btrfs-progs: move root-tree.c to kernel-shared/
      btrfs-progs: move uuid-tree.c to kernel-shared/
      btrfs-progs: move btrfs_find_free_objectid to inode.c
      btrfs-progs: docs: update list of features exported in sysfs
      btrfs-progs: docs: clarify file attributes and flags
      btrfs-progs: docs: update balance
      btrfs-progs: docs: update conventions
      btrfs-progs: docs: add discard=async to mount options
      btrfs-progs: docs: remove option logreplay
      btrfs-progs: add separate verbosity level for on-by-default messages
      btrfs-progs: docs: clarify balance regarding extent sharing
      btrfs-progs: fi defrag: clarify recursive mode
      btrfs-progs: docs: update bootloader section
      btrfs-progs: deprecate subcommand specific verbose/quiet options
      btrfs-progs: fixup spacing in help texts
      btrfs-progs: update CHANGES for 5.7
      Btrfs progs v5.7-rc1

Goffredo Baroncelli (1):
      btrfs-progs: fi usage: add support for RAID5/6

Johannes Thumshirn (19):
      btrfs-progs: simplify minimal stripe number checking
      btrfs-progs: simplify assignment of number of RAID stripes
      btrfs-progs: introduce alloc_chunk_ctl structure
      btrfs-progs: cache number of devices for chunk allocation
      btrfs-progs: pass alloc_chunk_ctl to chunk_bytes_by_type
      btrfs-progs: introduce raid profile table for chunk allocation
      btrfs-progs: consolidate assignment of minimal stripe number
      btrfs-progs: consolidate assignment of sub_stripes
      btrfs-progs: consolidate setting of RAID1 stripes
      btrfs-progs: do table lookup for simple RAID profiles' num_stripes
      btrfs-progs: consolidate num_stripes sanity check
      btrfs-progs: compactify num_stripe setting in btrfs_alloc_chunk
      btrfs-progs: introduce init_alloc_chunk_ctl
      btrfs-progs: don't pretend RAID56 has a different stripe length
      btrfs-progs: consolidate num_stripes setting for striping RAID levels
      btrfs-progs: use sub_stripes property from btrfs_raid_attr
      btrfs-progs: use minimal number of stripes from btrfs_raid_attr
      btrfs-progs: remove unused btrfs_raid_profile::max_stripes
      btrfs-progs: remove btrfs_raid_profile_table

Lakshmipathi (1):
      btrfs-progs: port btrfs-debugfs to python3

Qu Wenruo (37):
      btrfs-progs: check: don't exit if maybe_repair_root_item() can't find needed root extent
      btrfs-progs: don't abuse READA_* for extent tree search
      btrfs-progs: sync block group item accessors from kernel
      btrfs-progs: kill block_group_cache::key
      btrfs-progs: remove the unused btrfs_block_group_cache::cache
      btrfs-progs: rename btrfs_block_group_cache to btrfs_block_group
      btrfs-progs: check/lowmem: lookup block group item in a separate function
      btrfs-progs: block-group: refactor how we read one block group item
      btrfs-progs: rename btrfs_remove_block_group() and free_block_group_item()
      btrfs-progs: block-group: refactor how we insert a block group item
      btrfs-progs: block-group: rename write_one_cache_group()
      btrfs-progs: check: detect checksum item overlap
      btrfs-progs: tests: add test image for overlapping csum item
      btrfs-progs: qgroup-verify: avoid NULL pointer dereference for later silent qgroup repair
      btrfs-progs: qgroup-verify: also repair qgroup status version
      btrfs-progs: qgroup-verify: use fs_info::readonly to check if we should repair qgroups
      btrfs-progs: qgroup-verify: move qgroup classification out of report_qgroups
      btrfs-progs: qgroup-verify: allow repair_qgroups to do silent repair
      btrfs-progs: ctree: introduce function to create an empty tree
      btrfs-progs: mkfs: introduce function to insert qgroup info and limit items
      btrfs-progs: mkfs: introduce function to setup quota root and rescan
      btrfs-progs: fsfeatures: introduce runtime features
      btrfs-progs: mkfs: add -R|--runtime-features option
      btrfs-progs: mkfs: introduce quota runtime feature
      btrfs-progs: tests: add test for quotas and --rootdir
      btrfs-progs: allow btrfs_print_leaf to be called on dummy eb
      btrfs-progs: print-tree: export dump_superblock()
      btrfs-progs: tests: update fsck/012-leaf-corruption image
      btrfs-progs: tests: update fsck/035-inline-bad-ram-bytes image
      btrfs-progs: image: Don't modify the chunk and device tree if the source dump is single device
      btrfs-progs: image: pin down log tree blocks before fixup
      btrfs-progs: fix wrong chunk profile for do_chunk_alloc()
      btrfs-progs: mkfs-tests: Add test case to verify the --rootdir size limit
      btrfs-progs: convert: fix the pointer sign warning for ext2 label
      btrfs-progs: fix seemly wrong format overflow warning
      btrfs-progs: convert: ensure the data chunks size never exceed device size
      btrfs-progs: tests: check that convert does not create extents beyond device boundary

cezarmathe (1):
      libbtrfsutil: update btrfs_util_delete_subvolume docs

