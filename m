Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2D47417A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 12:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhLNL3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 06:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhLNL3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 06:29:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F6C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 03:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 529F5B8189E
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 11:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9966DC34601
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639481344;
        bh=DvQY7jnxLsYjf2PrAupywF4qlqJCzag0JW03mUb0CC4=;
        h=From:To:Subject:Date:From;
        b=iBjXjqHbvvypMHiZB+sUwDTQksQC+7XuAcfKME9LtxLlV7TlSyVp+7QXA/3/qRmGl
         OE7PzNs1CZeOz6gRr5C/J2BCDx/skf2iexi3SilmE1kZVBP4RublNVu3NcYBc3lKuw
         FXzePT/ShP3o5prpiCNRi5oExYO7puvzG+Rw8IecGMzbs2PsAbXCiFGUtaMj3vJUZY
         1fUvwKePue15faG8mi5Pupe+fho1CniQrBP+s+dDgOqwfiQLlWsG824d6ZDG37Q3Do
         UygoNwbGQIM5flHW5lg4XGUve05871fTUnAmTWUDeIX5sXhNcqRQtXUGcMs1KFC7lV
         JD9i0hvXIvyCQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix missing last dir item offset update when logging directory
Date:   Tue, 14 Dec 2021 11:29:01 +0000
Message-Id: <024e44a8e8d1fa7e15eb91c6891bd229b2b4210d.1639481280.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a directory, once we finish processing a leaf that is full
of dir items, if we find the next leaf was not modified in the current
transaction, we grab the first key of that next leaf and log it as to
mark the end of a key range boundary.

However we did not update the value of ctx->last_dir_item_offset, which
tracks the offset of the last logged key. This can result in subsequent
logging of the same directory in the current transaction to not realize
that key was already logged, and then add it to the middle of a batch
that starts with a lower key, resulting later in a leaf with one key
that is duplicated and at non-consecutive slots. When that happens we get
an error later when writing out the leaf, reporting that there is a pair
of keys in wrong order. The report is something like the following:

