Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9151C6D397E
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Apr 2023 19:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjDBRke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Apr 2023 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBRkd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Apr 2023 13:40:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72650CA1E;
        Sun,  2 Apr 2023 10:40:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81F271FDC1;
        Sun,  2 Apr 2023 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680457228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qbw5s6/UHTe5UZeUUOsbgR+nXVOA4GWoXLfe09Vi2Kk=;
        b=hMPJ6mhR8vETcAVXlNBbaE60lFtRELVxSe7ZLTdirU7CcQ/lGZLaVa8WaR/WCCyJIS3khL
        TfJXOBQV7h5YdZmrMK7CKkRldPLj/c3qAdAoIePEwTKrRoWWm9RUNfKxdY5DRucS9jovIu
        wdjXNvC4AI+nCZhl5A0WD8JFg8ZWJyk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 700782C161;
        Sun,  2 Apr 2023 17:40:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1606CDA7DE; Sun,  2 Apr 2023 19:34:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.3-rc5
Date:   Sun,  2 Apr 2023 19:34:12 +0200
Message-Id: <cover.1680455513.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes, for stable trees. Please pull, thanks.

- scan block devices in non-exclusive mode to avoid temporary mkfs
  failures

- fix race between quota disable and quota assign ioctls

- fix deadlock when aborting transaction during relocation with scrub

- ignore fiemap path cache when there are multiple paths for a node

----------------------------------------------------------------
The following changes since commit e15acc25880cf048dba9df94d76ed7e7e10040e6:

  btrfs: zoned: drop space_info->active_total_bytes (2023-03-15 20:51:07 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc4-tag

for you to fetch changes up to 2280d425ba3599bdd85c41bd0ec8ba568f00c032:

  btrfs: ignore fiemap path cache when there are multiple paths for a node (2023-03-29 01:16:23 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: scan device in non-exclusive mode

Filipe Manana (3):
      btrfs: fix race between quota disable and quota assign ioctls
      btrfs: fix deadlock when aborting transaction during relocation with scrub
      btrfs: ignore fiemap path cache when there are multiple paths for a node

 fs/btrfs/backref.c     | 85 +++++++++++++++++++++++++++++++++++++-------------
 fs/btrfs/ioctl.c       |  2 ++
 fs/btrfs/qgroup.c      | 11 ++++++-
 fs/btrfs/transaction.c | 15 ++++++++-
 fs/btrfs/volumes.c     | 20 ++++++++++--
 5 files changed, 107 insertions(+), 26 deletions(-)
