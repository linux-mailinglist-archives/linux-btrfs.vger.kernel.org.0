Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A8510568
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 19:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbiDZRbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiDZRbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 13:31:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7F66F4B2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 10:28:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABC49210E7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650994089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LlVIMqi6A4z+ivmiTspaY6H233dd/oxobilOs4y1exg=;
        b=AHzmddM7vz7sMem4gtKq4XPEBxZMQR/4YMODc4g0L1A3g/0A1cBgjDQqWvA9OFqYjFR53y
        YPWRiv7z8jotdTN7U6aBO677dgJbyHGuR+u/pSES7mzgWTI8/YWpF1VHwrBegH7C4eZeyD
        0uRU1D7ktmCGpknaZn15lR18tD6uYbg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A2A052C143
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 17:28:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 793A2DA7DE; Tue, 26 Apr 2022 19:24:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.17
Date:   Tue, 26 Apr 2022 19:24:03 +0200
Message-Id: <20220426172403.27553-1-dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.17 have been released.

Changelog:

* check:
  * repair wrong num_devices in superblock
  * recognize overly long xattr names
  * fix wrong total bytes check for seed device
* auto-repair on read on RAID56
* property set: unify handling of empty value to mean default, changed meaning
  for property 'compression' to allow reset to default and to set NOCOMPRESS,
  since kernel 5.14
* fixes:
  * dump-tree: print fs-verity items
  * fix location of system chunk on zoned filesystem
  * do not allow setting seeding flag on a filesystem with dirty log
  * mkfs and subpage support: use sectorsize as nodesize fallback for mixed
    profiles
* preparatory work for extent tree v2, global roots
* experimental feature (unstable interface, not built by default,
  do not use for production):
  * btrfstune: option --csum to switch checksum algorithm
* other:
  * cleanups, refactoring
  * update documentation build, remove asciidocs leftovers
  * update fssum to consider xattrs
  * add fsstress

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

David Sterba (15):
      btrfs-progs: docs: add remaining targets for sphinx build
      btrfs-progs: build: drop asciidoc detection, default to sphinx
      btrfs-progs: docs: remove asciidoc build support
      btrfs-progs: docs: remove all converted asciidoc sources
      btrfs-progs: docs: generate section 5 to final name directly
      btrfs-progs: docs: set version from VERSION file
      btrfs-progs: btrfstune: experimental, new option to switch csums
      btrfs-progs: tests: sync fssum.c from fstests
      btrfs-progs: tests: copy fsstress.c from fstests
      btrfs-progs: docs: update file attributes
      btrfs-progs: build: use rm for cleaning build directory
      btrfs-progs: docs: document generic error
      btrfs-progs: remove asciidoc generated files from .gitignore
      btrfs-progs: update CHANGES for 5.17
      Btrfs progs v5.17

Josef Bacik (40):
      btrfs-progs: check: fix check_global_roots_uptodate
      btrfs-progs: tests: use --force for --init-csum-tree in 003-multi-check-unmounted
      btrfs-progs: repair: bail if we find an unaligned extent
      btrfs-progs: do not try to load the free space tree if it's not enabled
      btrfs-progs: properly populate missing trees
      btrfs-progs: don't check skip_csum_check if there's no fs_info
      btrfs-progs: tree-stats: initialize the key properly
      btrfs-progs: handle orphan directories properly
      btrfs-progs: tests: add a test to check orphaned directories
      btrfs-progs: store LEAF_DATA_SIZE in the mkfs_config
      btrfs-progs: store BTRFS_LEAF_DATA_SIZE in the fs_info
      btrfs-progs: convert: use cfg->leaf_data_size
      btrfs-progs: reduce usage of __BTRFS_LEAF_DATA_SIZE
      btrfs-progs: btrfs_item_size_nr/btrfs_item_offset_nr everywhere
      btrfs-progs: add btrfs_set_item_*_nr() helpers
      btrfs-progs: change btrfs_file_extent_inline_item_len to take a slot
      btrfs-progs: rename btrfs_item_end_nr to btrfs_item_end
      btrfs-progs: remove the _nr from the item helpers
      btrfs-progs: replace btrfs_item_nr_offset(0)
      btrfs-progs: rework the btrfs_node accessors to match the item accessors
      btrfs-progs: make all of the item/key_ptr offset helpers take an eb
      btrfs-progs: add support for loading the block group root
      btrfs-progs: add print support for the block group tree
      btrfs-progs: mkfs: use the btrfs_block_group_root helper
      btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
      btrfs-progs: handle no bg item in extent tree for free space tree
      btrfs-progs: mkfs: add support for the block group tree
      btrfs-progs: check: add block group tree support
      btrfs-progs: qgroup-verify: scan extents based on block groups
      btrfs-progs: check: make free space tree validation extent tree v2 aware
      btrfs-progs: check: add helper to reinit the root based on a key
      btrfs-progs: check: handle the block group tree properly
      btrfs-progs: set the number of global roots in the super block
      btrfs-progs: handle the per-block group global root id
      btrfs-progs: add a btrfs_delete_and_free_root helper
      btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
      btrfs-progs: make btrfs_create_tree take a key for the root key
      btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
      btrfs-progs: mkfs: create the global root's
      btrfs-progs: check: don't do the root item check for extent tree v2

Li Zhang (1):
      btrfs-progs: props: don't translate value of compression=none

Mark Harmstone (1):
      btrfs-progs: check: add check for overlong xattr names

Naohiro Aota (4):
      btrfs-progs: zoned: export sb_zone_number() and related constants
      btrfs-progs: zoned: fix initial system BG location
      btrfs-progs: fix ordering of hole_size setting and dev_extent_hole_check()
      btrfs-progs: zoned: fix and simplify dev_extent_hole_check_zoned()

Qu Wenruo (18):
      btrfs-progs: check: fix two error messages used in qgroup verification
      btrfs-progs: check: add check and repair ability for super num devs mismatch
      btrfs-progs: tests: add test case for super num devs mismatch
      btrfs-progs: do not allow setting seed flag on fs with dirty log
      btrfs-progs: make sure "btrfstune -S1" will reject fs with dirty log
      btrfs-progs: fix a memory leak when starting a transaction on fs with error
      btrfs-progs: fix an error path which can lead to empty device list
      btrfs-progs: check: fix wrong total bytes check for seed device
      btrfs-progs: tests: check warning for seed and sprouted filesystems
      btrfs-progs: remove the unnecessary BTRFS_SUPER_INFO_OFFSET path for tree block read
      btrfs-progs: extract metadata restore read code into its own helper
      btrfs-progs: don't use write_extent_to_disk() directly
      btrfs-progs: use write_data_to_disk() to replace write_extent_to_disk()
      btrfs-progs: use read_data_from_disk() to replace read_extent_from_disk() and replace read_extent_data()
      btrfs-progs: remove extent_buffer::fd and extent_buffer::dev_bytes
      btrfs-progs: allow read_data_from_disk() to rebuild RAID56 using P/Q
      btrfs-progs: tests/fsck: add test case for data csum check on raid5
      btrfs-progs: mkfs: use sectorsize as nodesize fallback for mixed profiles

Sweet Tea Dorminy (1):
      btrfs-progs: dump-tree: add print support for verity items

