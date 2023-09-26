Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4CA7AF0AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjIZQ2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIZQ2r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 12:28:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567DBF;
        Tue, 26 Sep 2023 09:28:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 93A8421887;
        Tue, 26 Sep 2023 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695745718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Uo78WXp4NpI2DQI1aEMIMuXwKeeSHBd+jS5nF8ZBxc4=;
        b=syCW5o+0ILbFHDZeaeZa0ENnHru/Nc+hTHjrs5RKmFgfSbEE+KGLFgEsUt0eStYhsi5j8T
        EnSXjoOpsw6HDwAU7Xa8FBT3NPF1Dkp6B9JUzkfOK5+ak46pjhj6m22G9BYsqQhHMzlPVX
        Ily3iu0fcYtTChcPIoR3fOjm7M/8mds=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 695D82C145;
        Tue, 26 Sep 2023 16:28:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09871DA832; Tue, 26 Sep 2023 18:22:01 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.6-rc4
Date:   Tue, 26 Sep 2023 18:22:00 +0200
Message-ID: <cover.1695744160.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes and build warning fixes. Please pull, thanks.

- delayed refs fixes:
  - fix race when refilling delayed refs block reserve
  - prevent transaction block reserve underflow when starting transaction
  - error message and value adjustments

- fix build warnings with CONFIG_CC_OPTIMIZE_FOR_SIZE and -Wmaybe-uninitialized

- fix for smatch report where uninitialized data from invalid extent
  buffer range could be returned to the caller

- fix numeric overflow in statfs when calculating lower threshold for a
  full filesystem


----------------------------------------------------------------
The following changes since commit 8e7f82deb0c0386a03b62e30082574347f8b57d5:

  btrfs: fix race between reading a directory and adding entries to it (2023-09-14 23:24:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc3-tag

for you to fetch changes up to b4c639f699349880b7918b861e1bd360442ec450:

  btrfs: initialize start_slot in btrfs_log_prealloc_extents (2023-09-21 18:52:23 +0200)

----------------------------------------------------------------
Filipe Manana (5):
      btrfs: fix race when refilling delayed refs block reserve
      btrfs: prevent transaction block reserve underflow when starting transaction
      btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
      btrfs: remove redundant BUG_ON() from __btrfs_inc_extent_ref()
      btrfs: log message if extent item not found when running delayed extent op

Josef Bacik (3):
      btrfs: properly report 0 avail for very full file systems
      btrfs: make sure to initialize start and len in find_free_dev_extent
      btrfs: initialize start_slot in btrfs_log_prealloc_extents

Qu Wenruo (1):
      btrfs: reset destination buffer when read_extent_buffer() gets invalid range

 fs/btrfs/delayed-ref.c | 46 +++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/delayed-ref.h |  1 -
 fs/btrfs/extent-tree.c | 18 ++++++++++--------
 fs/btrfs/extent_io.c   |  8 +++++++-
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c |  6 +++---
 fs/btrfs/tree-log.c    |  2 +-
 fs/btrfs/volumes.c     | 13 ++++++-------
 8 files changed, 63 insertions(+), 33 deletions(-)
