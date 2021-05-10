Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5E3791DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhEJPDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 11:03:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243729AbhEJPB2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 11:01:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620658822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+LHw/EZSEJRuqcx27ELHiGek9yF6WSU6ZYkol4LO4Qk=;
        b=iSUeAlysoyFNhYHT5dthQ2NpmyCUOUp62a7/UzIDK1zILXokCK0TmSmKW6maFYvNKkzeoF
        oAEu8Skry0wqCYzR0/I8KTt5y4GBMv1A+cA3Qq66YUEJgAoakx1NSk0IF0U5xbeIzdVigU
        ScGGwFa5GHbg78c5kDedrotCBvgapgI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05DE0B148
        for <linux-btrfs@vger.kernel.org>; Mon, 10 May 2021 15:00:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20158DB226; Mon, 10 May 2021 16:57:52 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.12
Date:   Mon, 10 May 2021 16:57:52 +0200
Message-Id: <20210510145752.19053-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.12 have been released.

Notable things:

* libbtrfsutil has been relicensed to LGPL v2.1+

* zoned mode support has been added
  * a host-managed device is needed, there are several options how to emulate
    such device (null_blk, TCMU runner, file-backed ZBC device)
  * kernel 5.12+ is needed, during my testing I've hit a lot of bugs or corner
    cases so we're entering the stabilization period
  * https://btrfs.wiki.kernel.org/index.php/Zoned intro, will be updated as
    things get discovered

* travis-ci integration has been disabled, I'd like to find another hosted CI
  but so far none provides a recent kernel so more tests won't pass, last option
  is to self-host some VMs and monitor git, getting just build tests works but
  we need to run the testsuite

