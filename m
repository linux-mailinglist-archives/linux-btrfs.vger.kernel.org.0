Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BB27CE24
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgI2MyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2MyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 08:54:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7750C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 05:53:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so3404282qtv.3
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKS8mns7d52PsxTEtfp+VzCf9jWOm39n0d1APKbtjNw=;
        b=xB6X50VIofpsGxdQ9dF5csubEC6wmYM1W7joouuWzuF+tFIGI3rk5qq67ObgZH17i2
         taPV5+7Bgx0VPZ+fqP7Gret8fHnqyWwwW1Nu6/vRr8EheUzk5r7AablKB6XMhktoPuK6
         SbartJP5McF8fEKKbKWMCf7REzGqlVZglOpYnrDoywuQfQfSQHTHldL5pQkGxSscMkly
         +sm1H1MisQcMf7QbP9xue+oEpl0YVYCxwi1DgJ/e/gEAfnelErehii+V68piGnfnzDGL
         kWwy0wZfc7m3Pkb7iKpBQpK7b9QUnK/7BiX/m9hQLz5Dgjpn+rSw9Hb2LXHJcEiBaVvi
         ZpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKS8mns7d52PsxTEtfp+VzCf9jWOm39n0d1APKbtjNw=;
        b=ENd/rCMijByfXhdNtsdLRQLPIXoFy6DHcBugx1qtMNCvaXFcjkMfLXD1vw7UtuQSP+
         QjCAdzWX/gO51L2b1g1lAbxzrSeUdB3L8lriDES0wwyOK9hmcV28C+eT4HCOfge4GpeA
         bivUJQ1Bup8tjm48djZcbQFcd3qjunYE8TM7J5Im6cRFRhaQaQleID22iwFrLMJ5/Dtu
         4TWk7q4qrSMs/VHg1yfHttKV8Yi4f5/w2Ff+hkZkNC0a5FVHFREIuWYtUzDC2WTYkdj5
         QGUyGCjr6mr+BEfr5XyMGLveSNGew3Puon5kcUUGnt5yHpSjrVd0QXKh8jHxxd+ji9gz
         Cr6w==
X-Gm-Message-State: AOAM533WAyV5W+d0DvaJKH9WpTxVr3HQu7YvKxojyH/hWAMUZygfR1Bm
        MA8ULICc/0yTBH8pJOolJO3QSqyhPOrY5Ez7
X-Google-Smtp-Source: ABdhPJxTXsCnSDvK6AMHyjpQ1XFZMX2rlCNbtaNI4kXePcRzxP7NtvC2uUmCqSlBCLIcbH7FOnv/Gw==
X-Received: by 2002:ac8:4d84:: with SMTP id a4mr3145793qtw.365.1601384036914;
        Tue, 29 Sep 2020 05:53:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18sm4321892qko.126.2020.09.29.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 05:53:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: cleanup cow block on error
Date:   Tue, 29 Sep 2020 08:53:54 -0400
Message-Id: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
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
__btrfs_cow_block, and also free it so we do not leak it.

Fixes: 65b51a009e29 ("btrfs_search_slot: reduce lock contention by cowing in two stages")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a165093739c4..113da62dc17f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1064,6 +1064,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
 	if (ret) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -1071,6 +1073,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
 		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
 		if (ret) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
@@ -1103,6 +1107,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		if (last_ref) {
 			ret = tree_mod_log_free_eb(buf);
 			if (ret) {
+				btrfs_tree_unlock(cow);
+				free_extent_buffer(cow);
 				btrfs_abort_transaction(trans, ret);
 				return ret;
 			}
-- 
2.26.2

