Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01CA5A290
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfF1Rjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 13:39:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfF1Rjt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 13:39:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3682ADEA
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2019 17:39:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22D1ADAC70; Fri, 28 Jun 2019 19:40:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs pre-release 5.2-rc1
Date:   Fri, 28 Jun 2019 19:40:32 +0200
Message-Id: <20190628174032.3382-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a pre-release of btrfs-progs, 5.2-rc1.

The proper release is scheduled to next Friday, +7 days (2019-07-05), but can
be postponed if needed.

Scrub status has been reworked:

  UUID:             bf8720e0-606b-4065-8320-b48df2e8e669
  Scrub started:    Fri Jun 14 12:00:00 2019
  Status:           running
  Duration:         0:14:11
  Time left:        0:04:04
  ETA:              Fri Jun 14 12:18:15 2019
  Total to scrub:   182.55GiB
  Bytes scrubbed:   141.80GiB
  Rate:             170.63MiB/s
  Error summary:    csum=7
    Corrected:      0
    Uncorrectable:  7
    Unverified:     0

And subvolume show now prints the qgroup information:

 subv1
         Name:                   subv1
         UUID:                   58aa0df4-6bde-3e4e-b9f6-631d9c23578f
         Parent UUID:            -
         Received UUID:          -
         Creation time:          2019-06-19 12:34:56 +0200
         Subvolume ID:           258
         Generation:             9
         Gen at creation:        9
         Parent ID:              5
         Top level ID:           5
         Flags:                  -
         Snapshot(s):
         Quota group:            0/258
           Limit referenced:     -
           Limit exclusive:      1.00GiB
           Usage referenced:     16.00KiB
           Usage exclusive:      16.00KiB

Tweaks to the formatting are possible but I think we have our style now, this
is used by mkfs already so there should be no big surprise.

The JSON formatting output is not added to any command, only the infrastructure
code.

For developers to notice, I've moved files into cmds/ and common/. Git rebase
is smart enough to recognize that and rebased patches will follow the new path.

Changelog:

  * subvol show: print qgroup information when available
  * scrub status: show ETA, revamp the whole output
  * image: fix hang when there are more than 32 cpus online and compression is
    requested
  * convert: fix some false ENOSPC errors when --rootdir is used
  * build: fix gcc9 warnings
  * core changes:
    * command handling cleanups
    * dead code removal
    * cmds-* files moved to cmds/
    * other shared userspace files moved to common/
    * preparatory work for more output formats

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (43):
      btrfs-progs: pass whole key to btrfs_uuid_to_key
      btrfs-progs: build: disable -Waddress-of-packed-member by default
      btrfs-progs: docs: add reference of section 5 page
      btrfs-progs: pass cmd_struct to usage_unknown_option()
      btrfs-progs: subvol show: reformat qgroup information
      btrfs-progs: subvol show: don't return error if quotas are not enabled
      btrfs-progs: tests: simple test for subvol show output
      btrfs-progs: move get_df to utils.c
      btrfs-progs: sync btrfs_raid_attr from kernel
      btrfs-progs: scrub: improve output of status
      btrfs-progs: move cmds-quota.c to cmds/
      btrfs-progs: move cmds-qgroup.c to cmds/
      btrfs-progs: move cmds-rescue.c to cmds/
      btrfs-progs: move cmds/property.c to cmds/
      btrfs-progs: move and rename chunk-recover.c cmds/
      btrfs-progs: move and rename super-recover.c cmds/
      btrfs-progs: move cmds-replace.c to cmds/
      btrfs-progs: move cmds-device.c to cmds/
      btrfs-progs: move cmds-restore.c to cmds/
      btrfs-progs: move cmds-balance.c to cmds/
      btrfs-progs: move cmds-receive.c to cmds/
      btrfs-progs: move cmds-scrub.c to cmds/
      btrfs-progs: move cmds-subvolume.c to cmds/
      btrfs-progs: move all cmds-inspect*.c to cmds/
      btrfs-progs: move all cmds-fi*.c to cmds/
      btrfs-progs: move cmds-send.c to cmds/
      btrfs-progs: move internal.h to common/
      btrfs-progs: move messages.[ch] to common/
      btrfs-progs: move task-utils.[ch] to common/
      btrfs-progs: move help.[ch] to common/
      btrfs-progs: move commonh to common/
      btrfs-progs: move fsfeatures.[ch] to common/
      btrfs-progs: move string-table.[ch] to common/
      btrfs-progs: move utils.[ch] to common/
      btrfs-progs: build: drop kernel-lib from -I and update paths
      btrfs-progs: move rbtree-utils.[ch] to common/
      btrfs-progs: fix helpinfo formats, short and options separation
      btrfs-progs: help: add helpinfo marker for global options
      btrfs-progs: define new output format: json
      btrfs-progs: help: define helper for command with flags
      btrfs-progs: output formatter infrastructue
      btrfs-progs: update CHANGES for v5.2
      Btrfs progs v5.2-rc1

Grzegorz Kowal (1):
      btrfs-progs: scrub: show the scrubbing rate and estimated time to finish

Jeff Mahoney (12):
      btrfs-progs: qgroups: introduce and use info and limit structures
      btrfs-progs: qgroups: introduce btrfs_qgroup_query
      btrfs-progs: subvolume: add quota info to btrfs sub show
      btrfs-progs: help: convert ints used as bools to bool
      btrfs-progs: reorder placement of help declarations for send/receive
      btrfs-progs: filesystem balance: split out special handling
      btrfs-progs: use cmd_struct as command entry point
      btrfs-progs: pass cmd_struct to command callback function
      btrfs-progs: pass cmd_struct to clean_args_no_options{,_relaxed}
      btrfs-progs: pass cmd_struct to usage()
      btrfs-progs: handle command groups directly for common case
      btrfs-progs: add support for output formats

Nikolay Borisov (4):
      btrfs-progs: Remove redundant if
      btrfs-progs: Remove old commented code
      btrfs-progs: Remove old send buffer copy implementation
      btrfs-progs: check: Remove duplicated and commented functions

Qu Wenruo (10):
      btrfs-progs: image: Use SZ_* to replace intermediate size
      btrfs-progs: image: Fix a indent misalign
      btrfs-progs: image: Fix a access-beyond-boundary bug when there are 32 online CPUs
      btrfs-progs: image: Verify the superblock before restore
      btrfs-progs: Fix false ENOSPC alert by tracking used space correctly
      btrfs-progs: delayed-ref: Fix memory leak and use-after-free caused by wrong condition to free delayed ref/head.
      btrfs-progs: constify extent buffer reader
      btrfs-progs: Fix -Waddress-of-packed-member warning in btrfs_dev_stats_values callers
      btrfs-progs: Remove unnecessary fallthrough attribute in test_num_disk_vs_raid()
      btrfs-progs: Fix Wformat-overflow warning in cmds-receive.c

