Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF626FE98
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgIRNem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRNem (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=t7a+x1Rp+xBL6Pbyu5oHvUsPUNSFiqBQjU8B+BNV44k=;
        b=hkNkZQSg6JRy0f017hmCZBugaF9nufQyaP3yRDqzTOQTPYepsb3hsOuBUVzWQwpTZA+xi2
        w87snFa9RpxffedQqTOG4awd1q3x363sSsJXSx88FLKBudBmO9gl15fx/AuKEOxT2G4Pbk
        yoxzQSYuQRfcookaMEWkTeDAIhcQLWw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FDABB18C;
        Fri, 18 Sep 2020 13:35:15 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/7] Remove struct extent_io_ops
Date:   Fri, 18 Sep 2020 16:34:32 +0300
Message-Id: <20200918133439.23187-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Finally it's time to remove "struct extent_io_ops" and get rid of the indirect
calls to the "hook" functions. Each patch is rather self-explanatory, the basic
idea is to replace indirect calls with an "if" construct (patches 1,3,5,6). The
rest simply remove struct members and the struct it self.

This series survived a full xfstest run.

Nikolay Borisov (7):
  btrfs: Don't call readpage_end_io_hook for the btree inode
  btrfs: Remove extent_io_ops::readpage_end_io_hook
  btrfs: Call submit_bio_hook directly in submit_one_bio
  btrfs: Don't opencode is_data_inode in end_bio_extent_readpage
  btrfs: Stop calling submit_bio_hook for data inodes
  btrfs: Call submit_bio_hook directly for metadata pages
  btrfs: Remove struct extent_io_ops

 fs/btrfs/ctree.h             |  6 ++++--
 fs/btrfs/disk-io.c           | 20 +++++---------------
 fs/btrfs/disk-io.h           |  6 +++++-
 fs/btrfs/extent-io-tree.h    |  1 -
 fs/btrfs/extent_io.c         | 25 +++++++++++++------------
 fs/btrfs/extent_io.h         |  5 +----
 fs/btrfs/inode.c             | 28 ++++------------------------
 fs/btrfs/tests/inode-tests.c |  1 -
 8 files changed, 32 insertions(+), 60 deletions(-)

--
2.17.1

