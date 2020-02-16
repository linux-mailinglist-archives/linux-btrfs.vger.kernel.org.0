Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7417F160434
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2020 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBPNwG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Feb 2020 08:52:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:45176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgBPNwG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Feb 2020 08:52:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5AE57AC67;
        Sun, 16 Feb 2020 13:52:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0702CDA7A0; Sun, 16 Feb 2020 14:51:48 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.6-rc2
Date:   Sun, 16 Feb 2020 14:51:45 +0100
Message-Id: <cover.1581859345.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following mix of fixes. There are two races fixed,
memory leak fix, sysfs directory fixup and two new log messages.

* two fixed race conditions: extent map merging and truncate vs fiemap

* create the right sysfs directory with device information and move the
  individual device dirs under it

* print messages when the tree-log is replayed at mount time or cannot
  be replayed on remount

Thanks.

----------------------------------------------------------------
The following changes since commit d55966c4279bfc6a0cf0b32bf13f5df228a1eeb6:

  btrfs: do not zero f_bavail if we have available space (2020-02-02 18:49:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag

for you to fetch changes up to 1b9867eb6120db85f8dca8ff42789d9ec9ee16a5:

  btrfs: sysfs, move device id directories to UUID/devinfo (2020-02-12 18:28:22 +0100)

----------------------------------------------------------------
Anand Jain (2):
      btrfs: sysfs, add UUID/devinfo kobject
      btrfs: sysfs, move device id directories to UUID/devinfo

David Sterba (2):
      btrfs: print message when tree-log replay starts
      btrfs: log message when rw remount is attempted with unclean tree-log

Filipe Manana (2):
      Btrfs: fix race between using extent maps and merging them
      Btrfs: fix race between shrinking truncate and fiemap

Wenwen Wang (1):
      btrfs: ref-verify: fix memory leaks

 fs/btrfs/disk-io.c    |  1 +
 fs/btrfs/extent_map.c | 11 +++++++++++
 fs/btrfs/inode.c      |  8 ++++++++
 fs/btrfs/ref-verify.c |  5 +++++
 fs/btrfs/super.c      |  2 ++
 fs/btrfs/sysfs.c      | 17 ++++++++++++++++-
 fs/btrfs/volumes.h    |  1 +
 7 files changed, 44 insertions(+), 1 deletion(-)
