Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E61A63C5
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfICIYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 04:24:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfICIYN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 04:24:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DB61AE07
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2019 08:24:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: check: Repair invalid inode mode in subvolume trees
Date:   Tue,  3 Sep 2019 16:24:03 +0800
Message-Id: <20190903082407.13927-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, btrfs check can only repair bad free space cache
inode mode (as it was the first case detected by tree-checker and reported)

But now what may happen finally happened, we have user reorting bad
inode mode in subvolumes trees.

Although the reported get the fs fixed by removing the offending old
files, it's still a bad thing that "btrfs check" can't fix it.

This patch will bring the repair functionality to all inodes, along with
needed test image.

Qu Wenruo (4):
  btrfs-progs: check/common: Make repair_imode_common() to handle inodes
    in subvolume trees
  btrfs-progs: check/lowmem: Repair bad imode early
  btrfs-progs: check/original: Fix inode mode in subvolume trees
  btrfs-progs: tests/fsck: Add new images for inode mode repair
    functionality

 check/main.c                                  |  32 ++++--
 check/mode-common.c                           |  96 +++++++++++++++---
 check/mode-common.h                           |   2 +
 check/mode-lowmem.c                           |  39 +++++++
 .../039-bad-inode-mode/.lowmem_repairable     |   0
 .../bad_free_space_cache_imode.raw.xz}        | Bin
 .../bad_regular_file_imode.img.xz             | Bin 0 -> 2060 bytes
 7 files changed, 147 insertions(+), 22 deletions(-)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable
 rename tests/fsck-tests/{039-bad-free-space-cache-inode-mode/test.raw.xz => 039-bad-inode-mode/bad_free_space_cache_imode.raw.xz} (100%)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/bad_regular_file_imode.img.xz

-- 
2.23.0

