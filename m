Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77E349BBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 22:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhCYVj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 17:39:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:56116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhCYVjD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 17:39:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616708342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=z3BG5U3x049EYsQC5Opp/vswO9id6Cc9V2vrNMIpcFs=;
        b=SHWijGRlQfWbmuGiqHSFTkPWppBqswWuwZ6mCztSD+cEhdqppFSBh782KsKFKp7isQdZno
        kZGs8i3E/rcfgXSv4nzaP7TmiS27Qy8sgcfstcHp6npgSzQw5KUdRFGiXb1ubVMDIYPxiZ
        K9/HViMcbRd+lPbtMHHm6RRyjR7Z6k4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDD33AD8D;
        Thu, 25 Mar 2021 21:39:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CAF17DA732; Thu, 25 Mar 2021 22:36:55 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.12-rc5
Date:   Thu, 25 Mar 2021 22:36:55 +0100
Message-Id: <cover.1616690512.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

there are few fixes for issues that have some user visibility and are
simple enough for this time of development cycle.

Please pull thanks.

- a few fixes for rescue= mount option, adding more checks for missing
  trees

- fix sleeping in atomic context on qgroup deletion

- fix subvolume deletion on mount

- fix build with M= syntax

- fix checksum mismatch error message for direct io

----------------------------------------------------------------
The following changes since commit 485df75554257e883d0ce39bb886e8212349748e:

  btrfs: always pin deleted leaves when there are active tree mod log users (2021-03-16 20:32:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc4-tag

for you to fetch changes up to c1d6abdac46ca8127274bea195d804e3f2cec7ee:

  btrfs: fix check_data_csum() error message for direct I/O (2021-03-18 21:25:11 +0100)

----------------------------------------------------------------
David Sterba (1):
      btrfs: fix build when using M=fs/btrfs

Filipe Manana (2):
      btrfs: fix subvolume/snapshot deletion not triggered on mount
      btrfs: fix sleep while in non-sleep context during qgroup removal

Johannes Thumshirn (1):
      btrfs: zoned: remove outdated WARN_ON in direct IO

Josef Bacik (3):
      btrfs: do not initialize dev stats if we have no dev_root
      btrfs: initialize device::fs_info always
      btrfs: do not initialize dev replace for bad dev root

Omar Sandoval (1):
      btrfs: fix check_data_csum() error message for direct I/O

 fs/btrfs/Makefile      | 10 ++++++----
 fs/btrfs/dev-replace.c |  3 +++
 fs/btrfs/disk-io.c     | 19 +++++++++++++++++--
 fs/btrfs/inode.c       | 18 +++++++++---------
 fs/btrfs/qgroup.c      | 12 ++++++++++--
 fs/btrfs/volumes.c     |  3 +++
 6 files changed, 48 insertions(+), 17 deletions(-)
