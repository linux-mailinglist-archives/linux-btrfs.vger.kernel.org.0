Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8528B27B046
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 16:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgI1OtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgI1OtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 10:49:16 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8EC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 07:49:16 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so565207qvk.11
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzqtpciHitGtcYLE5GomEmIwTDLIj0/EqY+FN65NdNY=;
        b=EmffFjB+uisVQUw8GphlvZsskWXoKebRKHDsCuOWGLGx6PHtVevN88y9w2w8hKEl3J
         0VxfIfp40Qjko6KQgQuW8nVgDiTef4B0TokaU213pwhKEYFw34phpXfGI3emo4MqAPOI
         +tcVdKqhPvCOvEtCpjdj3Z8mBSz+4ZnRNxX376usAlrfLXYgEcjGKwgejHJmE8W2iN8S
         Jdp2WoavV3IBrNGvA9gMoTNqeZ2iqV67t1LxerEmqbP5sOWzcveFQSilS6+paukZzDKK
         8tIo5HGeiP9bsTEebnOQQhk/nSv2684fPMPMBG6ywOgH9YX5VSF5dL5n1x4RI38ZjZl/
         NOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzqtpciHitGtcYLE5GomEmIwTDLIj0/EqY+FN65NdNY=;
        b=e9WlxN9Ye1pNnAxYch9h+zTPTshMANP8Tik6oVaWy4TD/ccAXh8hOTNpiMVt8D1SxZ
         GBZlwt1jzopkKR/nFkAIlAc1Im46XNH+wnxFjnQ7RZ4NgSJZiX0oBH+wl63UyfsnAfPq
         ktOinMS7zKBBQUuY7rwbSLd12z0dh9zJyhritycrX4WuAbtsXq5vnQI+CiZUkaYH9AeL
         UtFqhv6uDwUmoAoArY2U98UrHk2Z2KQsP4v5tl/tsZVkK2o1nYDiVJ5kNBed+4LOYt04
         Gcop01Kur2rB6etCtLzKTIoS5yey4A32UKNC0srvlwQQsGh76EQOA9tTBcp/3J8zVa1d
         pmgQ==
X-Gm-Message-State: AOAM531l7i/g5dFjW7Cz4Es40O/VYghCrPTcVy7kEu9xCRi+pwH65c8E
        zhHVuDkHGvqNGItwLmLTraY5WJyOVyg30Q14
X-Google-Smtp-Source: ABdhPJw2E3WJLUecUdv203yCL5M/hxa46e1mJNoraQd9TJLqDxGxEvrYJ+pB2/C15tkqTD19wMmtkg==
X-Received: by 2002:a0c:f984:: with SMTP id t4mr12431965qvn.18.1601304555341;
        Mon, 28 Sep 2020 07:49:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b34sm1475647qtc.73.2020.09.28.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 07:49:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: unlock the cow block on error
Date:   Mon, 28 Sep 2020 10:49:13 -0400
Message-Id: <7706fb8d62576840c3e7dd69b326b1ae9e6d3ab7.1601304541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With my automated fstest runs I noticed one of my workers didn't report
results.  Turns out it was hung trying to write back inodes, and the
write back thread was stuck trying to lock an extent buffer

[root@xfstests2 xfstests-dev]# cat /proc/2143497/stack
[<0>] __btrfs_tree_lock+0x108/0x250
[<0>] lock_extent_buffer_for_io+0x35e/0x3a0
[<0>] btree_write_cache_pages+0x15a/0x3b0
[<0>] do_writepages+0x28/0xb0
[<0>] __writeback_single_inode+0x54/0x5c0
[<0>] writeback_sb_inodes+0x1e8/0x510
[<0>] wb_writeback+0xcc/0x440
[<0>] wb_workfn+0xd7/0x650
[<0>] process_one_work+0x236/0x560
[<0>] worker_thread+0x55/0x3c0
[<0>] kthread+0x13a/0x150
[<0>] ret_from_fork+0x1f/0x30

This is because we got an error while cow'ing a block, specifically here

        if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
                ret = btrfs_reloc_cow_block(trans, root, buf, cow);
                if (ret) {
                        btrfs_abort_transaction(trans, ret);
                        return ret;
                }
        }

The problem here is that as soon as we allocate the new block it is
locked and marked dirty in the btree inode.  This means that we could
attempt to writeback this block and need to lock the extent buffer.
However we're not unlocking it here and thus we deadlock.

Fix this by unlocking the cow block if we have any errors inside of
__btrfs_cow_block.

Fixes: 65b51a009e29 ("btrfs_search_slot: reduce lock contention by cowing in two stages")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a165093739c4..a6b6d1f74f23 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1064,6 +1064,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
 	if (ret) {
+		btrfs_tree_unlock(cow);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -1071,6 +1072,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
 		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
 		if (ret) {
+			btrfs_tree_unlock(cow);
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
@@ -1103,6 +1105,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		if (last_ref) {
 			ret = tree_mod_log_free_eb(buf);
 			if (ret) {
+				btrfs_tree_unlock(cow);
 				btrfs_abort_transaction(trans, ret);
 				return ret;
 			}
-- 
2.26.2

