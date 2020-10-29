Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6129EB32
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJ2MC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:02:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2MCz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:02:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y58y9Ndl1k0LWJdfWR40qLqYjoa9Bb0NufVHoxxdTNk=;
        b=NVs5ajC4KyIJImmXrzgq7U7nrFp+XVTvN/b470qRBFnmPQ7MJw0PWEEQeO+OdJ8wGNz/94
        ItJDZUQc2LcjWP08gxwR2K28bi/8L3gpQc44MXVxdjSrx8DoQ6QDt8i0OruDaKdFXez/U2
        jNvn8HG3j6UUwfEi0J7quVLJnaC35Dw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAFF8ACF1;
        Thu, 29 Oct 2020 12:02:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9913FDA7D9; Thu, 29 Oct 2020 13:01:19 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/8] Misc cleanups
Date:   Thu, 29 Oct 2020 13:01:19 +0100
Message-Id: <cover.1603972767.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Clean up:

- lockdep keyset definition
- accessors for various b-tree items
- message updates

David Sterba (8):
  btrfs: use the right number of levels for lockdep keysets
  btrfs: generate lockdep keyset names at compile time
  btrfs: send: use helpers to access root_item::ctransid
  btrfs: check-integrity: use proper helper to access btrfs_header
  btrfs: use root_item helpers for limit and flags in btrfs_create_tree
  btrfs: add set/get accessors for root_item::drop_level
  btrfs: remove unnecessary casts in printk
  btrfs: scrub: update message regarding read-only status

 fs/btrfs/check-integrity.c |  2 +-
 fs/btrfs/ctree.h           |  1 +
 fs/btrfs/disk-io.c         | 66 ++++++++++++++++++++------------------
 fs/btrfs/disk-io.h         |  3 --
 fs/btrfs/extent-tree.c     |  6 ++--
 fs/btrfs/inode.c           |  2 +-
 fs/btrfs/print-tree.c      |  3 +-
 fs/btrfs/ref-verify.c      |  3 +-
 fs/btrfs/relocation.c      | 10 +++---
 fs/btrfs/scrub.c           |  5 +--
 fs/btrfs/send.c            |  6 ++--
 fs/btrfs/super.c           |  2 --
 fs/btrfs/tree-checker.c    |  4 +--
 fs/btrfs/uuid-tree.c       |  3 +-
 14 files changed, 56 insertions(+), 60 deletions(-)

-- 
2.25.0

