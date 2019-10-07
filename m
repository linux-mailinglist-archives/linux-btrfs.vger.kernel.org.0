Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7459CECE8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJGTh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 15:37:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:44386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728079AbfJGTh1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 15:37:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6BC0AD7F;
        Mon,  7 Oct 2019 19:37:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27B96DA7FB; Mon,  7 Oct 2019 21:37:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Remove extent_map::bdev
Date:   Mon,  7 Oct 2019 21:37:40 +0200
Message-Id: <cover.1570474492.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent_map::bdev is unused and and can be removed, but it's not
straightforward so there are several steps. The first patch decouples
bdev from map_lookup. The remaining patches clean up use of the bdev,
removing a few bio_set_dev on the way. In the end, submit_extent_page is
one parameter lighter.

This has survived several fstests runs

David Sterba (5):
  btrfs: assert extent_map bdevs and lookup_map and split
  btrfs: get bdev from latest_dev for dio bh_result
  btrfs: drop bio_set_dev where not needed
  btrfs: remove extent_map::bdev
  btrfs: drop bdev argument from submit_extent_page

 fs/btrfs/compression.c | 10 ----------
 fs/btrfs/disk-io.c     |  3 ---
 fs/btrfs/extent_io.c   | 15 +++------------
 fs/btrfs/extent_map.c  |  6 +++++-
 fs/btrfs/extent_map.h  | 11 ++---------
 fs/btrfs/file-item.c   |  1 -
 fs/btrfs/file.c        |  3 ---
 fs/btrfs/inode.c       | 14 ++++----------
 fs/btrfs/relocation.c  |  2 --
 9 files changed, 14 insertions(+), 51 deletions(-)

-- 
2.23.0

