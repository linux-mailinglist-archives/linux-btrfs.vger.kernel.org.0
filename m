Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2F403EE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhIHSOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 14:14:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhIHSOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 14:14:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 179E51FDAA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631124811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=349lRvE9XwnMz3B6SaLPTQwMwZvGRmdsEzKfLaSfd60=;
        b=vNeVkghWlrNrTnpD3W1DegrnPL4dnNfSNtf3Qq7nBeAQINfIF2wJW/WB+fFeX+FssmZLj0
        y4XJw2b90Zb6qZXDLHRSjsKmvt/WB/l0EtsaGAMCbdLkjKMvdTB0lRRp0cwO087BvchMyc
        jEYODxYJXJb6LeGnNNlsIJ08sCB9UaQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 11060A3B92
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 18:13:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6FD95DA7E1; Wed,  8 Sep 2021 20:13:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs pre-release 5.14-rc1
Date:   Wed,  8 Sep 2021 20:13:26 +0200
Message-Id: <20210908181326.17046-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a pre-release of btrfs-progs, 5.14-rc1.

The proper release is scheduled to Friday, +2 days (2021-09-10).

Potentially breaking changes:

* libbtrfs with reduced exported symbols, only covering needs of snapper, so
  anything else will probably break (but we aren't aware of anything else using
  the library besides ioctls)

Features:

* convert
  * can generate/copy/set the uuid
  * output has been updated to be more in line with the formatting that's eg. in mkfs
* check
  * able to fix more problems in block groups or super block
* mkfs
  * degenerate raid0/raid10 support (coming in kernel 5.15)
* image
  * improved output in case of error

Fixes:

* better detection of 64bit timestamp support in e2fsprogs

Experimental features:

In order to get various features or patchsets merged and not rot in the
mailinglist, there's a configure option --enable-experimental that guards that
they won't be built by default. The idea is to merge code in a reasonable shape
but potentially unfinished or without stable interface (name, output, ...).
Each feature has a tracking issue so we can keep the overview and communicate
what's still pending.

That poses some risk of bloating the repository with dead code, but right now
it's a risk I'm willing to take in order to get in more contributions. Dead
code could be deleted eventually, with the optional build it's without the
problems of breaking user scripts and backward compatibility.

The feedback loop for progs patches is too long in some cases and I'm afraid
this discouraged many useful contributions.

This kind of lowers the quality barrier, but hopefully on the entry side only.
Promoting experimental feature to stable will happen after we're sure it meets
the release criteria.

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (46):
      btrfs-progs: convert: new option to copy or specify uuid
      btrfs-progs: tests: add test for convert --uuid option
      btrfs-progs: convert: rename context volume_name to label
      btrfs-progs: remove stale command declarations
      btrfs-progs: convert: update default output
      btrfs-progs: build: add configure time option to enable experimental features
      btrfs-progs: corupt-block: leave only long option for --block-group
      btrfs-progs: mkfs: allow degenerate raid0/raid10
      btrfs-progs: tests: add mkfs test for raid0/1 and raid10/2
      btrfs-progs: copy some raid_attr helpers from kernel
      btrfs-progs: add and use bit masks for RAID1 and RAID56 profiles
      btrfs-progs: parse profile name from the raid table
      btrfs-progs: split parsing helpers from utils.c
      btrfs-progs: move number and range parsing helpers to parse-utils.c
      btrfs-progs: factor out profile parsing to common utils
      btrfs-progs: mkfs: use common parser of bg profiles
      btrfs-progs: factor out compression type name parsing to common utils
      btrfs-progs: unify GPL header comments
      btrfs-progs: rename parse_qgroupid
      btrfs-progs: factor out plain qgroupid parsing
      btrfs-progs: move parse_qgroupid to parse utils
      btrfs-progs: qgroup create: accept only valid qgroupid
      btrfs-progs: move btrfs_tree_search2_ioctl_supported to fsfeatures.c
      btrfs-progs: use raid attr table in group_profile_max_safe_loss
      btrfs-progs: rename and move group_profile_max_safe_loss
      btrfs-progs: tests: do dm target detection by one
      btrfs-progs: tests: allow alternate name for dm target detection
      btrfs-progs: tests: properly load dm-thin in mkfs/017
      btrfs-progs: tests: add templates for most common test types
      btrfs-progs: move qgroup.h to cmds/
      btrfs-progs: merge qgroup.c into cmds/qgroup.c
      btrfs-progs: unexport local qgroup helpers
      btrfs-progs: add prefixes to exported qgroup helpers
      btrfs-progs: remove prefix from all static qgroup helpers
      btrfs-progs: move all private definitions to cmds/qgroup.c
      btrfs-progs: move send.h to kernel-shared/
      btrfs-progs: remove stale declaration from send.h
      btrfs-progs: move props.h to cmds/
      btrfs-progs: merge props.c to cmds/property.c
      btrfs-progs: move btrfsck.h to check/
      btrfs-progs: open code btrfs_list_get_path_rootid
      btrfs-progs: tests: add more API coverage to library-test
      btrfs-progs: libbtrfs: drop btrfs-list.h, raid56.h and btrfsck.h
      btrfs-progs: libbtrfs: cleanup libbtrfs.sym exports
      btrfs-progs: libbtrfs: hide unused symbols, same version
      Btrfs progs v5.14-rc1

