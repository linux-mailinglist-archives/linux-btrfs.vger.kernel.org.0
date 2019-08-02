Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3050E7FEE7
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391249AbfHBQtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 12:49:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389229AbfHBQtt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 12:49:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 836BCAEC3;
        Fri,  2 Aug 2019 16:49:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 331ABDADC0; Fri,  2 Aug 2019 18:50:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.3-rc3
Date:   Fri,  2 Aug 2019 18:50:19 +0200
Message-Id: <cover.1564757308.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the branch with the following fixes:

* tiny race window during 2 transactions aborting at the same time can
  accidentally lead to a commit

* regression fix, possible deadlock during fiemap

* fix for an old bug when incremental send can fail on a file that has
  been deduplicated in a special way

Thanks.

----------------------------------------------------------------
The following changes since commit a3b46b86ca76d7f9d487e6a0b594fd1984e0796e:

  btrfs: fix extent_state leak in btrfs_lock_and_flush_ordered_range (2019-07-26 12:21:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc2-tag

for you to fetch changes up to a6d155d2e363f26290ffd50591169cb96c2a609e:

  Btrfs: fix deadlock between fiemap and transaction commits (2019-07-30 18:25:12 +0200)

----------------------------------------------------------------
Filipe Manana (3):
      Btrfs: fix incremental send failure after deduplication
      Btrfs: fix race leading to fs corruption after transaction abort
      Btrfs: fix deadlock between fiemap and transaction commits

 fs/btrfs/backref.c     |  2 +-
 fs/btrfs/send.c        | 77 ++++++++++----------------------------------------
 fs/btrfs/transaction.c | 32 ++++++++++++++++++---
 fs/btrfs/transaction.h |  3 ++
 4 files changed, 47 insertions(+), 67 deletions(-)
