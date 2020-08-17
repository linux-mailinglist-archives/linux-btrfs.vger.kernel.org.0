Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB88B24649D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHQKhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 06:37:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgHQKhW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 06:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB76AB6B5;
        Mon, 17 Aug 2020 10:37:45 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs/173: Adjust compress file check
Date:   Mon, 17 Aug 2020 13:37:17 +0300
Message-Id: <20200817103718.10239-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817103718.10239-1-nborisov@suse.com>
References: <20200817103718.10239-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following kernel commit "btrfs: add missing check for nocow and
compression inode flags" the enforcement of "can't set +c on a +C" file
has been moved to the ioctl code. Modify the test to account for this.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/173     | 4 +---
 tests/btrfs/173.out | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/173 b/tests/btrfs/173
index 515d8cfa0994..c427320ad664 100755
--- a/tests/btrfs/173
+++ b/tests/btrfs/173
@@ -48,9 +48,7 @@ swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
 echo "Compressed file"
 rm -f "$SCRATCH_MNT/swap"
 _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
-$CHATTR_PROG +c "$SCRATCH_MNT/swap"
-swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
-swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
+$CHATTR_PROG +c "$SCRATCH_MNT/swap" 2>&1 | grep -o "Invalid argument while setting flags"
 
 status=0
 exit
diff --git a/tests/btrfs/173.out b/tests/btrfs/173.out
index 6d7856bf9e02..2920384045ad 100644
--- a/tests/btrfs/173.out
+++ b/tests/btrfs/173.out
@@ -2,4 +2,4 @@ QA output created by 173
 COW file
 swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
 Compressed file
-swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
+Invalid argument while setting flags
-- 
2.17.1