Josef Bacik (22):
      btrfs-progs: corrupt-block: add ability to corrupt block group items
      btrfs-progs: check: detect and fix invalid used for block groups
      btrfs-progs: tests: add image with a corrupt block group item
      btrfs-progs: propagate fs root errors in lowmem mode
      btrfs-progs: propagate extent item errors in lowmem mode
      btrfs-progs: check btrfs_super_used in lowmem check
      btrfs-progs: tests: fix running check mode lowmem tests
      btrfs-progs: check blocks in btrfs_next_sibling_block
      btrfs-progs: check: do not double add unaligned extent records
      btrfs-progs: check: do not infinite loop on corrupt keys with lowmem mode
      btrfs-progs: check: detect and fix problems with super_bytes_used
      btrfs-progs: tests: add image with an invalid super bytes_used
      btrfs-progs: mkfs: use an associative array for init blocks
      btrfs-progs: mkfs: get rid of MKFS_SUPER_BLOCK
      btrfs-progs: mkfs: use blocks_nr to determine the super used bytes
      btrfs-progs: mkfs: set nritems based on root items written
      btrfs-progs: mkfs: add helper for writing empty tree nodes
      btrfs-progs: make sure track_dirty and ref_cows is set properly
      btrfs-progs: mkfs: add the block group item in make_btrfs()
      btrfs-progs: add add_block_group_free_space helper
      btrfs-progs: mkfs: generate free space tree at make_btrfs() time
      btrfs-progs: add the incompat flag for extent tree v2

Li Zhang (1):
      btrfs-progs: build: fix detection of ext4 i_{a,c,a}time_extra

Qu Wenruo (15):
      btrfs-progs: mkfs: set super_cache_generation to 0 if we're using free space tree
      btrfs-progs: subvol delete: try to delete subvolume by id when its path can't be resolved
      btrfs-progs: tests: also check subpage warning for check_image cases
      btrfs-progs: tests: don't check subpage related warnings for simple fsck tests
      btrfs-progs: require full nodesize alignement for subpage support
      btrfs-progs: image: introduce framework for more dump versions
      btrfs-progs: image: introduce -d option to dump data
      btrfs-progs: image: reduce memory requirements for decompression
      btrfs-progs: image: fix restored image size misalignment
      btrfs-progs: move btrfs_format_csum() to common/utils.[ch]
      btrfs-progs: slightly enhance btrfs_format_csum()
      btrfs-progs: check: output proper csum values for --check-data-csum
      btrfs-progs: use btrfs_key for btrfs_check_node() and btrfs_check_leaf()
      btrfs-progs: backport btrfs_check_leaf() from kernel
      btrfs-progs: backport btrfs_check_node() from kernel

Sidong Yang (1):
      btrfs-progs: props: init compression prop_handlers with field name

