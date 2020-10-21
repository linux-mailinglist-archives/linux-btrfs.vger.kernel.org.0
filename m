Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD78B2947F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440657AbgJUFz2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 01:55:28 -0400
Received: from aliyun-cloud.icoremail.net ([47.90.73.12]:32303 "HELO
        aliyun-sdnproxy-4.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S2440654AbgJUFz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 01:55:28 -0400
X-Greylist: delayed 716 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 01:55:27 EDT
Received: from localhost.localdomain (unknown [210.32.148.79])
        by mail-app3 (Coremail) with SMTP id cC_KCgAXT5z4yI9fbU9RAA--.37365S4;
        Wed, 21 Oct 2020 13:37:00 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: ref-verify: Fix memleak in btrfs_ref_tree_mod
Date:   Wed, 21 Oct 2020 13:36:55 +0800
Message-Id: <20201021053655.28624-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgAXT5z4yI9fbU9RAA--.37365S4
X-Coremail-Antispam: 1UD129KBjvdXoWrAFyftrW5AF4UCF4kur1xZrb_yoWxWFbEka
        97Ary8ur1UZr1fua18Ka1ktrZYywnYgr4xXwn2kF1jkw42yFyrX393Jrn8ta45JrW7WFnx
        CFWSqrn8CwnrujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUP5rcUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgATBlZdtQf4pwAFs0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is one error handling path does not free ref,
which may cause a memory leak.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 fs/btrfs/ref-verify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 7f03dbe5b609..78693d3dd15b 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -860,6 +860,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 "dropping a ref for a root that doesn't have a ref on the block");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			kfree(ref);
 			kfree(ra);
 			goto out_unlock;
 		}
-- 
2.17.1

