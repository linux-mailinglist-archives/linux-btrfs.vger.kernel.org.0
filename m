Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D692340EEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 21:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhCRUQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 16:16:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhCRUQQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 16:16:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616098575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kMdeVu/yfgCb3jtV2y/tNtXsw895N8mesfITRLjpQKU=;
        b=WGkX1on4xJ9APyNeMdofABZlo98oXof8GnuxN64WplsZkH8x0Y4Hwz5D2L9LplTOHvtvQM
        zOJy+IvI5BMHxHSLrq3Z8pnWIgUTpDJ1o/qMPtUB4aPj8yJH/E1CJpSnq+23mKZMA5OiK1
        W8LVzt9sDgiSUBT0cTw803wL+7xutts=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1956AC24;
        Thu, 18 Mar 2021 20:16:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38FE2DA6E2; Thu, 18 Mar 2021 21:14:12 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.12-rc4
Date:   Thu, 18 Mar 2021 21:14:11 +0100
Message-Id: <cover.1616083082.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

there are still regressions being found and fixed in the zoned mode and
subpage code, the rest are fixes for bugs reported by users. Please
pull, thanks.

Regressions:

- subpage block support:
  - readahead works on the proper block size
  - fix last page zeroing

- zoned mode:
  - linked list corruption for tree log

Fixes:

- qgroup leak after falloc faiulre

- tree mod log and backref resolving
  - extent buffer cloning race when resolving backrefs
  - pin deleted leaves with active tree mod log users

- drop debugging flag from slab cache

----------------------------------------------------------------
The following changes since commit badae9c86979c459bd7d895d6d7ddc7a01131ff7:

  btrfs: zoned: do not account freed region of read-only block group as zone_unusable (2021-03-04 16:16:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc3-tag

for you to fetch changes up to 485df75554257e883d0ce39bb886e8212349748e:

  btrfs: always pin deleted leaves when there are active tree mod log users (2021-03-16 20:32:22 +0100)

----------------------------------------------------------------
David Sterba (1):
      btrfs: fix slab cache flags for free space tree bitmap

Filipe Manana (3):
      btrfs: zoned: fix linked list corruption after log root tree allocation failure
      btrfs: fix race when cloning extent buffer during rewind of an old root
      btrfs: always pin deleted leaves when there are active tree mod log users

Qu Wenruo (5):
      btrfs: fix wrong offset to zero out range beyond i_size
      btrfs: track qgroup released data in own variable in insert_prealloc_file_extent
      btrfs: fix qgroup data rsv leak caused by falloc failure
      btrfs: subpage: fix wild pointer access during metadata read failure
      btrfs: subpage: make readahead work properly

 fs/btrfs/ctree.c       |  2 ++
 fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
 fs/btrfs/extent_io.c   | 33 +++++++++++++++++++++++++++++++--
 fs/btrfs/inode.c       | 37 ++++++++++++++++++++++++++-----------
 fs/btrfs/reada.c       | 35 ++++++++++++++++++-----------------
 fs/btrfs/tree-log.c    |  8 ++++----
 6 files changed, 103 insertions(+), 35 deletions(-)
