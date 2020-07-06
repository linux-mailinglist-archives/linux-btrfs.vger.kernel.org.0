Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147C921536C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgGFHor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 03:44:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgGFHoq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 03:44:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D0A1AEA8;
        Mon,  6 Jul 2020 07:44:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans@knorrie.org>
Subject: [PATCH RFC 2/2] btrfs: space-info: Don't allow signal to interrupt ticket waiting
Date:   Mon,  6 Jul 2020 15:44:35 +0800
Message-Id: <20200706074435.52356-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706074435.52356-1-wqu@suse.com>
References: <20200706074435.52356-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When balance receive a fatal signal, it can make the fs to read-only
mode if the timing is unlucky enough:

  BTRFS info (device xvdb): balance: start -d -m -s
  BTRFS info (device xvdb): relocating block group 73001861120 flags metadata
  BTRFS info (device xvdb): found 12236 extents, stage: move data extents
  BTRFS info (device xvdb): relocating block group 71928119296 flags data
  BTRFS info (device xvdb): found 3 extents, stage: move data extents
  BTRFS info (device xvdb): found 3 extents, stage: update data pointers
  BTRFS info (device xvdb): relocating block group 60922265600 flags metadata
  BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4 unknown
  BTRFS info (device xvdb): forced readonly
  BTRFS info (device xvdb): balance: ended with status: -4

[CAUSE]
This is caused by the fact that btrfs ticketing space system can be
interrupted, and cause all kind of -EINTR returned to various critical
section, where we never thought of -EINTR at all.

Even for things like btrfs_start_transaction() can be affected by
signal:
 btrfs_start_transaction()
 |- start_transaction(flush = FLUSH_ALL)
    |- btrfs_block_rsv_add()
       |- btrfs_reserve_metadata_bytes()
          |- __reserve_metadata_bytes()
             |- handle_reserve_ticket()
                |- wait_reserve_ticket()
                   |- prepare_to_wait_event(TASK_KILLABLE)
                   |- ticket->error = -EINTR;

And all related callers get -EINTR error.

In fact, there are really very limited call sites can really handle that
-EINTR properly, above btrfs_drop_snapshot() is one case.

[FIX]
Things like metadata allocation is really a critical section for btrfs,
we don't really want it to be that killable by some impatient users.

In fact, for really long duration calls, it should have their own checks
on signal, like balance, reflink, generic fiemap calls.

So this patch will make ticket waiting uninterruptible, relying on each
long duration calls to handle their signals more properly.

Reported-by: Hans van Kranenburg <hans@knorrie.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c7bd3fdd7792..c5cfc759b804 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1099,7 +1099,8 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&space_info->lock);
 	while (ticket->bytes > 0 && ticket->error == 0) {
-		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
+		ret = prepare_to_wait_event(&ticket->wait, &wait,
+					    TASK_UNINTERRUPTIBLE);
 		if (ret) {
 			/*
 			 * Delete us from the list. After we unlock the space
-- 
2.27.0

