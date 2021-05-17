Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70097382DE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 15:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhEQNv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 09:51:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:40558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhEQNv0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 09:51:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621259409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Yuynx1ZfQy1XbbVokHeTdBIN44lHNRY03oROZvyFNJA=;
        b=sEzQL4TodnDnF/5IgSKRx8kBG0F/JxVxVGA1FHAe+Fq6knncU5thjDo8ORC2NOfkVisnVf
        6DmckX9UZyzSC3m7ln5XY/OHcGakg4zPC8K3uLnu/92GvdG6crWbCPr0+HbLplvHJxQJS1
        TtuBel6Et49RyEIK+k3bMY4+hLrojtw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADBF4AC8F;
        Mon, 17 May 2021 13:50:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46AF7DB228; Mon, 17 May 2021 15:47:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.13-rc3
Date:   Mon, 17 May 2021 15:47:35 +0200
Message-Id: <cover.1621258094.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes, please pull. Thanks.

- fix fiemap to print extents that could get misreported due to internal
  extent splitting and logical merging for fiemap output

- fix RCU stalls during delayed iputs

- fix removed dentries still existing after log is synced

----------------------------------------------------------------
The following changes since commit 77364faf21b4105ee5adbb4844fdfb461334d249:

  btrfs: initialize return variable in cleanup_free_space_cache_v1 (2021-05-04 18:05:15 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc2-tag

for you to fetch changes up to 54a40fc3a1da21b52dbf19f72fdc27a2ec740760:

  btrfs: fix removed dentries still existing after log is synced (2021-05-14 01:23:04 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: return whole extents in fiemap

Filipe Manana (1):
      btrfs: fix removed dentries still existing after log is synced

Johannes Thumshirn (1):
      btrfs: return 0 for dev_extent_hole_check_zoned hole_start in case of error

Josef Bacik (1):
      btrfs: avoid RCU stalls while running delayed iputs

 fs/btrfs/extent_io.c |  7 ++++++-
 fs/btrfs/inode.c     |  1 +
 fs/btrfs/tree-log.c  | 18 ++++++++++++++++++
 fs/btrfs/volumes.c   |  2 +-
 4 files changed, 26 insertions(+), 2 deletions(-)
