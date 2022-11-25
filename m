Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558886390CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKYUru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 15:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYUrt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 15:47:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2114193F6;
        Fri, 25 Nov 2022 12:47:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2AB812189A;
        Fri, 25 Nov 2022 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669409267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YBBYrboQ9C7soWP/CxVP/nBs2GyZ7rvVNHV0wFFseXA=;
        b=HcgQ6mk6dBhiY9v3u95XDqE1lIy3azcmPiZPxwtU+nTm2HIc2sUS+JRD6z1pGhUFnodKUH
        sf71RqcfIzq2CNtFNtM98+GAVCgi6ZhrGi8w4fdqieEcrNLHeqVaDaJE5V0dWt9HIOPhe8
        X6gxQWahuKoMNXN/tvzsieR0JAA91+0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2161D2C141;
        Fri, 25 Nov 2022 20:47:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70BD4DA822; Fri, 25 Nov 2022 21:47:16 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.1-rc7
Date:   Fri, 25 Nov 2022 21:47:15 +0100
Message-Id: <cover.1669400851.git.dsterba@suse.com>
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

a few more fixes from past two weeks. Please pull, thanks.

- fix a regression in nowait + buffered write

- in zoned mode fix endianness when comparing super block generation

- locking and lockdep fixes:
  - fix potential sleeping under spinlock when setting qgroup limit
  - lockdep warning fixes when btrfs_path is freed after copy_to_user
  - do not modify log tree while holding a leaf from fs tree locked

- fix freeing of sysfs files of static features on error

- use kv.alloc for zone map allocation as a fallback to avoid warnings
  due to high order allocation

- send, avoid unaligned encoded writes when attempting to clone range

----------------------------------------------------------------
The following changes since commit c62f6bec53e63b11112e1ebce6bbaa39ce6f6706:

  btrfs: zoned: fix locking imbalance on scrub (2022-11-07 14:35:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc6-tag

for you to fetch changes up to ffdbb44f2f23f963b8f5672e35c3a26088177a62:

  btrfs: sysfs: normalize the error handling branch in btrfs_init_sysfs() (2022-11-23 16:52:22 +0100)

----------------------------------------------------------------
Anand Jain (3):
      btrfs: free btrfs_path before copying inodes to userspace
      btrfs: free btrfs_path before copying fspath to userspace
      btrfs: free btrfs_path before copying subvol info to userspace

ChenXiaoSong (1):
      btrfs: qgroup: fix sleep from invalid context bug in btrfs_qgroup_inherit()

Christoph Hellwig (2):
      btrfs: zoned: fix missing endianness conversion in sb_write_pointer
      btrfs: use kvcalloc in btrfs_get_dev_zone_info

Filipe Manana (3):
      btrfs: fix assertion failure and blocking during nowait buffered write
      btrfs: send: avoid unaligned encoded writes when attempting to clone range
      btrfs: do not modify log tree while holding a leaf from fs tree locked

Josef Bacik (1):
      btrfs: free btrfs_path before copying root refs to userspace

Zhen Lei (1):
      btrfs: sysfs: normalize the error handling branch in btrfs_init_sysfs()

 fs/btrfs/ctree.c    | 36 ++++++++++++++++++++++++++------
 fs/btrfs/ioctl.c    | 23 ++++++++++++---------
 fs/btrfs/qgroup.c   |  9 +-------
 fs/btrfs/send.c     | 24 +++++++++++++++++++++-
 fs/btrfs/sysfs.c    |  7 +++++--
 fs/btrfs/tree-log.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/zoned.c    |  9 ++++----
 7 files changed, 132 insertions(+), 35 deletions(-)
