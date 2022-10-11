Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8395FADEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJKIA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJKIA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 04:00:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD815FDF6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 01:00:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 70AF41F8EB
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665475225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x2DMecO6Vu9AsC+Z8kW4sCY0WtEbJjOcddf5TpNzvV4=;
        b=DWK1gPEohk7L1CYD5hR+lLjWfP3GsUmg8RIlNC/UIORB/cZRTVcQ/v9/IWUYaq+Gnt+Kop
        qFhKoIHfPJleQAyqrJP1PtsMqy+lee7b5W4FEEHVRQ+XYVWgn2kErma+XMAhSdfF1+mseZ
        mAGcPcHzH8HKlOJUCNbLj83pKvmm7Nk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 67CCF2C141
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 08:00:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0B2ADA79D; Tue, 11 Oct 2022 10:00:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.0
Date:   Tue, 11 Oct 2022 10:00:20 +0200
Message-Id: <20221011080020.6417-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.0 have been released.

Changelog:

   * fi usage: in tabular output, print total size and slack size
   * mkfs:
      * option -O now accepts values from -R to unify the interface (-R will
	continue to work)
      * zone reset and discard is done in parallel on all devices
      * removed option --leafsize, deprecated long time ago
   * corrupt-block: recalculate checksum when changing generation
   * fixes:
      * convert: fix reserved range detection and overlaps
      * mkfs: fix creating files with reserved inode numbers with --rootdir
      * receive: escape filenames in command attributes
      * fix extent buffer leaks after transaction abort
   * experimental:
      * mkfs: support for block-group-tree (kernel 6.1)
      * fsverity in send (protocol v3, WIP)
      * btrfstune -b converts to block-group-tree
   * other:
      * cleanups, refactoring
      * new and updated tests
      * update documentation

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Anand Jain (1):
      btrfs-progs: dump-super: add extent-tree-v2

AtticFinder65536 (1):
      btrfs-progs: docs: update reflink cross-mount constraint

Boris Burkov (1):
      btrfs-progs: receive: add support for fs-verity

