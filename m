Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B112A840
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Dec 2019 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLYNjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Dec 2019 08:39:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLYNjn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Dec 2019 08:39:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D72E6AAA6
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Dec 2019 13:39:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/3] Introduce per-profile available space array to avoid over-confident can_overcommit()
Date:   Wed, 25 Dec 2019 21:39:35 +0800
Message-Id: <20191225133938.115733-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several bug reports of ENOSPC error in
btrfs_run_delalloc_range().

With some extra info from one reporter, it turns out that
can_overcommit() is using a wrong way to calculate allocatable metadata
space.

The most typical case would look like:
  devid 1 unallocated:	1G
  devid 2 unallocated:  10G
  metadata profile:	RAID1

In above case, we can at most allocate 1G chunk for metadata, due to
unbalanced disk free space.
But current can_overcommit() uses factor based calculation, which never
consider the disk free space balance.


To address this problem, here comes the per-profile available space
array, which gets updated every time a chunk get allocated/removed or a
device get grown or shrunk.

This provides a quick way for hotter place like can_overcommit() to grab
an estimation on how many bytes it can over-commit.

The per-profile available space calculation tries to keep the behavior
of chunk allocator, thus it can handle uneven disks pretty well.

The RFC tag is here because I'm not yet confident enough about the
implementation.
I'm not sure this is the proper to go, or just a over-engineered mess.

Qu Wenruo (3):
  btrfs: Introduce per-profile available space facility
  btrfs: Update per-profile available space when device size/used space
    get updated
  btrfs: space-info: Use per-profile available space in can_overcommit()

 fs/btrfs/space-info.c |  15 ++--
 fs/btrfs/volumes.c    | 205 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.h    |  10 +++
 3 files changed, 203 insertions(+), 27 deletions(-)

-- 
2.24.1

