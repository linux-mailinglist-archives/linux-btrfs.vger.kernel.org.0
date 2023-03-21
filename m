Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937526C2FF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCULOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCULOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91635474D1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D0C7B815B4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C2DC4339E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397245;
        bh=tP909pSj17ss91b2u8Z8O9nehtvtfIOFGNNIJdozB0s=;
        h=From:To:Subject:Date:From;
        b=auOS1j/m6goOegYQDbjkiAGxmnw79jRrYPAh9nM4TvTGw4nz5Nkd6GrSB+0wRmChC
         jiEZTbTljTv/4jh8u45icDGaFI9C2pvmWUV4rk1yAH7Okel5+fayWiOIas6BZItIU4
         0UIUEtgYJR6/5fAmhS5JHdIGE+bouSCtndEg6xLRrW0wup5NRZWdvPgyeT9bRUMSez
         uPXAfiZLctuXV/3L9xjOzApXI50mIKrLX37x0UruR/r/+n4juzrFB/vTtoEN6E2R/T
         +aury8hD8Vh/riFx7tWJImeOp3+e6LJ3tG1pptPn9dIlBqzRWlvTWh7R/l9AUsxOJC
         iWHV6+ocTwZ2g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/24] btrfs: cleanups and small fixes mostly around block reserves
Date:   Tue, 21 Mar 2023 11:13:36 +0000
Message-Id: <cover.1679326426.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A set of cleanups and small fixes that started as part of a larger work,
mostly around block reserves and space reservation, but as they are mostly
trivial and independent of the rest of that work, I'm sending them out
separately. More details on the individual changelogs.

Filipe Manana (24):
  btrfs: pass a bool to btrfs_block_rsv_migrate() at evict_refill_and_join()
  btrfs: pass a bool size update argument to btrfs_block_rsv_add_bytes()
  btrfs: remove check for NULL block reserve at btrfs_block_rsv_check()
  btrfs: update documentation for BTRFS_RESERVE_FLUSH_EVICT flush method
  btrfs: update flush method assertion when reserving space
  btrfs: initialize ret to -ENOSPC at __reserve_bytes()
  btrfs: simplify btrfs_should_throttle_delayed_refs()
  btrfs: collapse should_end_transaction() into btrfs_should_end_transaction()
  btrfs: remove bytes_used argument from btrfs_make_block_group()
  btrfs: count extents before taking inode's spinlock when reserving metadata
  btrfs: remove redundant counter check at btrfs_truncate_inode_items()
  btrfs: simplify btrfs_block_rsv_refill()
  btrfs: remove obsolete delayed ref throttling logic when truncating items
  btrfs: don't throttle on delayed items when evicting deleted inode
  btrfs: calculate the right space for a single delayed ref when refilling
  btrfs: accurately calculate number of delayed refs when flushing
  btrfs: constify fs_info argument of the metadata size calculation helpers
  btrfs: constify fs_info argument for the reclaim items calculation helpers
  btrfs: add helper to calculate space for delayed references
  btrfs: calculate correct amount of space for delayed reference when evicting
  btrfs: fix calculation of the global block reserve's size
  btrfs: use a constant for the number of metadata units needed for an unlink
  btrfs: calculate the right space for delayed refs when updating global reserve
  btrfs: simplify exit paths of btrfs_evict_inode()

 fs/btrfs/block-group.c    |  7 ++----
 fs/btrfs/block-group.h    |  2 +-
 fs/btrfs/block-rsv.c      | 21 +++++++----------
 fs/btrfs/block-rsv.h      |  2 +-
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/delayed-ref.c    | 49 ++++-----------------------------------
 fs/btrfs/delayed-ref.h    | 22 +++++++++++++++++-
 fs/btrfs/disk-io.c        |  1 -
 fs/btrfs/extent-tree.c    | 27 ++-------------------
 fs/btrfs/fs.h             | 17 +++++++++++---
 fs/btrfs/inode-item.c     | 15 +++++-------
 fs/btrfs/inode.c          | 43 ++++++++++++++++------------------
 fs/btrfs/space-info.c     | 32 +++++++++++++++++++++----
 fs/btrfs/space-info.h     |  1 +
 fs/btrfs/transaction.c    | 15 ++++--------
 fs/btrfs/volumes.c        |  2 +-
 16 files changed, 115 insertions(+), 143 deletions(-)

-- 
2.34.1

