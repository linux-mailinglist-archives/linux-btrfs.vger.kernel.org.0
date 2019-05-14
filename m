Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA11C745
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 12:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfENKys (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 06:54:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfENKys (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 06:54:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C7CCAEFF
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 10:54:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/8] Misc improvements to dev-replace code
Date:   Tue, 14 May 2019 13:54:37 +0300
Message-Id: <20190514105445.23051-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While fixing the failing ASSERT in device replace finishing procedure I also 
found several oddities/bugs. Here is the resultant pile.

First 3 patches are a couple simple cleanups.

Patch 4 fixes a real bug since btrfs_init_dev_replace_tgtdev accesses values
which might be updated by transaction commit, so naturally it should be called
after the transaction is actually committed. I think this should go to stable. 

Patch 5 cleanups unlocking code in btrfs_dev_replace_start removing a goto label 
and a local variable. 

Patch 6 also fixes a bug, since persisting the dev-replace item relied on global 
reserve being able to satisfy the condition. While this is not wrong per-se I 
find it somewhat subtle, so just be explicit and start a transaction with 
reservation for at least 1 item.

Patch 7 fixes the race condition which caused the newly added ASSERT to trigger. 
I've added the Fixes: tag to point to the first commit which introduced taking 
chunk_mutex. This is also stable material. 

Patch 8 is also a minor cleanup, just removing what I believe to be a redundant 
assignment. 

This series went under multiple xfstest runs and no regressions were observed. 

Nikolay Borisov (8):
  btrfs: Don't opencode sync_blockdev in btrfs_init_dev_replace_tgtdev
  btrfs: Reduce critical section in btrfs_init_dev_replace_tgtdev
  btrfs: Remove impossible WARN_ON
  btrfs: Ensure btrfs_init_dev_replace_tgtdev sees up to date values
  btrfs: Streamline replace sem unlock in btrfs_dev_replace_start
  btrfs: Explicitly reserve space for devreplace item
  btrfs: Ensure replaced device doesn't have pending chunk allocation
  btrfs: Remove redundant assignment of tgt_device->commit_total_bytes

 fs/btrfs/dev-replace.c | 59 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

-- 
2.17.1

