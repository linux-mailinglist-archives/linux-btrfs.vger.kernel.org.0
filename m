Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17D6B31F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 00:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCIXKQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 18:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCIXKO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 18:10:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB9F865A;
        Thu,  9 Mar 2023 15:10:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7DF6120364;
        Thu,  9 Mar 2023 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678403411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sWlU1jc6NW8wx2v5EprRzI5q1Vm8+Yyru19cRQx8k4g=;
        b=WkgUUBP5VDiERQkK9LB6j7lwjOsHw5Oz8wUoU77H4ECEUBJNeWdLSk47yYV4Kl88ozxeFF
        3kImExKJo1vzMNaD75z+1mE8ttexN0CuwQtfVZRUGwqqEQic5neNnxM8Z0PsFPd7LI4YLN
        7lYtPrILws9aC4Op41cHYem8z70Vvtg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6BFED2C141;
        Thu,  9 Mar 2023 23:10:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E257DA7A3; Fri, 10 Mar 2023 00:04:08 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.3-rc2
Date:   Fri, 10 Mar 2023 00:04:07 +0100
Message-Id: <cover.1678398321.git.dsterba@suse.com>
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

first batch of fixes. Among them there are two updates to sysfs and
ioctl which are not strictly fixes but are used for testing so there's
no reason to delay them.

Please pull, thanks.

* fix block group item corruption after inserting new block group

* fix extent map logging bit not cleared for split maps after dropping
  range

* fix calculation of unusable block group space reporting bogus values
  due to 32/64b division

* fix unnecessary increment of read error stat on write error

* improve error handling in inode update

* export per-device fsid in DEV_INFO ioctl to distinguish seeding
  devices, needed for testing

* allocator size classes
  * fix potential dead lock in size class loading logic
  * print sysfs stats for the allocation classes

----------------------------------------------------------------
The following changes since commit 964a54e5e1a0d70cd80bd5a0885a1938463625b1:

  btrfs: make kobj_type structures constant (2023-02-15 19:38:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc1-tag

for you to fetch changes up to 675dfe1223a69e270b3d52cb0211c8a501455cec:

  btrfs: fix block group item corruption after inserting new block group (2023-03-08 01:14:01 +0100)

----------------------------------------------------------------
Boris Burkov (2):
      btrfs: sysfs: add size class stats
      btrfs: fix potential dead lock in size class loading logic

Filipe Manana (2):
      btrfs: fix extent map logging bit not cleared for split maps after dropping range
      btrfs: fix block group item corruption after inserting new block group

Johannes Thumshirn (1):
      btrfs: fix percent calculation for bg reclaim message

Naohiro Aota (1):
      btrfs: fix unnecessary increment of read error stat on write error

Qu Wenruo (1):
      btrfs: ioctl: return device fsid from DEV_INFO ioctl

void0red (1):
      btrfs: handle btrfs_del_item errors in __btrfs_update_delayed_inode

 fs/btrfs/bio.c             |  2 +-
 fs/btrfs/block-group.c     | 58 ++++++++++++++++++++++++----------------------
 fs/btrfs/delayed-inode.c   |  2 +-
 fs/btrfs/extent_map.c      |  7 +++++-
 fs/btrfs/ioctl.c           |  1 +
 fs/btrfs/sysfs.c           | 42 +++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h | 12 +++++++++-
 7 files changed, 92 insertions(+), 32 deletions(-)
