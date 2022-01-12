Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE91548CA0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 18:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbiALRpK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 12:45:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44650 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355804AbiALRoq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 12:44:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 152B41F39B
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jan 2022 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642009485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=irdpPvBegJv3Y0mDWbFuND0lM3uihZi9N4O/AKO7srU=;
        b=vEpgu50rfqJUFK6hUdpRrz0t6bDhW0uZetwZkGQFmxhDrfDzWi50ttRotL9H6lQ+VQWz5N
        4LWT2XMInHymklUoPX4PqpOC+Y9sBeqKgrYDkCifgJLbW6oQ+Pty+Nlya8Bariwhv8CLUj
        7bppglnCxUQC2A74XzQ66JXQZt18Nm4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 11954A3B81
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jan 2022 17:44:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77F04DA799; Wed, 12 Jan 2022 18:44:11 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.16
Date:   Wed, 12 Jan 2022 18:44:11 +0100
Message-Id: <20220112174411.29423-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.16 have been released.

Changelog:

* rescue: new subcommand clear-uuid-tree to fix failed mount due to bad uuid
  subvolume keys, caught by tree-checker
* fi du: skip inaccessible files
* prop: properly resolve to symlink targets
* send, receive: fix crash after parent subvolume lookup errors
* build:
  * fix build on 5.12+ kernels due to changes in linux/kernel.h
  * fix build on musl with old kernel headers
* other:
  * error handling fixes, cleanups, refactoring
  * extent tree v2 preparatory work
  * lots of RST documentation updates (last release with asciidoc sources),
    https://btrfs.readthedocs.io

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Bruce Ashfield (1):
      btrfs-progs: include linux/const.h to fix build with 5.12+ headers

David Sterba (14):
      btrfs-progs: docs: drop indices from pages
      btrfs-progs: docs: add more of the new doc structure
      btrfs-progs: docs: add more chapters
      btrfs-progs: docs: add more chapters (part 2)
      btrfs-progs: docs: add more chapters (part 3)
      btrfs-progs: docs: update some chapters
      btrfs-progs: docs: more docs updates
      btrfs-progs: docs: update template, more about subvolumes
      btrfs-progs: send: properly handle an ERR_PTR in find_good_parent
      btrfs-progs: update README
      btrfs-progs: docs: split swapfile from section 5
      btrfs-progs: docs: split mount options
      btrfs-progs: update CHANGES for 5.16
      Btrfs progs v5.16

Dāvis Mosāns (1):
      btrfs-progs: receive: properly check ERR return value in process_snapshot

Fabrice Fontaine (1):
      btrfs-progs: include sys/sysinfo.h conditionally on musl

Goffredo Baroncelli (1):
      btrfs-progs: prop: allow autodetect_object_types() to handle link

Josef Bacik (24):
      btrfs-progs: check: fix set_extent_dirty range
      btrfs-progs: simplify btrfs_make_block_group
      btrfs-progs: check: don't walk down non fs-trees for qgroup check
      btrfs-progs: fi show: close ctree once we're done
      btrfs-progs: add a helper for setting up a root node
      btrfs-progs: stop passing root to csum related functions
      btrfs-progs: check: stop passing csum root around
      btrfs-progs: stop accessing ->csum_root directly
      btrfs-progs: image: keep track of seen blocks when walking trees
      btrfs-progs: move btrfs_fix_block_accounting to repair.c
      btrfs-progs: check: abstract out the used marking helpers
      btrfs-progs: check: move btrfs_mark_used_tree_blocks to common
      btrfs-progs: mark reloc roots as used
      btrfs-progs: stop accessing ->extent_root directly
      btrfs-progs: stop accessing ->free_space_root directly
      btrfs-progs: track csum, extent, and free space trees in a rb tree
      btrfs-progs: check: make reinit work per found root item
      btrfs-progs: check: check the global roots for uptodate root nodes
      btrfs-progs: check: check all of the csum roots
      btrfs-progs: check: fill csum root from all extent roots
      btrfs-progs: search all extent roots for marking used space
      btrfs-progs: common: allow users to select extent-tree-v2 option
      btrfs-progs: add definitions for the block group tree
      btrfs-progs: add on disk pointers to global tree ids

Nikolay Borisov (2):
      btrfs-progs: tests: test for btrfs fi usage output
      btrfs-progs: remove redundant fs uuid validation from make_btrfs

Qu Wenruo (1):
      btrfs-progs: rescue: introduce clear-uuid-tree

Sidong Yang (2):
      btrfs-progs: fi du: skip inaccessible files
      btrfs-progs: check: change commit condition in fixup_extent_refs()
