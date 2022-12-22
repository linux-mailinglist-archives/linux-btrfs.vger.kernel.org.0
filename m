Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF696547A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Dec 2022 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiLVVCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Dec 2022 16:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLVVCo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Dec 2022 16:02:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADACC13E90
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Dec 2022 13:02:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F55124E2E
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Dec 2022 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671742960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tt0L73BCMp/WrbnyrqkOPoAXNi5S4ICXDatirYGxod4=;
        b=XvV1/IWj73ec+j/6pRWIniGNbvlmryLm2gFbprToaWyI8gRg/IYVcle7RUdfEj3EJKkBns
        57g668Qh9sQFEm9FHYoGjSKd5KPb/AkUT3oaihuGQIipcW8E8Ys8JqmVYtYN6sHNE5baJR
        qspUY5HJIOj3XaUhXSlHLn3u+CqII60=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 07C042C141
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Dec 2022 21:02:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BEFC2DA859; Thu, 22 Dec 2022 21:57:16 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.1
Date:   Thu, 22 Dec 2022 21:57:16 +0100
Message-Id: <20221222205716.4916-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.1 have been released.

There are new commands that are in the experimental mode until the interface
stabilizes, which means that it's a good time to give feedback or point out
deficiencies. There's no ETA set to remove the experimental status, I think and
hope that the feedback loop could work better if there's something tangible and
ready to test. The code is not the hard part unlike the interfaces and
formatting, this starts at the use case and user input is the important part.

The json output is also kind of experimental but there are tools that want it
now and can give feedback before there's some common format for all commands.

Relevant issues

* reflink group and commands: https://github.com/kdave/btrfs-progs/issues/396
* inspect list-chunks: https://github.com/kdave/btrfs-progs/issues/559
* all current experimental features: https://github.com/kdave/btrfs-progs/issues?q=is%3Aissue+is%3Aopen+label%3Aexperimental

Changelog:

   * filesystem df: add json output
   * qgroup show: add json output
   * new command: 'inspect-internal map-swapfile' to check swapfile and its
     swapfile_offset value used for hibernation
   * corrupt-block: fix parsing of option --root argument
   * experimental (interfaces not finalized):
      * new command 'inspect-internal list-chunks'
      * new group reflink, command clone
   * other:
      * synchronize some files with kernel versions
      * docs updates
      * build: use gnu11

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (21):
      btrfs-progs: inspect: new subcommand to list chunks
      btrfs-progs: string-table: cleanup and enhance formatting capabilities
      btrfs-progs: string-table: check bounds before writing to a cell
      btrfs-progs: string-table: add ranged API for printing and clearing
      btrfs-progs: tests: add string-table test framework
      btrfs-progs: inspect: new command map-swapfile
      btrfs-progs: fi df: implement json output
      btrfs-progs: docs: swapfile and hibernation
      btrfs-progs: fi mkswapfile: update help text
      btrfs-progs: add new group reflink and command
      btrfs-progs: docs: fix typos
      btrfs-progs: docs: add 6.1 development statistics
      btrfs-progs: docs: updates, clarifications
      btrfs-progs: qgroup show: add json output
      btrfs-progs: add json formatter for escaped string
      btrfs-progs: use escaped json format for paths
      btrfs-progs: device stats: fix json formatter type for devid
      btrfs-progs: docs: typo fixups and formatting updates
      btrfs-progs: docs: add some kernel 6.1 release notes
      btrfs-progs: update CHANGES for 6.1
      Btrfs progs v6.1

Josef Bacik (21):
      btrfs-progs: build: turn on more compiler warnings and use -Wall
      btrfs-progs: fix make clean to clean convert properly
      btrfs-progs: build: use -std=gnu11
      btrfs-progs: ioctl: move btrfs_err_str into common/utils.h
      btrfs-progs: rename qgroup items to match the kernel naming scheme
      btrfs-progs: make btrfs_qgroup_level helper match the kernel
      btrfs-progs: ioctl: move dev-replace NO_RESULT definition into replace.c
      btrfs-progs: image: rename BLOCK_* to IMAGE_BLOCK_* for metadump
      btrfs-progs: rename btrfs_item_end to btrfs_item_data_end
      btrfs-progs: copy ioctl.h into libbtrfs
      btrfs-progs: stop using btrfs_root_item_v0
      btrfs-progs: make the find extent buffer helpers take fs_info
      btrfs-progs: move dirty eb tracking to it's own io_tree
      btrfs-progs: do not pass io_tree into verify_parent_transid
      btrfs-progs: move extent cache code directly into btrfs_fs_info
      btrfs-progs: delete state_private code
      btrfs-progs: rename extent buffer flags to EXTENT_BUFFER_*
      btrfs-progs: sync compression.h from the kernel
      btrfs-progs: replace btrfs_leaf_data with btrfs_item_nr_offset
      btrfs-progs: don't use btrfs_header_csum helper
      btrfs-progs: make write_extent_buffer take a const eb

Qu Wenruo (1):
      btrfs-progs: corrupt-block: fix the mismatch in --root and -r options

