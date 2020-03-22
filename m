Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76718EA86
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Mar 2020 17:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgCVQiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Mar 2020 12:38:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVQiN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Mar 2020 12:38:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF7E3AC24;
        Sun, 22 Mar 2020 16:38:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02389DA70B; Sun, 22 Mar 2020 17:37:41 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.6-rc7
Date:   Sun, 22 Mar 2020 17:37:40 +0100
Message-Id: <cover.1584893030.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following branch with two fixes. The first is a
regression, when dropping some incompat bits the conditions were
reversed, the other is a fix for rename whiteout potentially leaving
stack memory linked to a list.  Thanks.

----------------------------------------------------------------
The following changes since commit e7a04894c766daa4248cb736efee93550f2d5872:

  btrfs: fix RAID direct I/O reads with alternate csums (2020-03-03 15:26:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc6-tag

for you to fetch changes up to d8e6fd5c7991033037842b32c9774370a038e902:

  btrfs: fix removal of raid[56|1c34} incompat flags after removing block group (2020-03-20 21:31:32 +0100)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix log context list corruption after rename whiteout error
      btrfs: fix removal of raid[56|1c34} incompat flags after removing block group

 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/inode.c       | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)
