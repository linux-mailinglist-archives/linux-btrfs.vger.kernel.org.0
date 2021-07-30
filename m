Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF73DBAEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhG3On4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 10:43:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhG3On4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 10:43:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5F1002025B;
        Fri, 30 Jul 2021 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627656230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/MxUMQqOErt5s9kpr2UduIMjgtyEA7lRScXZz1pXJbc=;
        b=ODCClVam2dZUbrsTJ/mME//+Gky6EjgfZCbKl8MaZ9yN2mJsL94B9fm8BeQ8tu+1PH/Crt
        Echx3i0AwwSc+BiGo1q52Jd0RZGf5XD1jAC4txjoR795rNMVRmwYwgUZK/oO7JPpI8vMh+
        MNGHStvofmUKDKDmb2edgm7ZLSiWRNQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 56C2FA3B87;
        Fri, 30 Jul 2021 14:43:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1FAB6DB284; Fri, 30 Jul 2021 16:41:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes fro 5.14-rc4
Date:   Fri, 30 Jul 2021 16:40:59 +0200
Message-Id: <cover.1627655635.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes, please pull thanks.

* fix -Warray-bounds warning, to help external patchset to make it
  default treewide

* fix writeable device accounting (syzbot report)

* fix fsync and log replay after a rename and inode eviction

* fix potentially lost error code when submitting multiple bios for
  compressed range

----------------------------------------------------------------
The following changes since commit c7c3a6dcb1efd52949acc1e640be9aad1206a13a:

  btrfs: store a block_device in struct btrfs_ordered_extent (2021-07-22 15:50:15 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc3-tag

for you to fetch changes up to 7280305eb57dd32735f795ed4ee679bf9854f9d0:

  btrfs: calculate number of eb pages properly in csum_tree_block (2021-07-29 13:01:04 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: calculate number of eb pages properly in csum_tree_block

Desmond Cheong Zhi Xi (1):
      btrfs: fix rw device counting in __btrfs_free_extra_devids

Filipe Manana (1):
      btrfs: fix lost inode on log replay after mix of fsync, rename and inode eviction

Goldwyn Rodrigues (1):
      btrfs: mark compressed range uptodate only if all bio succeed

 fs/btrfs/compression.c | 2 +-
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/tree-log.c    | 4 ++--
 fs/btrfs/volumes.c     | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)