Dec 13 21:44:50 kernel: BTRFS critical (device dm-0): corrupt leaf:
root=18446744073709551610 block=118444032 slot=21, bad key order, prev
(704687 84 4146773349) current (704687 84 1063561078)
Dec 13 21:44:50 kernel: BTRFS info (device dm-0): leaf 118444032 gen
91449 total ptrs 39 free space 546 owner 18446744073709551610
Dec 13 21:44:50 kernel:         item 0 key (704687 1 0) itemoff 3835
itemsize 160
Dec 13 21:44:50 kernel:                 inode generation 35532 size
1026 mode 40755
Dec 13 21:44:50 kernel:         item 1 key (704687 12 704685) itemoff
3822 itemsize 13
Dec 13 21:44:50 kernel:         item 2 key (704687 24 3817753667)
itemoff 3736 itemsize 86
Dec 13 21:44:50 kernel:         item 3 key (704687 60 0) itemoff 3728 itemsize 8
Dec 13 21:44:50 kernel:         item 4 key (704687 72 0) itemoff 3720 itemsize 8
Dec 13 21:44:50 kernel:         item 5 key (704687 84 140445108)
itemoff 3666 itemsize 54
Dec 13 21:44:50 kernel:                 dir oid 704793 type 1
Dec 13 21:44:50 kernel:         item 6 key (704687 84 298800632)
itemoff 3599 itemsize 67
Dec 13 21:44:50 kernel:                 dir oid 707849 type 2
Dec 13 21:44:50 kernel:         item 7 key (704687 84 476147658)
itemoff 3532 itemsize 67
Dec 13 21:44:50 kernel:                 dir oid 707901 type 2
Dec 13 21:44:50 kernel:         item 8 key (704687 84 633818382)
itemoff 3471 itemsize 61
Dec 13 21:44:50 kernel:                 dir oid 704694 type 2
Dec 13 21:44:50 kernel:         item 9 key (704687 84 654256665)
itemoff 3403 itemsize 68
Dec 13 21:44:50 kernel:                 dir oid 707841 type 1
Dec 13 21:44:50 kernel:         item 10 key (704687 84 995843418)
itemoff 3331 itemsize 72
Dec 13 21:44:50 kernel:                 dir oid 2167736 type 1
Dec 13 21:44:50 kernel:         item 11 key (704687 84 1063561078)
itemoff 3278 itemsize 53
Dec 13 21:44:50 kernel:                 dir oid 704799 type 2
Dec 13 21:44:50 kernel:         item 12 key (704687 84 1101156010)
itemoff 3225 itemsize 53
Dec 13 21:44:50 kernel:                 dir oid 704696 type 1
Dec 13 21:44:50 kernel:         item 13 key (704687 84 2521936574)
itemoff 3173 itemsize 52
Dec 13 21:44:50 kernel:                 dir oid 704704 type 2
Dec 13 21:44:50 kernel:         item 14 key (704687 84 2618368432)
itemoff 3112 itemsize 61
Dec 13 21:44:50 kernel:                 dir oid 704738 type 1
Dec 13 21:44:50 kernel:         item 15 key (704687 84 2676316190)
itemoff 3046 itemsize 66
Dec 13 21:44:50 kernel:                 dir oid 2167729 type 1
Dec 13 21:44:50 kernel:         item 16 key (704687 84 3319104192)
itemoff 2986 itemsize 60
Dec 13 21:44:50 kernel:                 dir oid 704745 type 2
Dec 13 21:44:50 kernel:         item 17 key (704687 84 3908046265)
itemoff 2929 itemsize 57
Dec 13 21:44:50 kernel:                 dir oid 2167734 type 1
Dec 13 21:44:50 kernel:         item 18 key (704687 84 3945713089)
itemoff 2857 itemsize 72
Dec 13 21:44:50 kernel:                 dir oid 2167730 type 1
Dec 13 21:44:50 kernel:         item 19 key (704687 84 4077169308)
itemoff 2795 itemsize 62
Dec 13 21:44:50 kernel:                 dir oid 704688 type 1
Dec 13 21:44:50 kernel:         item 20 key (704687 84 4146773349)
itemoff 2727 itemsize 68
Dec 13 21:44:50 kernel:                 dir oid 707892 type 1
Dec 13 21:44:50 kernel:         item 21 key (704687 84 1063561078)
itemoff 2674 itemsize 53
Dec 13 21:44:50 kernel:                 dir oid 704799 type 2
Dec 13 21:44:50 kernel:         item 22 key (704687 96 2) itemoff 2612
itemsize 62
Dec 13 21:44:50 kernel:         item 23 key (704687 96 6) itemoff 2551
itemsize 61
Dec 13 21:44:50 kernel:         item 24 key (704687 96 7) itemoff 2498
itemsize 53
Dec 13 21:44:50 kernel:         item 25 key (704687 96 12) itemoff
2446 itemsize 52
Dec 13 21:44:50 kernel:         item 26 key (704687 96 14) itemoff
2385 itemsize 61
Dec 13 21:44:50 kernel:         item 27 key (704687 96 18) itemoff
2325 itemsize 60
Dec 13 21:44:50 kernel:         item 28 key (704687 96 24) itemoff
2271 itemsize 54
Dec 13 21:44:50 kernel:         item 29 key (704687 96 28) itemoff
2218 itemsize 53
Dec 13 21:44:50 kernel:         item 30 key (704687 96 62) itemoff
2150 itemsize 68
Dec 13 21:44:50 kernel:         item 31 key (704687 96 66) itemoff
2083 itemsize 67
Dec 13 21:44:50 kernel:         item 32 key (704687 96 75) itemoff
2015 itemsize 68
Dec 13 21:44:50 kernel:         item 33 key (704687 96 79) itemoff
1948 itemsize 67
Dec 13 21:44:50 kernel:         item 34 key (704687 96 82) itemoff
1882 itemsize 66
Dec 13 21:44:50 kernel:         item 35 key (704687 96 83) itemoff
1810 itemsize 72
Dec 13 21:44:50 kernel:         item 36 key (704687 96 85) itemoff
1753 itemsize 57
Dec 13 21:44:50 kernel:         item 37 key (704687 96 87) itemoff
1681 itemsize 72
Dec 13 21:44:50 kernel:         item 38 key (704694 1 0) itemoff 1521
itemsize 160
Dec 13 21:44:50 kernel:                 inode generation 35534 size 30
mode 40755
Dec 13 21:44:50 kernel: BTRFS error (device dm-0): block=118444032
write time tree block corruption detected

So fix that by adding the missing update of ctx->last_dir_item_offset with
the offset of the boundary key.

Reported-by: Chris Murphy <lists@colorremedies.com>
Link: https://lore.kernel.org/linux-btrfs/CAJCQCtT+RSzpUjbMq+UfzNUMe1X5+1G+DnAGbHC=OZ=iRS24jg@mail.gmail.com/
Fixes: dc2872247ec0ca ("btrfs: keep track of the last logged keys when logging a directory")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ab33caf016f..6517c455f5db 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3976,6 +3976,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 			goto done;
 		}
 		if (btrfs_header_generation(path->nodes[0]) != trans->transid) {
+			ctx->last_dir_item_offset = min_key.offset;
 			ret = overwrite_item(trans, log, dst_path,
 					     path->nodes[0], path->slots[0],
 					     &min_key);
-- 
2.33.0

