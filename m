Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C1275407
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIWJIj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 05:08:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIWJIj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 05:08:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A73F0AC65;
        Wed, 23 Sep 2020 09:09:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3925DA6E3; Wed, 23 Sep 2020 11:07:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.9-rc7
Date:   Wed, 23 Sep 2020 11:07:20 +0200
Message-Id: <cover.1600846065.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

syzkaller started to hit us with reports, in this pull request there's a
fix for one type (stack overflow when printing checksums on read error).
The other patch is a fix for sysfs object, we have a test for that and
it leads to a crash.

The other syzkaller reports are most likely races around device locking,
we have a candidate fix that's been in the development queue.  Some
reports don't have a reproducer and validating the fix is not
straightforward, I'll send another pull request once this is finished.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 1c78544eaa4660096aeb6a57ec82b42cdb3bfe5a:

  btrfs: fix wrong address when faulting in pages in the search ioctl (2020-09-14 17:27:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc6-tag

for you to fetch changes up to b5ddcffa37778244d5e786fe32f778edf2bfc93e:

  btrfs: fix put of uninitialized kobject after seed device delete (2020-09-22 15:57:52 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: fix put of uninitialized kobject after seed device delete

Johannes Thumshirn (1):
      btrfs: fix overflow when copying corrupt csums for a message

 fs/btrfs/disk-io.c | 11 +++++------
 fs/btrfs/sysfs.c   | 16 ++++++++++------
 2 files changed, 15 insertions(+), 12 deletions(-)
