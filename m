Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F4712714
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbjEZMzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbjEZMzY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 08:55:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6BF1BF;
        Fri, 26 May 2023 05:54:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EC6921B38;
        Fri, 26 May 2023 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685105693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EFGBtrdL+XVOtuL9WFJe+BmH+sfLHLHvfyBF4LSyZS4=;
        b=berQ9zijq8VLoQA3LfUFpf2mYazMrJITolkUnFnZSMKB7FzNnohVlHLmFMHO/f6t8WLsYT
        DtKN9GW5ojRoaehdfPSLysFPW/XKcTaLFzhsTCvFeO84PVp18Yj4wmPGWXfwXIs1GF2lc7
        RYknsh/whVZFE6g8zuOYpH02uq6TlGo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F0E022D40C;
        Fri, 26 May 2023 12:54:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 954FEDA85B; Fri, 26 May 2023 14:48:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.4-rc4
Date:   Fri, 26 May 2023 14:48:44 +0200
Message-Id: <cover.1685104958.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes, please pull thanks.

- handle memory allocation error in checksumming helper (reported by
  syzbot)

- fix lockdep splat when aborting a transaction, add NOFS protection
  around invalidate_inode_pages2 that could allocate with GFP_KERNEL

- reduce chances to hit an ENOSPC during scrub with RAID56 profiles

----------------------------------------------------------------
The following changes since commit 1d6a4fc85717677e00fefffd847a50fc5928ce69:

  btrfs: make clear_cache mount option to rebuild FST without disabling it (2023-05-10 14:51:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc3-tag

for you to fetch changes up to 597441b3436a43011f31ce71dc0a6c0bf5ce958a:

  btrfs: use nofs when cleaning up aborted transactions (2023-05-17 13:08:28 +0200)

----------------------------------------------------------------
Johannes Thumshirn (1):
      btrfs: handle memory allocation failure in btrfs_csum_one_bio

Josef Bacik (1):
      btrfs: use nofs when cleaning up aborted transactions

Qu Wenruo (1):
      btrfs: scrub: try harder to mark RAID56 block groups read-only

 fs/btrfs/block-group.c | 14 ++++++++++++--
 fs/btrfs/disk-io.c     |  9 +++++++++
 fs/btrfs/file-item.c   |  4 +++-
 fs/btrfs/scrub.c       |  9 ++++++++-
 4 files changed, 32 insertions(+), 4 deletions(-)
