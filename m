Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616DB3D2E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390442AbfFKQqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 12:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390050AbfFKQqu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:46:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C197AC2C
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2019 16:46:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A90A2DA905; Tue, 11 Jun 2019 18:47:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.1.1
Date:   Tue, 11 Jun 2019 18:47:40 +0200
Message-Id: <20190611164740.14472-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.1.1 have been released.

Changes:

  * convert and mkfs will try to use optimized crc32c
  * fi show: accept a file-backed image
  * fi show: fix possible crash when device is deleted in parallel
  * build:
    * support extra flags for python bindings
    * separate LDFLAGS for libbtrfsutil
  * other:
    * space reservation fixes or debugging improvements
    * V0 extent code removed
    * more tests and cleanups

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (9):
      btrfs-progs: tests: unmount testing mount point recursively
      btrfs-progs: tests: add helper for common mkfs on TEST_DEV
      btrfs-progs: switch to mkfs helper
      btrfs-progs: tests: fix misc-tests/029 to run on NFS
      btrfs-progs: tests: misc-tests/034: use sudo helper for module probing
      btrfs-progs: test: cleanup misc-tests/034
      btrfs-progs: fix gcc9 warning and potentially unaligned access to dev stats
      btrfs-progs: update CHANGES for v5.1.1
      Btrfs progs v5.1.1

Joshua Watt (1):
      btrfs-progs: build: Pass CFLAGS and LDFLAGS to Python

Nikolay Borisov (2):
      btrfs-progs: Correctly open filesystem on image file
      btrfs-progs: tests: Test fs on image files is correctly recognised

Qu Wenruo (7):
      btrfs-progs: convert: Workaround delayed ref bug by limiting the size of a transaction
      btrfs-progs: Output extent tree leaf if we failed to find a backref
      btrfs-progs: Enable crc32c optimization probe for convert and mkfs
      btrfs-progs: Cleanup BTRFS_COMPAT_EXTENT_TREE_V0
      btrfs-progs: check/lowmem: Reset path in repair mode to avoid incorrect item from being passed to lowmem check.
      btrfs-progs: Avoid nested chunk allocation call
      btrfs-progs: Do metadata preallocation for fs trees and csum tree

Sergei Trofimovich (1):
      btrfs-progs: build: apply LDFLAGS to libbtrfsutil.so

Su Yue (1):
      btrfs-progs: fix invalid memory write in get_fs_info()

