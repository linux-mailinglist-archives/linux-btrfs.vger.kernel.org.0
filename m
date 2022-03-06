Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C254C4CEC3E
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiCFQhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 11:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiCFQhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 11:37:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE82654F;
        Sun,  6 Mar 2022 08:36:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 312CB1F38E;
        Sun,  6 Mar 2022 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646584585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y/OFp9JJppWMgaJ4C2eJKgXQ8oIgkJro1umFnsey9cs=;
        b=n3hV1mEWP6oV9tNhk/zwFZMNJNwvg+uXHvtBHfm1/iglGqA22nfhyTqR6sdglHu0lVEGcc
        Kv3uiEVcMdDPL/HeSC2NugPwAp1PpS+8iXrA6UPGKISJNz3tTepNSHNmyw2yxoNKFUHuSL
        hSRmjOWVgVen5SXg9EJU9Uhgvr/TBco=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2905EA3B81;
        Sun,  6 Mar 2022 16:36:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 239A4DA823; Sun,  6 Mar 2022 17:32:31 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.17-rc7
Date:   Sun,  6 Mar 2022 17:32:30 +0100
Message-Id: <cover.1646581845.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

a few more fixes for various problems that have user visible effects or
seem to be urgent. Please pull, thanks.

* fix corruption when combining DIO and non-blocking iouring over
  multiple extents (seen on MariaDB)

* fix relocation crash due to premature return from commit

* fix quota deadlock between rescan and qgroup removal

* fix item data bounds checks in tree-checker (found on a fuzzed image)

* fix fsync of prealloc extents after EOF

* add missing run of delayed items after unlink during log replay

* don't start relocation until snapshot drop is finished

* fix reversed condition for subpage writers locking

* fix warning on page error

----------------------------------------------------------------
The following changes since commit 558732df2122092259ab4ef85594bee11dbb9104:

  btrfs: reduce extent threshold for autodefrag (2022-02-24 16:11:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc6-tag

for you to fetch changes up to ca93e44bfb5fd7996b76f0f544999171f647f93b:

  btrfs: fallback to blocking mode when doing async dio over multiple extents (2022-03-04 15:09:21 +0100)

----------------------------------------------------------------
Filipe Manana (3):
      btrfs: fix lost prealloc extents beyond eof after full fsync
      btrfs: add missing run of delayed items after unlink during log replay
      btrfs: fallback to blocking mode when doing async dio over multiple extents

Josef Bacik (2):
      btrfs: do not WARN_ON() if we have PageError set
      btrfs: do not start relocation until in progress drops are done

Omar Sandoval (1):
      btrfs: fix relocation crash due to premature return from btrfs_commit_transaction()

Qu Wenruo (1):
      btrfs: subpage: fix a wrong check on subpage->writers

Sidong Yang (1):
      btrfs: qgroup: fix deadlock between rescan worker and remove qgroup

Su Yue (1):
      btrfs: tree-checker: use u64 for item data end to avoid overflow

 fs/btrfs/ctree.h        | 10 ++++++++
 fs/btrfs/disk-io.c      | 10 ++++++++
 fs/btrfs/extent-tree.c  | 10 ++++++++
 fs/btrfs/extent_io.c    | 16 +++++++++---
 fs/btrfs/inode.c        | 28 +++++++++++++++++++++
 fs/btrfs/qgroup.c       |  9 ++++++-
 fs/btrfs/relocation.c   | 13 ++++++++++
 fs/btrfs/root-tree.c    | 15 ++++++++++++
 fs/btrfs/subpage.c      |  2 +-
 fs/btrfs/transaction.c  | 65 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/transaction.h  |  1 +
 fs/btrfs/tree-checker.c | 18 +++++++-------
 fs/btrfs/tree-log.c     | 61 +++++++++++++++++++++++++++++++++++++---------
 13 files changed, 230 insertions(+), 28 deletions(-)
