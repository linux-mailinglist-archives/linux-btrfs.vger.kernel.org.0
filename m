Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4423A1B011F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 07:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDTFrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 01:47:06 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:41039 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbgDTFrF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 01:47:05 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 01:47:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=7jeYy+0kw+BDwc27sM9Qazk8Eah3Qmvz5cfU906WJME=; b=l
        eDBAAKMySPKhlRK1SN0tEEU24/SP82dlmZf7+5N8hjRjQxDg2/Si8IBY+xsuJmuM
        FOaC01foEiZ9nTDfw7w1M5n1ZyYPU1McSpYJnk3p8ZcVbLYShYJ8d/dC9ebwLMPh
        MoNKSV/JinuCkUSCOzU5u2z/DHcTlpDw6F3sDek2J0=
Received: from localhost.localdomain (unknown [61.129.42.58])
        by app2 (Coremail) with SMTP id XQUFCgCXn+N3NZ1elfUdAA--.15497S3;
        Mon, 20 Apr 2020 13:39:04 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] btrfs: Fix btrfs_block_group refcnt leak
Date:   Mon, 20 Apr 2020 13:38:40 +0800
Message-Id: <1587361120-83160-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgCXn+N3NZ1elfUdAA--.15497S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4DuF48Jw4fXFyDJw1DWrg_yoW5GFW3pr
        yDKFs0gr1rCr1qva1xG390qw1Fg3WkGw4UGr98Crsaqw43JwnxZF9Iy3WYyry5tFWfXrZr
        Xa1Yv34UAF9FkrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUXTmhUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_remove_block_group() invokes btrfs_lookup_block_group(), which
returns a local reference of the blcok group that contains the given
bytenr to "block_group" with increased refcount.

When btrfs_remove_block_group() returns, "block_group" becomes invalid,
so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in several exception handling paths
of btrfs_remove_block_group(). When those error scenarios occur such as
btrfs_alloc_path() returns NULL, the function forgets to decrease its
refcnt increased by btrfs_lookup_block_group() and will cause a refcnt
leak.

Fix this issue by jumping to "out_put_group" label and calling
btrfs_put_block_group() when those error scenarios occur.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/btrfs/block-group.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 404e050ce8ee..d9f432bd3329 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -916,7 +916,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_put_group;
 	}
 
 	/*
@@ -954,7 +954,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 		if (ret) {
 			btrfs_add_delayed_iput(inode);
-			goto out;
+			goto out_put_group;
 		}
 		clear_nlink(inode);
 		/* One for the block groups ref */
@@ -977,13 +977,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
+		goto out_put_group;
 	if (ret > 0)
 		btrfs_release_path(path);
 	if (ret == 0) {
 		ret = btrfs_del_item(trans, tree_root, path);
 		if (ret)
-			goto out;
+			goto out_put_group;
 		btrfs_release_path(path);
 	}
 
@@ -1102,7 +1102,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	ret = remove_block_group_free_space(trans, block_group);
 	if (ret)
-		goto out;
+		goto out_put_group;
 
 	btrfs_put_block_group(block_group);
 	btrfs_put_block_group(block_group);
@@ -1132,6 +1132,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		btrfs_delayed_refs_rsv_release(fs_info, 1);
 	btrfs_free_path(path);
 	return ret;
+out_put_group:
+	btrfs_put_block_group(block_group);
+	goto out;
 }
 
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
-- 
2.7.4

