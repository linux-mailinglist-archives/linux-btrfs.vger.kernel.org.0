Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5C1B0122
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDTFsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 01:48:32 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:38296 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgDTFsc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 01:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=DjbzqYNqeqnbjCD12TkNbwM+GA7agGlpqtiuflvqEeQ=; b=k
        QyQgJig8hKn5pXyORfGGMB5fbkIDU/UUr9OUc6iZFYW6poCBKP8a+pWLSG/fOyAb
        mUua/+BkruHG1HZE6h3rWG1wl5BUTY+BE5IVtTvL37K8RvoL3rSzx1/QKo+r2kIo
        p5Cp77xV8SyL/bq+w90f0op7nze1W9NBqWMfiyFqyY=
Received: from localhost.localdomain (unknown [120.229.255.67])
        by app1 (Coremail) with SMTP id XAUFCgBXSHW6NZ1evHYWAA--.63135S3;
        Mon, 20 Apr 2020 13:40:12 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] btrfs: Fix refcnt leak in btrfs_recover_relocation
Date:   Mon, 20 Apr 2020 13:39:39 +0800
Message-Id: <1587361180-83334-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgBXSHW6NZ1evHYWAA--.63135S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xKF1rKw4kKw4ruF48JFb_yoW8Gr4fpr
        47Cw1Fgry5tw1kArsxKan5Cr1fGa1DWw18GrsYgws5Xws3J3WSya4jvwnrtry8tr1qqw4U
        XrsY9rW5Arn8C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_recover_relocation() invokes btrfs_join_transaction(), which joins
a btrfs_trans_handle object into transactions and returns a reference of
it with increased refcount to "trans".

When btrfs_recover_relocation() returns, "trans" becomes invalid, so the
refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
btrfs_recover_relocation(). When read_fs_root() failed, the refcnt
increased by btrfs_join_transaction() is not decreased, causing a refcnt
leak.

Fix this issue by calling btrfs_end_transaction() on this error path
when read_fs_root() failed.

Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error
handling")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/btrfs/relocation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 995d4b8b1cfd..46a451594c7a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4606,6 +4606,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
+			btrfs_end_transaction(trans);
 			goto out_free;
 		}
 
-- 
2.7.4

