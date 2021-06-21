Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169003AE6C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFUKM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 06:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUKM4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 06:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACE5461164
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624270242;
        bh=woPXeS0HuyN2MCctAg5s4TL6qYHOhiqTd6fNDdvLUjA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H7Ags+Me9IdSNtk3tFUcbPW6r8tKIhgCxPpARz19lw8euTGGLylxGHy5/KDgQ9LxD
         yqRDRpydIszF29Vso0/tHBnO2bz8zG5uQO8Zzb2hAt56kW9/pTNMu2FFpOw16+6pu6
         BFkO7YRo6f7wzzKdkgVARxW1LTSJH/kyiDwlzu/+bM58VUu7NAv327VfqqiUqs5Cgg
         fC2LreFCoJWAJjfVAKwgzRvkQhnWKKLzmclflui1E5fNA1eL0yLSlbhp96g+GdIDxd
         uIywM5KOtDrCGHu83CvuWWY3er+wHGZyj30CtIXSM/Yle033gluc/9p/97leL8lKhB
         M9HUmVVp04nPQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fixes for send with relocation and reclaim
Date:   Mon, 21 Jun 2021 11:10:37 +0100
Message-Id: <cover.1624269734.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623924268.git.fdmanana@suse.com>
References: <cover.1623924268.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's a recent report from Chris Murphy on a crash caused by send
triggering reclaim and inode eviction due to page/memory allocation,
the second patch fixes that. The first one just prevents relocation from
happening while there are send operations in progress, as currently only
balance is prevented from running but other operations can trigger
relocation too (device shrinking and automatic chunk relocation on zoned
filesystems). Details are in the changelogs of the patches.


V2: Add missing hunk to patch 1 where fs_info->send_in_progress is
    decremented while holding fs_info->send_reloc_lock and no longer
    while holding fs_info->balance_mutex. No changes to patch 2
    except for the rebase.

Filipe Manana (2):
  btrfs: ensure relocation never runs while we have send operations
    running
  btrfs: send: fix crash when memory allocations trigger reclaim

 fs/btrfs/block-group.c | 10 ++++++++--
 fs/btrfs/ctree.h       |  5 +++--
 fs/btrfs/disk-io.c     | 19 ++-----------------
 fs/btrfs/qgroup.c      |  8 +-------
 fs/btrfs/relocation.c  | 13 +++++++++++++
 fs/btrfs/send.c        | 16 +++++++---------
 fs/btrfs/transaction.c |  3 ---
 fs/btrfs/transaction.h |  2 --
 fs/btrfs/volumes.c     |  8 --------
 9 files changed, 34 insertions(+), 50 deletions(-)

-- 
2.28.0

