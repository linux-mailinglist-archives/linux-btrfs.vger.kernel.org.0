Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874598056B
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfHCIxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 04:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbfHCIxV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Aug 2019 04:53:21 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90BD821726
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Aug 2019 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564822400;
        bh=hHACZecEntIePRS3R7InnB4TclpQ+Yt+eLOK+pZpTg4=;
        h=From:To:Subject:Date:From;
        b=S9TAnYDxiMlcO7sXuIQGO4LmWPXxHvTHFgNSqELKVAmPLQYmmcBYYtIMoNQH9K6kj
         MTJmHoqaS+h1c/Nb47eoRHgGpFJKW3dsEh1leBuWw2XImMTK49GhYIHnnMDvDOG2I7
         wgx4JRr90ZkJeV/ZHMQCoe3mYHBmchNNlc3kX4To=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix memory leaks in the test test_find_first_clear_extent_bit
Date:   Sat,  3 Aug 2019 09:53:16 +0100
Message-Id: <20190803085316.7448-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test creates an extent io tree and sets several ranges with the
CHUNK_ALLOCATED and CHUNK_TRIMMED bits, resulting in the allocation of
several extent state structures. However the test never clears those
ranges, resulting in memory leaks of the extent state structures.

This is detected when CONFIG_BTRFS_DEBUG is set once we remove the
btrfs module (rmmod btrfs):

[57399.787918] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
[57399.790155] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
[57399.791941] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
[57399.793753] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
[57399.795188] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
[57399.796453] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
[57399.797765] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
[57399.799049] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
[57399.800142] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
[57399.801126] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
[57399.802106] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
[57399.803119] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
[57399.804153] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
[57399.805196] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
[57399.806191] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1

The start and end offsets reported correspond exactly to the ranges
used by the test.

So fix that by clearing all the ranges when the test finishes.

Fixes: 1eaebb341d2b41 ("btrfs: Don't trim returned range based on input value in find_first_clear_extent_bit")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/extent-io-tests.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 1bf6b5a79191..705a8a7eb815 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -514,6 +514,8 @@ static int test_find_first_clear_extent_bit(void)
 		"error handling beyond end of range search: start %llu end %llu",
 			start, end);
 
+	clear_extent_bits(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCATED);
+
 	return 0;
 }
 
-- 
2.11.0

