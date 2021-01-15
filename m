Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0EE2F810F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbhAOQoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 11:44:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbhAOQoh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 11:44:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610729036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gYze8oCBtW/Ev+PyUja/PcAw09bfKLoSVaUh2VxqnGs=;
        b=pRMR65pqw/zrFxGPxV/kBdr+ttLI0ZvE8Vln3Lm33SQK20hYMOtFUoZcYSJkoAl1I1PEVq
        wemD7PQG10Zw5Gz7DGoX7DDNGK5r/gjqqt8t/kC73i/VmiYanMXLSjUnLc1iWehWBtIKLR
        Og+Vue2JwjuMCcWUK/OrLHBYKVPfjEg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0223ADE3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 16:43:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AC5ADA7D5; Fri, 15 Jan 2021 17:42:02 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs pre-release 5.10-rc1
Date:   Fri, 15 Jan 2021 17:42:02 +0100
Message-Id: <20210115164202.19431-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a pre-release of btrfs-progs, 5.10-rc1.

The proper release is scheduled to Monday, +3 days (2021-01-18).

Changelog:

  * scrub status:
    * print percentage of progress
    * add size unit options
  * fi usage: also print free space from statfs
  * convert: copy full 64 bit timestamp from ext4 if avaialble
  * check:
    * add ability to repair extent item generation
    * new option to remove leftovers from inode number cache (-o inode_cache)
  * check for already running exclusive operation (balance, device add/...)
    when starting one
  * preliminary json output support for 'device stats'
  * fixes:
    * subvolume set-default: id 0 correctly falls back to tolpevel
    * receive: align internal buffer to allow fast CRC calculation
    * logical-resolve: distinguish -o subvol and bind mounts
  * build: new dependency libmount
  * other
    * doc fixes and updates
    * new tests
    * debugging output enhancements

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Adam Borowski (1):
      btrfs-progs: a bunch of typo fixes

Daniel Xu (1):
      btrfs-progs: sort main help menu entries

David Sterba (20):
      btrfs-progs: scrub status: print percents of scrubbed bytes
      btrfs-progs: scrub status: add unit mode options
      btrfs-progs: docs: add missing option to scrub status
      btrfs-progs: move path_cat_out helpers to path-utils
      btrfs-progs: docs: fix mknod arguments of the control device
      btrfs-progs: add helpers for parsing filesystem exclusive operation
      btrfs-progs: add helper to check or wait for exclusive operation
      btrfs-progs: add enqueue parameter for exclusive ops
      btrfs-progs: docs: document fs exclusive operations
      btrfs-progs: subvol show: fix required arguments in help texts
      btrfs-progs: fix short/long unit size options
      btrfs-progs: tests: add Makefile for testsuite
      btrfs-progs: initialize formatter context properly
      btrfs-progs: tests: add json formatter test coverage
      btrfs-progs: build: add missing gitignore and clean binaries
      btrfs-progs: tests: test full 64bit timestamp conversion on ext4
      btrfs-progs: subvol set-default: change id to 5 if specified as 0
      btrfs-progs: tests: set toplevel subvolume as default when specified as 0
      btrfs-progs: update CHANGES for 5.10
      Btrfs progs v5.10-rc1

Eric Semeniuc (1):
      btrfs-progs: docs: grammar and typo fix for btrfs check

Goldwyn Rodrigues (3):
      btrfs-progs: add get_fsid_fd() for getting fsid using fd
      btrfs-progs: add sysfs file reading helpers
      btrfs-progs: check for exclusive operation before issuing another

Jiachen YANG (1):
      btrfs-progs: convert: copy extra timespec on ext4

Josef Bacik (4):
      btrfs-progs: only print the parent or ref root for ref mismatches
      btrfs-progs: print the eb flags for nodes as well
      btrfs-progs: image: fix invalid size check for extent items
      btrfs-progs: check: properly exclude leaves for lowmem mode

Marcos Paulo de Souza (4):
      btrfs-progs: build: add libmount dependency
      btrfs-progs: utils: introduce find_mount_fsroot
      btrfs-progs: inspect: use find_mount_fsroot in logical-resolve
      btrfs-progs: tests: test logical-resolve in various scenarios

Nikolay Borisov (2):
      btrfs-progs: check: add option to remove ino cache
      btrfs-progs: tests: test check --clear-ino-cache

Omar Sandoval (1):
      btrfs-progs: send: fix crash on unknown option

Qu Wenruo (6):
      btrfs-progs: mkfs: refactor how we handle sectorsize override
      btrfs-progs: check/lowmem: add ability to repair extent item generation
      btrfs-progs: check/original: don't reset extent generation for check_block
      btrfs-progs: check/original: add ability to repair extent item generation
      btrfs-progs: tests: enhance invalid extent item generation test cases
      btrfs-progs: check: only warn if clearing v1 cache and v2 found

Sheng Mao (1):
      btrfs-progs: align receive buffer to enable fast CRC

Sidong Yang (3):
      btrfs-progs: fi usage: add avail info from statfs()
      btrfs-progs: extend fmt_print_start_group to handle unnamed group
      btrfs-progs: device stats: add json output format

Su Yue (2):
      btrfs-progs: subvol show: reset subvol_path to NULL after free
      btrfs-progs: print bytenr of child eb if mismatched level found in read_node_slot

Tomasz Torcz (1):
      btrfs-progs: docs: add info about "single" profile requirements for swapfile

