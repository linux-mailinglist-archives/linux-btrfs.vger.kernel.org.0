Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6966C32E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 16:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjAPPBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 10:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjAPPAl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 10:00:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC62332B;
        Mon, 16 Jan 2023 06:51:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2B31F37642;
        Mon, 16 Jan 2023 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673880678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1yNIiC+DlOYTUjgeCCgqwn2x0yECAXqm0gh7u//B+3g=;
        b=BtSTYuumDX11ifUEjXqrhSIMxTTgNL28469+794F8tPYZFQ1lyYJvjGKgoqcroaoiGFnzE
        koEKXLDF4dyHeNIkykjN25yVZYXQZiWRI9DrEVtjSc6VuRVU6ngG+ZTMzeS1C9n2a6aqSh
        +0NOhHxwyLmhDQf/6LaM1eTxQ9Vw9Tc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2064A2C186;
        Mon, 16 Jan 2023 14:51:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8EC9DA7E1; Mon, 16 Jan 2023 15:45:41 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.2-rc5
Date:   Mon, 16 Jan 2023 15:45:40 +0100
Message-Id: <cover.1673876631.git.dsterba@suse.com>
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

another batch of fixes, dealing with fallouts from 6.1 reported by users.

One or two extra -rcs would be appreciated, this pull request is for rc5
which is my usual target for big changes code freeze but there are still
such branches in the queue.

Please pull, thanks.

- tree-log fixes
  - fix directory logging due to race with concurrent index key deletion
  - fix missing error handling when logging directory items
  - handle case of conflicting inodes being added to the log
  - remove transaction aborts for not so serious errors

- fix qgroup accounting warning when rescan can be started at time with
  temporarily disable accounting

- print more specific errors to system log when device scan ioctl fails

- disable space overcommit for ZNS devices, causing heavy performance
  drop

----------------------------------------------------------------
The following changes since commit 2ba48b20049b5a76f34a85f853c9496d1b10533a:

  btrfs: fix compat_ro checks against remount (2023-01-03 16:22:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc4-tag

for you to fetch changes up to 09e44868f1e03c7825ca4283256abedc95e249a3:

  btrfs: do not abort transaction on failure to update log root (2023-01-12 15:43:31 +0100)

----------------------------------------------------------------
Filipe Manana (5):
      btrfs: fix missing error handling when logging directory items
      btrfs: add missing setup of log for full commit at add_conflicting_inode()
      btrfs: do not abort transaction on failure to write log tree when syncing log
      btrfs: do not abort transaction on failure to update log root

Naohiro Aota (1):
      btrfs: zoned: enable metadata over-commit for non-ZNS setup

Qu Wenruo (2):
      btrfs: add extra error messages to cover non-ENOMEM errors from device_add_list()
      btrfs: qgroup: do not warn on record without old_roots populated

 fs/btrfs/disk-io.c    |  9 ++++++++-
 fs/btrfs/fs.h         |  6 ++++++
 fs/btrfs/qgroup.c     | 14 ++++++++++++--
 fs/btrfs/space-info.c |  3 ++-
 fs/btrfs/tree-log.c   | 47 +++++++++++++++++++++++++++++++----------------
 fs/btrfs/volumes.c    | 11 ++++++++++-
 fs/btrfs/zoned.c      |  2 ++
 7 files changed, 71 insertions(+), 21 deletions(-)
