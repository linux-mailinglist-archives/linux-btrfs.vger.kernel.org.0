Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B186B2970B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375269AbgJWNfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375119AbgJWNfR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603460116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o6236GSnv36X7JXtMR5UzGVQrbXbIeppCMdHErKtqpo=;
        b=CmNUOX5QyWX5g8uFUbJsxX5N2Tse2hMQ9XaeAExjvmfKFx2BU2OI0uyblkAPNcLd3R1Lg3
        UTpPqkPtmC80mYZHZZrzS7o2PGqB1k6mI2//z0SHE5hXH/AT+uN8e1qSBnbNwEQ+PxsVC+
        tEp6Pjv/mPnQvoP/TwXxe6CQv+YxNHI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAA36ACA3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 13:35:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35B7BDA7F1; Fri, 23 Oct 2020 15:33:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.9
Date:   Fri, 23 Oct 2020 15:33:44 +0200
Message-Id: <20201023133344.1642-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.9 have been released (5.8 skipped).

Changelog:

  * mkfs:
    * switch default to single profile for multi-device filesystem, up to
      now it was raid0 that may not be simple to convert to some other profile
      as raid0 needs a workspace on all device for that
    * new option -R for run-time options (eg. mount time enabled), now
      understands free-space-tree
  * subvolume delete:
    * refuse to delete the default subvolume (kernel will not allow that but
      the error reason is not obvious)
    * warn on EPERM, eg. if send is on progress on the subvolume
  * convert:
    * fix 32bit overflows on large filesystems
    * improved error handling and error messages
    * check free space taking fragmentation into account
  * check:
    * detect and repair wrong inode generation
    * minor improvement in error reporting on roots
  * libbtrfsutils: follow main package versioning (5.9)
    * add pkg-config file definitions
  * python-btrfsutil: follow main package versioning (5.9)
  * inspect tree-stats: print node counts for each level, fanout
  * other:
    * docs:
      * remove obsolete mount options (alloc_start, subvolrootid)
      * deleting default subvolume is not permitted
    * updated or fixed tests
    * .editorconfig updates
    * move files to kernel-shared/
    * CI:
      * updated to use zstd 1.4.5
      * fix reiserfs build
      * more builds with asan, ubsan
    * sb-mod updates
    * build:
      * print .so versions of libraries in configure summary

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Anand Jain (1):
      btrfs-progs: sb-mod: add devid to the modifiable list

Boris Burkov (1):
      btrfs-progs: mkfs: support free space tree as -R option

Daniel Xu (2):
      btrfs-progs: add basic .editorconfig
      btrfs-progs: Update README.md with editorconfig hint

David Sterba (50):
      btrfs-progs: docs: remove deprecated alloc_start and subvolrootid
      btrfs-progs: inspect tree-stats: print number of nodes for each level
      btrfs-progs: docs: note when subvolume cannot be deleted
      btrfs-progs: mkfs: clean up default profile settings
      btrfs-progs: mkfs: switch to single as default profile for multiple-devices
      btrfs-progs: tests: rename mkfs/021-rootdir-size to 022
      btrfs-progs: docs: update profiles
      btrfs-progs: tests: add helper to print skipped operations
      btrfs-progs: tests: fsck/037-freespacetree-repair workaround for missing kernel fix
      btrfs-progs: tree-stats: print average fanout for each level
      btrfs-progs: check: rename global_info
      btrfs-progs: check: replace local fs_info by global fs_info in main.c
      btrfs-progs: check: replace local fs_info by global fs_info in mode-common.c
      btrfs-progs: check: replace local fs_info by global fs_info in mode-lowmem.c
      btrfs-progs: check: drop unused fs_info
      btrfs-progs: tests: skip cli-tests/014 in travis
      btrfs-progs: add flat include switch to send.h
      btrfs-progs: move extent-cache.c to common/
      btrfs-progs: move utils-lib.c to common/
      btrfs-progs: move send-dump.c to cmds/receive-dump.c
      btrfs-progs: move send-stream.c to common/
      btrfs-progs: move send-utils.c to common/
      btrfs-progs: move free-space-tree.c to kernel-shared/
      btrfs-progs: move extent_io.c to kernel-shared/
      btrfs-progs: move extent-tree.c to kernel-shared/
      btrfs-progs: move print-tree.c to kernel-shared/
      btrfs-progs: move disk-io.c to kernel-shared/
      btrfs-progs: move file.c to kernel-shared/
      btrfs-progs: move ctree.c to kernel-shared/
      btrfs-progs: move inode.c to kernel-shared/
      btrfs-progs: move transaction.c to kernel-shared/
      btrfs-progs: move volumes.c to kernel-shared/
      btrfs-progs: merge find-root.c and btrfs-find-root.c
      btrfs-progs: ci: updated zstd version to 1.4.5
      btrfs-progs: ci: fix libreiserfs build
      btrfs-progs: ci: enable free-space-tree for all mkfs tests
      btrfs-progs: ci: install clang unconditionally
      btrfs-progs: tests: add case for deleting default subvolume
      btrfs-progs: subvolume delete: print message for EPERM, possible send in progress
      btrfs-progs: tests: add case for send vs subvolume deletion
      btrfs-progs: sb-mod: add dev_item prefix for sb::device members
      btrfs-progs: sb-mod: add remaining dev_item members
      btrfs-progs: sb-mod: add syntax to the help text
      btrfs-progs: build: print versions for all subprojects in summary
      btrfs-progs: ci: add sanitizer coverage
      libbtrfsutil: let python-btrfsutil version follow main package version
      btrfs-progs: build: provide variables for main package version
      libbtrfsutil: set pkg-config Version to follow main package
      btrfs-progs: update CHANGES for 5.9
      Btrfs progs v5.9

Forza-tng (1):
      btrfs-progs: docs: update limits for minimal device size

Marcos Paulo de Souza (4):
      btrfs-progs: convert: make ASSERT not truncate cctx.total_bytes value
      btrfs-progs: docs: remove nonexistent nousebackuproot option
      btrfs-progs: make btrfs_lookup_dir_index in parity with kernel code
      btrfs-progs: convert: show more info when reserve_space fails

Nikolay Borisov (1):
      btrfs-progs: check: fix error reporting on root inode

Qu Wenruo (9):
      btrfs-progs: convert: prevent 32bit overflow for cctx->total_bytes
      btrfs-progs: tests: add convert test case for multiply overflow
      btrfs-progs: convert: handle errors better in ext2_copy_inodes()
      btrfs-progs: convert: update error message to reflect original fs unmodified cases
      btrfs-progs: convert: report available space before conversion happens
      btrfs-progs: remove the unused variable in check_chunks_and_extents_lowmem()
      btrfs-progs: check/lowmem: add inode transid detect and repair support
      btrfs-progs: check/original: add inode transid detect and repair support
      btrfs-progs: tests: add test image to fsck/043 for inode transid repair

Rafostar (1):
      btrfs-progs: scrub: make scrub status summary easier to read

Sheng Mao (1):
      libbtrfsutil: add pkg-config spec file

Sidong Yang (2):
      btrfs-progs: subvolume: check deleting default subvolume
      btrfs-progs: docs: add qgroup examples

gandalf3 (1):
      btrfs-progs: docs: fix typo in btrfs restore message

