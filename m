Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF52533EDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiEYOLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiEYOLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 10:11:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662DEABF66
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 07:11:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E3EAB1F8C4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653487865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TPB6QV/ykHs+ZAgNsYiFYhy/VPPsNrkNSUIu8pCL7/o=;
        b=h9XbPTPCu/2LocUjO5zyAqZPy6mr4oQtRnv9oOo0Sb9+n0NvcZSfgw3lpDEeFxV0VAvIU7
        gjCxx7/KyMQEpDBNVLtuxeA1k0eWnSmPo8+QHWlGmPKFkAENzIlxNzKUE8kvjqp08UZGm4
        yZGQetcg6Zw7ECUPiux/x2Rv2iLvyPQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DC21E2C141
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 14:11:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD261DA85E; Wed, 25 May 2022 16:06:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.18
Date:   Wed, 25 May 2022 16:06:44 +0200
Message-Id: <20220525140644.21979-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.18 have been released.

Changelog:
* fixes:
  * dump-tree: don't print traling zeros in checksums
  * recognize paused balance as exclusive operation state, allow to start
    device add
  * convert: properly initialize target filesystem label
  * mkfs: don't create free space bitmaps for empty filesystem
* restore: make lzo support build-time configurable, print supported
  compression in help text
* update kernel-lib sources
* other:
  * documentation updates, finish conversion to RST, CHANGES and INSTALL
    could be included into RST
  * fix build detection of experimental mode
  * new tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (34):
      btrfs-progs: reformat CHANGES for RST
      btrfs-progs: unify CHANGES indentation
      btrfs-progs: make device add and paused balance work together
      btrfs-progs: btrfstune: fix build-time detection of experimental features
      btrfs-progs: docs: move glossary to overview sections
      btrfs-progs: kernel-lib: add rbtree_types.h from linux
      btrfs-progs: kernel-lib: add simplified READ_ONCE and WRITE_ONCE
      btrfs-progs: kernel-lib: add rb_root_cached helpers
      btrfs-progs: kernel-lib: sync lib/rbtree.c
      btrfs-progs: kernel-lib: sync include/overflow.h
      btrfs-progs: kernel-lib: sync include/list.h
      btrfs-progs: kernel-lib: sync include/rtree.h
      btrfs-progs: INSTALL: update dependencies for docs build
      btrfs-progs: docs: link INSTALL to docs
      btrfs-progs: INSTALL: drop reference to libattr
      btrfs-progs: docs: add note about ifdef EXPERIMENTAL
      btrfs-progs: delete commented exports from libbtrfs.sym
      btrfs-progs: docs: separate bootloaders chapter
      btrfs-progs: docs: document paused balance
      btrfs-progs: docs: separate filesystem limits chapter
      btrfs-progs: docs: move flexibility to Administration
      btrfs-progs: docs: separate chapter for hardware considerations
      btrfs-progs: docs: merge storage model to hardware chapter
      btrfs-progs: docs: copy more contents from wiki
      btrfs-progs: docs: add subpage feature page
      btrfs-progs: docs: convert Experimental.md to RST
      btrfs-progs: docs: convert btrfs-ioctl.asciidoc to RST
      btrfs-progs: docs: convert conventions to RST
      btrfs-progs: docs: fix superscript formatting
      btrfs-progs: docs: update header formatting
      btrfs-progs: restore: list the supported compression
      btrfs-progs: tests: remove ext3 tests
      btrfs-progs: update CHANGES for 5.18
      Btrfs progs v5.18

Forza (1):
      btrfs-progs: docs: clarification on mixed profile

Qu Wenruo (9):
      btrfs-progs: remove the unused btrfs_fs_info::seeding member
      btrfs-progs: print-tree: print the checksum of header without tailing zeros
      btrfs-progs: check: lowmem, fix path leak when dev extents are invalid
      btrfs-progs: convert: initialize the target fs label
      btrfs-progs: remove unused header check/btrfsck.h
      btrfs-progs: docs: add more explanation on subapge limits
      btrfs-progs: do not use btrfs_commit_transaction() just to update super blocks
      btrfs-progs: properly initialize block group thresholds
      btrfs-progs: tests: make sure we don't create bitmaps for empty fs

Ross Burton (1):
      btrfs-progs: build: add option to disable LZO support for restore

