Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34865E467B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 11:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408322AbfJYJAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 05:00:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:55076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405717AbfJYJAB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 05:00:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73338B4D1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 09:00:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/2] btrfs: trim: Fix a bug certain range may not be trimmed properly
Date:   Fri, 25 Oct 2019 16:59:54 +0800
Message-Id: <20191025085956.48352-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug report about discard mount option not trimming some range
properly, and causing unexpected space usage for thin device.

It turns out to be that, if there are pinned extents across block group
boundary, we will only trim to the end of current block group, skipping
the remaining.

This patchset will fix it by ensuring btrfs_discard_extent() will
iterate the full range before exiting.

The first patch is just a tiny readability improvement found during the
fix.
The second patch is the main body of the fix.

Meanwhile I'm still looking into how to craft such test case for btrfs,
so the test case may be late for several days.

Changelog:
v2:
- Fold the __btrfs_map_block_for_discard() @length change into the main
  patch
  Since the @length parameter change itself doesn't make much sense,
  folding it into the fix looks more reasonable.

- Split the tiny readability improvement patch into its own patch

v3:
- Reset @num_bytes for btrfs_map_block() to limit the trim range inside
  the original range.
  Or we can trim into existing extent to corrupt data.

v4:
- Use better ASCII graph to show the bug
  No code change at all.

Qu Wenruo (2):
  btrfs: volumes: Use more straightforward way to calculate map length
  btrfs: extent-tree: Ensure we trim ranges across block group boundary

 fs/btrfs/extent-tree.c | 41 +++++++++++++++++++++++++++++++----------
 fs/btrfs/volumes.c     |  8 +++++---
 2 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.23.0

