Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366A624649E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHQKhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 06:37:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgHQKhW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 06:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBACFB6B7;
        Mon, 17 Aug 2020 10:37:45 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs/174: Adjust error message when setting compressed flag
Date:   Mon, 17 Aug 2020 13:37:18 +0300
Message-Id: <20200817103718.10239-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817103718.10239-1-nborisov@suse.com>
References: <20200817103718.10239-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following kernel commit "btrfs: add missing check for nocow and
compression inode flags" btrfs refuses setting +c on +C files during
validation of the args. Account for this by adjusting the expected
error message.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/174     | 2 +-
 tests/btrfs/174.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/174 b/tests/btrfs/174
index af3352212170..bca1dc5c0b3b 100755
--- a/tests/btrfs/174
+++ b/tests/btrfs/174
@@ -47,7 +47,7 @@ $LSATTR_PROG -l "$swapfile" | _filter_scratch | _filter_spaces
 
 # Compression we reject outright.
 echo "Enable compression"
-$CHATTR_PROG +c "$swapfile" 2>&1 | grep -o "Text file busy"
+$CHATTR_PROG +c "$swapfile" 2>&1 | grep -o "Invalid argument while setting flags"
 $LSATTR_PROG -l "$swapfile" | _filter_scratch | _filter_spaces
 
 echo "Snapshot"
diff --git a/tests/btrfs/174.out b/tests/btrfs/174.out
index bc24f1fb8be3..15bdf79e7bfb 100644
--- a/tests/btrfs/174.out
+++ b/tests/btrfs/174.out
@@ -2,7 +2,7 @@ QA output created by 174
 Disable nocow
 SCRATCH_MNT/swapvol/swap No_COW
 Enable compression
-Text file busy
+Invalid argument while setting flags
 SCRATCH_MNT/swapvol/swap No_COW
 Snapshot
 Text file busy
-- 
2.17.1

