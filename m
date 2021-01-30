Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D4309120
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 02:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhA3A4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 19:56:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:33122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232965AbhA3AyS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 19:54:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611967047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=yy9+LTUUib5Eava6aR+dMkN3FeoOlCdgvNkdvUDboVE=;
        b=VmTOyu8lQRtdV90qa5Pz7bVMFVJ5e5gqmcu56ZnmnEoprcZjlZaEj2UjWBWef3WOK1n6Fk
        a2Fj0qHG3flQrgYajkY6k7wiRD/Al8xBrI6RsbpqWZwIfQ4YkgGW0BBbu0fetBdwiH6FEo
        9n7GEgCFOE/rT/VyHm2QxeTAB9BlCn8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BEB93AC6E;
        Sat, 30 Jan 2021 00:37:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E082DA7C3; Sat, 30 Jan 2021 01:35:38 +0100 (CET)
Date:   Sat, 30 Jan 2021 01:35:38 +0100
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.11-rc6
Message-ID: <cover.1611932305.git.dsterba@suse.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm not sure the first post of this pull request made it through so
sending again.

A few more fixes for a late rc:

- fix lockdep complaint on 32bit arches and also remove an unsafe memory
  use due to device vs filesystem lifetime

- two fixes for free space tree
  - race during log replay and cache rebuild, now more likely to happen
    due to changes in this dev cycle
  - possible free space tree corruption with online conversion during
    initial tree population

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 34d1eb0e599875064955a74712f08ff14c8e3d5f:

  btrfs: don't clear ret in btrfs_start_dirty_block_groups (2021-01-18 16:00:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc5-tag

for you to fetch changes up to 9ad6d91f056b99dbe59a262810cb342519ea8d39:

  btrfs: fix log replay failure due to race with space cache rebuild (2021-01-25 18:44:53 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix log replay failure due to race with space cache rebuild

Josef Bacik (1):
      btrfs: fix possible free space tree corruption with online conversion

Su Yue (1):
      btrfs: fix lockdep warning due to seqcount_mutex on 32bit arch

 fs/btrfs/block-group.c     | 10 +++++++-
 fs/btrfs/ctree.h           |  3 +++
 fs/btrfs/extent-tree.c     | 61 ++++++++++++++--------------------------------
 fs/btrfs/free-space-tree.c | 10 +++++++-
 fs/btrfs/volumes.c         |  2 +-
 fs/btrfs/volumes.h         | 11 +++++----
 6 files changed, 46 insertions(+), 51 deletions(-)
