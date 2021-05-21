Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4A38CEAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhEUUPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 16:15:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhEUUPN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:15:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621628028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FF/j55GfQl57arjqXTMUh9IA8X9Sg5o3NkTPqiHMnFM=;
        b=YBXOLP76l/8OebEdTj+QBfeXkzop2bTAvmQJ7L3/GifV17AfGH0FyD/LucWO+C2cWYqsM1
        QkChEIXRGlm2qoKXCvjR+J7S7YXD9UqI1GdB4puZxVlZBfgvEwx0HULzsJYQaz6vpyACWL
        phPnAaFiWRmirUJo6IwJ1VlH9D9c7Fg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0E36AAA6;
        Fri, 21 May 2021 20:13:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47868DA72C; Fri, 21 May 2021 22:11:14 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for v5.13-rc3, part 2
Date:   Fri, 21 May 2021 22:11:13 +0200
Message-Id: <cover.1621627293.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes. Please pull, thanks.

- fix unaligned compressed writes in zoned mode

- fix false positive lockdep warning when cloning inline extent

- remove wrong BUG_ON in tree-log error handling

----------------------------------------------------------------
The following changes since commit 54a40fc3a1da21b52dbf19f72fdc27a2ec740760:

  btrfs: fix removed dentries still existing after log is synced (2021-05-14 01:23:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc2-tag

for you to fetch changes up to 764c7c9a464b68f7c6a5a9ec0b923176a05e8e8f:

  btrfs: zoned: fix parallel compressed writes (2021-05-20 15:51:07 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: release path before starting transaction when cloning inline extent

Johannes Thumshirn (2):
      btrfs: zoned: pass start block to btrfs_use_zone_append
      btrfs: zoned: fix parallel compressed writes

Josef Bacik (1):
      btrfs: do not BUG_ON in link_to_fixup_dir

 fs/btrfs/compression.c | 42 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/reflink.c     |  5 +++++
 fs/btrfs/tree-log.c    |  2 --
 fs/btrfs/zoned.c       |  4 ++--
 fs/btrfs/zoned.h       |  5 ++---
 7 files changed, 49 insertions(+), 13 deletions(-)
