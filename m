Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1DE6245FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiKJPdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiKJPbi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 10:31:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E84DC4E;
        Thu, 10 Nov 2022 07:30:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 123862293C;
        Thu, 10 Nov 2022 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668094200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AC0J52ThlGkm9MsN6oUTTnURzFVxgH77cQk9JrHiop8=;
        b=H3MVxbgREkvughMWP3KzbE3izb04QQiCjBtdR4XOnb3ZLiTEIJhvWJlb386cV3D1nfaMOQ
        JFI0LeZB10xHTwduG7RTZrKBg3Dw9gXsJkImJA/Ws9+p7IPxVZAFdA27LLGlzBqbIahNhZ
        OBFmQ8xzb7ox9zXdBqdRmlVWZKyArfE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 07B492C141;
        Thu, 10 Nov 2022 15:30:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0A74CDA96D; Thu, 10 Nov 2022 16:29:36 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.1-rc5
Date:   Thu, 10 Nov 2022 16:29:36 +0100
Message-Id: <cover.1668091779.git.dsterba@suse.com>
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

a few more regression fixes and regular fixes. Please pull, thanks.

- revert memory optimization for scrub blocks, this misses errors in
  2nd and following blocks

- add exception for ENOMEM as reason for transaction abort to not print
  stack trace, syzbot has reported many

- zoned fixes:
  - fix locking imbalance during scrub
  - initialize zones for seeding device
  - initialize zones for cloned device structures

- when looking up device, change assertion to a real check as some of
  the search parameters can be passed by ioctl, reported by syzbot

- fix error pointer check in self tests

----------------------------------------------------------------
The following changes since commit eb81b682b131642405a05c627ab08cf0967b3dd8:

  btrfs: fix inode reserve space leak due to nowait buffered write (2022-11-02 17:44:45 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc4-tag

for you to fetch changes up to c62f6bec53e63b11112e1ebce6bbaa39ce6f6706:

  btrfs: zoned: fix locking imbalance on scrub (2022-11-07 14:35:25 +0100)

----------------------------------------------------------------
David Sterba (1):
      btrfs: don't print stack trace when transaction is aborted due to ENOMEM

Johannes Thumshirn (3):
      btrfs: zoned: clone zoned device info when cloning a device
      btrfs: zoned: initialize device's zone info for seeding
      btrfs: zoned: fix locking imbalance on scrub

Liu Shixin (1):
      btrfs: fix match incorrectly in dev_args_match_device

Qu Wenruo (1):
      Revert "btrfs: scrub: use larger block size for data extent scrub"

Zhang Xiaoxu (1):
      btrfs: selftests: fix wrong error check in btrfs_free_dummy_root()

 fs/btrfs/ctree.c             | 16 ++++++++++++++++
 fs/btrfs/ctree.h             | 11 +++++++----
 fs/btrfs/disk-io.c           |  4 +++-
 fs/btrfs/scrub.c             |  9 +--------
 fs/btrfs/tests/btrfs-tests.c |  2 +-
 fs/btrfs/volumes.c           | 39 +++++++++++++++++++++++++++++----------
 fs/btrfs/volumes.h           |  2 +-
 fs/btrfs/zoned.c             | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h             | 11 +++++++++++
 9 files changed, 109 insertions(+), 25 deletions(-)
