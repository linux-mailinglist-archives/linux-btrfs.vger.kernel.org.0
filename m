Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A639A3B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFCOym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 10:54:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOym (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 10:54:42 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB94F219FC;
        Thu,  3 Jun 2021 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622731976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LllFbR9Tx5VhCEx+xj05LcWJlD4OQ5cmrPp/AfZjk+o=;
        b=MP7V3W5Nmq0PqAbtcKnounL1xIYKMFUgBtuN5+Kkj+3Z7N5b39YIVErBwpCwaDLDNRM5H3
        +FxO79007tvjHEe0vCg4ej//NOv+dtaXAZCdk6ivHvip6Lhf026AHRhbtE9lRlRq6vjhDR
        MTYH1UWWK7T/WDDxfaQH6/GMn+ajHOQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E442BA3B81;
        Thu,  3 Jun 2021 14:52:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED188DA89C; Thu,  3 Jun 2021 16:50:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.13-rc5
Date:   Thu,  3 Jun 2021 16:50:15 +0200
Message-Id: <cover.1622728563.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a batch from last week, I wanted to give it more testing because
last pull request introduced a bug, interacting zoned and subpage
features. Otherwise there are error handling improvements and bug
fixes. The last commit is from today, adding IRC link to maintainers
file.

Please pull, thanks.

- error handling improvements, caught by error injection
  - handle errors during checksum deletion
  - set error on mapping when ordered extent io cannot be finished
  - inode link count fixup in tree-log
  - missing return value checks for inode updates in tree-log
  - abort transaction in rename exchange if adding second reference fails

- fixes
  - fix fsync failure after writes to prealloc extents
  - fix deadlock when cloning inline extents and low on available space
  - fix compressed writes that cross stripe boundary

----------------------------------------------------------------
The following changes since commit 764c7c9a464b68f7c6a5a9ec0b923176a05e8e8f:

  btrfs: zoned: fix parallel compressed writes (2021-05-20 15:51:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc4-tag

for you to fetch changes up to 503d1acb01826b42e5afb496dfcc32751bec9478:

  MAINTAINERS: add btrfs IRC link (2021-06-03 15:40:38 +0200)

----------------------------------------------------------------
David Sterba (1):
      MAINTAINERS: add btrfs IRC link

Filipe Manana (2):
      btrfs: fix fsync failure and transaction abort after writes to prealloc extents
      btrfs: fix deadlock when cloning inline extents and low on available space

Josef Bacik (6):
      btrfs: fix error handling in btrfs_del_csums
      btrfs: return errors from btrfs_del_csums in cleanup_ref_head
      btrfs: mark ordered extent and inode with error if we fail to finish
      btrfs: fixup error handling in fixup_inode_link_counts
      btrfs: check error value from btrfs_update_inode in tree log
      btrfs: abort in rename_exchange if we fail to insert the second ref

Qu Wenruo (1):
      btrfs: fix compressed writes that cross stripe boundary

 MAINTAINERS            |   1 +
 fs/btrfs/compression.c |  17 +++++---
 fs/btrfs/extent-tree.c |   2 +-
 fs/btrfs/file-item.c   | 108 ++++++++++++++++++++++++++++++++++++-------------
 fs/btrfs/inode.c       |  19 ++++++++-
 fs/btrfs/reflink.c     |  38 +++++++++--------
 fs/btrfs/tree-log.c    |  21 ++++++----
 7 files changed, 148 insertions(+), 58 deletions(-)
