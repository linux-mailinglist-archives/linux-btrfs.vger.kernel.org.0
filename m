Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114F939A47A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhFCPYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 11:24:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhFCPYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 11:24:46 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F8AF1FD4E;
        Thu,  3 Jun 2021 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622733780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AhcdrSqD3z3ooEh9y9EFb2y41tJTxAozqYnmCzARuLg=;
        b=G/1XH5ah+DBvANN+MRJwIgP0y/6pk66z0PpR5XQQT8rvc61C6gdTWsyFihOzTpcxUyjkNo
        iRxX6QyV4gp0w3FV7ah4WWfzBJPFQLyfG2757A0gmXfr8mVLWK2ij7kRtS9PCwZDHaZCNe
        6+rmpo105k4RjiTTgJtW8qhYZQslTyc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6962CA3B85;
        Thu,  3 Jun 2021 15:23:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F1D9DA734; Thu,  3 Jun 2021 17:20:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Slightly how START_SYNC and WAIT_SYNC work
Date:   Thu,  3 Jun 2021 17:20:19 +0200
Message-Id: <cover.1622733245.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The async transaction commit ioctl has a subtle semantics that used to
work for ceph. We need more straightforward semantics in progs (eg. when
waiting for commit after subvolume deletion) and otherwise the async
commit does a few annoying things.

Long explanation is in patch 3. I hope it works, but somebody please
double check. It's a minor change in the commit logic, but merely
removing some waiting, no other changes in state transitions.

David Sterba (4):
  btrfs: sink wait_for_unblock parameter to async commit
  btrfs: inline wait_current_trans_commit_start in its caller
  btrfs: replace async commit by pending actions
  btrfs: remove fs_info::transaction_blocked_wait

 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/disk-io.c     |   5 +-
 fs/btrfs/ioctl.c       |  12 ++---
 fs/btrfs/super.c       |   1 -
 fs/btrfs/transaction.c | 103 +----------------------------------------
 fs/btrfs/transaction.h |   2 -
 6 files changed, 9 insertions(+), 115 deletions(-)

-- 
2.31.1

