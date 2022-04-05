Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C54F477B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiDEVGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384078AbiDEPOw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 11:14:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A1689A6;
        Tue,  5 Apr 2022 06:28:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DABBD210DE;
        Tue,  5 Apr 2022 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649165329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B1KHdOwVSkxc4cwioVl/fqGmb4ILJaNXLeIecIndREU=;
        b=Jg1tYOq01mB8B0vxbgs4NgOXJtRQr3uDIvlYQoTjvOY7mEVQ3u6at1FQZe9Tw3SE3QbNZ9
        yZdEcUaKfQVEW+gX5DmsUmWlZ09rfQXT/6A699HqreRbUT5ylyrydwStiI9dbGzoL9EGpI
        vudzaTBUEUaXlugYM7VcAAseaxSEPf4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CF71DA3B87;
        Tue,  5 Apr 2022 13:28:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1C70DA80E; Tue,  5 Apr 2022 15:24:48 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.18-rc2
Date:   Tue,  5 Apr 2022 15:24:47 +0200
Message-Id: <cover.1649109877.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

please pull the following fixes for btrfs, thanks.

- prevent deleting subvolume with active swapfile

- fix qgroup reserve limit calculation overflow

- remove device count in superblock and its item in one transaction so
  they cant't get out of sync

- skip defragmenting an isolated sector, this could cause some extra IO

- unify handling of mtime/permissions in hole punch with fallocate

- zoned mode fixes:
  - remove assert checking for only single mode, we have the DUP mode
    implemented

  - fix potential lockdep warning while traversing devices when checking
    for zone activation

----------------------------------------------------------------
The following changes since commit d3e29967079c522ce1c5cab0e9fab2c280b977eb:

  btrfs: zoned: put block group after final usage (2022-03-14 13:13:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc1-tag

for you to fetch changes up to 60021bd754c6ca0addc6817994f20290a321d8d6:

  btrfs: prevent subvol with swapfile from being deleted (2022-03-24 17:50:57 +0100)

----------------------------------------------------------------
Darrick J. Wong (1):
      btrfs: fix fallocate to use file_modified to update permissions consistently

Ethan Lien (1):
      btrfs: fix qgroup reserve overflow the qgroup limit

Johannes Thumshirn (2):
      btrfs: zoned: traverse devices under chunk_mutex in btrfs_can_activate_zone
      btrfs: zoned: remove left over ASSERT checking for single profile

Josef Bacik (1):
      btrfs: do not warn for free space inode in cow_file_range

Kaiwen Hu (1):
      btrfs: prevent subvol with swapfile from being deleted

Qu Wenruo (2):
      btrfs: remove device item and update super block in the same transaction
      btrfs: avoid defragging extents whose next extents are not targets

 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/file.c      | 13 +++++++++--
 fs/btrfs/inode.c     | 23 ++++++++++++++++++-
 fs/btrfs/ioctl.c     | 20 +++++++++++-----
 fs/btrfs/volumes.c   | 65 ++++++++++++++++++++++------------------------------
 fs/btrfs/zoned.c     | 13 ++++-------
 6 files changed, 81 insertions(+), 55 deletions(-)
