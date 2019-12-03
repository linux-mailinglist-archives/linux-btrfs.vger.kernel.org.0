Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3F1101B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLCQBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 11:01:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:48652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfLCQBU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 11:01:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D1236A21A
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2019 16:01:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33A15DA7D9; Tue,  3 Dec 2019 17:01:12 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.4
Date:   Tue,  3 Dec 2019 17:01:11 +0100
Message-Id: <20191203160111.17341-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.4 have been released.

The new checksum algorithms support will be one release earlier than in kernel
to make it easier to test, same for the raid1c34 feature. Otherwise, there are
some nice improvements in check and image.

Changelog:

  * support new hash algorithms (kernel 5.5):
    * mkfs.btrfs and btrfs-convert with --csum, crc32c, xxhash, sha256, blake2
  * mkfs: support new raid1c3 and raid1c4 block group profiles (kernel 5.5)
  * check:
    * --repair delays start with a warning, can be skipped using --force
    * enhanced detetion of inode types from partial data, more options for
      repair
  * receive: fix quiet option
  * image: speed up chunk loading
  * fi usage:
    * sort devices by id
    * print ratio of used/total per block group type
  * rescue zero-log: reset the log pointers directly, avoid reading some other
    potentially damaged structures
  * new make target install-static to install only static binaries/libraries
  * other
    * docs updates
    * new tests
    * cleanups and refactoring

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:
Alexandru Ungureanu (1):
      btrfs-progs: docs: add example for replacing an online drive

Anand Jain (3):
      btrfs-progs: receive: make option quiet work
      btrfs-progs: balance start: fix usage add long verbose
      btrfs-progs: balance status: fix usage show long verbose

David Sterba (33):
      btrfs-progs: add xxhash sources v0.7.1
      btrfs-progs: build: clean temporary files in crypto/
      btrfs-progs: move sha256 from tests to crypto/
      btrfs-progs: constify and reduce csum definition table
      btrfs-progs: add crc32c to hash wrappers
      btrfs-progs: use hash wrapper for crc32c in btrfs_csum_data
      btrfs-progs: crypto: add hash speedtest utility
      btrfs-progs: add blake2b reference implementation
      btrfs-progs: add blake2b support
      btrfs-progs: add SHA256 to hash-speedtest
      btrfs-progs: add BLAKE2 to hash-speedtest
      btrfs-progs: ci: use newer image base on travis
      btrfs-progs: README: add gitlab CI/CD status badge
      btrfs-progs: move parse_csum_type to utils
      btrfs-progs: convert: add option for checksum type
      btrfs-progs: tests: enhance mkfs option injection
      btrfs-progs: tests: enhance convert option injection
      btrfs-progs: tests: remove unused variables in common
      btrfs-progs: docs: document checksum options for mkfs and convert
      btrfs-progs: docs: switch btrfs(5) to auto-numbered list
      btrfs-progs: docs: checksum algorithms
      btrfs-progs: docs: document new --repair --force behaviour
      btrfs-progs: docs: update check modes
      btrfs-progs: fi usage: sort table by device id
      btrfs-progs: add support for raid1c3 and raid1c4
      btrfs-progs: tests: add raid1c34 to basic mkfs tests
      btrfs-progs: tests: add tests for checksums
      btrfs-progs: docs: update mkfs blockgroup description
      btrfs-progs: build: document install targets
      btrfs-progs: build: optional dependencies for html doc target
      btrfs-progs: fi usage: print ratio of used/total for each chunk type
      btrfs-progs: update CHANGES for 5.4
      Btrfs progs v5.4

Fabrice Fontaine (1):
      btrfs-progs: build: install static library and headers in install-static

Johannes Thumshirn (4):
      btrfs-progs: add xxhash64 to mkfs
      btrfs-progs: move crc32c implementation to crypto/
      btrfs-progs: add sha256 as supported checksumming algorithm
      btrfs-progs: check: warn users about the possible dangers of --repair

Marcos Paulo de Souza (3):
      btrfs-progs: utils: Replace __attribute__(fallthrough)
      btrfs-progs: Makefile: Add -Wimplicit-fallthrough
      btrfs-progs: docs: clarify the default list sort order of subvolumes

Merlin Büge (1):
      btrfs-progs: small fixes/cleanup in Documentation

Nikolay Borisov (5):
      btrfs-progs: corrupt-block: Refactor tree block corruption code
      btrfs-progs: tests: Test backup root retention logic
      btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk
      btrfs-progs: Remove type argument from btrfs_alloc_data_chunk
      btrfs-progs: Remove convert param from btrfs_alloc_data_chunk

Qu Wenruo (24):
      btrfs-progs: image: Output error message for chunk tree build error
      btrfs-progs: image: Fix error output to show correct return value
      btrfs-progs: image: Don't waste memory when we're just extracting super block
      btrfs-progs: image: Allow restore to record system chunk ranges for later usage
      btrfs-progs: image: determine if a tree block is in the range of system chunks
      btrfs-progs: image: Rework how we search chunk tree blocks
      btrfs-progs: check: Export btrfs_type_to_imode
      btrfs-progs: check: find imode using info from INODE_REF item
      btrfs-progs: check: Make repair_imode_common() handle inodes in subvolume trees
      btrfs-progs: check/lowmem: Repair bad imode early
      btrfs-progs: check/original: Fix inode mode in subvolume trees
      btrfs-progs: tests: Add new images for inode mode repair functionality
      btrfs-progs: check/lowmem: Add check and repair for invalid inode generation
      btrfs-progs: check/original: Add check and repair for invalid inode generation
      btrfs-progs: test: tests: Add test image for invalid inode generation repair
      btrfs-progs: Refactor excluded extent functions to use fs_info
      btrfs-progs: Refactor btrfs_read_block_groups()
      btrfs-progs: Replace btrfs_block_group_cache::item with dedicated members
      btrfs-progs: Reduce error level from error to warning for OPEN_CTREE_PARTIAL
      btrfs-progs: rescue/zero-log: Manually write all supers to handle extent tree error more gracefully
      btrfs-progs: check/lowmem: Fix a false alert on uninitialized value
      libbtrfsutil: Convert to designated initialization for BtrfsUtilError_type
      libbtrfsutil: Convert to designated initialization for QgroupInherit_type
      libbtrfsutil: Convert to designated initialization for SubvolumeIterator_type

Su Yue (2):
      btrfs-progs: mkfs-tests/005: check global prereq for dmsetup
      btrfs-progs: add comments of block group lookup functions
