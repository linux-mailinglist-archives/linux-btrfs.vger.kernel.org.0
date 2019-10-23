Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CDE20E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJWQr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:47:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfJWQr6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:47:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48ACEADCB;
        Wed, 23 Oct 2019 16:47:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C256DA734; Wed, 23 Oct 2019 18:48:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/6] Block group structure cleanups
Date:   Wed, 23 Oct 2019 18:48:07 +0200
Message-Id: <cover.1571848791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The block group cache structure has two embedded members that belong to
the on-disk format but were used for the in-memory structures. It's been
like that forever and I wonder why nobody was bothered by that. Switch
to normal members and rename a few things on along the way.

The size of block_group_cache is down from 528 to 504 so it should not
fit better to slab pages. Further shrinkage is possible.

David Sterba (6):
  btrfs: move block_group_item::used to block group
  btrfs: move block_group_item::flags to block group
  btrfs: remove embedded block_group_cache::item
  btrfs: rename block_group_item on-stack accessors to follow naming
  btrfs: rename extent buffer block group item accessors
  btrfs: add dedicated members for start and length of a block group

 fs/btrfs/block-group.c                 | 191 +++++++++++++------------
 fs/btrfs/block-group.h                 |   5 +-
 fs/btrfs/ctree.h                       |  12 +-
 fs/btrfs/extent-tree.c                 |  31 ++--
 fs/btrfs/free-space-cache.c            |  39 +++--
 fs/btrfs/free-space-tree.c             |  83 ++++++-----
 fs/btrfs/ioctl.c                       |   5 +-
 fs/btrfs/print-tree.c                  |   6 +-
 fs/btrfs/reada.c                       |   4 +-
 fs/btrfs/relocation.c                  |  18 +--
 fs/btrfs/scrub.c                       |  10 +-
 fs/btrfs/space-info.c                  |   3 +-
 fs/btrfs/sysfs.c                       |   4 +-
 fs/btrfs/tests/btrfs-tests.c           |   5 +-
 fs/btrfs/tests/free-space-tree-tests.c |  75 +++++-----
 fs/btrfs/tree-checker.c                |  10 +-
 fs/btrfs/volumes.c                     |  19 ++-
 include/trace/events/btrfs.h           |  21 ++-
 18 files changed, 264 insertions(+), 277 deletions(-)

-- 
2.23.0

