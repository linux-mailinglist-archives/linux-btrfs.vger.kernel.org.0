Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08329B523
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfHWRIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:08:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732234AbfHWRIJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDC6DAC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:08:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66954DA796; Fri, 23 Aug 2019 19:08:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/7] Move some code out of ctree.c and ctree.h
Date:   Fri, 23 Aug 2019 19:08:31 +0200
Message-Id: <cover.1566579823.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ctree.[ch] files gathered a lot of unrelated code over the years, it
should be moved to appropriate files. This series does the easiest part,
nes I'll split the incompate/feature handling and messages.

David Sterba (7):
  btrfs: move cond_wake_up functions out of ctree
  btrfs: move math functions to misc.h
  btrfs: move private raid56 definitions from ctree.h
  btrfs: rename and export read_node_slot
  btrfs: move functions for tree compare to send.c
  btrfs: move struct io_ctl to free-space-cache.h
  btrfs: move dev_stats helpers to volumes.c

 fs/btrfs/block-group.c      |   2 +-
 fs/btrfs/block-group.h      |   2 +
 fs/btrfs/block-rsv.c        |   2 +-
 fs/btrfs/compression.c      |   1 +
 fs/btrfs/ctree.c            | 382 +-----------------------------------
 fs/btrfs/ctree.h            |  93 +--------
 fs/btrfs/delayed-inode.c    |   1 +
 fs/btrfs/dev-replace.c      |   1 +
 fs/btrfs/extent-tree.c      |   2 +-
 fs/btrfs/free-space-cache.h |  14 +-
 fs/btrfs/inode.c            |   1 +
 fs/btrfs/locking.c          |   1 +
 fs/btrfs/math.h             |  28 ---
 fs/btrfs/misc.h             |  50 +++++
 fs/btrfs/ordered-data.c     |   1 +
 fs/btrfs/raid56.c           |  16 ++
 fs/btrfs/send.c             | 374 +++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.c       |   2 +-
 fs/btrfs/transaction.c      |   1 +
 fs/btrfs/tree-log.c         |   1 +
 fs/btrfs/volumes.c          |  25 ++-
 fs/btrfs/zstd.c             |   1 +
 22 files changed, 505 insertions(+), 496 deletions(-)
 delete mode 100644 fs/btrfs/math.h
 create mode 100644 fs/btrfs/misc.h

-- 
2.22.0

