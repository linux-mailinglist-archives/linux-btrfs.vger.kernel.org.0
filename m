Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB49613895
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 15:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiJaOAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiJaOA1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 10:00:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2221006C;
        Mon, 31 Oct 2022 07:00:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EBF021F993;
        Mon, 31 Oct 2022 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667224824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rL+ukzqaR3EpZTEWJBwfsPSlXjFTGEinGuLkFUWAfqk=;
        b=S3U9snANdTad/5fHyuQgar16B+km5+YuegSdq2tQ6Yx9QFrsucu8TMZD0Q5KGtyTlyxT5e
        oaxmltbGUtvGqm5uzCq8p0FnXw6LC+95eJXJz4+Fk1id1pZW/y7MJbdzNCJZiQEgg7SMRN
        e1Ihl+fojw3mVc0CbKvH32+VUFnb0x8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E04F92C142;
        Mon, 31 Oct 2022 14:00:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BC1EDA79D; Mon, 31 Oct 2022 15:00:08 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.1-rc4
Date:   Mon, 31 Oct 2022 15:00:06 +0100
Message-Id: <cover.1667223120.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

a few more fixes and regression fixes. Please pull, thannk.

- fix a corner case when handling tree-mod-log chagnes in reallocated
  notes

- fix crash on raid0 filesystems created with <5.4 mkfs.btrfs that could
  lead to division by zero

- add missing supper block checksum verification after thawing
  filesystem

- handle one more case in send when dealing with orphan files

- fix parameter type mismatch for generation when reading dentry

- improved error handling in raid56 code

- better struct bio packing after recent cleanups

----------------------------------------------------------------
The following changes since commit 4efb365a3f04d0bee7833f168b0b00a15edefeac:

  MAINTAINERS: update btrfs website links and files (2022-10-14 13:54:21 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc3-tag

for you to fetch changes up to 76a66ba101329316a5d7f4275070be22eb85fdf2:

  btrfs: don't use btrfs_chunk::sub_stripes from disk (2022-10-25 10:17:33 +0200)

----------------------------------------------------------------
BingJing Chang (1):
      btrfs: send: fix send failure of a subcase of orphan inodes

David Sterba (2):
      btrfs: reorder btrfs_bio for better packing
      btrfs: fix type of parameter generation in btrfs_get_dentry

Josef Bacik (1):
      btrfs: fix tree mod log mishandling of reallocated nodes

Qu Wenruo (4):
      btrfs: raid56: properly handle the error when unable to find the missing stripe
      btrfs: raid56: avoid double freeing for rbio if full_stripe_write() failed
      btrfs: make thaw time super block check to also verify checksum
      btrfs: don't use btrfs_chunk::sub_stripes from disk

 fs/btrfs/disk-io.c     | 10 ++++------
 fs/btrfs/disk-io.h     |  2 ++
 fs/btrfs/export.c      |  2 +-
 fs/btrfs/export.h      |  2 +-
 fs/btrfs/extent-tree.c | 25 +++++++++++++------------
 fs/btrfs/raid56.c      | 18 +++++++++++-------
 fs/btrfs/send.c        | 24 +++++++++++++-----------
 fs/btrfs/super.c       | 16 ++++++++++++++++
 fs/btrfs/volumes.c     | 12 +++++++++++-
 fs/btrfs/volumes.h     |  2 +-
 10 files changed, 73 insertions(+), 40 deletions(-)
