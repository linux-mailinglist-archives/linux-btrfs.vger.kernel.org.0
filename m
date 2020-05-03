Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61841C2DF0
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgECQ01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 May 2020 12:26:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:53592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgECQ01 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 3 May 2020 12:26:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30AAFAB76;
        Sun,  3 May 2020 16:26:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B282DDA70B; Sun,  3 May 2020 18:25:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.7-rc4, part 2
Date:   Sun,  3 May 2020 18:25:37 +0200
Message-Id: <cover.1588522631.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull a few more stability fixes, minor build warning fixes and
git url fixup. Thanks.

- fix partial loss of prealloc extent past i_size after fsync

- fix potential deadlock due to wrong transaction handle passing via
  journal_info

- fix gcc 4.8 struct intialization warning

- update git URL in MAINTAINERS entry

----------------------------------------------------------------
The following changes since commit 1402d17dfd9657be0da8458b2079d03c2d61c86a:

  btrfs: fix transaction leak in btrfs_recover_relocation (2020-04-23 17:24:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-rc3-tag

for you to fetch changes up to eb91db63a90d8f8e8768b82fcb2cae5f7198cf6b:

  MAINTAINERS: btrfs: fix git repo URL (2020-05-03 18:13:18 +0200)

----------------------------------------------------------------
Arnd Bergmann (1):
      btrfs: fix gcc-4.8 build warning for struct initializer

Eric Biggers (1):
      MAINTAINERS: btrfs: fix git repo URL

Filipe Manana (1):
      btrfs: fix partial loss of prealloc extent past i_size after fsync

Qu Wenruo (1):
      btrfs: transaction: Avoid deadlock due to bad initialization timing of fs_info::journal_info

 MAINTAINERS            |  2 +-
 fs/btrfs/backref.c     |  2 +-
 fs/btrfs/transaction.c | 13 +++++++++++--
 fs/btrfs/tree-log.c    | 43 ++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 53 insertions(+), 7 deletions(-)