David Sterba (102):
      btrfs-progs: build: add rule for cleaning build dependencies
      btrfs-progs: fix may be unused warning in load_free_space_extents
      btrfs-progs: factor out and export rotational/ssd device helper
      btrfs-progs: mkfs: open code profile parsing helper
      btrfs-progs: mkfs: open code label parsing helper
      btrfs-progs: mkfs: duplicate argument for --rootdir path
      btrfs-progs: mkfs: reorder includes
      btrfs-progs: convert: reorder includes
      btrfs-progs: image: reorder includes
      btrfs-progs: check: reorder includes
      btrfs-progs: common: reorder includes
      btrfs-progs: receive: escape target paths for rename, symlink and hardlink
      btrfs-progs: tests: check that receive --dump escapes target paths
      btrfs-progs: fi usage: fix unallocated and print total and slack
      btrfs-progs: cmds: reorder includes
      btrfs-progs: fix path to internal libbtrfsutil includes
      btrfs-progs: reorder includes in standalone tools
      btrfs-progs: update include list in standalone tools
      btrfs-progs: image: update include lists
      btrfs-progs: convert: update include lists
      btrfs-progs: mkfs: update include lists
      btrfs-progs: check: update include lists
      btrfs-progs: tests: add helper for creating local temporary file
      btrfs-progs: tests: use _mktemp for creating files
      btrfs-progs: tests: use _mktemp_local for temporary files
      btrfs-progs: tests: detect send stream version in misc/053
      btrfs-progs: prepare merging compat feature lists
      btrfs-progs: ci: fix image updater script
      btrfs-progs: factor string helpers out of utils.c
      btrfs-progs: move parse_qgroupid_or_path to parse-utils
      btrfs-progs: factor filesystem helpers out of utils.c
      btrfs-progs: libbtrfs: update include lists
      btrfs-progs: cmds: update include lists
      btrfs-progs: common: update include lists, part 1
      btrfs-progs: use error helper for messages in non-kernel code
      btrfs-progs: use warning helper for multiple profile messages
      libbtrfsutil: update include lists
      btrfs-progs: mkfs: use message helpers for error messages
      btrfs-progs: convert: use message helpers for error messages
      btrfs-progs: corrupt-block: use message helpers for error messages
      btrfs-progs: map-logical: use message helpers for error messages
      btrfs-progs: select-super: use message helpers for error messages
      btrfs-progs: btrfstune: use message helpers for error messages
      btrfs-progs: remove random-test.c
      btrfs-progs: kernel-lib: remove radix-tree
      btrfs-progs: docs: note about read-only mount for send
      btrfs-progs: tests: in mkfs/002 use grep -E instead of egrep
      btrfs-progs: tags: add nullb for testing zoned devices
      btrfs-progs: tests: add mkfs/025 to test parallel zone reset
      btrfs-progs: fi usage: unify naming of device and chunk info variables
      btrfs-progs: docs: remove some asciidoc formatting artifacts
      btrfs-progs: check: move global variables to common headers
      btrfs-progs: check: factor out code for clearing caches
      btrfs-progs: move repair.c from common/ to check/
      btrfs-progs: check: rename global repair option
      btrfs-progs: factor out common message helper for internal errors
      btrfs-progs: remove unnecessary casts for u64
      btrfs-progs: rename MUST_LOG to LOG_ALWAYS
      btrfs-progs: introduce more message levels
      btrfs-progs: mkfs: group feature option declarations
      btrfs-progs: mkfs: use _set suffix for option tracking
      btrfs-progs: mkfs: rename dev_cnt to device_count
      btrfs-progs: docs: clarify meaning of mkfs --byte-count
      btrfs-progs: mkfs: remove support for option --leafsize
      btrfs-progs: add template for common error messages
      btrfs-progs: use template for out of memory error messages
      btrfs-progs: use template for transaction start error messages
      btrfs-progs: use template for transaction commit error messages
      btrfs-progs: mkfs: do proper error handling
      btrfs-progs: convert: do proper error handling
      btrfs-progs: use our ASSERT macro everywhere
      btrfs-progs: device-utils: rename btrfs_device_size
      btrfs-progs: docs: add note about mounted filesystem for tree-stats
      btrfs-progs: use common define error and warning message prefixes
      btrfs-progs: add logic to handle LOG_DEFAULT messages
      btrfs-progs: cmds: use LOG_DEFAULT for messages
      btrfs-progs: cmds: use LOG_ levels where hardcoded
      btrfs-progs: device: use pr_verbose for messages
      btrfs-progs: fi du: use pr_verbose for messages
      btrfs-progs: fi usage: use pr_verbose for messages
      btrfs-progs: filesystem: use pr_verbose for messages
      btrfs-progs: inspect: use pr_verbose for messages
      btrfs-progs: property: use pr_verbose for messages
      btrfs-progs: quota: use pr_verbose for messages
      btrfs-progs: rescue: use pr_verbose for messages
      btrfs-progs: scrub: use pr_verbose for messages
      btrfs-progs: subvol list: use pr_verbose for messages
      btrfs-progs: subvolume: use pr_verbose for messages
      btrfs-progs: cmds: remove unnecessary casts for u64
      btrfs-progs: factor out check for message level
      btrfs-progs: add helper to print messages to stderr
      btrfs-progs: build: redirect dependency files files to .deps
      btrfs-progs: fi du: print warning when file can't be accessed
      btrfs-progs: balance: use pr_stderr for messages
      btrfs-progs: filesystem: use pr_verbose and pr_stderr for messages
      btrfs-progs: replace: use pr_stderr for messages
      btrfs-progs: restore: use pr_stderr for messages
      btrfs-progs: send: use pr_stderr for messages
      btrfs-progs: cmds: use bool for status variables
      btrfs-progs: docs: update documentation site references in manual pages
      btrfs-progs: update CHANGES for 6.0
      Btrfs progs v6.0

Guillaume Legrand (1):
      btrfs-progs: README: update links to manual pages

Li Zhang (1):
      btrfs-progs: mkfs: run device preparation in parallel

Qu Wenruo (13):
      btrfs-progs: unexport csum_tree_block()
      btrfs-progs: corrupt-block: re-generate the checksum for generation corruption
      btrfs-progs: hide block group tree behind experimental feature
      btrfs-progs: remove unused function extent_io_tree_init_cache_max()
      btrfs-progs: remove duplicated leaked extent buffer report
      btrfs-progs: properly handle write error when writing back tree blocks
      btrfs-progs: properly initialize extent generation in __btrfs_record_file_extent()
      btrfs-progs: mkfs: offset inode numbers of the source filesystem
      btrfs-progs: fsfeatures: properly merge -O and -R options
      btrfs-progs: tests: fix the wrong kernel version check
      btrfs-progs: tests: add support check to convert-tests/022
      btrfs-progs: mkfs: fix a crash when enabling extent-tree-v2
      btrfs-progs: mkfs: fix a stack over-flow when features string are too long

Sidong Yang (1):
      btrfs-progs: docs: add cross reference for manualpages

Solt Budavári (1):
      btrfs-progs: docs: fix typo in subvolume intro

Thomas Hebb (6):
      btrfs-progs: convert: move simple_range into common.h
      btrfs-progs: convert: make comment formatting consistent
      btrfs-progs: convert: fix off-by-one error in overlap test
      btrfs-progs: convert: fix buggy logic in create_image_file_range()
      btrfs-progs: convert: expose intersect_with_reserved() to main.c
      btrfs-progs: convert: simplify create_image_file_range()

Torstein Eide (1):
      btrfs-progs: docs: add a section about troubleshooting swapfile