Changelog:

  * libbtrfsutil: relicensed to LGPL v2.1+
  * mkfs: zoned mode support (kernel 5.12+)
  * fi df: show zone_unusable per profile type in zoned mode
  * fi usage: show total amount of zone_unusable
  * fi resize: fix message for exact size
  * image: fix warning and enlarge output file if necessary
  * core
    * refactor chunk allocator for more modes
    * implement zoned mode support: allocation and writes, sb log
    * crypto/hash refactoring and cleanups
    * refactoring and cleanups
  * other
    * test updates
    * CI updates
      * travis-ci integration disabled
      * docker images updated, more coverage
    * incomplete build support for Android removed
  * doc updates
    * chattr mode m for 'NOCOMPRESS"
    * swapfile used from fstab
    * how to add a new export to libbtrfsutil
    * update status of mount options since 5.9

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (47):
      btrfs-progs: crypto: add test vectors
      btrfs-progs: tests: add missing variable setup to test-console
      btrfs-progs: factor open_ctree parameters to a structure
      btrfs-progs: crypto: remove unused sha256 definitions
      btrfs-progs: mkfs: remove stale csum_type initialization
      btrfs-progs: build: note about 32bit build on 64bit host
      btrfs-progs: docs: add more general ioctl description
      btrfs-progs: docs: update chattr attribute for NOCOMPRESS
      btrfs-progs: docs: how to use swapfile from fstab
      btrfs-progs: kerncompat: add const_ilog2
      btrfs-progs: add prefix to exported queue_param
      btrfs-progs: add prefix to discard_blocks
      btrfs-progs: add prefix to zero_blocks
      btrfs-progs: add prefix to get_partition_size
      btrfs-progs: update comments for device helpers
      btrfs-progs: remove unused disk_size
      btrfs-progs: add fd version of device_get_partition_size
      btrfs-progs: zoned: replace raw ioctl with a helper for device size
      btrfs-progs: remove unnecessary linux/*.h includes
      btrfs-progs: split open/close helpers from utils.c
      btrfs-progs: build: remove incomplete android support
      btrfs-progs: split unit related helpers from utils.c
      btrfs-progs: mkfs: move btrfs_make_root_dir from utils.c
      btrfs-progs: move repair.[ch] to common/
      libbtrfsutil: move the linker sym file to our directory
      libbtrfsutil: document how to add a new API function
      libbtrfsutil: add warning about autogenerated constants.c
      libbtrfsutil: fix test case class name for python bindings
      btrfs-progs: build: fix zoned detection
      btrfs-progs: ci: disable zoned mode where not working
      btrfs-progs: ci: add docker build and run script
      btrfs-progs: ci: disable travis-ci.org
      btrfs-progs: ci: fix package ordering for tumbleweed image
      btrfs-progs: fi df: report zone_unusable on zoned filesystem
      btrfs-progs: mkfs: indent zone size report in the summary
      btrfs-progs: mkfs: add fallback check for signature
      btrfs-progs: ci: fix docker-run argument parsing
      btrfs-progs: ci: install clang on all images
      btrfs-progs: ci: install static libs to Tumbleweed image
      btrfs-progs: export get_zone_unusable and move to utils.c
      btrfs-progs: fi usage: print zone unusable in the overview
      btrfs-progs: docs: move inode_cache to deprecated options
      btrfs-prog: docs: add recent new mount options and features
      btrfs-progs: delete bogus zero checksum check
      btrfs-progs: use proper array designator for exclop initialization
      btrfs-progs: update CHANGES for 5.12
      Btrfs progs v5.12

Johannes Thumshirn (1):
      btrfs-progs: pass in fs_info to btrfs_csum_data

Naohiro Aota (39):
      btrfs-progs: mark BUG() as unreachable
      btrfs-progs: introduce chunk allocation policy
      btrfs-progs: refactor find_free_dev_extent_start()
      btrfs-progs: convert type of alloc_chunk_ctl::type
      btrfs-progs: consolidate parameter initialization of regular allocator
      btrfs-progs: factor out decide_stripe_size()
      btrfs-progs: factor out create_chunk()
      btrfs-progs: rewrite btrfs_alloc_data_chunk() using create_chunk()
      btrfs-progs: fix to use half the available space for DUP profile
      btrfs-progs: use round_down for allocation calcs
      btrfs-progs: drop alloc_chunk_ctl::stripe_len
      btrfs-progs: simplify arguments of chunk_bytes_by_type()
      btrfs-progs: rename calc_size to stripe_size
      btrfs-progs: utils: introduce queue_param helper function
      btrfs-progs: provide fs_info from btrfs_device
      btrfs-progs: build: check zoned block device support
      btrfs-progs: zoned: add new ZONED feature flag
      btrfs-progs: zoned: get zone information of zoned block devices
      btrfs-progs: zoned: check and enable ZONED mode
      btrfs-progs: zoned: introduce max_zone_append_size
      btrfs-progs: zoned: disallow mixed-bg in ZONED mode
      btrfs-progs: zoned: allow zoned filesystems on non-zoned block devices
      btrfs-progs: zoned: implement log-structured superblock
      btrfs-progs: zoned: implement zoned chunk allocator
      btrfs-progs: zoned: load zone's allocation offset
      btrfs-progs: zoned: implement sequential extent allocation
      btrfs-progs: zoned: calculate allocation offset for conventional zones
      btrfs-progs: zoned: redirty clean extent buffers
      btrfs-progs: zoned: reset zone of freed block group
      btrfs-progs: zoned: support resetting zoned device
      btrfs-progs: zoned: support zero out on zoned block device
      btrfs-progs: zoned: support wiping superblock on sequential write zone
      btrfs-progs: mkfs: detect and enable zoned feature flag
      btrfs-progs: mkfs: zoned: check incompatible features with zoned btrfs
      btrfs-progs: mkfs: tweak initial system block group placement
      btrfs-progs: mkfs: use sbwrite to update superblock in regular and zoned mode
      btrfs-progs: zoned: wipe temporary superblocks in superblock log zone
      btrfs-progs: device add: support adding zoned device
      btrfs-progs: zoned: introduce zoned support for device replace

Neal Gompa (1):
      libbtrfsutil: relicense to LGPLv2.1+

Nikolay Borisov (1):
      btrfs-progs: fix null pointer deref in balance_level

Qu Wenruo (4):
      btrfs-progs: mkfs: only output the warning if the sectorsize is not supported
      btrfs-progs: image: remove the dead stat() call in metadump
      btrfs-progs: image: enlarge output file if no tree modification is needed for restore
      btrfs-progs: tests: add test to ensure the restored image can be mounted

Su Yue (1):
      btrfs-progs: fi resize: fix false 0.00B size output

