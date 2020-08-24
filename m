Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6C250371
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHXQpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 12:45:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:58018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgHXQox (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 12:44:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C9E7AC46;
        Mon, 24 Aug 2020 16:45:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52A8BDA730; Mon, 24 Aug 2020 18:43:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.9-rc3
Date:   Mon, 24 Aug 2020 18:43:43 +0200
Message-Id: <cover.1598283719.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes. Please pull, Thanks.

- fix swapfile activation on subvolumes with deleted snapshots

- error value mixup when removing directory entries from tree log

- fix lzo compression level reset after previous level setting

- fix space cache memory leak after transaction abort

- fix const function attribute

- more error handling improvements

----------------------------------------------------------------
The following changes since commit c57dd1f2f6a7cd1bb61802344f59ccdc5278c983:

  btrfs: trim: fix underflow in trim length to prevent access beyond device boundary (2020-08-12 10:15:58 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc2-tag

for you to fetch changes up to a84d5d429f9eb56f81b388609841ed993f0ddfca:

  btrfs: detect nocow for swap after snapshot delete (2020-08-21 12:21:23 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: detect nocow for swap after snapshot delete

David Sterba (1):
      btrfs: use the correct const function attribute for btrfs_get_num_csums

Filipe Manana (1):
      btrfs: fix space cache memory leak after transaction abort

Johannes Thumshirn (1):
      btrfs: handle errors from async submission

Josef Bacik (1):
      btrfs: check the right error variable in btrfs_del_dir_entries_in_log

Marcos Paulo de Souza (1):
      btrfs: reset compression level for lzo on remount

 fs/btrfs/ctree.c            |  2 +-
 fs/btrfs/ctree.h            |  6 +++---
 fs/btrfs/disk-io.c          |  1 +
 fs/btrfs/extent-tree.c      | 17 +++++++++++------
 fs/btrfs/file.c             |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 29 ++++++++++++++---------------
 fs/btrfs/super.c            |  1 +
 fs/btrfs/tree-log.c         | 10 ++++++----
 9 files changed, 39 insertions(+), 31 deletions(-)
