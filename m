Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5379F5FA1
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 16:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfKIPHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 10:07:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfKIPHR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Nov 2019 10:07:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 431F7AC37;
        Sat,  9 Nov 2019 15:07:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B555DA7E8; Sat,  9 Nov 2019 16:07:21 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.4-rc7
Date:   Sat,  9 Nov 2019 16:07:16 +0100
Message-Id: <cover.1573307154.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are a few regressions and fixes for stable. Please pull, thanks.

Regressions:

- fix a race leading to metadata space leak after task received a signal

- un-deprecate 2 ioctls, marked as deprecated by mistake

Fixes:

- fix limit check for number of devices during chunk allocation

- fix a race due to double evaluation of i_size_read inside max() macro,
  can cause a crash

- remove wrong device id check in tree-checker

----------------------------------------------------------------
The following changes since commit ba0b084ac309283db6e329785c1dc4f45fdbd379:

  Btrfs: check for the full sync flag while holding the inode lock during fsync (2019-10-17 20:36:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc6-tag

for you to fetch changes up to a5009d3a318e9f02ddc9aa3d55e2c64d6285c4b9:

  btrfs: un-deprecate ioctls START_SYNC and WAIT_SYNC (2019-11-04 21:42:01 +0100)

----------------------------------------------------------------
David Sterba (1):
      btrfs: un-deprecate ioctls START_SYNC and WAIT_SYNC

Filipe Manana (1):
      Btrfs: fix race leading to metadata space leak after task received signal

Josef Bacik (1):
      btrfs: save i_size to avoid double evaluation of i_size_read in compress_file_range

Qu Wenruo (2):
      btrfs: Consider system chunk array size for new SYSTEM chunks
      btrfs: tree-checker: Fix wrong check on max devid

 fs/btrfs/inode.c        | 15 ++++++++++++++-
 fs/btrfs/ioctl.c        |  6 ------
 fs/btrfs/space-info.c   | 21 +++++++++++++++++++++
 fs/btrfs/tree-checker.c |  8 --------
 fs/btrfs/volumes.c      |  1 +
 5 files changed, 36 insertions(+), 15 deletions(-)
